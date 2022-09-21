Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ADE5BF5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIUFyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIUFyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:54:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0FDFBE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 22:54:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so11190064ejy.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 22:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O+/FFDzqjGUa/uvDMSfAuiQjEkg5o9+lgPvGbc+n8wE=;
        b=M2HNg17GHPWM6YaoxXWHCj0Bj4Qcb3SFiebct60i4Kq2DeqFUCVSkSFeGDa1eQr76o
         QAj9qXjArpAvj6pZoapjSa8fvl8Ybj74urvoPRvvb8029qo35RLoAiKXpoM02YxOoaPP
         SEPdHtwtTdLozFOWHQQfD0FaI1vBycLifzNug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O+/FFDzqjGUa/uvDMSfAuiQjEkg5o9+lgPvGbc+n8wE=;
        b=0wfOdeV6o4lF2X02EL75RleQqEWcpJ7XXFxBoF2S2P81sID6MIe63UhWP/pxIU2bQd
         LZ0VgntTwmWjHhtiMjVu2Z0ceVRjrmuJ0hfOQQK6JLbccHPDI7YDyonR433ywlQZjiiu
         g/KKWp8Eu3+u0cLigMPw+yYe3x1cDQAZepr+JoM3nDvRxL0B/iJL9NMDZMPtRO1vDy7o
         HRBpZ7fXtOjaI5DC18fRUNIVcvFC+Cgzrno46JTx3YooGmbYoKPoHTRjJa77MmyARDVC
         6pyTEQM9+L1BsChb2lgmiLcpwrz5EG002NpllAdQEwHqJ3EzpfEmTgYaj6pJIFOiFoHk
         7axA==
X-Gm-Message-State: ACrzQf27cNyQ+Q5+Gz2BOLmJxFKOVYF9S82FzNH3lsDj/+2SwjzsU0Pu
        3lCrN7MjY41+Uq/b1wuHvCpKM0wVqe4qF/+3K8TQiQ==
X-Google-Smtp-Source: AMsMyM7DwZfJgUBj+Jcm+ahguQtT7+RYi7n81t2AfUSbJlFqnH/D7ZLc78O5AtvKtve14UtIE21JWlJbn+K5xTQxSGs=
X-Received: by 2002:a17:907:7289:b0:780:2017:3898 with SMTP id
 dt9-20020a170907728900b0078020173898mr19775359ejc.276.1663739683574; Tue, 20
 Sep 2022 22:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com> <YylweQAZkIdb5ixo@infradead.org>
In-Reply-To: <YylweQAZkIdb5ixo@infradead.org>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Tue, 20 Sep 2022 22:54:32 -0700
Message-ID: <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
To:     Christoph Hellwig <hch@infradead.org>
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

On Tue, Sep 20, 2022 at 12:49 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
> > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > sends a hint to (supported) thinly provisioned block devices to
> > allocate space for the given range of sectors via REQ_OP_PROVISION.
>
> So, how does that "provisioning" actually work in todays world where
> storage is usually doing out of place writes in one or more layers,
> including the flash storage everyone is using.  Does it give you one
> write?  And unlimited number?  Some undecided number inbetween?

Apologies, the patchset was a bit short on describing the semantics so
I'll expand more in the next revision; I'd say that it's the minimum
of regular mode fallocate() guarantees at each allocation layer. For
example, the guarantees from a contrived storage stack like (left to
right is bottom to top):

[ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]

would be predicated on the guarantees of fallocate() per allocation
layer; if ext4(1) was replaced by a filesystem that did not support
fallocate(), then there would be no guarantee that a write to a file
on ext4(2) succeeds.

For dm-thinp, in the current implementation, the provision request
allocates blocks for the range specified and adds the mapping to the
thinpool metadata. All subsequent writes are to the same block, so
you'll be able to write to the same block inifinitely. Brian mentioned
this above, one case it doesn't cover is if provision is called on a
shared block, but the natural extension would be to allocate and
assign a new block and copy the contents of the shared block (kind of
like copy-on-provision).

[reflowed]
> How is it affected by write zeroes to that range or a discard?

The current semantics of discards for dm-thinp/ext4/sparse files will
apply as they do today; discards will unmap the dm-thin block/free the
file extent. Write zeroes is more interesting; dm-thinp will treat the
command as usual. ext4_zero_range will mark the extents as unwritten,
so essentially if a user did provision + write to a block, write zeros
to the block would essentially leave it in the original provisioned
state, but ext4 would now show the contents of the block as zero on
the next read. I think, similar to above, the semantics of a request
will depend on each layer that it passes through.

Best
Sarthak
