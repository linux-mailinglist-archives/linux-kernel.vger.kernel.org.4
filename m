Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D8A6EDFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjDYJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjDYJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:48:44 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE012C82
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:48:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f0a2f8216fso66951cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682416096; x=1685008096;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CeWRGPx2LawBwBGvr0WFM+GqJWUBACPVQzzjgyj15yw=;
        b=SiGttW/+6v4IDlVVTRt0v4v3m8Io2FqeltpCVkli46UFyxzA+osamD2MUatPpJKmVJ
         fgCUX2/EgTDAbGQWKH6jmHmk3S+scJZ/xGkKt1oa0ZNXDn+zcrVGJt3X4W9Xy89l9bDz
         wJrOK+mLqS3MppcKi3Df23PlAv4tUYVgXoarmyPzHVNuzj16qE0IU0t3cd16YDsOAr+5
         tOIySf6cXAt1EGwoaeOUDN6dNXx6e8du22cTRXstSVv5u0HArhvkzaviR3i1hsJchfVp
         SEwbfbzoVz5hhDQDo9q5dd9SO5C5yvLFOdLo4YBWPOSq3MX9FS7oCOLHyoIYG0kN3kU5
         ZGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682416096; x=1685008096;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeWRGPx2LawBwBGvr0WFM+GqJWUBACPVQzzjgyj15yw=;
        b=WbxgJBow2ImwKB1200zfw9hjq9B0RANCMQTX/XT8YmxZ0i0LYDZSUoTJ3cWf2nHroH
         29/7GFVX8kdr3lUwtPJGoR4ExKSe48RUR/Oqfhawe8BL1hB6zXjjadBBY2F52BNyyfxW
         NfeOEQQqO+q0mRc3x8K8atCVeKgctvj5pNDRMEdn5z3n6RmppDU4SFyZS+0Z1bXwoqMC
         MT7dQP91+AK3PA6+jgiyghWLR5TjLfRJE7hw09w20WgwM9to4M/ZLmBEIR2w06zzLxFP
         ZPB5DW4Cz5/QLu2XIZL1Hti8WENgBrYMUTP9+hHYWh2alEGfrpx4OjTeM04PFhssg47b
         o8ZA==
X-Gm-Message-State: AAQBX9cHk0rPT5LT3W/wvQ0QBsFq3Ey+QmtyiL/bmqNrCoURfkRwJqNH
        kLOdvoa1A4vTQrnf95qPjSbbaUlf4MoZstgljGPArW61XELMJ5qXIiOT6Q==
X-Google-Smtp-Source: AKy350Yi/HK5wFCVHtgc0boND65EG4RC2aE2Ukvk6IvxUe2KzVKCjJaiyFXfHQ43mqzqfxrBi8TMa5kMTx6ltmj7w0M=
X-Received: by 2002:a05:622a:15ce:b0:3ef:3083:a437 with SMTP id
 d14-20020a05622a15ce00b003ef3083a437mr288540qty.18.1682416096501; Tue, 25 Apr
 2023 02:48:16 -0700 (PDT)
MIME-Version: 1.0
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 25 Apr 2023 11:48:05 +0200
Message-ID: <CANp29Y5dbsSjd5q2TNJYgO5U1d6wu+XSSWR3PHWTX_efg7VyEA@mail.gmail.com>
Subject: Resolving the `fixes` tree build errors
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Dear RISC-V maintainers,

Could you please consider picking up the following fix to the `fixes`
branch of your tree?

https://lore.kernel.org/linux-riscv/20230227072016.14618-1-rdunlap@infradead.org/

As per https://lore.kernel.org/bpf/871qkh9zj8.fsf@all.your.base.are.belong.to.us/T/,
this leads to syzbot not being able to build and fuzz Linux kernel on
its riscv instance for already 74 days.

--
Best Regards,
Aleksandr
