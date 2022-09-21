Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07705C0105
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIUPVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIUPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD7883E1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663773703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKklums/Err7Bepni4gts8csmAXQyEMPG5WxwPmhH+I=;
        b=PHyOe+361YoQwAXf2enmFaT3H6nrBFeBlaUbzKUxyrxch8o9iZM8go/jst1M8cRDSBs0GZ
        COge2o9yZz1pYZ7dQ0a6vHDZAJsoMkUn5I5Ejz7QSGKK4OGN4ZD5PMeYT/17opxtFO87mg
        D27eyU9lVBY+J+2894U5tSwo3POkTiU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-rQLOytVAP1O-Cx6xi37dQQ-1; Wed, 21 Sep 2022 11:21:40 -0400
X-MC-Unique: rQLOytVAP1O-Cx6xi37dQQ-1
Received: by mail-qt1-f197.google.com with SMTP id b13-20020ac87fcd000000b0035cbe5d58afso4365192qtk.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YKklums/Err7Bepni4gts8csmAXQyEMPG5WxwPmhH+I=;
        b=YohQY7Pl54scR6O1BEFtvwzbL+z2ykmBook5jF8X4H6n1S0dS97y6FxTm507nhUcYg
         xXqRph7Rb9+crkrNNrpFGrHTYJtxNV21n7E8GOQifswXLW7Zeq+1CXMScT9fJXkpYlVx
         qWaKytHKQ1xzEW3aDbD+4Pman8ur9VusoEojuOAS015V2aN5426R2N/5CeCwlMtv40dk
         zDx9er9ldrtLDQ591g/Sd304VPYTx64cyuh/fABqI7zi0byjTJJsBYOmryX6XKyU2N3k
         SihaZyl1c96vQlwBlRG3QF3zAv2zrU0dLLfVGxMw+ELJR9HHC7+KRtDQFdFLgj4/raNV
         q+IQ==
X-Gm-Message-State: ACrzQf0mqwfbg+JEFgbImfmHSXGL5wBkdl6mTKjJWNUcq/u5AajZZ8+S
        0grN+bNoe+o3TCZq44O6f8z5qn3J/q+TkodI5tfhItNFtfa3Ze0wU7mHXgOJKKfzzvWTS4XLsep
        3kp6jbsK39aCjK5xwuBm+o78=
X-Received: by 2002:a05:622a:613:b0:342:f81f:4f7e with SMTP id z19-20020a05622a061300b00342f81f4f7emr23848811qta.198.1663773699675;
        Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7OzWfjG2GRtTFHT6VQqKwenYDGxd0vRx6UOENP8cSn03FrcY2GR/YED/OGOmZJunHnK1JMlw==
X-Received: by 2002:a05:622a:613:b0:342:f81f:4f7e with SMTP id z19-20020a05622a061300b00342f81f4f7emr23848782qta.198.1663773699383;
        Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
Received: from localhost ([217.138.198.196])
        by smtp.gmail.com with ESMTPSA id cf14-20020a05622a400e00b0031f41ea94easm1815844qtb.28.2022.09.21.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:21:37 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
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
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YyssAb/zTcIG2bev@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
 <YylweQAZkIdb5ixo@infradead.org>
 <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21 2022 at  1:54P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> On Tue, Sep 20, 2022 at 12:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > >
> > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > sends a hint to (supported) thinly provisioned block devices to
> > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> >
> > So, how does that "provisioning" actually work in todays world where
> > storage is usually doing out of place writes in one or more layers,
> > including the flash storage everyone is using.  Does it give you one
> > write?  And unlimited number?  Some undecided number inbetween?
> 
> Apologies, the patchset was a bit short on describing the semantics so
> I'll expand more in the next revision; I'd say that it's the minimum
> of regular mode fallocate() guarantees at each allocation layer. For
> example, the guarantees from a contrived storage stack like (left to
> right is bottom to top):
> 
> [ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]
> 
> would be predicated on the guarantees of fallocate() per allocation
> layer; if ext4(1) was replaced by a filesystem that did not support
> fallocate(), then there would be no guarantee that a write to a file
> on ext4(2) succeeds.
> 
> For dm-thinp, in the current implementation, the provision request
> allocates blocks for the range specified and adds the mapping to the
> thinpool metadata. All subsequent writes are to the same block, so
> you'll be able to write to the same block inifinitely. Brian mentioned
> this above, one case it doesn't cover is if provision is called on a
> shared block, but the natural extension would be to allocate and
> assign a new block and copy the contents of the shared block (kind of
> like copy-on-provision).

It follows that ChromiumOS isn't using dm-thinp's snapshot support?

But please do fold in incremental dm-thinp support to properly handle
shared blocks (dm-thinp already handles breaking sharing, etc.. so
I'll need to see where you're hooking into that you don't get this
"for free").

Mike

