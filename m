Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01795BF4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIUDs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIUDsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:48:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C17C310;
        Tue, 20 Sep 2022 20:48:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b21so4381163plz.7;
        Tue, 20 Sep 2022 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X35vTpMjT4JUzdTpTOGe0YDg/vRzJ/72gtqZZF6EwZw=;
        b=TIchTrk6LcgzDDQ8AFqJ4xvF0DQy/GH1PrTcZsl47HPjIW4N9bAhmZr0cKJSQP0mIe
         dcTPofMbsqgq+n23YaQjaNdyGt01wOU08IYY877KynrlWkBD3WO/dAsRdKNUjKbrk91t
         LJsSBb0hxLB16WK8K1jYGJ8jJKbi4gDSaYTCNHG/wUe08Zll//maFZxZm6S4TF+gUm5R
         dpDlOVt5JRDxyfvV+wvgMrm8DPVENKMZyJAJpnNgC+Fisz2bYebzUG9AwVRKlOkRex6B
         0qSSV7ZyImEP9PdIWV6W5zVk7P/2XdVwgwdyojTKLRxu/dllobkB98ZbUiYU4TVb9Ur3
         fKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X35vTpMjT4JUzdTpTOGe0YDg/vRzJ/72gtqZZF6EwZw=;
        b=qlM/G9uKrsRnVQ2Wt2P6lamNvZrmV9K+mwMh9X9KbwQ9l3gpZppwReuX7F9TbFZuzA
         8RRDFP4GWU2mU/TeBkgpiu8FytXhXjhheMYaWiR8SQErbNJ4susB+ADLGsSu/V9Kpps5
         cSyVR39cYkvBoS/efH2jvctePKS25Fzz5JuUcx1co4mEsAa9Ip873gqo5Lo6ORycXAqM
         R5A2jBji+rt8Yi5tZ1gl81tYvm8Y8oej/XEo7L0LEcMN5hIO9yaMU8vfzfz5zXLeCULN
         D3tAUx86pTUl32lOiCp6xCSO+RO0x0aFbiv4G7Iis+Rqxj4wKtsJTihMfgBGH/QxcLBh
         3yww==
X-Gm-Message-State: ACrzQf2VA2QjEwE+3O0qbcyLmH2fKLAD1HSxnVPwAToRt99azsDOp0D1
        xGq0J5QW11zcjuGFnjxfghKmWibfO8U=
X-Google-Smtp-Source: AMsMyM6K9GqwvGT3+gDXIsQ7nZ2fMPOgroJtzYUUSxVGQV0M16/FcTofgYq3YjzGANtm73SGGuss3w==
X-Received: by 2002:a17:902:c94f:b0:178:4423:af05 with SMTP id i15-20020a170902c94f00b001784423af05mr2827126pla.147.1663732091867;
        Tue, 20 Sep 2022 20:48:11 -0700 (PDT)
Received: from carrot.. (i118-19-12-172.s42.a014.ap.plala.or.jp. [118.19.12.172])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b00176ca74c58bsm686016plf.245.2022.09.20.20.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 20:48:11 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] nilfs2: Remove the unneeded result variable
Date:   Wed, 21 Sep 2022 12:48:03 +0900
Message-Id: <20220921034803.2476-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921034803.2476-1-konishi.ryusuke@gmail.com>
References: <20220921034803.2476-1-konishi.ryusuke@gmail.com>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value nilfs_segctor_sync() directly instead of storing it in
another redundant variable.

Link: https://lkml.kernel.org/r/20220831033403.302184-1-ye.xingchen@zte.com.cn
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 0afe0832c754..9abae2c9120e 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2235,7 +2235,6 @@ int nilfs_construct_segment(struct super_block *sb)
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	struct nilfs_sc_info *sci = nilfs->ns_writer;
 	struct nilfs_transaction_info *ti;
-	int err;
 
 	if (!sci)
 		return -EROFS;
@@ -2243,8 +2242,7 @@ int nilfs_construct_segment(struct super_block *sb)
 	/* A call inside transactions causes a deadlock. */
 	BUG_ON((ti = current->journal_info) && ti->ti_magic == NILFS_TI_MAGIC);
 
-	err = nilfs_segctor_sync(sci);
-	return err;
+	return nilfs_segctor_sync(sci);
 }
 
 /**
-- 
2.34.1

