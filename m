Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEDB64037F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiLBJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiLBJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:39:04 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C3DB7DDF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:39:03 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id s196so3958479pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 01:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTUvgvzDNVb3Q9BB7bRv2FXaIaCGfv+EeGtlZYfVaoQ=;
        b=hMvIFlwlVksw1eDYumOyDAe11st4Yq+ToOip5YnUcW5IwJNugmUb5q4tjItT0aLg/g
         ZGEZJosDgbqFI6/v6pFNmaUhRn32NHYNdix/RZIExGDNKFOMKkDliczA9U9/xZrxE58K
         MdWNRAAbO50wdaSO/Qc3XwLAb/0gv/0aBMRLxheLiT7zmcyBZuOrTyiUjfLppMTbguJl
         VSqVmyVXlkEWjah4ofHrHaRYP0KAxH/Erbri50B5okozhkrwG5x71uPU233dj7gDzpfY
         YQ1gEdKVDcY91IDBTLS9CXrYWla8a8bSE3TTfst6uss5M45xO9uBMHa9rYL9R+TZlJhd
         8DfA==
X-Gm-Message-State: ANoB5pkwNl5pX7L3+ZHXSOBshPYbPKnxMAXkMPN2A17HVqbhR9xpkUfR
        iD0j0t0Zj7LICEN9rLUOwDs=
X-Google-Smtp-Source: AA0mqf6J1M+yCJEF5nYzQWdCHEx6Sr9pLrtgXjbBufF2fVOSOVHalEqonlNYxQzI8ak98NKtBx2JCQ==
X-Received: by 2002:a05:6a00:3017:b0:56b:ac5c:f3dc with SMTP id ay23-20020a056a00301700b0056bac5cf3dcmr53663510pfb.77.1669973942742;
        Fri, 02 Dec 2022 01:39:02 -0800 (PST)
Received: from redsun91.ssa.fujisawa.hgst.com ([129.253.182.55])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a564f00b001ef8ab65052sm4370881pji.11.2022.12.02.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 01:39:01 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 2/2] mcb: mcb-parse: fix error handing in chameleon_parse_gdd()
Date:   Fri,  2 Dec 2022 01:38:50 -0800
Message-Id: <ebfb06e39b19272f0197fa9136b5e4b6f34ad732.1669624063.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669624063.git.johannes.thumshirn@wdc.com>
References: <cover.1669624063.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

If mcb_device_register() returns error in chameleon_parse_gdd(), the refcount
of bus and device name are leaked. Fix this by calling put_device() to give up
the reference, so they can be released in mcb_release_dev() and kobject_cleanup().

Fixes: 3764e82e5150 ("drivers: Introduce MEN Chameleon Bus")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 0266bfddfbe2..aa6938da0db8 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -108,7 +108,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	return 0;
 
 err:
-	mcb_free_dev(mdev);
+	put_device(&mdev->dev);
 
 	return ret;
 }
-- 
2.37.3

