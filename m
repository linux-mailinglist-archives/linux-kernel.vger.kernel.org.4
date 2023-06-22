Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4F7398B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjFVH5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjFVH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E951F185
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687420618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9Wcdec1+6SOyPl2/pil567norHAANYKnJAaOAugoPc=;
        b=cFkM2fM/ykIp6UNPxSIcbn6ksEpQiPG7BI2cAtWQ2h9TraVRJkJGhZHooRUsOG/SY1Ac4J
        v/ok/loLnB6G6z79TiYIhA0fJU0sDKVe3uhzx67ocXhD5SSQcXpN113Co0u/WtcPFzU9nv
        1Id2spIcET8XaDDbq7oguyWnFsmd224=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-NoT-841AMMam8JAYLfbbbQ-1; Thu, 22 Jun 2023 03:56:55 -0400
X-MC-Unique: NoT-841AMMam8JAYLfbbbQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-341d0d5d8c6so2663605ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420615; x=1690012615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9Wcdec1+6SOyPl2/pil567norHAANYKnJAaOAugoPc=;
        b=a6yZOnYxz9QsTvlQLKwsL8nZbsVO7k8z/pWeKrtljUejrPJ/8oYBZN/H4vVrekyBB0
         mdi6244F2KhQfnUstjfETiF5RXiTdMPjhXTb+2U9wSH7wqOrPCgnhX7XgpIzi5jrugr1
         zdvM6DNT9Vs+ETjnyvFcTDfIFSQbVjeKfpBjlZfg5z3c8o08xqWE5fzjIomIdlYQGlks
         ycyKWw5C6OPKHoU+UDV+a47/dhVIGYMvgQR5zBXcrGFubh00GZ5hIGMvgTM5CdOBYM8B
         xXo49X4FCuddM+2SdHRoEXGRTrdPibyRK46n6qFl2EdC2dPCAVseesLx93oiNagkuUUp
         ymYA==
X-Gm-Message-State: AC+VfDyoGJnq5okgJ35iXkVSN1OvhbvKYAoOhsCuUxyUUXyAZ9upz7a0
        1FIm1nee4YjvLoKOPgw8ALS8Cvj1BZpz/cPaYX/mGA1XvlvtP5793t1P3NBODG5Ov7NI0DGh3uS
        VhsLv65Uymqtb4EsTyQBivsgiQWgTd23k39DZYe+t
X-Received: by 2002:a05:6e02:110:b0:341:c484:2951 with SMTP id t16-20020a056e02011000b00341c4842951mr11480462ilm.8.1687420614996;
        Thu, 22 Jun 2023 00:56:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45OfXdeeFzX5Op9Jf/lNWHdnm1dNiAdcN4cb/UGhbN75C6y+W4289TqoIyiafu+9/daBf3Q4pv2B697b/IpH0=
X-Received: by 2002:a05:6e02:110:b0:341:c484:2951 with SMTP id
 t16-20020a056e02011000b00341c4842951mr11480453ilm.8.1687420614697; Thu, 22
 Jun 2023 00:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
 <CAL7ro1EmCcienVMY7Pi_mEFbUiLZq24EGOyFovexmpJMGbfjcA@mail.gmail.com> <3730215c-d59d-8b8e-fe36-7754f7782d15@linux.alibaba.com>
In-Reply-To: <3730215c-d59d-8b8e-fe36-7754f7782d15@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Thu, 22 Jun 2023 07:56:43 +0000
Message-ID: <CAL7ro1HhYUDrOX7A-13p7rLBZSWHTQWGOdOzVcYkddkU_LArUw@mail.gmail.com>
Subject: Re: [RFC 0/2] erofs: introduce bloom filter for xattr
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 8:37=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 6/21/23 7:50 PM, Alexander Larsson wrote:
> > On Wed, Jun 21, 2023 at 10:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>
> >> Background
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> Filesystems with ACL enabled generally need to read
> >> "system.posix_acl_access"/"system.posix_acl_default" xattr to get the
> >> access and default ACL.  When filesystem is mounted with ACL enabled
> >> while files in the system have not set access/default ACL, the getattr=
()
> >> will run in vain while the round trip can decrease the performance in
> >> workload like "ls -lR".
> >>
> >> For example, there's a 12% performance boost if erofs is mounted with
> >> "noacl" when running "ls -lR" workload on dataset [1] (given in [2]).
> >>
> >> We'd better offer a fastpath to boost the above workload, as well as
> >> other negative xattr lookup.
> >>
> >>
> >> Proposal
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >> Introduce a per-inode bloom filter for xattrs to boost the negative
> >> xattr queries.
> >>
> >> As following shows, a 32-bit bloom filter is introduced for each inode=
,
> >> describing if a xattr with specific name exists on this inode.
> >>
> >> ```
> >>  struct erofs_xattr_ibody_header {
> >> -       __le32 h_reserved;
> >> +       __le32 h_map; /* bloom filter */
> >>         ...
> >> }
> >> ```
> >>
> >> Following are some implementation details for bloom filter.
> >>
> >> 1. Reverse bit value
> >> --------------------
> >> The bloom filter structure describes if a given data is inside the set=
.
> >> It will map the given data into several bits of the bloom filter map.
> >> The data must not exist inside the set if any mapped bit is 0, while t=
he
> >> data may be not inside the set even if all mapped bits is 1.
> >>
> >> While in our use case, as erofs_xattr_ibody_header.h_map is previously=
 a
> >> (all zero) reserved field, the bit value for the bloom filter has a
> >> reverse semantics in consideration for compatibility.  That is, for a
> >> given data, the mapped bits will be cleared to 0.  Thus for a previous=
ly
> >> built image without support for bloom filter, the bloom filter is all
> >> zero and when it's mounted by the new kernel with support for bloom
> >> filter, it can not determine if the queried xattr exists on the inode =
and
> >> thus will fallback to the original routine of iterating all on-disk
> >> xattrs to determine if the queried xattr exists.
> >>
> >>
> >> 2. The number of hash functions
> >> -------------------------------
> >> The optimal value for the number of the hash functions (k) is (ln2 *
> >> m/n), where m stands the number of bits of the bloom filter map, while=
 n
> >> stands the number of all candidates may be inside the set.
> >>
> >> In our use case, the number of common used xattr (n) is approximately =
8,
> >> including system.[posix_acl_access|posix_acl_default],
> >> security.[capability|selinux] and
> >> security.[SMACK64|SMACK64TRANSMUTE|SMACK64EXEC|SMACK64MMAP].
> >>
> >> Given the number of bits of the bloom filter (m) is 32, the optimal va=
lue
> >> for the number of the hash functions (k) is 2 (ln2 * m/n =3D 2.7).
> >
> > This is indeed the optimal value in a traditional use of bloom
> > filters. However, I think it is based on a much larger set of values.
> > For this usecase it may be better to choose a different value.
> >
> > I did some research a while ago on this, and I thought about the
> > counts too. Having more than one hash function is useful because it
> > allows you to avoid problems if two values happen to hash to the same
> > bucket, but this happens at the cost of there being less "unique
> > buckets".  I spent some time looking for common xattr values
> > (including some from userspace) and ended up with a list of about 30.
>
> Yeah, if the number of common used xattr (n) is 30, then the optimal
> value for the number of the hash functions (k) is 1 (ln2 * m/n =3D 0.74).
> The optimal value in theory also matches our intuition.
>
>
> > If we can choose a single hash function that maps all (or most) of
> > these to a unique bucket (mod 32),
>
> Excellent research!  Would you mind sharing the list of these
> approximately 30 commonly used xattrs, so that I could check if they are
> mapped to unique bucket with the single hash function we proposed?

This is the list I came up with:

trusted.overlay.opaque
trusted.overlay.redirect
trusted.overlay.origin
trusted.overlay.impure
trusted.overlay.nlink
trusted.overlay.upper
trusted.overlay.metacopy
trusted.overlay.protattr
user.overlay.opaque
user.overlay.redirect
user.overlay.origin
user.overlay.impure
user.overlay.nlink
user.overlay.upper
user.overlay.metacopy
user.overlay.protattr
security.evm
security.ima
security.selinux
security.SMACK64
security.SMACK64IPIN
security.SMACK64IPOUT
security.SMACK64EXEC
security.SMACK64TRANSMUTE
security.SMACK64MMAP
security.apparmor
security.capability
system.posix_acl_access
system.posix_acl_default
user.mime_type

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

