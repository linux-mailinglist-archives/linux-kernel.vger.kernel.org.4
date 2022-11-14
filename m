Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEBB627D32
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiKNL7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiKNL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:56:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D69C1A3AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:53:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p21so9838545plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hk+Ng6HzdEIcxEdrVoC5xdXSCCrpPQX/sVOx2Fc1RIU=;
        b=XSsHqQQFR8a+jzglZGxrXAFL9CywFjxS/ReTLiwH6YBiTS4TZcDe60UCsGDeSSmFoz
         /WGYg9BAcVn9Ndl0EcjAiPgjot0FOIB/o/4N8SJEjNA1mQddh93SbRNfGxsOQgOozsFD
         E18Ch1DrCYA92fARFXicfyxie5L6+hsQ/F2p6uDe9R1bpEPDBoo6UtVCgZzs3juahDPa
         OkCGZCRdUUQ8rQAypKWsERASJNPyKtM5X9BohXZ2E3XYIHfuzJwmDJCiCHrJE5cNx3Ra
         nE98MaN7VB55HtQBLUSQqEpilE0hKSY5MfbPDIdklhLd8q+c8rkDlP60Qyi/3bQTHIni
         Di9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hk+Ng6HzdEIcxEdrVoC5xdXSCCrpPQX/sVOx2Fc1RIU=;
        b=MU2f5RR9f7fPbKwxW3s0+wFIF1ttjE3HRe2z60p8mCZ1qT+Mlc/zLfi4oU5YwrGBRw
         mdvQ8zhFRQ+mL0tdV6aIYDxHMlhCgvbpAwGZBOiyuCCDjdj6dFOpQoKbkoXOXfhwZNb6
         gb5LDRjrKE75ZL9fV+kTZVhfwmvt9J76V5mjxZTgE83+mc9kO5UXa6LB6fbp8/ZiNJDb
         rp42GbM7NcxJDIrr/Dz+3niXhtA45ri0f5MnNH3f3h9n7EJofIJaDGoimfMLP+dZJSWe
         fAdiFh/10xj+Xn5M6sOTKtZHiFtEVGO9/y+fXJZSt3HKPaT2WT2qekai3sZKjRfHhMBv
         OKNA==
X-Gm-Message-State: ANoB5pn/PBBQC1KXWvIbFm09dVBzyn86BckM1XsZy44osDKI6CaXmh9P
        u6MHPHaJCqi3QeCP8OJOmj4=
X-Google-Smtp-Source: AA0mqf59B2DO9ZPDLarWALVCW0QEKktkW/UTpAJO53Bv+6cCEY7rNVHY9Wxfvns5lFF5/ZGBg8dXtg==
X-Received: by 2002:a17:90a:a391:b0:212:fe4a:c378 with SMTP id x17-20020a17090aa39100b00212fe4ac378mr13592444pjp.82.1668426814474;
        Mon, 14 Nov 2022 03:53:34 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.16])
        by smtp.googlemail.com with ESMTPSA id d4-20020a170902654400b00188a23098aasm7248907pln.69.2022.11.14.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:53:33 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com
Subject: [PATCH v2] fs/ntfs3: Validate attribute data and valid sizes
Date:   Mon, 14 Nov 2022 17:23:14 +0530
Message-Id: <20221114115314.183818-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.37.3
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

The data_size and valid_size fields of non resident attributes should be
less than the its alloc_size field, but this is not checked in
ntfs_read_mft function.

Syzbot reports a allocation order warning due to a large unchecked value
of data_size getting assigned to inode->i_size which is then passed to
kcalloc.

Add sanity check for ensuring that the data_size and valid_size fields
are not larger than alloc_size field.

Link: https://syzkaller.appspot.com/bug?extid=fa4648a5446460b7b963
Reported-and-tested-by: syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---

Please apply this instead of my previous patch.

Changes in v2:
 Correct the format used for the Fixes tag.

 fs/ntfs3/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 970bb7c357c7..763dd982a43a 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -132,6 +132,13 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (le16_to_cpu(attr->name_off) + attr->name_len > asize)
 		goto out;
 
+	if (attr->non_res) {
+		t64 = le64_to_cpu(attr->nres.alloc_size);
+		if (le64_to_cpu(attr->nres.data_size) > t64 ||
+		    le64_to_cpu(attr->nres.valid_size) > t64)
+			goto out;
+	}
+
 	switch (attr->type) {
 	case ATTR_STD:
 		if (attr->non_res ||
-- 
2.37.3

