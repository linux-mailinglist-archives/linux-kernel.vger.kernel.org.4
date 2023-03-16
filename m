Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046FF6BCED2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCPL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCPL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85323BD4F5;
        Thu, 16 Mar 2023 04:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8183061FEE;
        Thu, 16 Mar 2023 11:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C72BC433D2;
        Thu, 16 Mar 2023 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678967952;
        bh=JTnjYbj66aN40aUIHsnXpnQOvlOwhzGAN41UkEtNOfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5x4qxlnXN/FxScIYVQLl3wY7G+sY6nohkE9R9DKJKUci9iLi5ng3MakWJHStU+OO
         Rd3z/9l/qUvHUFRQRt1/DEmkpF4TpXq6eU7DuS6bxc3JxWEU/VvyZ/LhiVyZ4QrPmQ
         yME36sVYK8hNymm5mq5MWaoFzj6DbTXaKYpJY+bo=
Date:   Thu, 16 Mar 2023 12:59:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: uart_poll_init() should power on the UART
Message-ID: <ZBMEjp16fBNE33o4@kroah.com>
References: <20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid>
 <20230307073155.2.I106c39498d8094c6f5e7ada42c7db17aa5c64e48@changeid>
 <CAD=FV=XFEYPbC64TFLVUmky=1Y-b_iyqiwrALvjKTM_NWr34Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XFEYPbC64TFLVUmky=1Y-b_iyqiwrALvjKTM_NWr34Dg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:53:02PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Mar 7, 2023 at 7:32 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > On Qualcomm devices which use the "geni" serial driver, kdb/kgdb won't
> > be very happy if you use it but the resources of the port haven't been
> > powered on. Today kdb/kgdb rely on someone else powering the port
> > on. This could be the normal kernel console or an agetty running.
> > Let's fix this to explicitly power things on when setting up a polling
> > driver.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/tty/serial/serial_core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Just in case it's not obvious, even though we ended up going with
> Johan's series [1] instead of patch #1 of my series, patch #2 and #3
> of my series are still relevant. I can repost the series without patch
> #1 if it's helpful.
> 
> [1] https://lore.kernel.org/r/20230307164405.14218-1-johan+linaro@kernel.org

Ye,s it's not obvious at all.  Please resubmit.

thanks,

greg k-h
