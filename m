Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A661768A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKCGD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKCGDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:03:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4A19280
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:03:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o7so716868pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 23:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcRPdTV+WHrAGCtQC2DiKk2qf+ALI9TLfQTYJZ4jJzU=;
        b=nHMjJVtMxmTIzf2SCJTSZI8zPM1b+mG2EXn9V6MK0pgbT7qfY3VOu+H/BmRcHFvppS
         9Un+JTe85Imf4beW1yi4D9Ips5UD9pcQk82+5ZOPH3hh4QF8UUfYCS2ibY1R/hLdGkMs
         yywa47cffiRjPj6E2Ai5H2WJ84Pn7cyrNqhas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcRPdTV+WHrAGCtQC2DiKk2qf+ALI9TLfQTYJZ4jJzU=;
        b=PZqnL3wjhmtSUbxmLCHSz61Kc4Ab2jgFw81UBDg88COBZvGCbjEl/W2jEJKQ+47sGQ
         jZ8l28Cb2+7x9i85VONuevolCfP6iz3dKnrBvzyBRZLRXVVlxD8AieGwR5eFTBHtnXfN
         9Q4bcvszf/Wdd+IfYFnZdEwEHbhhX3z+07dTy3EPWpO1F6m+PeskejqhZwu6/0a8Y8Wv
         otq0XSxMVUs3R2sbiX6Og5nBm+ZadbKswuDpx84iyWrzbqBw/C0dqhnsbp/7JUqLKRnm
         ZAf+4FAbcE3lFCXY6j8amfcW+74Sm6ju1MmrBNuzr4F0MYZKeMnN6RP+h9vqw842vJrT
         BAEg==
X-Gm-Message-State: ACrzQf0LrsNycpQHh/Ztq8Pz2WQZtfK+zaU/sD8i35lN0dR42l5v3QnG
        Wxz6Gmql4a4WwS2Q8PvrClOQfQ==
X-Google-Smtp-Source: AMsMyM5Lgg4d1HWZx4U9r1HuArlLezm+6Cgwa2h+aatIn3Tt+M5tHsQPX4DWSi3/GzOXxo4OXBxTtA==
X-Received: by 2002:a17:902:ce92:b0:187:2938:2fca with SMTP id f18-20020a170902ce9200b0018729382fcamr16935349plg.7.1667455432892;
        Wed, 02 Nov 2022 23:03:52 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001745662d568sm9359633plh.278.2022.11.02.23.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 23:03:52 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:03:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2NZxD5SpHEObPaE@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2M0t5etyJiUfeQi@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 12:25), Sergey Senozhatsky wrote:
> > or we can introduce the threshold with action item.
> >   
> >   echo "idle 888" > /sys/block/zram0/recompress
> >   echo "huge 888" > /sys/block/zram0/recompress
> >   echo "normal 888" > /sys/block/zram0/recompress
> 
> I like the latter one, when threshold is an optional argument.
> I probably would even go a bit further and add keywords:
> 
> 	type=STRING threshold=INT

E.g. recompress support for type= and optional threshold=

We kind of don't have a use case of type=normal, as it is an equivalent
of no type. So we have huge, idle, huge_idle and no param means all
pages (which is sort of logical). threshold is optional.

---
 drivers/block/zram/zram_drv.c | 55 ++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9a614253de07..12f03745baf9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1688,7 +1688,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
  * Corresponding ZRAM slot should be locked.
  */
 static int zram_recompress(struct zram *zram, u32 index, struct page *page,
-			   int size_watermark)
+			   int size_threshold)
 {
 	unsigned long handle_prev;
 	unsigned long handle_next;
@@ -1708,7 +1708,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	/*
 	 * Do not recompress objects that are already "small enough".
 	 */
-	if (comp_len_prev < size_watermark)
+	if (comp_len_prev < size_threshold)
 		return 0;
 
 	ret = zram_read_from_zspool(zram, page, index);
@@ -1780,29 +1780,42 @@ static ssize_t recompress_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	char *args, *param, *val;
 	unsigned long index;
 	struct page *page;
 	ssize_t ret;
-	int mode, size_watermark = 0;
-
-	if (sysfs_streq(buf, "idle")) {
-		mode = RECOMPRESS_IDLE;
-	} else if (sysfs_streq(buf, "huge")) {
-		mode = RECOMPRESS_HUGE;
-	} else if (sysfs_streq(buf, "huge_idle")) {
-		mode = RECOMPRESS_IDLE | RECOMPRESS_HUGE;
-	} else {
-		/*
-		 * We will re-compress only idle objects equal or greater
-		 * in size than watermark.
-		 */
-		ret = kstrtoint(buf, 10, &size_watermark);
-		if (ret)
-			return ret;
-		mode = RECOMPRESS_IDLE;
+	int mode = 0, size_threshold = 0;
+
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		if (!*val)
+			return -EINVAL;
+
+		if (!strcmp(param, "type")) {
+			if (!strcmp(val, "idle"))
+				mode = RECOMPRESS_IDLE;
+			if (!strcmp(val, "huge"))
+				mode = RECOMPRESS_HUGE;
+			if (!strcmp(val, "huge_idle"))
+				mode = RECOMPRESS_IDLE | RECOMPRESS_HUGE;
+			continue;
+		}
+
+		if (!strcmp(param, "threshold")) {
+			/*
+			 * We will re-compress only idle objects equal or
+			 * greater in size than watermark.
+			 */
+			ret = kstrtoint(val, 10, &size_threshold);
+			if (ret)
+				return ret;
+			continue;
+		}
 	}
 
-	if (size_watermark > PAGE_SIZE)
+	if (size_threshold > PAGE_SIZE)
 		return -EINVAL;
 
 	down_read(&zram->init_lock);
@@ -1841,7 +1854,7 @@ static ssize_t recompress_store(struct device *dev,
 		    zram_test_flag(zram, index, ZRAM_RECOMP_SKIP))
 			goto next;
 
-		err = zram_recompress(zram, index, page, size_watermark);
+		err = zram_recompress(zram, index, page, size_threshold);
 next:
 		zram_slot_unlock(zram, index);
 		if (err) {
-- 
2.38.1.273.g43a17bfeac-goog

