Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B16162D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKBMkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiKBMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:40:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3252B2A254;
        Wed,  2 Nov 2022 05:40:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i3so16265507pfc.11;
        Wed, 02 Nov 2022 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWycHaP8mfKxEznoLfJrfhCyqFQA+DINLzwU4BVGVxk=;
        b=Vjz6n77GwFrjTad3BeT91Wjt9YM/ZuHb/Ihplqu7Quq40BkVDlbSXLkn7IGbIEwTJd
         WIMpL3Nla3r0fZ+BqFRPC8liWRTn/03ai1RK4lOrYcR8lpTLISCbHi/hzjq/K5lY8Lxh
         YBHY0Kv4f2eFOSIkqYHMiYlQyNFjJsVadJ0YyWbgU8V7jYNanDRspS2SLiCu83lIEymE
         sgzAZs/HBhERYNmbcNYfGdP/nkZgYrRxxyRB30yKe1p+PaSsOqQnhbotmUqEXJf/JdC3
         1XsaKzluGl8R1u7G6w2z/R9pCik9nWdnnMlgYgBFB6/SCCVovyj0vTX8Bg3H5uIP3AM5
         VHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWycHaP8mfKxEznoLfJrfhCyqFQA+DINLzwU4BVGVxk=;
        b=CcYlAy+iHjkRc3BcOCZ3xszBC0z0FHg23TbrdoUZxMepIohwLY3pZMDhRj13w+UW89
         irSy3mUadsEDXEwct0BOID96B/IKAvihzyRXDapPuqz1vpwCmAH0K8vFaZ4Pd88bpkng
         Qdene8cp/CZtTqdty7acE/Pzze5xQjyl7Tgikqk+hv0gpW/0qmalFZVR1nSo1Vx1G5fH
         HHAHXPysos2TnP2+t2UzzhidhnCrTlC7Z2AsNJ0e7h+OZlJ0AgwESI1zW6DMXQdjaTXv
         ur//F69eOjt0dL/cIgQefxbZdde/r2xpcmfyfZIYNHM+sUuWXtI2qaxq8opNU1thLu4r
         8qmQ==
X-Gm-Message-State: ACrzQf0TOHAQZmNUphUnz5PyvBITh/ieqbxOo4YO3nt+kkrTY3fkjl2C
        MAEI1B+fyI6eLXpp8aMggyPtj0rq+2Hg2D3y
X-Google-Smtp-Source: AMsMyM6+peOYHtwZjDWKqsEc76ZhDpUihRXvTF1OtSrg2x70YIx+HB/0VsHCP9OFhoKDCBnafaeWJA==
X-Received: by 2002:a05:6a00:1152:b0:56c:dd9c:da94 with SMTP id b18-20020a056a00115200b0056cdd9cda94mr24949120pfm.66.1667392822584;
        Wed, 02 Nov 2022 05:40:22 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm8339360pfk.196.2022.11.02.05.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:40:22 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [PATCH 4/5] block, bfq: change "secs" to "sects" for bfq log in bfq_bfqq_served()
Date:   Wed,  2 Nov 2022 20:39:55 +0800
Message-Id: <20221102123956.230-5-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
References: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
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

Let "sects" short for sectors, as "secs" is reminiscent of seconds.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-wf2q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 8fc3da4c23bb..f57ed0b037f3 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -823,7 +823,7 @@ void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
 		st->vtime += bfq_delta(served, st->wsum);
 		bfq_forget_idle(st);
 	}
-	bfq_log_bfqq(bfqq->bfqd, bfqq, "bfqq_served %d secs", served);
+	bfq_log_bfqq(bfqq->bfqd, bfqq, "bfqq_served %d sects", served);
 }
 
 /**
-- 
2.34.1

