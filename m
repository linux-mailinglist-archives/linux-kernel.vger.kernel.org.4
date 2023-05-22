Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF870CC37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEVVVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjEVVVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:21:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2FC9C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:21:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae4c5e1388so63042455ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684790477; x=1687382477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtWptAsa4eS8Kz5UJ2iVjBJtBMlQ0SUqdqNlkHKBLEs=;
        b=JIq7ayuhUCPY+jd41Z0soEOBn/LFyKyWmnktUDKUkFjbcodRiaN8GF9yRYnWncUysg
         JMis495bRgGRsJPACvfNdeWyPpeRvfE+6TCQlXMJSjY4oCQAKJ2NcKfPCjEzu8E/qn+d
         4O2sTSDN8hdrY3dVMXBStxPpbdjTlpkZ95Wb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684790477; x=1687382477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtWptAsa4eS8Kz5UJ2iVjBJtBMlQ0SUqdqNlkHKBLEs=;
        b=eM61pE/ltRPUR6mXR3hqTHhCmtUI8ZeCp6Db1xiGqMQg+YWwOE2raI+i7nMYRmWMuj
         +K34gLrcLWoiKqOf+1ijX51WTd71o3++TAo89mOmapdOsjMc/O9jtt9vrVMU6ZukDHBl
         ww2qNjzSo+qgbsmxtLunWUn0oIOu5/yeLUXchfk4u57v7dWajLs1RZuZ0epGhrmla3gR
         COiXo3d78RfVBeDd3tWn3/G2CT8yeifItioLSUorwiennouQQrej7qVyppR0cvugK/nH
         4jsB+4vAOvNtC3Ar8/Cg2cFC74m7FH2y6FiWyf5s6tBw32IQvZ5I9Qk6tiI8Q72RvnHI
         HF6w==
X-Gm-Message-State: AC+VfDyS/xHKRGqtYalEp96fBnYHBtBa11DTlpqIe1AQNYFe547vBeKj
        7a3PW9pxYojb7AeYvPTJdGsmHA==
X-Google-Smtp-Source: ACHHUZ4Qk7EITjWh+NVhaDiZRNwGFS+DHaJu7PM8BcgUFv03Lt3J0yK+zWPWlEVAJbnH7f3us6FDQQ==
X-Received: by 2002:a17:903:48a:b0:1ae:52ea:5fa6 with SMTP id jj10-20020a170903048a00b001ae52ea5fa6mr11039976plb.8.1684790477220;
        Mon, 22 May 2023 14:21:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001ae44e2f425sm5239217plg.223.2023.05.22.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Song Liu <song@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] md/raid5: Convert stripe_head's "dev" to flexible array member
Date:   Mon, 22 May 2023 14:21:15 -0700
Message-Id: <20230522212114.gonna.589-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; h=from:subject:message-id; bh=fm/ezGihLT88LzMah4Fd0e38oNOXvo+hj+2PCvpzioM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBka9zLVXP5GF5nusCTtCCpiPzdqxuZYP1lhGnV3/nP RaabgLaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGvcywAKCRCJcvTf3G3AJqLNEA CQhGxdsHJfIqJXnwaI/TKJqp1MlIRzOzuHQNQKFtG4lEGw33c0Z9FoyV3oXosgTp/gW+KVRR2Fp7Bn x4Ca7pXIy0HGuOLJlMhQJXKh3AfnPuibkkQVSpnvWqCjTcGz/mBhQOt+Q11QIAYdp+bL/n25kQV2Pm VuS3s0lLyhnltc6DArfq/ujY8mva8GUWZJ2i881mp2oL+BIgS7/4/HvvbcPj9tPQUXtKZv7UnVwFiK LhH/HXhio18g9cdQ9xgpsohuY0bjXL/Ij86RbwWRD3fhS6P7ndkUBXvFi3Fu4niWIWMKweZl6DdNnG 8nbNPhPd8QOCpREE2CfIW8irzwtgQo4wb6/xB1kaXjfnFb38T0HkDUP4lM4C5nOybf+CQiiEWJByHc Oo1q75O2wAAHLf7SG8kDsGKMyjXi4bKdFn8HW4qfaVITrNJIyayw8icR2WPeO+TAdMor4B+NDvJjtV 4YXgUxNr7U8KyTfeqSKfIP1/HJw20rOeFjeMwHSfHDtl5CMx6NzT9TceqDuw1TY/DnG7lPGP74L/JW 4he8eKVFBT/URlGL4CRj2P4gKD/FDj2Y6zVlR724kQKFHneEoSdRF0y40JyVXPD4Ixd+FvjxffTOYA K/6TvPUHFv6VKillKK3lpunJgPFx//uKrg35R9Fb1vkkMbmlz5+t0KQk4fOw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace old-style 1-element array of "dev" in struct stripe_head with
modern C99 flexible array. In the future, we can additionally annotate
it with the run-time size, found in the "disks" member.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
It looks like this memory calculation:

        memory = conf->min_nr_stripes * (sizeof(struct stripe_head) +
                 max_disks * ((sizeof(struct bio) + PAGE_SIZE))) / 1024;

... was already buggy (i.e. it included the single "dev" bytes in the
result). However, I'm not entirely sure if that is the right analysis,
since "dev" is not related to struct bio nor PAGE_SIZE?

v1: https://lore.kernel.org/all/20230517233313.never.130-kees@kernel.org/
v2: use new struct_size_t() helper from
    https://lore.kernel.org/lkml/20230522211810.never.421-kees@kernel.org/
---
 drivers/md/raid5.c | 4 ++--
 drivers/md/raid5.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4739ed891e75..64865f9dd3f5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2433,7 +2433,7 @@ static int grow_stripes(struct r5conf *conf, int num)
 
 	conf->active_name = 0;
 	sc = kmem_cache_create(conf->cache_name[conf->active_name],
-			       sizeof(struct stripe_head)+(devs-1)*sizeof(struct r5dev),
+			       struct_size_t(struct stripe_head, dev, devs),
 			       0, 0, NULL);
 	if (!sc)
 		return 1;
@@ -2559,7 +2559,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 
 	/* Step 1 */
 	sc = kmem_cache_create(conf->cache_name[1-conf->active_name],
-			       sizeof(struct stripe_head)+(newsize-1)*sizeof(struct r5dev),
+			       struct_size_t(struct stripe_head, dev, newsize),
 			       0, 0, NULL);
 	if (!sc)
 		return -ENOMEM;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index e873938a6125..6cfc74162b41 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -268,7 +268,7 @@ struct stripe_head {
 		unsigned long	flags;
 		u32		log_checksum;
 		unsigned short	write_hint;
-	} dev[1]; /* allocated with extra space depending of RAID geometry */
+	} dev[]; /* allocated with extra space depending of RAID geometry */
 };
 
 /* stripe_head_state - collects and tracks the dynamic state of a stripe_head
-- 
2.34.1

