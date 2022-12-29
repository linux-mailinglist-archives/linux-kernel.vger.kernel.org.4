Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950DC658A67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiL2IS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiL2ISF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:18:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1093613DCE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:17:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r26so20575126edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7n+B+X0KvL5FYpt4R5yWJ/ag0L0NLxa0tbY9qucKwuI=;
        b=aM/Ttwb0xqobbPsfNShnECgwZZ0RVTZPBATDxWKlrmgoYc131+i6w0GKSBj1PdVklm
         gbChCXaQ6kiGtiwXqjToSpSW7zNn+YGWX5SWfwTFn1L5KuHM7Q7U66SHcHp9Wg2KrYUe
         zxjDtJAp6e++CJq9Z/mH0g4XiyUZ6LJVU+4AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7n+B+X0KvL5FYpt4R5yWJ/ag0L0NLxa0tbY9qucKwuI=;
        b=H83CBPDtIx/C4MqOQDbhvneJ3Vo72zb0mv8pE6O92hurCUfghDkrwlWTbgRyuywHoW
         Wnmkxfiq60V7nlnLopQbr55DB2Z3NePjpDVrmhViHRhRpwoaeik+lARx6M8ZG0om6fN1
         9EvnSbuBxqZja0R73v8Oi6O+JpnesdK7UkpuYCnwjR8f/DBzoX41S/899JcypD3jgdnc
         1wPJOooL5I+mTSbmtD4Ml1V6C0n50k7o/oEvgvlib08HzpRpOGQBIr63M8lJhVjLA2rS
         BQGyt/R7CA+8I7WOtwRfALHop5+bBVGDPAsWAJl53gxuLmFFycn6bu2h52dTP3OtdygR
         /mPQ==
X-Gm-Message-State: AFqh2kqz6HCG2Qei7am7EiZeFIfok+ePOLu74wuujAvTV0ufdQRZiIiS
        yt7ZRyg21a45X12/ZiHII9hd13FWOOwMZXTrRSjNYw==
X-Google-Smtp-Source: AMrXdXulwl3zEgOGWwmMivflDb4UfyGNGI7lU4m/aeAvt/3L5Hf+inrJtG+WSFp0FPQl5mpy0l5FjfKOF5TBfRVSOU8=
X-Received: by 2002:a50:fe17:0:b0:487:e554:31e8 with SMTP id
 f23-20020a50fe17000000b00487e55431e8mr670416edt.353.1672301854647; Thu, 29
 Dec 2022 00:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-2-sarthakkukreti@google.com> <Yy3NeY02zEMLTdsa@redhat.com>
In-Reply-To: <Yy3NeY02zEMLTdsa@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 29 Dec 2022 00:17:23 -0800
Message-ID: <CAG9=OMO=j=kOGX4hnYSt490wURF_a8ZM5MctKpeV2TaiKS8RhQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] block: Introduce provisioning primitives
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 8:15 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Thu, Sep 15 2022 at 12:48P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
> > Introduce block request REQ_OP_PROVISION. The intent of this request
> > is to request underlying storage to preallocate disk space for the given
> > block range. Block device that support this capability will export
> > a provision limit within their request queues.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/blk-core.c          |  5 ++++
> >  block/blk-lib.c           | 55 +++++++++++++++++++++++++++++++++++++++
> >  block/blk-merge.c         | 17 ++++++++++++
> >  block/blk-settings.c      | 19 ++++++++++++++
> >  block/blk-sysfs.c         |  8 ++++++
> >  block/bounce.c            |  1 +
> >  include/linux/bio.h       |  6 +++--
> >  include/linux/blk_types.h |  5 +++-
> >  include/linux/blkdev.h    | 16 ++++++++++++
> >  9 files changed, 129 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 8bb9eef5310e..be79ad68b330 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -57,6 +57,7 @@ void blk_set_default_limits(struct queue_limits *lim)
> >       lim->misaligned = 0;
> >       lim->zoned = BLK_ZONED_NONE;
> >       lim->zone_write_granularity = 0;
> > +     lim->max_provision_sectors = 0;
> >  }
> >  EXPORT_SYMBOL(blk_set_default_limits);
> >
> > @@ -81,6 +82,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
> >       lim->max_dev_sectors = UINT_MAX;
> >       lim->max_write_zeroes_sectors = UINT_MAX;
> >       lim->max_zone_append_sectors = UINT_MAX;
> > +     lim->max_provision_sectors = UINT_MAX;
> >  }
> >  EXPORT_SYMBOL(blk_set_stacking_limits);
> >
>
> Please work through the blk_stack_limits() implementation too (simple
> min_not_zero?).
>
(Sorry, I might have misunderstood what you meant) Doesn't the chunk
at L572 handle this:


@@ -572,6 +588,9 @@ int blk_stack_limits(struct queue_limits *t,
struct queue_limits *b,
        t->max_segment_size = min_not_zero(t->max_segment_size,
                                           b->max_segment_size);

+       t->max_provision_sectors = min_not_zero(t->max_provision_sectors,
+                                               b->max_provision_sectors);
+
        t->misaligned |= b->misaligned;
