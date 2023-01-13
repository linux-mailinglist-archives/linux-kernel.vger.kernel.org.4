Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4376690CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbjAMI15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbjAMI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:27:35 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32A55652
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 7so14515584pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iTd5byfBOgh9LVNuYuoOV6hXCYzXq9gAf1csxesg8Y=;
        b=f4WyK3XlBgkV1829d+TSRcqYiXtgsgVc0lzyFga2JdKfICjv+2pvnWx/fysrvWeeqp
         4g4zEITqfzVovBMOaYMAZfTvSO8H0c30bfGjbfVneHfX96pffYg/4NNwdDubQkeAXGF+
         NXmTN8SrCcmw3gbQvFXSjxxTysiPyVQmreTuYBlhfVs9xmkwxs4MkOfz4DJBkJC0m96G
         9NAYz8PdGTXGdRsRIKvcQmaKr69fppmU74LXLcB/u1qvpzBHYeMFSGM7lViEsSM8g4UK
         Z+Km4VvT4nxgGfATWUcbqR40opiVVYy4VerfXH1aB0dTKhgNsB/JAyzzeVrL9rENC0lA
         U9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iTd5byfBOgh9LVNuYuoOV6hXCYzXq9gAf1csxesg8Y=;
        b=qwAAW5MOdg+KA3x4fS/11OJdgn/GhJlB9f9Ut25ZcpXbPUcrsQc3kIl5WvJlYJvoSF
         cvzghw9vIJOtqoj7Q9ht3NfhCZBSGB8B/MWtVNSRteOS+AO4unlufBNbU50FsKq3xS27
         vuvfiAyucAlDX2N/TrmyTTCfuVoC75ZS+VBPanjNO1xY/HhhjT8qypkF1ZjTqh1JReeq
         852EPBXkgCUg2LoXFEqo3VYATs347qPudwhauQe5dkp0m92MUhjFY4FLqh4ZemjCrrxb
         f8vnQGQjY6YHW1gjjiOFTsexLHBRQcpIC9SA+gzpDtaAMZDZbqzvezMrXQt/6HCaALf6
         HTmg==
X-Gm-Message-State: AFqh2krThuUM2lP3d3sJ9zU1aDjFhsLNcg+EtLs0GXCD0OyV+9OISkel
        7cCQvufD3WxlBeceE1AL2AgOIw==
X-Google-Smtp-Source: AMrXdXsx5JHY+ED58MLqqtW4K6Yducj8FoqsJMzI/rev6xhsXOh0KNm1J6lTIgHBLlpTVaL9EMJ4ug==
X-Received: by 2002:a62:e703:0:b0:577:7cfb:a896 with SMTP id s3-20020a62e703000000b005777cfba896mr9537441pfh.31.1673598430465;
        Fri, 13 Jan 2023 00:27:10 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm13092738pfl.136.2023.01.13.00.27.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Jan 2023 00:27:10 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 1/3] memblock: Make a boundary tighter in memblock_add_range().
Date:   Fri, 13 Jan 2023 16:26:57 +0800
Message-Id: <20230113082659.65276-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
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

When type->cnt * 2 + 1 is less than or equal to type->max, there is
enough empty regions to insert.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 mm/memblock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..6eedcfc5dcc1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -601,11 +601,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	/*
 	 * The worst case is when new range overlaps all existing regions,
 	 * then we'll need type->cnt + 1 empty regions in @type. So if
-	 * type->cnt * 2 + 1 is less than type->max, we know
+	 * type->cnt * 2 + 1 is less than or equal to type->max, we know
 	 * that there is enough empty regions in @type, and we can insert
 	 * regions directly.
 	 */
-	if (type->cnt * 2 + 1 < type->max)
+	if (type->cnt * 2 + 1 <= type->max)
 		insert = true;
 
 repeat:
-- 
2.20.1

