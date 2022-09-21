Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF85BFAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiIUJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiIUJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:30:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45619C2E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:29:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w10so4174468pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RVUaRoblqJj6CCB5bT+e7N9S28X8kMEcB+++/nDi7mc=;
        b=gErcK6iWfdyaysIzteVuHISTUDt8fCSa5QAcKNZ9gKmqz8DLuz1oNymToDG1FEAojS
         Cuee7+X0H4D+ZFfgImowTgsWvWow/dAehb90NcZ5phlvynknGvRTNTasPwWlmYA6VM4F
         h4rl2R4fOsXuTP1l8A89HAkB7U+q1by2xYW/K15LsAFTa67BbgBDMeiaOo6UiMjIHDn/
         5ux8WZ0WwRsgfAGnNCLHV8SyXgpiOQ0MSKIcosxe/mgQNtVFrBcxpXXNeVRWd6Vo0Nub
         6mhN5+ufOu6nS18UflHMK/Nsp4DW0lGwN6RiRIDMpTBCHvnU6xSKZt4O7jU8fXUmi5FH
         IAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RVUaRoblqJj6CCB5bT+e7N9S28X8kMEcB+++/nDi7mc=;
        b=UK9/BDVp1lcyiRofbtZsT4qvlSwejGOrnnSWKRvcrlZL68cRoKG0/JYX8bqQ61aj89
         5NI8j0D11OJMQ8XCgEFyiXZegYDlZkJDUl6jC53hLl/op31YlRN0SqrwZZMoeJJnyp7V
         C0wBQvG5d1O87bfD+UVYmwDSh9Q1Q76IjF7NztymBGB+kxtodfYa5FvfX9LsMh4KfBSS
         4681ELAXXrYaiBFdQuTeksJmLs3ioud1amyVpX57lvtOnUlfF9WrM9vR9apodw+MqMMj
         CmNyITtXkr0+RILAyIffs83MOeFDsf23vwfmIXaavKMBzvVML1gE3uIT+vPHPEn5h5xv
         YjEw==
X-Gm-Message-State: ACrzQf3Yvh2bTO2/nJJl7jGQvHlBC6ik2PutBtWI1HuFXq8TC/+WHI1C
        wNcrWRd3SL+jHrHJ81kwXNM=
X-Google-Smtp-Source: AMsMyM6DbuTO7DuFWtytAgfrEMuSbSJuGAmyZOjnjaPkRv+Tgtz0YLAExhMMfFPG1gWOh9bbZzcfdw==
X-Received: by 2002:a17:903:1ce:b0:178:80f1:c4c7 with SMTP id e14-20020a17090301ce00b0017880f1c4c7mr3831630plh.27.1663752589911;
        Wed, 21 Sep 2022 02:29:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a6-20020aa795a6000000b0053abb15b3d9sm1696461pfk.19.2022.09.21.02.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:29:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     richard@nod.at
Cc:     anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        baihaowen@meizu.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] um: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:29:44 +0000
Message-Id: <20220921092944.230413-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/um/os-Linux/umid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 7a1abb829930..288c422bfa96 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -40,7 +40,7 @@ static int __init make_uml_dir(void)
 				__func__);
 			goto err;
 		}
-		strlcpy(dir, home, sizeof(dir));
+		strscpy(dir, home, sizeof(dir));
 		uml_dir++;
 	}
 	strlcat(dir, uml_dir, sizeof(dir));
@@ -243,7 +243,7 @@ int __init set_umid(char *name)
 	if (strlen(name) > UMID_LEN - 1)
 		return -E2BIG;
 
-	strlcpy(umid, name, sizeof(umid));
+	strscpy(umid, name, sizeof(umid));
 
 	return 0;
 }
@@ -262,7 +262,7 @@ static int __init make_umid(void)
 	make_uml_dir();
 
 	if (*umid == '\0') {
-		strlcpy(tmp, uml_dir, sizeof(tmp));
+		strscpy(tmp, uml_dir, sizeof(tmp));
 		strlcat(tmp, "XXXXXX", sizeof(tmp));
 		fd = mkstemp(tmp);
 		if (fd < 0) {
-- 
2.25.1
