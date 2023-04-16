Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A346E3899
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDPNTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025DF9D;
        Sun, 16 Apr 2023 06:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E84C60F52;
        Sun, 16 Apr 2023 13:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D6C433EF;
        Sun, 16 Apr 2023 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681651175;
        bh=PO2AdSlTeCvfUbMy2pMYOaf6qyqjQAif6RUcDHaH/eI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VpgdkaqoiHo6LihovF0kAWGRzF0o+Q+bZI14oq1KLzjr0b0o70HPpKVPDzvaBH8E1
         rLf8owSN9dcEn4bwwJ8VMnyVwSAJxGENRb6AGMn32pHMZHsBoFy2bvDdZrAKrnhipi
         bAEYAoM11Nn6grAXEUHMiMqro574vOrFdLmk4wxPQpZShn3XFMjhJV5p1zJPxGebfW
         gNWaFfgtcfOiBRomDvrHWNq49xYZLKkwgmvU2MLMX4YrglzKKFBMxyr2ZmYR1N0Gps
         MfhNUbgFIw76Bdsg3xUVJSAUlitG+CY48GyhdXI6FO3pHybgSjNdKbczpODPUeGqah
         XzeHUszeAPBJA==
Date:   Sun, 16 Apr 2023 14:19:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Message-ID: <20230416141936.6e78b6c7@jic23-huawei>
In-Reply-To: <c221d0b5-a142-8154-08a1-5947d037d864@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
        <884c8f386541ac572939b8993df7aea6ad99613b.1677331779.git.mazziesaccount@gmail.com>
        <20230408113029.35429440@jic23-huawei>
        <c221d0b5-a142-8154-08a1-5947d037d864@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 11:52:05 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 4/8/23 13:30, Jonathan Cameron wrote:
> > On Sat, 25 Feb 2023 15:55:25 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> + * @IIO_CHAN_INFO_INT_TIME:	Integration time. Time during which the data is
> >> + *				accumulated by the device.  
> > 
> > Unit? (seconds I think).  
> 
> Holy moly. Thanks for bringing this up now. I just checked this and the 
> API doc indeed says clearly and loud the unit is in seconds. This means 
> the BU27034 driver as well as the gain-time-scale helper does this 
> wrong. I hope you can postpone sending them upstream until this gets 
> fixed. I'll try to cook incremental patch on top of the iio/togreg - but 
> I am not sure if I can do it today as I need to run after an hour... 
> Sorry and thanks!

It's a fix so we have time.  This one we'd take even if the driver
had made it to a release, but then we'd manage to annoy people.

Jonathan

> 
> Yours,
> 	-- Matti
> 

