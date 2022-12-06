Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB9644A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiLFROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiLFRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:13:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB4326F7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:13:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vp12so7808691ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHW4AF6UbouyjsoQjAo93Rw4CHPKsRNQFiH676IJZhI=;
        b=U3JPE2wpoXJXzygCbWmscmBrgC7FK5UJNHsQONmaGZiZmH3+sgAYjnYd5Ls05NwlQM
         vONDSCbVwBJkvD+yFM9ZlH2UrOXI+N1akE2rtdo0FhyTxLbcXJNrdp0P8+pXIposb+UE
         IGcNcfKz8Y8mljOCpJv3hMRSWaepYsKExZQ89Ffqglmn9IibZIsuj3nOEpTrpsOKREm8
         f5yPVKxG2TqfCm71/bP+FY8Zs7eq1s5zzjEyw9tPwFRlJlN4dRk6a6hyVJyj1p1wafID
         e4W96vxjpUtly6cSO2Kh3gkhCt0wDtzy0xrJ0UNTk96w+7FtOjPNllJxXrMYRQbjBwzd
         7Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHW4AF6UbouyjsoQjAo93Rw4CHPKsRNQFiH676IJZhI=;
        b=3yYYy2G0w/uu10t+zNuSmAU9VeS7QIETp49jC4loj4eEZ16ApBjwAlBlkz4CDCKRkB
         JNdShAr83172msKAoyP0gtWAqkcBPEF29wrkBVlHDYhVjLsQtNkE9/mTyb1/6muFLyNB
         8vI11YlfHw65eUTfk4dWKzCusudrTmY2SgscuRqCL4MSgtT8WhFs+Qh3RuR29C7s/GGp
         ipkGmbURnZiFo85IGROd9cU4k3qg8F5KIGR/QzuqGNFqAHpraXdCsEtago2VYGd42siX
         FJSt2PjY8JZU+XEvRDEowTicvseLV/zp3OVmslxGlENG4VaUfAtUg1Fx4I0YbiYDTzl+
         GfJA==
X-Gm-Message-State: ANoB5plw2PqiX0+SKrmgHI61kuzMphZ4c3/5PZGiKR8tYhOm6KqVF22r
        5AuFCjr3AYgmp3LL2VwiuI8JPg==
X-Google-Smtp-Source: AA0mqf5W2qYVz5F/48F3bnWfVdeE4oLgzzBVbetcU0AUNKL0OBDRXLlvzL52A5PMrRggIG/5SLHwQQ==
X-Received: by 2002:a17:906:a107:b0:77f:9082:73c7 with SMTP id t7-20020a170906a10700b0077f908273c7mr56670721ejy.517.1670346835640;
        Tue, 06 Dec 2022 09:13:55 -0800 (PST)
Received: from localhost ([2a02:8070:6387:ab20:15aa:3c87:c206:d15e])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170907819100b007c03fa39c33sm7515048ejc.71.2022.12.06.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:13:55 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mm: push down lock_page_memcg()
Date:   Tue,  6 Dec 2022 18:13:38 +0100
Message-Id: <20221206171340.139790-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New series based on the discussion in the previous thread around
getting lock_page_memcg() out of rmap.

I beat on this with concurrent high-frequency moving of tasks that
partially share a swapped out shmem file. I didn't spot anything
problematic. That said, it is quite subtle, and Hugh, I'd feel better
if you could also subject it to your torture suite ;)

Thanks!

Against yesterday's mm-unstable.

 Documentation/admin-guide/cgroup-v1/memory.rst | 11 ++++-
 mm/memcontrol.c                                | 56 ++++++++++++++++++------
 mm/rmap.c                                      | 26 ++++-------
 3 files changed, 60 insertions(+), 33 deletions(-)


