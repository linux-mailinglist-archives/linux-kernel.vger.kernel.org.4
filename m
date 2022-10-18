Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D0B602150
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJRCmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJRCmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:42:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25D94105
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:42:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y191so12848443pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RqeqoWqCjNqsK/xnS0nJr4BZwfuoj4Sj4MC4233ZF6Y=;
        b=VajYXNL8heC+d3EjGeQoNV0ccBG9rW9OALdTpXtV6hFkWtgdcmad0xx0D1SkNCxEne
         MdBrKH84G/Z3fwCKnTAyLiH3EO/LQ9BW6TJraV3NKq5KA5uAI3JAQQs0Afi6f9ujWHEk
         nDUBz656iaKRHyvf3aDoKl1K2hL7bD7nodh/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqeqoWqCjNqsK/xnS0nJr4BZwfuoj4Sj4MC4233ZF6Y=;
        b=rO+mDNHWG9V2T3hhDOmUv9syEkaj+VFl6B+VPcRuJY//elHgL9isSVHZmVaiL9wf/b
         mA4pD86P4zVfkIVhvT1OXqQZiM4bxJ8T6nN0GjPe4KKNf+rRLteRTvhn/v/HKxrVexFd
         Gmpg5i2R96cWRUG8lAKS/0k24pa1ok5D743CzhM4/xQHg+tiC31az+rskxWkX83hKHHX
         xry//iN+AqJkQfDANe1lJr9ylLCV8/eKS9ZCnIo1jODkK0CN1j5IlZTLPIj9RQA9ArM9
         GBtH+jeJGKnjndNtVTjtHIfC/Kf8JPS4A6kE4/c6vSDyaaE7Zdg0UJKFAPPVkOiduppl
         o+vA==
X-Gm-Message-State: ACrzQf04R5auRw5rr1WNKn/77ID38zTnRmXF6nY7oL1WMEViaaAq9PZk
        Jsx40OdEI2aRzYsGqo4x0t/7Cw==
X-Google-Smtp-Source: AMsMyM7D2E1TUCt6bluuMstbnVzW7wwywIoeH1xxhTE5eRRjGqD1I+0xkvHquZney3KDq7SEBc067A==
X-Received: by 2002:a63:1b58:0:b0:45f:e7ba:a223 with SMTP id b24-20020a631b58000000b0045fe7baa223mr737575pgm.548.1666060963676;
        Mon, 17 Oct 2022 19:42:43 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:58b4:95a3:4654:2a9f])
        by smtp.gmail.com with ESMTPSA id 8-20020a630308000000b0043c80e53c74sm6887064pgd.28.2022.10.17.19.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:42:43 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:42:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 4/8] zram: Introduce recompress sysfs knob
Message-ID: <Y04Sn50kt5qLxpbK@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
 <20221009090720.1040633-5-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009090720.1040633-5-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A fixup patch: update Kconfig description and tweak coding styles.

---

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 7febf36e93eb..3e00656a6f8a 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -90,3 +90,6 @@ config ZRAM_MULTI_COMP
 
           echo TIMEOUT > /sys/block/zramX/idle
           echo SIZE > /sys/block/zramX/recompress
+
+	SIZE (in bytes) parameter sets the object size watermark: idle
+	objects that are of a smaller size will not get recompressed.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 12368e773f3d..143c33bd6783 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1623,9 +1623,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  *
  * Corresponding ZRAM slot should be locked.
  */
-static int zram_recompress(struct zram *zram,
-			   u32 index,
-			   struct page *page,
+static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			   int size_watermark)
 {
 	unsigned long handle_prev;
@@ -1708,8 +1706,7 @@ static int zram_recompress(struct zram *zram,
 
 static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
-				const char *buf,
-				size_t len)
+				const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
