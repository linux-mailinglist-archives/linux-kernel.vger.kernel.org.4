Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F470F48F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjEXKtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjEXKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA7198
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684925296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1b7B2eWvrCdXsO/LwBEusNkxbQCx1woNLXNuitI/A7s=;
        b=dwfxW93sDlxGEQbxyXKyhPO5pfNGrIPKEJbckudx+oZ42mlmRmVF1Pb5EzGcgEEBfgJuau
        V+lK7G6iVbz8iqryGo4+P1HLKSYbzt0Et/mvEUBj+T/nUP9+4pCg4dWCOwc8kvbJKEic8g
        IIyW3ONqPTJu9zSfF8mOCbRLA1hdQU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-w0HYiZ6tN_qJ6p3SozTy0A-1; Wed, 24 May 2023 06:48:13 -0400
X-MC-Unique: w0HYiZ6tN_qJ6p3SozTy0A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35BEC85A5AA;
        Wed, 24 May 2023 10:48:13 +0000 (UTC)
Received: from localhost (unknown [10.39.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2564492B0A;
        Wed, 24 May 2023 10:48:12 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Du Rui <durui@linux.alibaba.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
Subject: Re: dm overlaybd: targets mapping OverlayBD image
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
        <ZGz32yw7ecKhW+lj@redhat.com>
        <CAL7ro1FPEqXyOuX_WPMYdsT6rW-bD5EU=v=oWKsd6XscykLF6Q@mail.gmail.com>
        <fd4d0429-4da3-8217-6c13-14fd8a198920@linux.alibaba.com>
        <87r0r6ywri.fsf@redhat.com>
        <02524ece-956f-f5d8-fb21-adc4e5617dc6@linux.alibaba.com>
Date:   Wed, 24 May 2023 12:48:11 +0200
In-Reply-To: <02524ece-956f-f5d8-fb21-adc4e5617dc6@linux.alibaba.com> (Gao
        Xiang's message of "Wed, 24 May 2023 16:26:25 +0800")
Message-ID: <87mt1uyphw.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> Hi Giuseppe,
>
> On 2023/5/24 01:11, Giuseppe Scrivano wrote:
>> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
>> 
>
> ...
>
>>> Agreed, I hope you guys could actually sit down and evaluate a proper
>>> solution on the next OCI v2, currently I know there are:
>>>
>>>   - Composefs
>>>   - (e)stargz   https://github.com/containerd/stargz-snapshotter
>>>   - Nydus       https://github.com/containerd/nydus-snapshotter
>>>   - OverlayBD   https://github.com/containerd/accelerated-container-image
>>>   - SOCI        https://github.com/awslabs/soci-snapshotter
>>>   - Tarfs
>>>   - (maybe even more..)
>>>
>>> Honestly, I do think OSTree/Composefs is the best approach for now for
>>> deduplication and page cache sharing (due to kernel limitation of page
>>> cache sharing and overlayfs copyup limitation).  I'm too tired of
>>> container image stuffs honestly.  Too much unnecessary manpower waste.
>> for a file-based storage model, I am not sure a new format would
>> really
>> buy us much or it can be significantly different.
>> Without a proper support from the kernel, a new format would still
>> need
>> to create the layout overlay expects, so it won't be much different than
>> what we have now.
>
> I've seen lot efforts on this, for example,
> https://docs.google.com/presentation/d/1lBKVrYzm9JEYuw-gIEsrcePSK0jL1Boe/edit#slide=id.p22
>
> Merging the writable layer and read-only layers with overlayfs is
> feasible. I mean, at least for composefs model on backing XFS/btrfs, we
> could merge these layers with overlayfs so that I guess reflink could
> be done to avoid full copyup as well?  I do think that's a net win.
>
>> The current OCI format, with some tweaks like (e)stargz or
>> zstd:chunked,
>> already make its content addressable and a client can retrieve only the
>> subset of the files that are needed.  At the same time we maintain the
>> simplicity of a tarball and it won't break existing clients.
>
> (e)stargz or zstd:chunked still needs to be converted by the publisher
> and not all exist OCI images are stored in this way.  But apart from
> detailed comparsion, disk mapping image approaches seems really a
> drawback at least on my side.

these images can be treated as if all their files are missing and the
checksum is calculated on the receiver side.  They will still be stored
locally indexed by their checksum.  We lose the possibility to pull only
the missing files but we maintain the other advantages at runtime.  In
this way moving to a new format can be done incrementally without
breaking what we have now.

> Anyway, I think it's what OCIv2 would like to eventually address
> anyway.
>
>> IMO, the most interesting problem is how to store these images
>> locally
>> and how the kernel can help with that.
>
> I think composefs model can do both sides. But I'm not sure the final
> conclusion, I tend to leave it to the OCI guys.
>
>> The idea behind composefs is to replace the existing storage model
>> used
>> for overlay, where each layer has its own directory, with a single
>> directory where all the files are stored by their checksum.  The
>> expected layout then is recreated at runtime.
>
> Yes, what I'd like to say, without finer page cache sharing mechanism,
> the composefs way sounds better to me honestly to the whole system.
>
> Thanks,
> Gao Xiang

