Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F186AE7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCGRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCGRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:08:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400FA59E79;
        Tue,  7 Mar 2023 09:03:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1DD8B81995;
        Tue,  7 Mar 2023 17:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B5CC433A0;
        Tue,  7 Mar 2023 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678208545;
        bh=xyhOP3knmAZWGdgwRUztgCp151B23i7g++xpeMHd9wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVRtuL9RpWQEUcOTGTZyKOGqpg2j2zx/oLVMJiif5LNZ1K8Dp/MOsCSAvYuzOxyRL
         LNEUxxf8ys8kYcnTvSt6GLl72R7oozge5RfyEvz9+h0dkMrZeJ4qzYacjxq+QE4lo1
         R4t7eMwi7pMYytE93SlQxofS192rrccUHbM8WK43DexRtkZQCUx5zlE5FOPPKri2YV
         ooT8G6U+ZOHritqcKURl+ZtGH3FKSoFbcnP/ckjCnjUwNHsqVKyNZu8Mznt6aqpzcI
         Pn1qEitvICUh+46roiLc0D2DLYH6KOLV3/xKQI7FdeCML2/JAOxTXzf3AlrLK2O1wM
         yDHGpLZbtNX+A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZaiT-0003rm-G8; Tue, 07 Mar 2023 18:03:09 +0100
Date:   Tue, 7 Mar 2023 18:03:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
Message-ID: <ZAduTSTirQbqZlIg@hovoldconsulting.com>
References: <20230307164405.14218-1-johan+linaro@kernel.org>
 <CACMJSes3usJUvCsrMBR_9dDGCbo2y7JqA8-B5mP28H2Cjg-v6A@mail.gmail.com>
 <CACMJSesztZbB53QPaiLg+GKghJ-8MbiS60t8CbN_m8Wcph3-9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSesztZbB53QPaiLg+GKghJ-8MbiS60t8CbN_m8Wcph3-9g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:47:27PM +0100, Bartosz Golaszewski wrote:
> On Tue, 7 Mar 2023 at 17:44, Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > On Tue, 7 Mar 2023 at 17:43, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > This series fixes some of the fallout after a recent series adding
> > > support for DMA transfers to the Qualcomm geni serial driver.
> > >
> > > Most importantly it fixes a hang during reboot when using a serial
> > > console and the getty is stopped during reboot.
> > >
> > > Doug just posted an equivalent fix here:
> > >
> > >         https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
> > >
> > > but the commit message only mentions the regression with respect to
> > > kgdb, which is not as widely used serial consoles generally, so I
> > > figured I'd post my version for completeness.
> > >
> > > Either version of that fix should address the immediate regression, but
> > > fixing the underlying problems which have been there since the driver
> > > was first merged is going to be a bit more involved.
> > >
> > > The rest of the series fixes a few bugs in the new DMA support that I
> > > found while investigating the console regression.
> > >
> > > Johan
> > >
> > >
> > > Johan Hovold (4):
> > >   serial: qcom-geni: fix console shutdown hang
> > >   serial: qcom-geni: fix DMA mapping leak on shutdown
> > >   serial: qcom-geni: fix mapping of empty DMA buffer
> > >   serial: qcom-geni: drop bogus uart_write_wakeup()
> > >
> > >  drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.39.2
> > >
> >
> > Hey Johan,
> >
> > Douglas and Srini beat you to these fixes but thanks!

> Nevermind, I read your other message now. And also patch 3/4 looks right.

Heh, this hang has been in linux-next for over a month and I've
actively tried to not spend time on investigating it in the hope that
someone else would be beat me to it before I moved to 6.3-rc. :)

Obviously I may be a bit biased, but I prefer this series over the
alternate fixes as the commit messages are a bit more complete and my
version of the empty DMA buffer fix is a bit cleaner.

Johan
