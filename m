Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68575EE69E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiI1U1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1U1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:27:38 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA78A98E1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:27:37 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i3so8619193qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=8adqXN45JE2olLRk9Lphi2ZcgXsJm6thwoQKvNld65w=;
        b=NvoTO3K9YrwXsLuTr2K12Ojxt9FpL5LnrKKiOfYp9TI6tY4cZY5t5vLFCVgVPstbze
         84Q4132pi0ULC9SvyAd0De6GOmP05juLUI5WA7LHFIYulacEHzfLmeMVWdjPgSzQ1UdO
         5kclja6Qs4+st95fOlpPShcdo9fKUBCPiFtFCGVSZdZVuSUmX7oILm0F3RlJ75xSGYDt
         7Fkkt9/z8zbxou4qLjiN1s/2WuqrWGPN6xP6BT0lTfm0TXs7nmhmi8yWygfHVesMSgU1
         6TuMpRK8MmO6OQmIinD6M4M1ETGBGII3restta5gy4u8/cBEyXDs7iVDkOhTYQ2FlCZb
         +Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=8adqXN45JE2olLRk9Lphi2ZcgXsJm6thwoQKvNld65w=;
        b=RWnDhKHmpC5MR09n1eaI+dn66HDECQrXmOgWepsDpGRMYJ+ZRwigzWpb+6tVh+fpDK
         z56rX0k7xwr8RLVfJdutricLr6b4tR2E/xDt7B0keWJtq+PsWXG6kQop2QGuWWPfmUKc
         /7pBYqL/spRPotgW3N90iIvYUjcMayTuKBvB3WzHt8N9nEbvIbAi68cKD+jPjeq83JMc
         M9Luu4HjGX5afbFeFVVT5ZUnDLET/rRzhyjwlifM2fVUWgsGtKUb2iG1qVl4dWRrfWPU
         miYdCT8pZFXIO1t6uvyqW852hACQChLytz1aQ1Xc2LW2S09UVJSh17EA6NNshADS12oU
         Wqbg==
X-Gm-Message-State: ACrzQf2Tlj4Th8gdTgxfY8Hr3gmLoL65DM2b56hfMzZZ45moC/pIPC8r
        uwLZXu4zVJDFtFIXb4n3aZQS+4A4Ji5xQg==
X-Google-Smtp-Source: AMsMyM5ldKk195h1RT9CHCFvAwC2cFlQaqd/R0NvvDz82ndpFuvN3S4A5bvupjoHEvYyrQllgCt6gg==
X-Received: by 2002:a37:40e:0:b0:6cb:be14:1818 with SMTP id 14-20020a37040e000000b006cbbe141818mr22922511qke.284.1664396856242;
        Wed, 28 Sep 2022 13:27:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a441100b006cbdc9f178esm4313961qkp.25.2022.09.28.13.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:27:35 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:27:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= 
        <thomas.weissschuh@amadeus.com>
Subject: Re: [PATCH] tmpfs: ensure O_LARGEFILE with generic_file_open()
In-Reply-To: <20220928104535.61186-1-linux@weissschuh.net>
Message-ID: <4d5a721-cffe-cc7-8023-ae86ba35cb7d@google.com>
References: <20220928104535.61186-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1420712399-1664396855=:21219"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1420712399-1664396855=:21219
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Sep 2022, Thomas Wei=C3=9Fschuh wrote:
> From: Thomas Wei=C3=9Fschuh <thomas.weissschuh@amadeus.com>
>=20
> Without this check open() will open large files on tmpfs although
> O_LARGEFILE was not specified. This is inconsistent with other
> filesystems.
> Also it will later result in EOVERFLOW on stat() or EFBIG on write().
>=20
> Link: https://lore.kernel.org/lkml/76bedae6-22ea-4abc-8c06-b424ceb39217@t=
-8ch.de/
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@amadeus.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks! I think you deserve some special award for finding and fixing
such an ancient bug/inconsistency - dating back to early v2.4 it seems.

But only affecting 32-bit; and since we've happily lived with it so long,
and the fix does change behaviour for userspace, better not to Cc stable.

There are some other filesystems still behaving as tmpfs was (ramfs,
hugetlbfsi, and I didn't look further); but we do make more of an effort
to keep tmpfs in line with the major filesystems - thank you.

> ---
>  mm/shmem.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 42e5888bf84d..902c5550fabc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3876,6 +3876,7 @@ EXPORT_SYMBOL(shmem_aops);
> =20
>  static const struct file_operations shmem_file_operations =3D {
>  =09.mmap=09=09=3D shmem_mmap,
> +=09.open=09=09=3D generic_file_open,
>  =09.get_unmapped_area =3D shmem_get_unmapped_area,
>  #ifdef CONFIG_TMPFS
>  =09.llseek=09=09=3D shmem_file_llseek,
>=20
> base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
> --=20
> 2.37.3
---1463760895-1420712399-1664396855=:21219--
