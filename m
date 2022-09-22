Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5555E5D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIVIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIVIIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:08:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF40ACC8EC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:08:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l14so19217854eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iXb0cbDYs80FVQvp3dlURrNlpg98/EoNXEVRyzUkW50=;
        b=IHpFXTxMzEFLQHuCqKnKjLgk03sYFq1tMjEvHAzozOB9BfCb+i3KBMhvs3JlKgQj/+
         bEMZSL0mvAsy3XH8Hmf/XLkjX9u4gNiXsuA45KPErhXW9/EHW/LMcxrQm6ohuyOJEzLP
         WpezbHIfEgfsuCUS3VzgSBfjXcGiuMBnnuLlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iXb0cbDYs80FVQvp3dlURrNlpg98/EoNXEVRyzUkW50=;
        b=S9Thv6AOTiuS5dMdT+Zm7Hr/vAXpS87gZeYS8nNSA2sa3Pwsmzq2FrtAf01eGAQh0l
         wmTcAF91sfldVkhUd8ifUGK9aSzre+zbXAbj8c+fICwVz2eiF2vwGsLe6bUO+yR72wD0
         7CxpqM5Z8TqLL5umKqGklw/Hn2eg8+xsNWK0fzH48l1vlkyycAWvrz4gucJ4zncmoECI
         P8Ys2vo6ZNDobMUr+imdz/cmbWet8vCc/ajFNAEYlAs3tPtcdtqlgiYbMoh+VoCcNoaZ
         KDDTL1OXn3tORIG1CYRajdHyeXBUsk4+dnFM5tBIj+wJLza5BYQGfOKqvRptvA2xMoZb
         z/YQ==
X-Gm-Message-State: ACrzQf15ygh+VNRiK0bnfUR+9ybnVPIECK67Y3ok7abt4aKKOvWYiWwl
        2L1UqKfJmAIgNNFesk/LrFDS99GzuCPBLuPlobiY/g==
X-Google-Smtp-Source: AMsMyM7i6u9R9wd6F2HsmOaCSgsITPCe9fOhLfptS21SS36RpCCdvJBHZsBH+Qgv2Rg77TzYFsaXYBngYZEeV1fxkLM=
X-Received: by 2002:a17:907:968d:b0:782:66dc:4b89 with SMTP id
 hd13-20020a170907968d00b0078266dc4b89mr478912ejc.386.1663834095090; Thu, 22
 Sep 2022 01:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com> <YylweQAZkIdb5ixo@infradead.org>
 <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com> <YyssAb/zTcIG2bev@redhat.com>
In-Reply-To: <YyssAb/zTcIG2bev@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 22 Sep 2022 01:08:03 -0700
Message-ID: <CAG9=OMN6+ra3W2VcyvnnxRvxQz6uncSCNZvxZ8x9HgvV4GGB6w@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 8:21 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Wed, Sep 21 2022 at  1:54P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > On Tue, Sep 20, 2022 at 12:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > >
> > > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > > sends a hint to (supported) thinly provisioned block devices to
> > > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > >
> > > So, how does that "provisioning" actually work in todays world where
> > > storage is usually doing out of place writes in one or more layers,
> > > including the flash storage everyone is using.  Does it give you one
> > > write?  And unlimited number?  Some undecided number inbetween?
> >
> > Apologies, the patchset was a bit short on describing the semantics so
> > I'll expand more in the next revision; I'd say that it's the minimum
> > of regular mode fallocate() guarantees at each allocation layer. For
> > example, the guarantees from a contrived storage stack like (left to
> > right is bottom to top):
> >
> > [ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]
> >
> > would be predicated on the guarantees of fallocate() per allocation
> > layer; if ext4(1) was replaced by a filesystem that did not support
> > fallocate(), then there would be no guarantee that a write to a file
> > on ext4(2) succeeds.
> >
> > For dm-thinp, in the current implementation, the provision request
> > allocates blocks for the range specified and adds the mapping to the
> > thinpool metadata. All subsequent writes are to the same block, so
> > you'll be able to write to the same block inifinitely. Brian mentioned
> > this above, one case it doesn't cover is if provision is called on a
> > shared block, but the natural extension would be to allocate and
> > assign a new block and copy the contents of the shared block (kind of
> > like copy-on-provision).
>
> It follows that ChromiumOS isn't using dm-thinp's snapshot support?
>
Not at the moment, but we definitely have ideas to explore re:snapshot
and dm-thinp (like A-B updates with thin volume snapshots), where this
would definitely be useful!

> But please do fold in incremental dm-thinp support to properly handle
> shared blocks (dm-thinp already handles breaking sharing, etc.. so
> I'll need to see where you're hooking into that you don't get this
> "for free").
>
Will do in v2. Thanks for the feedback.

Best
Sarthak

> Mike
>
