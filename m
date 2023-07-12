Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0861F7507ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGLMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjGLMQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4364AE5F;
        Wed, 12 Jul 2023 05:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D57BB617A2;
        Wed, 12 Jul 2023 12:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7744BC433C8;
        Wed, 12 Jul 2023 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689164170;
        bh=Bylv8XlW+i1HG1dsiDrjrNkPFeP+ZdT4WJRra3TyGqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fj/G6RmnOz9GGjOnSJln0t53s0KUxQ82Qnjcr3OQtXxRrekKAchaiDPg0XGz8xXdV
         uA5j7UGIHht7JqIY120Fi+4F12E9+wr4OYwq4dwUm6sb3ET5/HATXpanYIDRC8I/qK
         0whU+rjYXm6lQiGuHpcm5g+CQ4IC7kIil/enYjdUX9WdvfZ7grpE+d1vKPcw6nIvXr
         7SU7TL46MVDoLLDDCI1Q8TOr8ysw2dZZaD+NXJLNmSDX7Y8/GG+iPITzUwJfCdwJfd
         UgmgoQ5ZMMPoU1kdRLJdhN1+p7WlnhPWm2T+YEPQKk0vgwcT17au+JyVz+BsrR9sdy
         9921e7W7cDUSw==
Message-ID: <5ccff4a9-1073-ea82-8360-445a956e9266@kernel.org>
Date:   Wed, 12 Jul 2023 15:16:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/3] Support dwc3 runtime suspend during bus suspend
Content-Language: en-US
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230711174320.24058-1-quic_eserrao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elson,

On 11/07/2023 20:43, Elson Roy Serrao wrote:
> Changes in v3
>  - Added a dt property 'snps,allow-rtsusp-on-u3' to make this feature platform
>    dependent as per the feedback from Thinh N.
>  - Changed the RT idle/suspend/resume handling to device mode specific and dt
>    property dependent.
>  - Modified the cover letter to document how resume is handled on qcom platforms.
>  
> Changes in v2
>  - Used pm_runtime_resume_and_get() API instead of pm_runtime_get_sync()
>    as suggested by Dan.
>  - Handled the return value in ether_wakeup_host to print error message.
> 
> When a USB link is idle, the host sends a bus suspend event to the device
> so that the device can save power. But true power savings during bus
> suspend can be seen only if we let the USB controller enter low power
> mode and turn off the clocks. Vendor drivers may have their own runtime
> power management framework to power up/down the controller. But since
> vendor drivers' runtime suspend/resume routines depend on the dwc3 child
> node we would need a framework to trigger dwc3 runtime pm ops whenever a
> bus suspend is received. If the device wants to exit from bus suspend
> state it can send a wakeup signal to the host by first bringing out the
> controller from low power mode. This series implements the needed
> framework to achieve this functionality when a bus suspend interupt is
> received. The assumption here is that the dwc3 hibernation feature is not
> enabled and the platform is responsible in detecting the resume events to
> bring the controller out of suspend.
> 
> On Qualcomm platforms the bus resume is handled through Phy and informed to
> software through wakeup capable phy interrupts.
> usb2 PHY is configured to detect the Resume K event and sends an interrupt
> when this event is detected. This would trigger the runtime resume of the
> glue driver which would intrinsically wakeup the dwc3 child. In case of usb3 PHY,
> it is configured to detect the LFPS wake signal during bus resume and the
> corresponding interrupt triggers the runtime resume of the glue driver.

Subject says runtime suspend. But are you testing system sleep/wakeup as well
while USB is suspended?

> 
> The series is organized in below fashion:
> Patch 1: This includes the modification needed from function drivers to let
> UDC enter low power mode with u_ether as an example.
> Patch 2: New dt property to allow dwc3 runtime suspedn during bus suspend scenario. 
> Patch 3: This has the modification needed in the UDC driver to trigger runtime
> suspend whene a bus suspend interrupt is received. Since this is a platform
> dependent change it is made applicable through a dt property. This also handles
> resume and remote wakeup modifications from power management perspective.
> 
> Elson Roy Serrao (3):
>   usb: function: u_ether: Handle rx requests during suspend/resume
>   dt-bindings: usb: snps,dwc3: Add allow-rtsusp-on-u3 property
>   usb: dwc3: Modify runtime pm ops to handle bus suspend
> 
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 ++
>  drivers/usb/dwc3/core.c                       | 26 ++++++++--
>  drivers/usb/dwc3/core.h                       |  3 ++
>  drivers/usb/dwc3/gadget.c                     | 40 +++++++++++++---
>  drivers/usb/gadget/function/u_ether.c         | 47 +++++++++++++++----
>  5 files changed, 102 insertions(+), 19 deletions(-)
> 

-- 
cheers,
-roger
