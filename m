Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3442574EB86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGKKKu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:10:49 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A99E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:10:48 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-c17534f4c63so6826649276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070247; x=1691662247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NklhkwlNR5eEmz7lf9gHixIXUDPU7r/AgZFQC+NZaNg=;
        b=PPTOP23yYuE/IlTWJNikWapf5fsQ8dAvlfSiatoKhMjNhjuO7T+GZI3lUZD4gCVGvu
         VwGaVR9uIisoPII+w703p4R7GtntDd585kXLBagshCCw25M9XDEdfaVTuxcFuj2Yr+Mk
         GsM8xOsLch/vtKOA2Td3L7Rgfcli8mUmhmMKipsRLUot/xECvXTz6+/tgvtl0qsmfuxI
         7zY3IhU2kHm6DFDoAfvCE175yimtr10uYSPTBpamBctIt7xe75YisiTyNu4gwqaG0B8N
         X0NRAes7t8wtXjy8faJwEX5i463f0mPfRF/wY8GAUhzyhRu/hIpCkhrVob7x3yrzNgzy
         xCwA==
X-Gm-Message-State: ABy/qLaSKn3UrG2N6xXfNpiZ558jOU1sJ/lo5daqM5i853emOuhq+fDF
        OPU1g6Pz5Y63lbH1fiYocK7YLj6ib0i+zw==
X-Google-Smtp-Source: APBJJlEX4RnqqKoDLp3DXZXMUywpFRfIB4anUQJoTz046ukMFKcDZW3zu6dt5WCW1H+3DSd6SffcBA==
X-Received: by 2002:a81:e94e:0:b0:56d:824e:d93f with SMTP id e14-20020a81e94e000000b0056d824ed93fmr14030707ywm.38.1689070247453;
        Tue, 11 Jul 2023 03:10:47 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id l124-20020a0dc982000000b00578942e2a86sm473202ywd.60.2023.07.11.03.10.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:10:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-57a551ce7e9so61014837b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:10:46 -0700 (PDT)
X-Received: by 2002:a81:4f4a:0:b0:57a:5c79:482a with SMTP id
 d71-20020a814f4a000000b0057a5c79482amr10682578ywb.50.1689070245876; Tue, 11
 Jul 2023 03:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230711035444.526-1-zhangpeng.00@bytedance.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jul 2023 12:10:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVtHXnm0EvPV7tVMeF7Z9JEhjyKMmg19aS3hdj2qRDhWw@mail.gmail.com>
Message-ID: <CAMuHMdVtHXnm0EvPV7tVMeF7Z9JEhjyKMmg19aS3hdj2qRDhWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Improve the validation for maple tree and some cleanup
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, Jul 11, 2023 at 5:56 AM Peng Zhang <zhangpeng.00@bytedance.com> wrote:
> These patches do the following:
> 001 - 002: Small cleanup to maple tree.
> 003 - 006: Improve the validation for maple tree.
> 007 - 008: Drop some functions that will no longer be used.
>
> Thanks Liam for the review.
>
> Changes since v1:
>  - Add fixes tag and the necessary Cc. [1/8]
>  - Add the verification that gaps beyond the node limit are zero. [3/8]
>  - Revise comment. [5/8]
>  - Reformat the code. [6/8]
>
> Peng Zhang (8):
>   maple_tree: set the node limit when creating a new root node
>   maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
>   maple_tree: make mas_validate_gaps() to check metadata
>   maple_tree: fix mas_validate_child_slot() to check last missed slot
>   maple_tree: make mas_validate_limits() check root node and node limit
>   maple_tree: update mt_validate()
>   maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
>   maple_tree: drop mas_first_entry()
>
>  include/linux/maple_tree.h |   2 -
>  lib/maple_tree.c           | 258 ++++++++++++-------------------------
>  2 files changed, 79 insertions(+), 181 deletions(-)

Thanks for your series!

I gave it a try with test_maple_tree on m68k/ARAnyM, and the net
impact is:

     TEST STARTING

     BUG at next_prev_test:2014 (1)
     Pass: 3749128 Run:3749129
    -BUG at check_empty_area_window:2655 (1)
    -Pass: 3754275 Run:3754277
    -BUG at check_empty_area_window:2656 (1)
    -Pass: 3754275 Run:3754278
    -BUG at check_empty_area_window:2657 (1)
    -Pass: 3754275 Run:3754279
    -BUG at check_empty_area_window:2661 (1)
    -Pass: 3754275 Run:3754280
    -BUG at check_empty_area_window:2662 (1)
    -Pass: 3754275 Run:3754281
    -maple_tree: 3804518 of 3804524 tests passed
    +maple_tree: 3804523 of 3804524 tests passed

So only one bug left to squash ;-)

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
