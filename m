Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965965E88E5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 08:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiIXG4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiIXG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 02:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0FB1C915;
        Fri, 23 Sep 2022 23:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A6AC60B5B;
        Sat, 24 Sep 2022 06:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E87EC433C1;
        Sat, 24 Sep 2022 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664002587;
        bh=BSAa+I4RIdZWGzshe6klmFRiSF/Qy5u0G3INxPjE03s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPA1JcMfo1TKe/PFlRooU2HR/7jYkduwKByfrkCrKpay2GR6NJzYjFL9uBcvYlBzy
         XKht7TJIZZH9HjQWFtohzuL1GaF/MkdGnMOqJD/xveeztbAD+RFVBHwEH89TtcQ7o8
         eUFkz+CRiKLWXbj5jIbeh8EwCuYfdqYelYFu+qtE=
Date:   Sat, 24 Sep 2022 08:56:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeff Harris <jefftharris@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: serial: New xr20m117x driver questions
Message-ID: <Yy6qOmuuzIffRQGC@kroah.com>
References: <CAGMfbUO=Zy_nXJ9wKV5r2xRBuK7_X3kL2TvM1jWB_hTPUvhnbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGMfbUO=Zy_nXJ9wKV5r2xRBuK7_X3kL2TvM1jWB_hTPUvhnbw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:29:52AM -0400, Jeff Harris wrote:
> I have a driver for the MaxLinear XR20M117x family of UARTs that I'd like
> to contribute but have a couple questions.  The driver is heavily based on
> the existing sc16is7xx driver.  The driver started with the sample driver
> from MaxLinear for Linux 3.x.x, but as the integration of their driver
> proceeded into our 4.4 kernel, there were features and fixes missing that
> were present in the current sc16is7xx driver.
> 
> The register set is similar, but there are a few places where the behavior
> is different.  Would it be best to create a new driver or add the XR20M117x
> UARTs to the sc16is7xx driver with a flag to choose one behavior or the
> other?

Probably a flag, but let's see the patch to be sure.

> I have developed and tested the driver as a back-port of the mainline
> sc16is7xx driver to the 4.4 kernel used on our embedded platform.  I don't
> have a ready method to test the driver with a newer kernel (other than
> ensuring compilation success).  Is that a concern for accepting the driver?

Please don't use any new devices with the obsolete and insecure and
out-of-date 4.4 kernel tree, that's going to be a regulatory nightmare
when you realize how broken it is.

Anyway, it has to work in the latest kernel tree for us to be able to
accept it as we can't go back in time and do new development on old
kernels :)

thanks,

greg k-h
