Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274EF6AE5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCGQDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCGQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:02:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F497FD4D;
        Tue,  7 Mar 2023 08:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9B867CE1C17;
        Tue,  7 Mar 2023 16:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A69C433EF;
        Tue,  7 Mar 2023 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678204833;
        bh=XELSBi6E3+FbM/LiXAELFwCSOKXenhaobdNpjoZaK00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzCfG+RbhV7fm4X9jGeuuYZ7Dwg/nLxgYz3b192FZwW0x7HfiQxE67RBV3apXnLsc
         GmEZPntEaMxS1mHW1UiRtDnCD/+YdcgjHNM8UXEcNId/Tm75RtRwyEJx4Q8vcjU9Z8
         6ZPFwQU/PcaPr0DZuEK11FbgDf7ubX5YuF+qQ0eGGEK6ggoR00RhVZE5tjgNHc8MO9
         qL6U91zjPS5wYLBx6WdbtJdmthaakLZVWCK1PyoOAVO/JRv69gjqTuwoFp9/Vy2dxR
         knYGWBBgk2fbrb3R8hBFSea/pw0ZOCqnlQEtb04UQm0YJ13k3pfptTx/Tv+Z3qLPXy
         sk8V98dtkyISA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZZka-0000Od-JP; Tue, 07 Mar 2023 17:01:16 +0100
Date:   Tue, 7 Mar 2023 17:01:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: serial: qcom-geni-serial: Fix kdb/kgdb after
 port shutdown (again)
Message-ID: <ZAdfzHnRtBtcDbKK@hovoldconsulting.com>
References: <20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:32:11AM -0800, Douglas Anderson wrote:
> Commit d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations
> in progress at shutdown") was basically a straight revert of the
> commit it claims to fix without any explanation of why the problems
> talked about in the original patch were no longer relevant. Indeed,
> commit d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations
> in progress at shutdown") re-introduces the same problem that commit
> e83766334f96 ("tty: serial: qcom_geni_serial: No need to stop tx/rx on
> UART shutdown") fixed.
> 
> The problems are very easy to see by simply doing this on a
> sc7180-based Chromebook:
> 
> 1. Boot in developer mode with serial console enabled and kdb setup on
>    the serial console.
> 2. via ssh: stop console-ttyMSM0; echo g > /proc/sysrq-trigger
> 
> When you do the above you'll see the "kdb" prompt printed on the
> serial console but be unable to interact with it.
> 
> Let's fix the problem again by noting that the console port is never
> configured in DMA mode and thus we don't need to stop things for the
> console.
> 
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in progress at shutdown")

The offending commit broke serial console more generally by breaking TX
and thus hanging the system when stopping the getty on reboot.

The underlying bug has been there since this driver was first merged,
and as fixing it properly is going to be a bit involved, I was about to
post a patch equivalent to this one to fix the immediate regression and
get us back to status quo.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index d69592e5e2ec..74a0e074c2de 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1070,8 +1070,10 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
>  static void qcom_geni_serial_shutdown(struct uart_port *uport)
>  {
>  	disable_irq(uport->irq);
> -	qcom_geni_serial_stop_tx(uport);
> -	qcom_geni_serial_stop_rx(uport);
> +	if (!uart_console(uport)) {
> +		qcom_geni_serial_stop_tx(uport);
> +		qcom_geni_serial_stop_rx(uport);
> +	}
>  }
>  
>  static int qcom_geni_serial_port_setup(struct uart_port *uport)

Johan
