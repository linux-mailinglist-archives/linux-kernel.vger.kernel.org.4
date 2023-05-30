Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A7716593
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjE3PCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjE3PCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538EE5;
        Tue, 30 May 2023 08:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C43C63019;
        Tue, 30 May 2023 15:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B48C433D2;
        Tue, 30 May 2023 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685458968;
        bh=IGu/SIS5nO+4P63qYCwsR2tsSMfXDgOvY5qdgU7R3pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeOqiEd67vy+w2qgzA1AOXF48C/qda8KQnb2clUO4Lt0pbwrZxAMAS9XwMJ8jbC/f
         aS5LzicX0nY3qN76R2qS3RSZ31juaccabl3rwwcM13ROY3MZaTFJbuabKcQt0mdQ/5
         kUWxnloNP1X8osiJbfc96r3wlc0JRNEwyhmo2ARxM1UDxzikP5JxlqWC2FT98MYBfJ
         /SWU2bTjugptGZNzFWCjiI73SZycy6wKnoC1Gp4VxVISrbl99blM+ioa/HXJX3btNd
         RecKa3wrLjBu8t4DOYDYvvfiNoA3TvqxoIDVDwnreoXFZc41EpVRCnTuaA1ymt9i++
         RoivMOGGNV8rw==
Date:   Tue, 30 May 2023 08:06:31 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mehul Raninga <quic_mraninga@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vdadhani@quicinc.com,
        quic_vtanuku@quicinc.com, quic_vnivarth@quicinc.com
Subject: Re: [PATCH] serial: qcom_geni_serial: Setup serial port after Deep
 sleep
Message-ID: <20230530150631.7eg6nkre6sva5dcz@ripper>
References: <20230530111557.10944-1-quic_mraninga@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530111557.10944-1-quic_mraninga@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:45:57PM +0530, Mehul Raninga wrote:
> While exiting deep sleep, serial port loses its configuration
> hence it prints garbage characters on console.

Presumably it lost its configuration sometime after suspend, rather than
while resuming the system?

> 
> Set serial port configuration while resume from deep sleep.
> 

What happens if you do this unconditionally?

> Signed-off-by: Mehul Raninga <quic_mraninga@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 8582479f0211..c04b8fec30ba 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -20,6 +20,7 @@
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
>  #include <dt-bindings/interconnect/qcom,icc.h>
> @@ -1737,6 +1738,8 @@ static int qcom_geni_serial_sys_resume(struct device *dev)
>  	if (uart_console(uport)) {
>  		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
>  		geni_icc_set_bw(&port->se);
> +		if (pm_suspend_via_firmware())

I'm not familiar with this api, but aren't all our systems implementing
firmware-assisted suspend?

Regards,
Bjorn

> +			qcom_geni_serial_port_setup(uport);
>  	}
>  	return ret;
>  }
> -- 
> 2.17.1
> 
