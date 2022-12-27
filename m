Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5D656634
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 01:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiL0AKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 19:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiL0AKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:10:35 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FC825F6;
        Mon, 26 Dec 2022 16:10:34 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id r205so11257853oib.9;
        Mon, 26 Dec 2022 16:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m08v6vPEyDDdbiE9IGFPtfPiAZQ8HDk4iklrra/12x8=;
        b=G45XIwj4Il212n7mpbzK72STiB3ip0uqIccsOUkmD0QTCYigka54gS895KbNtSDyZb
         R8Bckg+N2m1CTo0KxsFb7wxDBfFoh+c3d7le+e7Qvt+b85JjNFDGB9Cusu0fIzYju6jh
         CPAqZXyFplo8uA8KFh9fg7aZ9SOe2v0S0LfKqknnCq8DhJCu3KnyQ6cN2Y9XTMNnCdVs
         idKy5UMvIIQA886+mFO8bB1+YlgUON4rFWXUFI3Os7HtAR8V6Vx+cvirL5PzYUgPZ/xg
         it0wAPcQrZdfptEjyYd7u96lS0LJJsDVXjSpIlGI+IMeXPdtCmgdM0Cd6Vc6rpIeubHp
         DBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m08v6vPEyDDdbiE9IGFPtfPiAZQ8HDk4iklrra/12x8=;
        b=HDze14V+ER6RFx8I7IWH4yKE1Su4bzAp1OAHLaChIYjH7cItu1l/0wdw17nBk0BOHk
         0MDRgHx0katOOFOGN/DBrU+ddiHI2x1HQD+Y21Db5EouKqMKDDgmeQnYEAZrVbYvcW/y
         53gC9OYaTCY17YWoeHTWAgM7AhNN0AlX+1DbQvgE34tZe4PLi8TurtZzBTBgJdSqegWf
         KT/Ch4b0aB3CGBGjDvayuF308ekmO6oWAIa1Uvqzq8eqDFOd04uKsG+eBRBdgmPsM5/Z
         8QvEyEZa35tXTA5dmxa7s+5bRQ/1z56Zy9ZWEYsV0+iZreAC+pqNP8NlxoogE9JxbVln
         hVkA==
X-Gm-Message-State: AFqh2ko/1Ger0IPnDTICtR8KRVNzEI1AIck+kxrpJdhXtH72S37kjD5x
        H2QB4OdgCN5oWAIUN/L8EWI=
X-Google-Smtp-Source: AMrXdXtLnHFkjVZ3zRiOuLt6VtehV+wKidFbi4wKby3Ipp5jWpYTGmuHZfNj167cMwzgwLWvXyGyWA==
X-Received: by 2002:aca:1c19:0:b0:355:1de8:de4b with SMTP id c25-20020aca1c19000000b003551de8de4bmr9317317oic.36.1672099833535;
        Mon, 26 Dec 2022 16:10:33 -0800 (PST)
Received: from protoss.cs.ucr.edu (protoss.cs.ucr.edu. [169.235.26.60])
        by smtp.gmail.com with ESMTPSA id q43-20020a056830442b00b006393ea22c1csm5955080otv.16.2022.12.26.16.10.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Dec 2022 16:10:33 -0800 (PST)
From:   Hang Zhang <zh.nvgt@gmail.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hang Zhang <zh.nvgt@gmail.com>
Subject: [PATCH] scsi: dpt_i2o: fix a potential use-after-free in __adpt_reset()
Date:   Mon, 26 Dec 2022 16:10:01 -0800
Message-Id: <20221227001001.51626-1-zh.nvgt@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__adpt_reset() invokes adpt_hba_reset(), which can free "pHba"
on error paths and return an negative error code in those
situations. The problem is that "pHba" is from the global pointer
"cmd->device->host->hostdata[0]", regardless of the possible free
of "pHba", that original global pointer is never nullified and
thus may become a dangling pointer and be dereferenced later,
potentially causing a use-after-free.

Fix the issue by nullifying "cmd->device->host->hostdata[0]" if
adpt_hba_reset() returns a negative error code to __adpt_reset(),
which indicates the free of "pHba". Also add a NULL check before
any dereference of "pHba", or the aliased global pointer. Note
that the similar NULL check already exists at other places, like
in adpt_queue_lck().

Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
---
 drivers/scsi/dpt_i2o.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 2e9155ba7408..9827517a1898 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -753,6 +753,9 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
 	char name[32];
 
 	pHba = (adpt_hba*)cmd->device->host->hostdata[0];
+	if (!pHba) {
+		return FAILED;
+	}
 	strncpy(name, pHba->name, sizeof(name));
 	printk(KERN_WARNING"%s: Hba Reset: scsi id %d: tid: %d\n", name, cmd->device->channel, pHba->channel[cmd->device->channel].tid);
 	rcode =  adpt_hba_reset(pHba);
@@ -760,6 +763,7 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
 		printk(KERN_WARNING"%s: HBA reset complete\n", name);
 		return SUCCESS;
 	} else {
+		cmd->device->host->hostdata[0] = NULL;
 		printk(KERN_WARNING"%s: HBA reset failed (%x)\n", name, rcode);
 		return FAILED;
 	}
-- 
2.39.0

