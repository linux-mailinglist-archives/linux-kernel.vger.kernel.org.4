Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90C46E35A3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDPHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDPHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:21:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089D3599
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:21:15 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-328cb023b1dso646095ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681629674; x=1684221674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLEQTsqzCVRCUPiGUlNa/vQf/juGQHTnx9NiZ9KIoGE=;
        b=7m3mqhjFjn/sQucXGVwMV5Pyau6vm8qKgpT712mQJFrIBM5ljzDOZbdIKgVYAmLKT5
         jhe3/9dXIZaVEz5nHQcxXCwgfGUmvGa3A1tiB9uTeVnIyMYeJjzWYARx6etheiSYraFE
         6HfRLguVuveOvirylb1zzx3EcZmBVuVVszBT5cMsWRDKRLzCOkpoOrrjqpi6YWWgKB1R
         /3DakLtX62B9rZi27dsIKz5/ywG29PKYI39/GyUhWiy4Mx/cEPdWRO44s3YE2V7T733p
         AcsthrKI2lfG3JQCoNYD8yjcJTZQvotxo3R3a7ziy/cp3aSL/VmzG8obu2IC8AF5wG+E
         W/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629674; x=1684221674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLEQTsqzCVRCUPiGUlNa/vQf/juGQHTnx9NiZ9KIoGE=;
        b=WMGU4b0WJUUgYRKxRN0i7+fJBbi4yyhWygEtaAvoH8y3VcvLj4cUWrxQd7ZBw8V1kT
         In2kRxW36jfZ3bUPfse1yKARyl21rUfF93Tc/cA2lSWr9MAgooXOaER3Rc9ZCohPI8cn
         PMK/TCKjAPtdeK8zrLiWL77oqrfVuHfgoL2g4Q4cLie4acAYkAQxukiEg/9fng9K5BJ4
         0lztrYlq6Fz8yR8gK8ohL/hucwfabLoiEZVQsR6iVVA43ibPrSlhFHxefnl4uXbfJ3k7
         vlljd7mp5pLjh2933C7Kuevhgt3RYTOpiYQbc4LsOOe+pmigD8/5YicoMt+LBEcAv2Oh
         Gn/Q==
X-Gm-Message-State: AAQBX9dsYbstgK3SbJOyOZBMxLdx6vbwlyvvYLrHVPyDMKLvDehUNz1h
        zWqwQcYCH5ArM8xz+Nn4640b+GDGsqXXBBulCgEeAobynkLfaPgOuMR+FQ==
X-Google-Smtp-Source: AKy350az7d9NJOT3IqdR8km3o0Zj2SR3hy8JSwCFtU/L69vtqoCH3RWX4MMgyhNC4eBhfnYYTlVVzL0fsy89/SzASRM=
X-Received: by 2002:a05:6e02:2186:b0:32a:dc6a:3b97 with SMTP id
 j6-20020a056e02218600b0032adc6a3b97mr159138ila.0.1681629673725; Sun, 16 Apr
 2023 00:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
In-Reply-To: <20230304034835.2082479-1-senozhatsky@chromium.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 16 Apr 2023 01:20:37 -0600
Message-ID: <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 8:48=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
>         Hi,
>
> Existing zsmalloc page fullness grouping leads to suboptimal page
> selection for both zs_malloc() and zs_compact(). This patchset
> reworks zsmalloc fullness grouping/classification.
>
> Additinally it also implements new compaction algorithm that is
> expected to use less CPU-cycles (as it potentially does fewer
> memcpy-s in zs_object_copy()).
>
> Test (synthetic) results can be seen in patch 0003.

Seeing the following crashes from mm-unstable. Please take a look. Thanks.

  list_add corruption. next is NULL.
  kernel BUG at lib/list_debug.c:26!
  Call Trace:
   <TASK>
   zs_compact+0xbf6/0xda0
   zs_shrinker_scan+0x19/0x30
   do_shrink_slab+0x1ac/0x450
   shrink_slab+0xdc/0x3d0
   shrink_one+0xe2/0x1d0
   shrink_node+0xc7f/0xea0
   do_try_to_free_pages+0x1b5/0x500
   try_to_free_pages+0x396/0x5d0
   __alloc_pages_slowpath+0x5d0/0x1030
   __alloc_pages+0x1de/0x280
   __folio_alloc+0x1e/0x40
   vma_alloc_folio+0x4c0/0x530
   shmem_alloc_and_acct_folio+0x1a6/0x3b0
   shmem_get_folio_gfp+0x689/0xf00
   shmem_fault+0x81/0x240
