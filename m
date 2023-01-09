Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6155A661E80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 06:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjAIFqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 00:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjAIFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:46:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7BFF5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 21:46:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 725A0B80CB8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13236C433D2;
        Mon,  9 Jan 2023 05:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673243179;
        bh=oWKT64cyNa8ErN5yILzdB7muatJ9WA8Jd9QKW9SzBYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPCTin5pOx2rnZdmgjmIrxLo797O7HjbLDhuuFH+vF/1gDjpoldinTIDL9U4hjMXJ
         58jPJxwOf4NwGqkHLZhRmot53mGx+JQX8Lb6ppb50cGsX0aHLY8Lz3xKWT4kHBoN5n
         d4VP+zUTzIk1v6vpS/L3IByvdHItYJTw+WhbJk3hN5mTzOk7vGON+sFk8dDaeH2VKd
         r6NYt5vra6/rNffsmlYHkm/pfF5u3eP9fKrjYT8CiAvOY4hoAHJon9DOgMZpoEx9Yg
         HIsCPgEJ7/nYqUitS2wtTCiYs6CWL7f7dtuKNtBiVqRb50dpFSIAQp1afZGM6yeCiI
         DA354fAlTab/A==
Date:   Mon, 9 Jan 2023 13:46:15 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chromeos: cros_ec: Use per-device lockdep key
Message-ID: <Y7uqJ+DPyqFxaQUV@google.com>
References: <20230106045537.1243887-1-wenst@chromium.org>
 <Y7flCydDtLVwsXIJ@google.com>
 <CAGXv+5Gnc6tCjO95VjBJ4F5p5bnS+M96at3ErpSX==3qPwNUsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXv+5Gnc6tCjO95VjBJ4F5p5bnS+M96at3ErpSX==3qPwNUsg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 01:43:57PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jan 6, 2023 at 5:08 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Fri, Jan 06, 2023 at 12:55:37PM +0800, Chen-Yu Tsai wrote:
> > > Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
> > > the following lock sequences:
> > >
> > > 1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
> > > 2. lock(&ec_dev->lock); lock(prepare_lock);
> > >
> > > The actual dependency chains are much longer. The shortened version
> > > looks somewhat like:
> > >
> > > 1. cros-ec-rpmsg on mtk-scp
> > >    ec_dev->lock -> prepare_lock
> > > 2. In rt5682_i2c_probe() on native I2C bus:
> > >    prepare_lock -> regmap->lock -> (possibly) i2c_adapter->bus_lock
> > > 3. In rt5682_i2c_probe() on native I2C bus:
> > >    regmap->lock -> i2c_adapter->bus_lock
> > > 4. In sbs_probe() on cros-ec-i2c (passthrough) I2C bus on cros-ec
> > >    i2c_adapter->bus_lock -> ec_dev->lock
> > >
> > > While lockdep is correct that the shared lockdep classes have a circular
> > > dependency, it is bogus because
> > >
> > >   a) 2+3 happen on a native I2C bus
> > >   b) 4 happens on the actual EC on ChromeOS devices
> > >   c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
> > >      happen to expose a cros-ec interface, but do not have a passthrough
> > >      I2C bus
> > >
> > > In short, the "dependencies" are actually on different devices.
> >
> > Path of 4 looks weird to me.
> >
> > Could you point out where sbs_probe() gets to acquire ec_dev->lock?
> 
> sbs_probe() calls sbs_get_battery_presence_and_health(), which
> 
>   -> does an I2C transfer. This SBS instance is connected on the I2C bus
>      on the EC, so the I2C transfer
> 
>      -> acquires i2c_adapter->bus_lock, and

I see.

Another question: the i2c_adapter here should be different from the native
I2C bus in 2 and 3.  Did they really form the circular dependencies?
