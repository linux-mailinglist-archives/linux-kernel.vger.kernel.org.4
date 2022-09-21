Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3F5C00C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIUPI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIUPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D2B79A5C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663772926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ptp1oLSt177eSTGNW8YxvUlUM4rs67KrLKfl9pj1Lys=;
        b=iXwIAMIZtd1F+2omRf5mhg+42DheRLbxGcX2NBPrfqqGiGgePj2TAZqid8EYSBNq7mzZDT
        LL3ZDp3tVWo3egM3nc1s3k2KlSV9+7eokMLR7sELWEWf6v02VMGcd6CDW55qRuVKoV0IHa
        L5uIX/9Z5lw0yWLWrzzlF8rlzohiapc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-368-9xGSOKIQNsC1T94MLWyxlQ-1; Wed, 21 Sep 2022 11:08:45 -0400
X-MC-Unique: 9xGSOKIQNsC1T94MLWyxlQ-1
Received: by mail-qt1-f197.google.com with SMTP id w4-20020a05622a134400b0035cbc5ec9a2so4376074qtk.14
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ptp1oLSt177eSTGNW8YxvUlUM4rs67KrLKfl9pj1Lys=;
        b=n08ypzP1Zr3vX+S+ZxluD1iqBz2wO60JlQlxm9HQz2GOV7LocKLDv975S3kfeOcqlk
         J3vdQAOD5KeOVHXdlF0PwMXiXkwnPyipGHDwRERuvpruHn7W5KXopmYVcXbPu8kfTVb+
         KMV2MsPAof5ebgFO72sU1Vyk4h32IA7gIAcVNlCmGzmOSmGFlHH7PMvB8naFmUPzaC1r
         57oRGuBxGk1nVEo+NAIlGQ2eE1Vf4izJuFoQ8PMZUUt7pzJQdtCEXk43giTl2ShAe31X
         iU3WLwE3DJ+cZqc/+5jqMgRjjYx74Pu/OFwEdFwEWEdcbzfiXZET3rMmDjeTsKx/MdFy
         j/xw==
X-Gm-Message-State: ACrzQf2hMeFCHxBAI8yO2mNH1nevR5x0kSCBSz+hm+5Gu3PUIw4pj4HY
        STAnVipMVunCc4f20PmnrOE21S6J6vF/2+s1oEb7K01wSYYoHex4o+drrXq+PKuCFlmvu0fUxPx
        Ac+GX7ULG1DWOJpNXRqGf/H4=
X-Received: by 2002:ac8:7d85:0:b0:35b:f5b1:63df with SMTP id c5-20020ac87d85000000b0035bf5b163dfmr23884634qtd.113.1663772924828;
        Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4EexL7l8DWx+8oreUyHWUiCWf8NA2huyVubxlwg6z5TXJwF+130R2NsOA173MiJm0z6yEZRA==
X-Received: by 2002:ac8:7d85:0:b0:35b:f5b1:63df with SMTP id c5-20020ac87d85000000b0035bf5b163dfmr23884597qtd.113.1663772924537;
        Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
Received: from localhost ([217.138.198.196])
        by smtp.gmail.com with ESMTPSA id w7-20020ac857c7000000b0035bbb6268e2sm2041812qta.67.2022.09.21.08.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:08:44 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:08:43 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Daniil Lunev <dlunev@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Stefan Hajnoczi <stefanha@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <Yyso+9ChDJQUf9B1@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
 <YymkSDsFVVg1nbDP@infradead.org>
 <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20 2022 at  5:48P -0400,
Daniil Lunev <dlunev@google.com> wrote:

> > There is no such thing as WRITE UNAVAILABLE in NVMe.
> Apologize, that is WRITE UNCORRECTABLE. Chapter 3.2.7 of
> NVM Express NVM Command Set Specification 1.0b
> 
> > That being siad you still haven't actually explained what problem
> > you're even trying to solve.
> 
> The specific problem is the following:
> * There is an thinpool over a physical device
> * There are multiple logical volumes over the thin pool
> * Each logical volume has an independent file system and an
>   independent application running over it
> * Each application is potentially allowed to consume the entirety
>   of the disk space - there is no strict size limit for application
> * Applications need to pre-allocate space sometime, for which
>   they use fallocate. Once the operation succeeded, the application
>   assumed the space is guaranteed to be there for it.
> * Since filesystems on the volumes are independent, filesystem
>   level enforcement of size constraints is impossible and the only
>   common level is the thin pool, thus, each fallocate has to find its
>   representation in thin pool one way or another - otherwise you
>   may end up in the situation, where FS thinks it has allocated space
>   but when it tries to actually write it, the thin pool is already
>   exhausted.
> * Hole-Punching fallocate will not reach the thin pool, so the only
>   solution presently is zero-writing pre-allocate.
> * Not all storage devices support zero-writing efficiently - apart
>   from NVMe being or not being capable of doing efficient write
>   zero - changing which is easier said than done, and would take
>   years - there are also other types of storage devices that do not
>   have WRITE ZERO capability in the first place or have it in a
>   peculiar way. And adding custom WRITE ZERO to LVM would be
>   arguably a much bigger hack.
> * Thus, a provisioning block operation allows an interface specific
>   operation that guarantees the presence of the block in the
>   mapped space. LVM Thin-pool itself is the primary target for our
>   use case but the argument is that this operation maps well to
>   other interfaces which allow thinly provisioned units.

Thanks for this overview. Should help level-set others.

Adding fallocate support has been a long-standing dm-thin TODO item
for me. I just never got around to it. So thanks to Sarthak, you and
anyone else who had a hand in developing this.

I had a look at the DM thin implementation and it looks pretty simple
(doesn't require a thin-metadata change, etc).  I'll look closer at
the broader implementation (block, etc) but I'm encouraged by what I'm
seeing.

Mike

