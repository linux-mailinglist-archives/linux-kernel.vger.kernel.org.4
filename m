Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F826C2B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCUHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCUHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF8410BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679384652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFMCkdwb/gHudPYJPKuUV3mKfXn/whPMD3aT6HDnwA0=;
        b=CgMWOm5vyspCkaqXthKbiL7+w+IHBfq5TnaxzlCv77CTva9eRYFGTnPxAizulC9f6BHWqT
        UPlFjzd8kFTogcCt5T+JxyHpB3XhAzXoSX7aaR57ImL39NDMDOH5/XaGWxtmo7fKw5ZSeA
        fPdIf68olCOPHBFrjD6RcifxBhE9viY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-AkR_bImgM7apROVUqlxptg-1; Tue, 21 Mar 2023 03:44:08 -0400
X-MC-Unique: AkR_bImgM7apROVUqlxptg-1
Received: by mail-ot1-f72.google.com with SMTP id u10-20020a9d4d8a000000b0069f892902fcso383892otk.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFMCkdwb/gHudPYJPKuUV3mKfXn/whPMD3aT6HDnwA0=;
        b=a/Ej6UQ42rtpIOjWlfReYGzashYks738mYF9nIVSs5xfgqjMGAEvSh9KpbjBy0DLtQ
         cf+8zndToVO5IFyG2j/s76DmSC/suPHbXZEo8IskuFaI5aw/djniIU/m5biajXFgATwi
         STcvkdtyE4eA2q4tF1rEKv9ctyFNzqvIkVfifvtRFhkojWZzLFJuI4LzY0vdO9S2bG0N
         q6ddGWczgte3a7VFV1L5y9pp6+77TWpxHm825GWG7RJbiZa+c6IpbhLkIAVDhevU7A53
         RWMujaxPyXDhfOEsHKXBZpukppAqdfYSxkvVaPM5+0wl3Fg2iWqo/DBJ2iIu8lDUPHkr
         /vgg==
X-Gm-Message-State: AO0yUKWAkqjJhNT+ThWCMmnVRmWFt1oSZn5K1S6Ax4v1VXDv9LYIjlpA
        OPuAT/ecEbOj62Rv0XeNyJbgM5G4AF9rRb5aaKNctLmGq4rIX+FLzS4sb4164sG/DGEYDw3dvcY
        8yB864ZVdWLAfq8rqtGe0QTi9
X-Received: by 2002:a4a:2c4b:0:b0:53b:5518:bce9 with SMTP id o72-20020a4a2c4b000000b0053b5518bce9mr562436ooo.1.1679384648103;
        Tue, 21 Mar 2023 00:44:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set+f0OAojAIqMUZciV4xEytZ4fL9bz1L0cPgDGOY+LCNYqJVyk0c6lUzNU3/abQTUvMslZ23bw==
X-Received: by 2002:a4a:2c4b:0:b0:53b:5518:bce9 with SMTP id o72-20020a4a2c4b000000b0053b5518bce9mr562431ooo.1.1679384647881;
        Tue, 21 Mar 2023 00:44:07 -0700 (PDT)
Received: from [192.168.15.177] ([179.111.176.145])
        by smtp.gmail.com with ESMTPSA id v13-20020a9d5a0d000000b00693c9f984b4sm4788041oth.70.2023.03.21.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:44:07 -0700 (PDT)
Message-ID: <61ee85961cbab30f9e7e56771bbe8f9b5b7753b8.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/6] Deduplicating RISCV cmpxchg.h macros
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Mar 2023 04:44:04 -0300
In-Reply-To: <20230321063430.2218795-1-leobras@redhat.com>
References: <20230321063430.2218795-1-leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-21 at 03:34 -0300, Leonardo Bras wrote:
> While studying riscv's cmpxchg.h file, I got really interested in=20
> understanding how RISCV asm implemented the different versions of=20
> {cmp,}xchg.
>=20
> When I understood the pattern, it made sense for me to remove the=20
> duplications and create macros to make it easier to understand what exact=
ly=20
> changes between the versions: Instruction sufixes & barriers.
>=20
> I split those changes in 3 levels for each cmpxchg and xchg, resulting a=
=20
> total of 6 patches. I did this so it becomes easier to review and remove=
=20
> the last levels if desired, but I have no issue squashing them if it's=
=20
> better.
>=20
> Please provide comments.
>=20
> Thanks!
> Leo
>=20
> Changes since v1:
> - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
>=20
> Leonardo Bras (6):
>   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() macros
>   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
>   riscv/cmpxchg: Deduplicate xchg() asm functions
>   riscv/cmpxchg: Deduplicate xchg() macros
>   riscv/cmpxchg: Deduplicate arch_xchg() macros
>=20
>  arch/riscv/include/asm/cmpxchg.h | 316 +++++++------------------------
>  1 file changed, 64 insertions(+), 252 deletions(-)
>=20

Re-sending, since it seems to have not worked with patchwork properly.

