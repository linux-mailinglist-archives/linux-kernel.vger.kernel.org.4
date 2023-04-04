Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBE6D583F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjDDFyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjDDFyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:54:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDE130
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:54:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bi9so40894564lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680587670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pLZ5LIf8dxXXGkQydUyk48pKyWVSSg042pIy4p88C0=;
        b=TSw6w1rIK1WYomZFu9uZTSDk+UhsyInS9UjfdwlusGHkpOmhhSSrFdGNs8dHAZgJI8
         4+mMArf/HsKq2uyIWnHYSCcZywuujCJ5PkJhDsW38ZNAE/H/AA0/XRGqnW+vReJAvacU
         E3lqM+lrd2yF+ZwvQD8C5a7WzRFce4HbWnMDlaqlt2jB9XaPtwWaTXQW/Btb0TNemfoA
         XWByEtMcUdJFdHwVQJvjAMjWmJAvoB1EfYMPizL6kM1YFK30dGl18sjP4X1MVG/Berob
         h6WVpIqQbZRj+Bok77RkSDiySlBFdWFP54SBTSfxPG9J0aYDF2RIQnxF3PXjRkDz5YAM
         mm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680587670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pLZ5LIf8dxXXGkQydUyk48pKyWVSSg042pIy4p88C0=;
        b=qquVas0zPi24xkdmd0gncXFfdG9CMQu0B3q+nlmovTOhOuf5mz0E8a1pCKpEqirx0I
         jU5+dIw5ruWKD6np+2g8wio14ez4QkPEv71b5LzIwmbftrE9gmfcVGZiMyrlDBM7LHrl
         G7sZUi4UO40Sp4MhyuS1+cmdAz0ODUsjLWpTNyf2CGqLu6lXMcoNZoMVZCEbz36m3SzU
         OQxuQ1lqhT6/w12vlTJhxY2ZhImr8VGHZ0vUt70BMGnPO69fcx3VxCF8/Ezy43j8RVkt
         JD+/GrkI3n4oAcfhf5FILvZd9DOvvinSqd6fCHuZipNTtzug7nr7wNnANWAwaatC5Vh0
         xpQQ==
X-Gm-Message-State: AAQBX9fnkiOWDSqtU5bPgIY45UZZMK9oKFT5KN6Xi43ukIYRlzlmdktE
        lIcHSLz3eT06YYkA9hxdRP9vPhCtBgDcSujvI3dT6p78yqE=
X-Google-Smtp-Source: AKy350aOW2jpD10bAFVZ92wn5Znp2UCYPJFzDM4B5RQKE/1/d3f8rcjPmHgThvFlvl4GyjM00bt2reXLoQ5kq3YiTVY=
X-Received: by 2002:ac2:5d64:0:b0:4eb:982:ad5 with SMTP id h4-20020ac25d64000000b004eb09820ad5mr350332lft.4.1680587669520;
 Mon, 03 Apr 2023 22:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <1680587425-4683-1-git-send-email-Xiaosong.Ma@unisoc.com>
In-Reply-To: <1680587425-4683-1-git-send-email-Xiaosong.Ma@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 4 Apr 2023 13:54:07 +0800
Message-ID: <CAGWkznFpe8owKprFserE571JSu4wXCWkQpnFD2aENOzYfTRH4w@mail.gmail.com>
Subject: Re: [PATCH] mm: check mapping addr is correct when dump page
To:     "xiaosong.ma" <Xiaosong.Ma@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 1:50=E2=80=AFPM xiaosong.ma <Xiaosong.Ma@unisoc.com>=
 wrote:
>
> when we debug with slub_debug_on, the following backtraces show dump_page
> will show wrong info when the bad page is non-NULL mapping and page->mapp=
ing
> is 0x80000000000 so do virt_addr valid check is needed when dump mapping =
page.
>
> crash_arm64> bt
> PID: 232    TASK: ffffff80e8c2c340  CPU: 0   COMMAND: "Binder:232_2"
>  #0 [ffffffc013e5b080] sysdump_panic_event$b2bce43a479f4f7762201bfee02d78=
89 at ffffffc0108d7c2c
>  #1 [ffffffc013e5b0c0] atomic_notifier_call_chain at ffffffc010300228
>  #2 [ffffffc013e5b2c0] panic at ffffffc0102c926c
>  #3 [ffffffc013e5b370] die at ffffffc010267670
>  #4 [ffffffc013e5b3a0] die_kernel_fault at ffffffc0102808a4
>  #5 [ffffffc013e5b3d0] __do_kernel_fault at ffffffc010280820
>  #6 [ffffffc013e5b410] do_bad_area at ffffffc01028059c
>  #7 [ffffffc013e5b440] do_translation_fault$4df5decbea5d08a63349aa36f0742=
6b2 at ffffffc0111149c8
>  #8 [ffffffc013e5b470] do_mem_abort at ffffffc0100a4488
>  #9 [ffffffc013e5b5e0] el1_ia at ffffffc0100a6c00
>  #10 [ffffffc013e5b5f0] __dump_page at ffffffc0104beecc
>  #11 [ffffffc013e5b630] bad_page at ffffffc0104e6ffc
>  #12 [ffffffc013e5b820] rmqueue_bulk at ffffffc0104e9128
>  #13 [ffffffc013e5b950] rmqueue at ffffffc0104e7c3c
>  #14 [ffffffc013e5b9c0] get_page_from_freelist at ffffffc0104e3e3c
>  #15 [ffffffc013e5ba50] __alloc_pages_nodemask at ffffffc0104e3a7c
>  #16 [ffffffc013e5bac0] pagecache_get_page at ffffffc01047d0e4
>  #17 [ffffffc013e5bb20] grab_cache_page_write_begin at ffffffc010480e3c
>  #18 [ffffffc013e5bb50] block_write_begin at ffffffc010586204
>  #19 [ffffffc013e5bb90] blkdev_write_begin$75b353f60767e771433fc3b19ba260=
ab at ffffffc01058cc48
>  #20 [ffffffc013e5bc00] generic_perform_write at ffffffc010480f1c
>  #21 [ffffffc013e5bc60] __generic_file_write_iter at ffffffc01048115c
>  #22 [ffffffc013e5bcf0] blkdev_write_iter at ffffffc01058c0a8
>  #23 [ffffffc013e5bda0] __vfs_write at ffffffc01052d808
>  #24 [ffffffc013e5bdd0] vfs_write at ffffffc01052da5c
>  #25 [ffffffc013e5be30] __arm64_sys_pwrite64 at ffffffc01052e09c
>  #26 [ffffffc013e5be60] el0_svc_common at ffffffc010272224
>  #27 [ffffffc013e5bea0] el0_svc_handler at ffffffc010272148
>  #28 [ffffffc013e5bff0] el0_svc at ffffffc0100a7ec4
>
> Signed-off-by: xiaosong.ma <Xiaosong.Ma@unisoc.com>
> ---
>  mm/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/debug.c b/mm/debug.c
> index 7f8e5f7..da61172 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -109,7 +109,7 @@ static void __dump_page(struct page *page)
>                 type =3D "ksm ";
>         else if (PageAnon(page))
>                 type =3D "anon ";
> -       else if (mapping)
> +       else if (mapping && virt_addr_valid(mapping))
could be else if (virt_addr_valid(mapping))
>                 dump_mapping(mapping);
>         BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + 1);
>
> --
> 1.9.1
