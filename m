Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66BA5B7935
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiIMSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiIMSLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:11:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3A72B7C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p18so12490354plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XQ8hIFG6q5WKMN5Ns4E0eRv8QKNJMaYAAhMqE3kUHyU=;
        b=Zwd2T64CMlOt2t6v2YUv91XYfNgJbAxGmsslT3ZAOs6w6EZg8t5Fqp8Nqh8dVEKNAA
         FqB9RVgbnB5pAyE57yYcdPvNa3eK64heDwFxyr1qvrUFEBWY/8t5kaRgEGMu0OsOUvVk
         rgmlIr3av1kFrhsoQVo6gw7QSDja6eytLvufYelEZXhwBU4yEEmu36iJOPKR+NAcJx6R
         UDEu5dpNkDEBF3pPNPSxZTIce6cEgmE6LsXYTBHQXL8MNOnp2+etsTirEjdR8SZnElid
         DzmhxcVu6uxPtGGYRT57qjG2E7JL8PUIeaqgsNR5nSimhHdOf0kfcFDwQ3j+5j9EWE+Z
         Y2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XQ8hIFG6q5WKMN5Ns4E0eRv8QKNJMaYAAhMqE3kUHyU=;
        b=XxrJ6qYEl45KiIfTPAbw1U9jhfKtyl5eudoSoUhsDWEwt1S49P3Wo1uMkVidSO3aer
         fLiATzUYV5BUwVgxDhCQOVotfO/xfvucUGj8juVF1cdIrmjXsizQ0FdWdxy8f+aZkJdE
         VLBNt8KGvNWxeLzpEWHqJFkru/jt2o1ijlmb5sgg049LLJHXo9F8f1IvqQ1V/crjBtmn
         2rGcu/FHoZ9VRtFSH6lcuhdTzeAkYKNIyr3Ms0PymnqCoivZ7sdzjRLaS93Wa3UIAWXL
         yl4+83FD9Mo9u5ZMKf5p50BDvdAsjGAo8/P9eDnld9E8Mf3ZpbeCzttapy3BHnbTjIzT
         MAVw==
X-Gm-Message-State: ACgBeo0srT7kzo5ptrJGIRxObhf0uUMonX3eHLjs7ge2GolXsP+9u6Wj
        j/CBJsfxF7bzMQIJJpcMnRiKcpukz6X/3w==
X-Google-Smtp-Source: AA6agR6R65XTgekQohxDq76X9er4kMYytxvwLwcHqbE3PUPmsCOvUZYFcycYI1IHpgWbWwLDaTiQlw==
X-Received: by 2002:a17:902:820a:b0:178:456e:138 with SMTP id x10-20020a170902820a00b00178456e0138mr4704863pln.145.1663089480839;
        Tue, 13 Sep 2022 10:18:00 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id z27-20020aa79e5b000000b0053e5b905843sm796474pfq.203.2022.09.13.10.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:18:00 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 1/3] vmw_balloon: access reset_required through READ/WRITE_ONCE
Date:   Tue, 13 Sep 2022 02:43:04 -0700
Message-Id: <20220913094306.317734-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913094306.317734-1-namit@vmware.com>
References: <20220913094306.317734-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

reset_required might be accessed concurrently, at least through debugfs.
While there is no apparent functional risk, avoid any potential race,
even if it is benign.

Use READ_ONCE() and WRITE_ONCE() when accessing reset_required.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 61a2be712bf7..7fa91983c567 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -492,7 +492,7 @@ __vmballoon_cmd(struct vmballoon *b, unsigned long cmd, unsigned long arg1,
 
 	/* mark reset required accordingly */
 	if (status == VMW_BALLOON_ERROR_RESET)
-		b->reset_required = true;
+		WRITE_ONCE(b->reset_required, true);
 
 	return status;
 }
@@ -965,7 +965,7 @@ static int64_t vmballoon_change(struct vmballoon *b)
 	 * Otherwise we might get huge positives instead of negatives
 	 */
 
-	if (b->reset_required)
+	if (READ_ONCE(b->reset_required))
 		return 0;
 
 	/* consider a 2MB slack on deflate, unless the balloon is emptied */
@@ -1446,7 +1446,7 @@ static void vmballoon_reset(struct vmballoon *b)
 	}
 
 	vmballoon_stats_gen_inc(b, VMW_BALLOON_STAT_RESET);
-	b->reset_required = false;
+	WRITE_ONCE(b->reset_required, false);
 
 	error = vmballoon_vmci_init(b);
 	if (error)
@@ -1473,7 +1473,7 @@ static void vmballoon_work(struct work_struct *work)
 	struct vmballoon *b = container_of(dwork, struct vmballoon, dwork);
 	int64_t change = 0;
 
-	if (b->reset_required)
+	if (READ_ONCE(b->reset_required))
 		vmballoon_reset(b);
 
 	down_read(&b->conf_sem);
@@ -1666,7 +1666,7 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 		   VMW_BALLOON_CAPABILITIES);
 	seq_printf(f, "%-22s: %#16lx\n", "used capabilities", b->capabilities);
 	seq_printf(f, "%-22s: %16s\n", "is resetting",
-		   b->reset_required ? "y" : "n");
+		   READ_ONCE(b->reset_required) ? "y" : "n");
 
 	/* format size info */
 	seq_printf(f, "%-22s: %16lu\n", "target", READ_ONCE(b->target));
-- 
2.25.1

