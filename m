Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D56A015E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjBWDFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjBWDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:05:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647D8113CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:04:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so5377150pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asf6wyECn9s5Ay0jPFpgYQEaM+Qi9v9+4K9yS1D0J28=;
        b=GqW5JVFuXU7tv2rHfd8Pt7M7iy6Q2n1a4GMuUZashCmIOIlVkOSJRYEUBSVwU5p6BN
         HmcFaeQO/ndJkTMhziVkwhsUDE+mw2yq2JVYc3K7T1mKO0Z7l704UPaTXezHLwhMagoV
         tHQAbr94XZ2e0HAwUdwmKFL5dxpzFuOJz7rGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asf6wyECn9s5Ay0jPFpgYQEaM+Qi9v9+4K9yS1D0J28=;
        b=ldM3/oxgXD+OUtzYzPGi/dtgRlcMsM0GkspGwE1B4+i/9PZtcl0LnQg6ZzvTwI10Er
         Zb0HU0FpGD7oq7VtDAyC6Gpz5cd6R1u+EBPTpXB7LNeWLrv1Nhd1P2Pdn4SMyAyQnZL5
         RC+sA98adD02FB0e6GWIWQn2N7lO9syHU1LrpCq3l3R9GRr8GHrWonyd/UHRdLyfrZ4f
         09WwJ0XCe/VNh/HWL8eFGqyLXzdvux15MJgo35a/vPV4uyxkJQ3yE+DeVCzsWd5QauHj
         rNxiX2SavfOrjQBbHozcmbHr3HKIJcbkVsf+Ce1BZN156LuZW8q3HsZ47wufm9spaAYW
         K2bw==
X-Gm-Message-State: AO0yUKWU4GfCxlR1QQ5tSEJTUlXybyVUwUEsNEtvJszajDMFdXs1TKcc
        nt1cCgeKd8iCJ27SALeINOg8Zw==
X-Google-Smtp-Source: AK7set+EATz74Pic1+zOa/tByny2R+TyuhM/yQ3zojLfWsgEkDn4lxaa1dTV4OZ51+F+v4AZoFtXow==
X-Received: by 2002:a17:902:d482:b0:19c:356f:e98f with SMTP id c2-20020a170902d48200b0019c356fe98fmr13032448plg.60.1677121497854;
        Wed, 22 Feb 2023 19:04:57 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6de2:9e85:b508:57b8])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b0019926c77577sm608520plb.90.2023.02.22.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:04:57 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/6] zsmalloc: fine-grained fullness and new compaction algorithm
Date:   Thu, 23 Feb 2023 12:04:45 +0900
Message-Id: <20230223030451.543162-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Existing zsmalloc page fullness grouping leads to suboptimal page
selection for both zs_malloc() and zs_compact(). This patchset
reworks zsmalloc fullness grouping/classification.

Additinally it also implements new compaction algorithm that is
expected to use CPU-cycles (as it potentially does fewer memcpy-s
in zs_object_copy()).

TEST
====

It's very challenging to reliably test this series. I ended up
developing my own synthetic test that has 100% reproducibility.
The test generates significan fragmentation (for each size class)
and then performs compaction for each class individually and tracks
the number of memcpy() in zs_object_copy(), so that we can compare
the amount work compaction does on per-class basis.

Total amount of work (zram mm_stat objs_moved)
----------------------------------------------

Old fullness grouping, old compaction algorithm:
323977 memcpy() in zs_object_copy().

Old fullness grouping, new compaction algorithm:
262944 memcpy() in zs_object_copy().

New fullness grouping, new compaction algorithm:
213978 memcpy() in zs_object_copy().


Per-class compaction memcpy() comparison (T-test)
-------------------------------------------------

x Old fullness grouping, old compaction algorithm
+ Old fullness grouping, new compaction algorithm

    N           Min           Max        Median           Avg        Stddev
x 140           349          3513          2461     2314.1214     806.03271
+ 140           289          2778          2006     1878.1714     641.02073
Difference at 95.0% confidence
	-435.95 +/- 170.595
	-18.8387% +/- 7.37193%
	(Student's t, pooled s = 728.216)


x Old fullness grouping, old compaction algorithm
+ New fullness grouping, new compaction algorithm

    N           Min           Max        Median           Avg        Stddev
x 140           349          3513          2461     2314.1214     806.03271
+ 140           226          2279          1644     1528.4143     524.85268
Difference at 95.0% confidence
	-785.707 +/- 159.331
	-33.9527% +/- 6.88516%
	(Student's t, pooled s = 680.132)

Sergey Senozhatsky (6):
  zsmalloc: remove insert_zspage() ->inuse optimization
  zsmalloc: remove stat and fullness enums
  zsmalloc: fine-grained inuse ratio based fullness grouping
  zsmalloc: rework compaction algorithm
  zsmalloc: extend compaction statistics
  zram: show zsmalloc objs_moved stat in mm_stat

 Documentation/admin-guide/blockdev/zram.rst |   1 +
 drivers/block/zram/zram_drv.c               |   5 +-
 include/linux/zsmalloc.h                    |   2 +
 mm/zsmalloc.c                               | 365 ++++++++++----------
 4 files changed, 188 insertions(+), 185 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

