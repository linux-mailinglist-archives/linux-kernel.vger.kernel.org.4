Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193E667E54A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjA0MeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjA0MeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:34:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E6F43467;
        Fri, 27 Jan 2023 04:34:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0646B81F99;
        Fri, 27 Jan 2023 12:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3CDC433D2;
        Fri, 27 Jan 2023 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674822839;
        bh=TS2+CpKa2cp61H4L2xyxqqO1Xa+9EPd/tgoYGYbo2PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOIO/dmBppqhBtGmbssqspC6gF08zWXRP3blx3PpWb0QrYlXVWOIZA8xnJc3C+eWu
         5kyaDq09s3nJoxaQTN1VT1ciyn4JxcwsT9/Jl/kmN/S2+jN0xhoMHwTeCOCpIUG7wd
         bvY4O/P0xk2eSogKpMu0lC1ZQFj2jr5pjAoJdOX4=
Date:   Fri, 27 Jan 2023 13:33:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Liang He <windhl@126.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Zou Wei <zou_wei@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/16] of: device: make of_device_uevent_modalias()
 take a const device *
Message-ID: <Y9PEtP7oLjRJTxFM@kroah.com>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-2-gregkh@linuxfoundation.org>
 <CAL_JsqJ4QsLym-bQGGjUpzT14MYuTE1n8BQkGn6Ey9NiFF7u7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ4QsLym-bQGGjUpzT14MYuTE1n8BQkGn6Ey9NiFF7u7w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 08:54:04AM -0600, Rob Herring wrote:
> On Wed, Jan 11, 2023 at 5:30 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > of_device_uevent_modalias() does not modify the device pointer passed to
> > it, so mark it constant.  In order to properly do this, a number of
> > busses need to have a modalias function added as they were attempting to
> > just point to of_device_uevent_modalias instead of their bus-specific
> > modalias function.  This is fine except if the prototype for a bus and
> > device type modalias function diverges and then problems could happen.  To
> > prevent all of that, just wrap the call to of_device_uevent_modalias()
> > directly for each bus and device type individually.
> 
> Why not just put the wrapper function in the DT code instead of making
> 4 copies of it?

Ok, I looked at doing this today, but in the end, making "4" copies of
this is simpler overall.  To do it your way would require a "const"
version of the function be added to the core, and then convert these 4
busses to use that, and then when the real function is converted to be
const, move all of these functions back over to use that again.

Lots of churn, and then in the end, we still have the mismatch of a
the same function callback being used in two different types of
callbacks (one a bus, one a class).  This way we separate them to make
things much more obvious and self-contained.

So I'll keep this as-is for now, thanks.

greg k-h
