Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA864037E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiLBJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiLBJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:39:02 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CAB5D9B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:39:01 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id c15so4385477pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 01:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0HPGO5sCDYER8nLUp0b1v0HtrgxMZNE6bVgRCZ1Yeo=;
        b=P/qk4oZLqrAsqVK4/jnSl3q8IgbW3j+klplsHe3l81+pvr0S8zC0nRpgD2T0jKBBXw
         7XAWNtkwvaQU8pWFh92uCbDuluxJDSffE8D5yOcUrjjRqjuSoZ6W78fMjSju132raAVW
         pVr3fyYck+tYx/HXajAlMNr3n/GPje5C51ZtlPhJCQ7tMVYGf9C8LQ3Bft7/zFQS2+3O
         N9WhYQx6+wb1L56GfcwK8kFn/N8oqrWsGnGiZeZDDsbllQm1xdKioFA/AuWNiIUVJU26
         vlNExzgSEs9BMCnxrV2XO+c6AVC2aQvkPslqxZ+ZtQ3iZxxQDddCL4UnFIAmB6kBQ/2r
         yyMw==
X-Gm-Message-State: ANoB5pki36Q0rWdSz7OMTBfWOV9LMx9Num3KvnI8syF9dDknbeD/lZez
        XlK0X7mcPTqyLag/vtQPRrY=
X-Google-Smtp-Source: AA0mqf7W2TXFm/GNZrafRIqn4w21vsuQ6VvwezFXzzneUimTFz9VgvlZ9ut8pM+ancPPVzQ60GVczA==
X-Received: by 2002:a63:f845:0:b0:478:1187:b58 with SMTP id v5-20020a63f845000000b0047811870b58mr22256887pgj.43.1669973940511;
        Fri, 02 Dec 2022 01:39:00 -0800 (PST)
Received: from redsun91.ssa.fujisawa.hgst.com ([129.253.182.55])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a564f00b001ef8ab65052sm4370881pji.11.2022.12.02.01.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 01:38:59 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Subject: [PATCH 1/2] drivers: mcb: fix resource leak in mcb_probe()
Date:   Fri,  2 Dec 2022 01:38:49 -0800
Message-Id: <9f87de36bfb85158b506cb78c6fc9db3f6a3bad1.1669624063.git.johannes.thumshirn@wdc.com>
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

From: Zhengchao Shao <shaozhengchao@huawei.com>

When probe hook function failed in mcb_probe(), it doesn't put the device.
Compiled test only.

Fixes: 7bc364097a89 ("mcb: Acquire reference to device in probe")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 338fc889b357..b8ad4f16b4ac 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -71,8 +71,10 @@ static int mcb_probe(struct device *dev)
 
 	get_device(dev);
 	ret = mdrv->probe(mdev, found_id);
-	if (ret)
+	if (ret) {
 		module_put(carrier_mod);
+		put_device(dev);
+	}
 
 	return ret;
 }
-- 
2.37.3

