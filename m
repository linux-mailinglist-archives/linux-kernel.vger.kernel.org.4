Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2B6B0039
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCHHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCHHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:51:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B5984FD;
        Tue,  7 Mar 2023 23:51:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EA377CE1E87;
        Wed,  8 Mar 2023 07:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EACBC4339B;
        Wed,  8 Mar 2023 07:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678261873;
        bh=eDUO7aWiJI6PcUc6kJ44VSrhyl3mjhoGXUohXuPNExA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tq3SX0oMDUYD7p+E0wpqhUjxSxcpKbK7SjqJP1wc/pObkFVJ2KHptlK/BKDWZ00gn
         xTeGU7xPeJcEgmjF6J/jM+fbnOcx0OjXaP25beeSpYUUhbn204Jy7e4rlKfJUJXnAk
         3zbmw043ihfxC20+FBXECrF+DRWbUGgWMhgjzYh1VrRWQk/yTU62xPqEvoVFtpdkdd
         4dB4LbJA6iTKTSI3kQuT5iMCNFbMZIrajidnSspcHbSpQSTZEiPx5BTvpDBCgTWGi5
         qkh1qHh9grDDZwXnNfQZjiWPIuy88i/iDOTXSX0bXPrNmnwU7IwE5ktxC9ll54iISt
         cySXgmHkkAFGw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZoab-0007bT-Vx; Wed, 08 Mar 2023 08:51:58 +0100
Date:   Wed, 8 Mar 2023 08:51:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] serial: qcom-geni: fix mapping of empty DMA buffer
Message-ID: <ZAg+neaKU51D59QJ@hovoldconsulting.com>
References: <20230307164405.14218-1-johan+linaro@kernel.org>
 <20230307164405.14218-4-johan+linaro@kernel.org>
 <CAD=FV=VR5oCThAuc29Bum-VHQUcH_H+s4nr55YpJk1aYaqZKTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VR5oCThAuc29Bum-VHQUcH_H+s4nr55YpJk1aYaqZKTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:41:46AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Tue, Mar 7, 2023 at 8:43 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Make sure that there is data in the ring buffer before trying to set up
> > a zero-length DMA transfer.
> >
> > This specifically fixes the following warning when unmapping the empty
> > buffer on the sc8280xp-crd:
> >
> >    WARNING: CPU: 0 PID: 138 at drivers/iommu/dma-iommu.c:1046 iommu_dma_unmap_page+0xbc/0xd8
> >    ...
> >    Call trace:
> >     iommu_dma_unmap_page+0xbc/0xd8
> >     dma_unmap_page_attrs+0x30/0x1c8
> >     geni_se_tx_dma_unprep+0x28/0x38
> >     qcom_geni_serial_isr+0x358/0x75c
> >
> > Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 2aa3872e6283..9871225b2f9b 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -631,6 +631,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> >         if (port->tx_dma_addr)
> >                 return;
> >
> > +       if (uart_circ_empty(xmit))
> > +               return;
> 
> I guess you could remove the uart_circ_empty() test in
> qcom_geni_serial_handle_tx_dma() now?

I considered that, but decided to leave it in as it makes the flow in
qcom_geni_serial_handle_tx_dma() a bit more obvious (and that function
already handles the related uart_write_wakeup() which the check could
potentially be combined with).

> In any case, with or without that:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks for reviewing.

Johan
