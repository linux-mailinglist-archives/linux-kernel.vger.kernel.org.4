Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F06DFC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDLRIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDLRIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:08:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFEF118
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:08:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m4so15427351lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681319308; x=1683911308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHz36P6n/IFFYRn+2wzmmIWjkkyGKKtV0x6DRHklJqg=;
        b=ub4rOKQiFk3fl6RCjWMFWEwScl/mi0Mb8jEGcN8OPvBVr3WIhDPXcjKhhJ1ZczX1i5
         tVHVOvw/fNbZJ8QccOygNweSQ9/o3jZmEqBZXHNaMkdNHQshebFGrAPput/hUzDWombz
         +Ap9OibnxYWBtlk95HGHSFzUlPr5rdjesByXpKt2Gf9gBbP34ELi8+PzKfPV9Y0hRfsb
         Jdhpxad+pPNjRpnqmTgq1++zLtw6MTCopw229216FM3jbytkW5wPklMF0WjC/ipL9ZQf
         TrduHVqxWfQJis0Mq5wGYKh38TgZPkvyHsRdna9mUnlQZjVSMwrJbvopmmuYdWzG5aan
         GQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319308; x=1683911308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHz36P6n/IFFYRn+2wzmmIWjkkyGKKtV0x6DRHklJqg=;
        b=RLdlxaa7+zh+p+4C2qgm/Nw4EfPaDmX7Z44boPEGCN5HSKyhUDZYP3ZIQSBarStwXx
         gTo2mRhYzOSmjSO4oKohMD1EMV8uZLEp74I20vrBU46baA7RfUcBXc9rGk+bV0ACZCPF
         BYNCUN7rCKlSV50ORZ1G4myMQCvIAMcQwnLWGdXjub19S4BgshYUGfUd4Tkra3E5C4VE
         RQKmQO4ErWQgfTVdGmgVGMvb2eYkiA7eip090sw76GFqdX9r+Fj+Q3u0psmvG5/RluE1
         4bwouTlBaAHWuni47aQCKF84pbmvxg37DMAwNeS0pionJg1Zyd3vk0u7Cv92orjVs89x
         HgvA==
X-Gm-Message-State: AAQBX9fPJoNQtFZHrg0JiIXm4dU3wFm9pmKN6qPqITSUzEUzTxUMc5st
        zBP9bUva3GplDUEdBU+acrnSnMkTQIVk7fZL+viCeRBvB7GdFgLqQ6U=
X-Google-Smtp-Source: AKy350aeRD2uyIx+8xPYqOwdHgXc/Hv+zLNUb4oOukQRWLRx6AvonH/xj+JYS9QZTPyjHv8+b8RlxhWgvF30nruae7E=
X-Received: by 2002:a19:f717:0:b0:4dc:807a:d140 with SMTP id
 z23-20020a19f717000000b004dc807ad140mr4424933lfe.10.1681319307825; Wed, 12
 Apr 2023 10:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230412163922.327282-1-peterx@redhat.com> <20230412164234.328168-1-peterx@redhat.com>
In-Reply-To: <20230412164234.328168-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 12 Apr 2023 10:07:51 -0700
Message-ID: <CAJHvVch3fv2Z509fSha5R3VCvp_unPNgy7QUA+Xbet2J6hJhOA@mail.gmail.com>
Subject: Re: [PATCH v2 10/31] selftests/mm: Test UFFDIO_ZEROPAGE only when !hugetlb
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 12, 2023 at 9:42=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Make the check as simple as "test_type =3D=3D TEST_HUGETLB" because that'=
s the
> only mem that doesn't support ZEROPAGE.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

The end state we get to in patch 26 is what I was hoping for - we
check the ioctls reported by UFFDIO_REGISTER to decide if we rest this
or not. So then this intermediate state used to get rid of
get_expected_ioctls() is fine.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/sel=
ftests/mm/userfaultfd.c
> index 795fbc4d84f8..d724f1c78847 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -1118,7 +1118,7 @@ static int __uffdio_zeropage(int ufd, unsigned long=
 offset, bool retry)
>  {
>         struct uffdio_zeropage uffdio_zeropage;
>         int ret;
> -       bool has_zeropage =3D get_expected_ioctls(0) & (1 << _UFFDIO_ZERO=
PAGE);
> +       bool has_zeropage =3D !(test_type =3D=3D TEST_HUGETLB);
>         __s64 res;
>
>         if (offset >=3D nr_pages * page_size)
> --
> 2.39.1
>
