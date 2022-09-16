Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44B5BB438
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIPV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIPV7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:59:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7FB48A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:59:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x94so16112122ede.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tXp8Qm0HOu9b4+ry3VO9lluub8ul1uWHsnihCuufP3w=;
        b=Q39zWQsJZD445lUFViZ2aCm54TZUMrPkeF3F88WLVvuuYcpxoDzhCFhjgK7Miw1X4J
         vTUBHYPMxnpweHtFOgVUpZ0AFNYZLEHNNMquduvRqskfJOtkTcmwvzwsat05Z1HBH8pL
         Pa8fsG6pO3KNhCw44XALJuGbnSttZcWxEWr/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tXp8Qm0HOu9b4+ry3VO9lluub8ul1uWHsnihCuufP3w=;
        b=3CaVwTJvU/qFUtWW7nBoy4uZbHFHh3Vguxuw9/N4MauZ/2dO01rj9qWn6zwPxB8NQc
         rnIazNkEWQRZPlEYu8S050yBOXGr38xnvV+lqgCkrQEHm9C0fhg5SWIFHAUKygyK9sJx
         acrgX+rkTK5mJYyNq/3hBHQfBFG2utyP3LNLz6OiI+v7DH2BBlWQs+TgegOnu/p3BKnj
         1h1yhqPKwz8OeTOZNkoV+OrkoAJjQVtAuAerlTpD7DhIbVD9JxJiH/BVlqkO+MxBwjgO
         wtmjgYAaEMtE7K3aBtzrUERqBN3bSlIcbvjDASzETrTL3YHS23ZMOMPZ7J+cjxH5FFJx
         nHrg==
X-Gm-Message-State: ACrzQf1qJyquhGW6gT9q4gk5++Ppd887QH8unYGshoF1vZb6fGQ2GXYm
        Ka1IMktfad2NVZuO1pIEXFd2BVuR2EX98ofuxa0nlQ==
X-Google-Smtp-Source: AMsMyM57U86vqx070tvFh9n6rb5P+QpCeQvsVAXwmkT/JivZJxEBgvPEObSHPiDtHBStbOgCq0EOZ0nQ8Xzj88PWlsQ=
X-Received: by 2002:a05:6402:161a:b0:451:ea13:572e with SMTP id
 f26-20020a056402161a00b00451ea13572emr5613477edv.41.1663365574516; Fri, 16
 Sep 2022 14:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora> <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <0be0e378-1601-678c-247a-ba24d111b934@acm.org>
In-Reply-To: <0be0e378-1601-678c-247a-ba24d111b934@acm.org>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Fri, 16 Sep 2022 14:59:22 -0700
Message-ID: <CAG9=OMMS8gPFvGGH87bU2oBNk4WEBM5tG-z2Z5oaW4hUoKV8Jw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 1:01 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/16/22 11:48, Sarthak Kukreti wrote:
> > Yes. On ChromiumOS, we regularly deal with storage devices that don't
> > support WRITE_ZEROES or that need to have it disabled, via a quirk,
> > due to a bug in the vendor's implementation. Using WRITE_ZEROES for
> > allocation makes the allocation path quite slow for such devices (not
> > to mention the effect on storage lifetime), so having a separate
> > provisioning construct is very appealing. Even for devices that do
> > support an efficient WRITE_ZEROES implementation but don't support
> > logical provisioning per-se, I suppose that the allocation path might
> > be a bit faster (the device driver's request queue would report
> > 'max_provision_sectors'=0 and the request would be short circuited
> > there) although I haven't benchmarked the difference.
>
> Some background information about why ChromiumOS uses thin provisioning
> instead of a single filesystem across the entire storage device would be
> welcome. Although UFS devices support thin provisioning I am not aware
> of any use cases in Android that would benefit from UFS thin
> provisioning support.
>
Sure (and I'd be happy to put this in the cover letter, if you prefer;
I didn't include it initially, since it seemed orthogonal to the
discussion of the patchset)!

On ChromiumOS, the primary driving force for using thin provisioning
is to have flexible, segmented block storage, both per-user and for
applications/virtual machines with several useful properties, for
example: block-level encrypted user storage, snapshot based A-B
updates for verified content, on-demand partitioning for short-lived
use cases. Several of the other planned use-cases (like verified
content retention over powerwash) require flexible on-demand block
storage that is decoupled from the primary filesystem(s) so that we
can have cryptographic erase for the user partitions and keep the
on-demand, dm-verity backed executables intact.

Best
Sarthak

> Thanks,
>
> Bart.
