Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506126A189C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBXJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:19:01 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF261EFE;
        Fri, 24 Feb 2023 01:18:58 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 15D5724000A;
        Fri, 24 Feb 2023 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677230337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3ozjZdZR8sNKNPhgcvAJ2WlN7ZmVjanXl59zU7ERyw=;
        b=EUMdp5xYUoX1LkvoICtaztv5JY7YBwkJHyO9aZnKMY03yXU9wbzFWDHgoX0Vw0fXdE7n3f
        i8gvDC2lRnZ099HYY3Gu6nuRi2S4OD11pT0GlmaNfo+e0eiSd6PMQe83aG5vSy9xMjbelc
        tVPKuGTdlG/9tubvnhnxVd1Moy9CHwlbnJUkLHOoMpG3Set/robfhj6iKX7IL0vDPTGUip
        WgPoPGgUzOEdmXC0lFU0Uvrha+ML5O7WOPNgBrB68WcApTBuwgFTyxI8/8soWVQ/GciJOT
        BKLZVApxKUjf6u+2ca2d1orP8NKYxRz/+utKdsVQjiuVnehXDOrDWaWYngIxYw==
Date:   Fri, 24 Feb 2023 10:18:54 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell
 offset
Message-ID: <Y/iA/sQh/p9980qQ@mail.local>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-17-johan+linaro@kernel.org>
 <Y+bJqIpgZ0fbzL2b@mail.local>
 <Y+dQXlABqc/uzIXc@hovoldconsulting.com>
 <Y+fF94EOkUuMq9Fc@mail.local>
 <Y+0NiJsp4JjeyrqH@hovoldconsulting.com>
 <Y/hzcxrS3D0O3s9U@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/hzcxrS3D0O3s9U@hovoldconsulting.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 09:21:07+0100, Johan Hovold wrote:
> Hi Alexandre,
> 
> On Wed, Feb 15, 2023 at 05:51:20PM +0100, Johan Hovold wrote:
> > On Sat, Feb 11, 2023 at 05:44:39PM +0100, Alexandre Belloni wrote:
> > > On 11/02/2023 09:22:54+0100, Johan Hovold wrote:
> > > > On Fri, Feb 10, 2023 at 11:48:08PM +0100, Alexandre Belloni wrote:
> > > > > On 02/02/2023 16:54:42+0100, Johan Hovold wrote:
> > > > > > On many Qualcomm platforms the PMIC RTC control and time registers are
> > > > > > read-only so that the RTC time can not be updated. Instead an offset
> > > > > > needs be stored in some machine-specific non-volatile memory, which a
> > > > > > driver can take into account.
> > > > > > 
> > > > > > Add an 'offset' nvmem cell which can be used to store a 32-bit offset
> > > > > > from the Unix epoch so that the RTC time can be updated on such
> > > > > > platforms.
> > > > > > 
> > > > > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > > > > The patch doesn't apply because this part of the context is not
> > > > > upstream. Can you rebase?
> > > > 
> > > > Ah, sorry about that. That's because of commit 51b3802e7960
> > > > ("dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property") which
> > > > is now in Linus's tree (and your rtc-fixes branch).
> > > > 
> > > > Do you still want me to rebase or do you prefer to handle the conflict
> > > > some other way?
> > > 
> > > Ah yes, my bad, I'll merge rtc-fixes in rtc-next before applying
> > 
> > Sorry about reminding so soon, but with the merge window approaching
> > fast, will you be able to get this merged for 6.3?
> 
> Looks like these last two patches adding support for the nvmem offset
> has not been applied yet. Still hoping you can get them merged for 6.3
> even if this one does not apply cleanly unless you first merge your
> rtc-fixes branch.

This is still my plan, I'm travelling right now but they will be sent for
6.3

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
