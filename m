Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3323738367
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjFULvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFULvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE0610DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687348257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZCxbwN/fBZM1/IqvleFuFO1GiX4lYJkVAnMsqMaFMw=;
        b=E7zoJzMVExyq2ilZ4Yq5QwJs8D61mnUHaGCcTi7SZyHY0aPa8J5N+EkKbovDMp1sycVTox
        z7T1eMUXv0BVbb/Ej+wQePyNCLw2zWnOQ0lX/jS3SzqlfnOrS42It+NDz7NIvhmpw42xOM
        wfQEvUuQcIkrgywZaeiYbpDnBLr9X0k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-bF1V1xdNNCO-7EWjIYl0Hw-1; Wed, 21 Jun 2023 07:50:55 -0400
X-MC-Unique: bF1V1xdNNCO-7EWjIYl0Hw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77e33466fa2so344139039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348255; x=1689940255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZCxbwN/fBZM1/IqvleFuFO1GiX4lYJkVAnMsqMaFMw=;
        b=lnNhKw0W9IJaJdmjxQZGbSJsVW3mkOKVRtMlraK8akwPWOpLh1dqstw4Dht+p9AO22
         h2jaf5HS3jnLbtfN4RxZaA3bwijEj46ilPblfIVBXDunui5tIoqZ8DZUxMKMw5rTf3eF
         s+UAZBTkqsuw1u8zK1R5JAnPcbH6AiqnMWrT8lgapLAc9yT7prMHR2To9cFkhhv1CCyH
         xDojx0+iGNRVNGTlPMXr8Ff32Y0gnM9mmfbtCkSMdQJHeMdSQzjTDnKDsBsPXHfewrCa
         MlvZUUl57md/hXI+YxSStqy7jKQKr/a7mE39rapqr8+Y/JtO7aOAAa/LguqiLEG7k1Is
         q/1w==
X-Gm-Message-State: AC+VfDztv1O6VfL2hV87SmgbhGFQYX/DeM1e8LM7oD/jdczYSGShHuau
        foJmP+1l/jbU6UOnEDafSQPIqrc4YQtqLIK6ypBS0e3D8pGYlKcFtNjU+N0y9yOwqOjPwZLFy/T
        ejbz2t4gj/R3RIiZ+uOmaKqHyTd0AjANB7k0uu22OHXkj905MI80=
X-Received: by 2002:a92:d9cb:0:b0:340:9f52:a981 with SMTP id n11-20020a92d9cb000000b003409f52a981mr10565083ilq.2.1687348254848;
        Wed, 21 Jun 2023 04:50:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76KxJo9Yk/hYbLA5LofTwK7sebnG7qzFyA6+bsQ06fuBfM3XCfpffFr4o0yohCtXfXEwtar35+6FVQNAHy/fc=
X-Received: by 2002:a92:d9cb:0:b0:340:9f52:a981 with SMTP id
 n11-20020a92d9cb000000b003409f52a981mr10565079ilq.2.1687348254601; Wed, 21
 Jun 2023 04:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Wed, 21 Jun 2023 11:50:43 +0000
Message-ID: <CAL7ro1EmCcienVMY7Pi_mEFbUiLZq24EGOyFovexmpJMGbfjcA@mail.gmail.com>
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Filesystems with ACL enabled generally need to read
> "system.posix_acl_access"/"system.posix_acl_default" xattr to get the
> access and default ACL.  When filesystem is mounted with ACL enabled
> while files in the system have not set access/default ACL, the getattr()
> will run in vain while the round trip can decrease the performance in
> workload like "ls -lR".
>
> For example, there's a 12% performance boost if erofs is mounted with
> "noacl" when running "ls -lR" workload on dataset [1] (given in [2]).
>
> We'd better offer a fastpath to boost the above workload, as well as
> other negative xattr lookup.
>
>
> Proposal
> =3D=3D=3D=3D=3D=3D=3D=3D
> Introduce a per-inode bloom filter for xattrs to boost the negative
> xattr queries.
>
> As following shows, a 32-bit bloom filter is introduced for each inode,
> describing if a xattr with specific name exists on this inode.
>
> ```
>  struct erofs_xattr_ibody_header {
> -       __le32 h_reserved;
> +       __le32 h_map; /* bloom filter */
>         ...
> }
> ```
>
> Following are some implementation details for bloom filter.
>
> 1. Reverse bit value
> --------------------
> The bloom filter structure describes if a given data is inside the set.
> It will map the given data into several bits of the bloom filter map.
> The data must not exist inside the set if any mapped bit is 0, while the
> data may be not inside the set even if all mapped bits is 1.
>
> While in our use case, as erofs_xattr_ibody_header.h_map is previously a
> (all zero) reserved field, the bit value for the bloom filter has a
> reverse semantics in consideration for compatibility.  That is, for a
> given data, the mapped bits will be cleared to 0.  Thus for a previously
> built image without support for bloom filter, the bloom filter is all
> zero and when it's mounted by the new kernel with support for bloom
> filter, it can not determine if the queried xattr exists on the inode and
> thus will fallback to the original routine of iterating all on-disk
> xattrs to determine if the queried xattr exists.
>
>
> 2. The number of hash functions
> -------------------------------
> The optimal value for the number of the hash functions (k) is (ln2 *
> m/n), where m stands the number of bits of the bloom filter map, while n
> stands the number of all candidates may be inside the set.
>
> In our use case, the number of common used xattr (n) is approximately 8,
> including system.[posix_acl_access|posix_acl_default],
> security.[capability|selinux] and
> security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].
>
> Given the number of bits of the bloom filter (m) is 32, the optimal value
> for the number of the hash functions (k) is 2 (ln2 * m/n =3D 2.7).

This is indeed the optimal value in a traditional use of bloom
filters. However, I think it is based on a much larger set of values.
For this usecase it may be better to choose a different value.

I did some research a while ago on this, and I thought about the
counts too. Having more than one hash function is useful because it
allows you to avoid problems if two values happen to hash to the same
bucket, but this happens at the cost of there being less "unique
buckets".  I spent some time looking for common xattr values
(including some from userspace) and ended up with a list of about 30.
If we can choose a single hash function that maps all (or most) of
these to a unique bucket (mod 32), then it seems to me that having
just that single hash function is better, as it is faster to compute,
and is good enough to uniquely identify each of these commonly used
xattrs.

