Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0797D620148
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiKGVgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiKGVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:36:28 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032046164
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:36:27 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so11958017pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tQ7MqopprIdRhb/IgvKRUjGQBe2LKpMrEFgj2d9jZg=;
        b=M1k2UTfxuajNc/oXu0LY2P83Vd6nzF4vsNIzUWoBnmefSmqUYpjNgicnLsxLPpisLb
         jPkY9vCm6EFryy8KQ1OzKez3Trva3tiqeOp197xzXqo94hWFlu9UwwpjxJwv/WMSC/+G
         Qvh2gU2cvXsntxroGga6/4cJal+65h+gZdq697jW8ScV1cljBAMaAkJ2N94z8RxfLQ14
         NAtLJwbhGJ4TKHuz4zUc7huMFbiah9SGAK5A2rhAOrEqP5GCQH8OFP0R7Dfnyf3zBcaX
         GZIt6Wt64YchXsxJ/6ghFniaO/c+49GjJH3elxH4mHdREZZGQNDDtjbwizo7OdECLKJP
         HQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tQ7MqopprIdRhb/IgvKRUjGQBe2LKpMrEFgj2d9jZg=;
        b=dIW5VTNSmmVu+lUw1oQT0gwjho4i1E787jkwxBw3SfgAkFkW2xd6SkxjrRIeEv33L7
         ce3tuF1pU5iFsCDotDSTUyHesus75Ix5UwGpJn4V0bjMY9jUo4YlZG4XrRhugmToDxvi
         vG7IGkr2/y3AEguttkiLfkcWJGlZXUmMZ2PV9RdamshbLm/oONW2tKNW6QEWOxLLU/f+
         TrS/yi/FL/SlvJloRnaEoMMFLryHsXimyBI66A37p3cjyoKQL4b6wRnBlcnlKfhGqyRt
         nxxX8L7FRwThTrqU9CpZnXqGwv6KVQL2Ba/fyEvhGg3i29tLBKn4KQeGJhTqVegIVEG7
         ghQw==
X-Gm-Message-State: ACrzQf3ycCjahVtEotmUYi3R+UiWnFw8bj17aw5r4wPC34zH5zxfbweP
        kVK1vwDDQrKHcPu/w+iIeA8=
X-Google-Smtp-Source: AMsMyM7bTMxCsP9dOI+Bl1xuj1IaaaoIqlOYDL8utEB69BRcDrg0hci5JTHfuZuMGkulrILxqo1MmA==
X-Received: by 2002:a65:41ca:0:b0:434:f92f:d711 with SMTP id b10-20020a6541ca000000b00434f92fd711mr45773572pgq.151.1667856986465;
        Mon, 07 Nov 2022 13:36:26 -0800 (PST)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b00178b9c997e5sm5446350plh.138.2022.11.07.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:36:25 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     senozhatsky@chromium.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, akpm@linux-foundation.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 4/5] zsmalloc: Add ops fields to zs_pool to store evict handlers
Date:   Mon,  7 Nov 2022 13:36:25 -0800
Message-Id: <20221107213625.939660-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y2Htmak6+7b+6pBv@google.com>
References: <Y2Htmak6+7b+6pBv@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Essentially, the zpool constructor allows us to set things up with a null
struct zpool, zpool_ops, or zpool_ops->evict, which we have to handle.  A
similar null-handling pattern can be observed in zbud (mm/zbud.c) and z3fold
(mm/z3fold.c) - see zbud_zpool_evict and zbud_zpool_create for e.g.

In particular:

1. pool->zpool_ops is the ops (containing the evict handler zpool_ops->evict)
passed into the zpool constructor (zs_zpool_create)

2. pool->ops/zs_zpool_ops (struct zs_ops) is a struct wrapping zs_zpool_evict,
which itself is a wrapper for the zpool evict handler (pool->zpool_ops->evict).
zs_zpool_evict also handles the case where zpool or zpool_ops is null, or
zpool_ops->evict is not defined (i.e return -ENOENT).

FWIW, I do think this is quite convoluted. In the long run, we might want to
simplify this design, but for this patch series I think it is wise to err on
the safe side and follow the other two allocators' design for consistency.

That said, while staring at the code again, I found a bug - in the case
pool->zpool_ops is null, pool->ops is undefined garbage. The v3 patch will fix
that to follow zbud's pattern (pool->ops = NULL in this case).
