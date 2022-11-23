Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AF56369BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiKWTRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiKWTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:17:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD8C72CA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:17:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p12so17506391plq.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zszPKirATociZwkufCMKuACjS2vwEYsrnSZpS9P9lU=;
        b=Pjl0mjJlKG1hOe2sKOhjXT4gUoSAjgo1SasKPbLKNH10Mwo7iw07plvWf50TYRiYD/
         lmRm617Y3gCQ+CaSwGIqJnTR/lpteyBRLmBW+LlbxUuLHhx9sld4qVIx721DTVCXv/Xr
         1mr8W6jJh3AqJ0uXmDXyWm/vfk14FQM7Wp5D0znqXME4eVBcJ3uM58CzPXFkmyH/MWLl
         yYMsvLyoBqUut6u3gJo1d6E6Pm/MKgJDYyP0vFzlusNnIj7iuPmMqURMzx9knZcUPOJO
         QQnzOGwFW2ItNQfq1Yp/dTsbGx9WEXSoN2+LmOaiC+rFYLB8QwH/JMaq6dctbb7sWXCJ
         b7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zszPKirATociZwkufCMKuACjS2vwEYsrnSZpS9P9lU=;
        b=qH+CY+8vTKO0VU1p4KCwTgqLrK7twSIU1TgbMQ25NMau9DGBGRa5Uwuk2i/noz1g+7
         i1dvdXzV+zBqfeh/eKO9AhuxJ2pLFJheAoGTznfPJQxgoepvkDwW+uO8jfat74I/3iqU
         VtVy3HenXp/DAQZKLKV5P8i2fRbfWZdtzFvXIDpqCIiC8eKLX42vdktydX7GHg+3Nr6x
         yS7Q6fR9cKnyQuDOs96vz9dZOETCv18LQJYFKlz+sOxd0yNMPIO9pFCw8rMpOlCcAetk
         Fx4ACHcDfNoprCJlUdXi+IsDAqPi56+PFS9x9fglGaJOeBBztP0FBtyPykkPKY3CVHPU
         Oigg==
X-Gm-Message-State: ANoB5pl9t3+jXlJOge7WHB1PR2xaxOyc0K7xQ1l9AUYxCB+KmccAx7ms
        i/1z0auxndQ2HW/bSRVwQM8=
X-Google-Smtp-Source: AA0mqf7sE3DNwI8yQ+VmRrDuWB9sYV3N0BLxETDbF+WTN69Rchh9HUX9BCBlkK80HpEAGYYHEzbjHQ==
X-Received: by 2002:a17:902:9881:b0:188:62b8:2278 with SMTP id s1-20020a170902988100b0018862b82278mr16094017plp.96.1669231025106;
        Wed, 23 Nov 2022 11:17:05 -0800 (PST)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id i29-20020a63131d000000b00460ea630c1bsm11021421pgl.46.2022.11.23.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:17:04 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 0/6] Implement writeback for zsmalloc (fix)
Date:   Wed, 23 Nov 2022 11:17:01 -0800
Message-Id: <20221123191703.2902079-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This contains two small fixes that should be applied on top of patch 4
and patch 6 of my zsmalloc writeback series, respectively.

Changelog:
v6-fix:
  * Add a comment explaining LRU update logic in zs_map_object.
    (patch 4)
    (sugegested by Sergey Senozhatsky and Johannes Weiner).
  * Use get_first_page() and add cond_resched() in retry-loop.
    (patch 6) (sugegested by Sergey Senozhatsky).
v6:
  * Move the move-to-front logic into zs_map_object (patch 4)
    (suggested by Minchan Kim).
  * Small clean up for free_zspage at free_handles() call site
    (patch 6) (suggested by Minchan Kim).
v5:
  * Add a new patch that eliminates unused code in zpool and simplify
    the logic for storing evict handler in zbud/z3fold (patch 2)
  * Remove redudant fields in zs_pool (previously required by zpool)
    (patch 3)
  * Wrap under_reclaim and deferred handle freeing logic in CONFIG_ZPOOL
    (patch 6) (suggested by Minchan Kim)
  * Move a small piece of refactoring from patch 6 to patch 4.
v4:
  * Wrap the new LRU logic in CONFIG_ZPOOL (patch 3).
    (suggested by Minchan Kim)
v3:
  * Set pool->ops = NULL when pool->zpool_ops is null (patch 4).
  * Stop holding pool's lock when calling lock_zspage() (patch 5).
    (suggested by Sergey Senozhatsky)
  * Stop holding pool's lock when checking pool->ops and retries.
    (patch 5) (suggested by Sergey Senozhatsky)
  * Fix formatting issues (.shrink, extra spaces in casting removed).
    (patch 5) (suggested by Sergey Senozhatsky)
v2:
  * Add missing CONFIG_ZPOOL ifdefs (patch 5)
    (detected by kernel test robot).

--
2.30.2
