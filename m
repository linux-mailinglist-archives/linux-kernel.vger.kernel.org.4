Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3870DD3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjEWNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbjEWNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BDBDB;
        Tue, 23 May 2023 06:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3CA60BA6;
        Tue, 23 May 2023 13:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471A2C433EF;
        Tue, 23 May 2023 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684847475;
        bh=Sddi6O0W7Q4lS+qA4cWluXzgfscZUqbIj8VrG2ya2OU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=s9zE2SLW1Kcosn3utWP71RzVK9W9s7NPberv0YFBtxz1tMovUCjSnHPexxHdIJ4LI
         P57uNVw8heqJLBVr7lnN7bV2qC2bJbunDvXVETzYJVNIg6EHh1vcJs4wFOI052YcaL
         XjSv0SFKKf09sW03GjkO9iXinC1C8IDBXgkJ7tFan+sHkIyoSN81qw1KZWyrtuy6+i
         JpdDh2zJP4VsmggP6dGodjbRvZXp8ST8NoY+0x4WSuIRClUOEKeiXHAq/+A9axcPX8
         2uTLQiiCWLSqsWExsj0K4v3iIM8hUSCzbY4oeB0h8RvOlWWYtKGwS/s1cGcqhon1YZ
         zRLl+FHmHIi/g==
Date:   Tue, 23 May 2023 15:11:11 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
cc:     Fei Shao <fshao@chromium.org>, Jeff LaBundy <jeff@labundy.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Fix Goodix touchscreen power leakage for MT8186
 boards
In-Reply-To: <CAD=FV=XVubT-ozs7JssBPz+9UcsZb+q0My8Aq6HNs-nFiJnogg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2305231510270.29760@cbobk.fhfr.pm>
References: <20230427035656.1962698-1-fshao@chromium.org> <CAD=FV=XVubT-ozs7JssBPz+9UcsZb+q0My8Aq6HNs-nFiJnogg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Doug Anderson wrote:

> > These changes are based on the series in [1], which modified the
> > i2c-hid-of-goodix driver and removed the workaround for a power leakage
> > issue, so the issue revisits on Mediatek MT8186 boards (Steelix).
> >
> > The root cause is that the touchscreen can be powered in different ways
> > depending on the hardware designs, and it's not as easy to come up with
> > a solution that is both simple and elegant for all the known designs.
> >
> > To address the issue, I ended up adding a new boolean property for the
> > driver so that we can control the power up/down sequence depending on
> > that.
> >
> > Adding a new property might not be the cleanest approach for this, but
> > at least the intention would be easy enough to understand, and it
> > introduces relatively small change to the code and fully preserves the
> > original control flow.
> > I hope this is something acceptable, and I'm open to any better
> > approaches.
> >
> > [1] https://lore.kernel.org/all/20230207024816.525938-1-dianders@chromium.org/
> >
> > Changes in v4:
> > - Minor coding style improvement
> >
> > Changes in v3:
> > - In power-down, only skip the GPIO but not the regulator calls if the
> >   flag is set
> >
> > Changes in v2:
> > - Use a more accurate property name and with "goodix," prefix.
> > - Do not change the regulator_enable logic during power-up.
> >
> > Fei Shao (2):
> >   dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend"
> >     property
> >   HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend"
> >     property
> >
> >  .../bindings/input/goodix,gt7375p.yaml           |  9 +++++++++
> >  drivers/hid/i2c-hid/i2c-hid-of-goodix.c          | 16 +++++++++++++++-
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> Just double-checking if there is any work needed on this series. I
> think it's ready to land but I wanted to double-check.

I don't think I've been CCed on the dt-binding part (patch 1/2 I guess). 
Has it been Acked? If so, I will happily take it through hid.git, but 
please send it my way.

Thanks,

-- 
Jiri Kosina
SUSE Labs

