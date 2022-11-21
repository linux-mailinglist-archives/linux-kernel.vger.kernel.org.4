Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD16327A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiKUPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiKUPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:16:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432F14014
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:12:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A40612AC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DDCC4314F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669043526;
        bh=Y2awgxzkLXn6V7BTrm8gtaQXfSLTb8RLAcCS65ZDhoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F3ijGoICNR9wHi5/fz7CdYAI9mQeZ9alLkqsoAF1PrfSMFgXCbzs+exVs8YBVGxuA
         8Da6ejJeLsfj40i6RUh/Shrm8foCHZlRu/K6q/rD4Q0YhZetpFstPz8j/Y9PUq/sPi
         Ek3gfenvjQpVdJdAV+OOWxO4RjkdLVjcW9gOsNUGAhPUIwhTDeKBu1Z53ThYihATbp
         VH1GsjDOjlpz4e7U1FEchNdUb0aTtu+X6KGwshZURSRLkgdp84vH6ptrSnQjNrcKw6
         gRVaOw9MUmDCoFnttED0weLKq9fifJxOGTyhvN3C63pujNdkaDJu7ERbkrkykCFsUQ
         cBA2aoQBnkAXA==
Received: by mail-yb1-f179.google.com with SMTP id e76so5185762yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:12:06 -0800 (PST)
X-Gm-Message-State: ANoB5pnRMQlTv5cy2XPXXxudteQLtVnEUASXF/jUDOjz1woRppO0rpob
        9hQQSiQFZXX1oburHZVhj436nfFY7A2Hg6KDJ0E=
X-Google-Smtp-Source: AA0mqf5/5xxD5cxs88zpMsUiAEvUlgBYebjN8ztc7BugrLv4fV04+FofRMCpOJDou4t7KLcL8prele+XwwE85kjzVxs=
X-Received: by 2002:a25:ed10:0:b0:6d0:5d59:dba1 with SMTP id
 k16-20020a25ed10000000b006d05d59dba1mr16252093ybh.68.1669043525889; Mon, 21
 Nov 2022 07:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20221119204435.97113-1-ogabbay@kernel.org> <20221119204435.97113-3-ogabbay@kernel.org>
 <9ce1bf9f-a481-92e3-c7cc-a1b41270468d@quicinc.com>
In-Reply-To: <9ce1bf9f-a481-92e3-c7cc-a1b41270468d@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 21 Nov 2022 17:11:39 +0200
X-Gmail-Original-Message-ID: <CAFCwf11doYdEEg8juX4Z3yOk8NfauWOV2hn8bCzmDY3k6-9sdg@mail.gmail.com>
Message-ID: <CAFCwf11doYdEEg8juX4Z3yOk8NfauWOV2hn8bCzmDY3k6-9sdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] accel: add dedicated minor for accelerator devices
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 11:47 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/19/2022 1:44 PM, Oded Gabbay wrote:
> > diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
> > index fac6ad6ac28e..703d40c4ff45 100644
> > --- a/drivers/accel/drm_accel.c
> > +++ b/drivers/accel/drm_accel.c
> > @@ -8,14 +8,25 @@
> >
> >   #include <linux/debugfs.h>
> >   #include <linux/device.h>
> > +#include <linux/xarray.h>
>
> Including xarray, but using idr
> This should be linux/idr.h
>
> This seems so minor, I don't think I advise spinning a v5 for it.  If a
> v5 is warranted elsewhere, obviously fix this.  If not, hopefully this
> can be fixed up by whoever applies it, or someone submits a follow up patch.
>
> Hopefully this is the only nit.  I would like to see this merged.
>
> -Jeff
Thanks,
I'll update it before sending the PR.
Oded
