Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B75B57D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiILKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiILKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:05:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4BA36DFB;
        Mon, 12 Sep 2022 03:05:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so5323902pja.1;
        Mon, 12 Sep 2022 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PsU/slrk28JmyCysqbUZO1ZiE18Wx7mJDBo1ZXvuwys=;
        b=Nq0wbQ8lera+YzcLAvtRX6hpjblCOdD24/jPJmZD1feCm2KR7HHgSTJ6V2fUvHz/8L
         X956PotxxC4KFIRnzPNl7PZpDA1I8NrIyKs6LE8nGzv+Y2iE6o2EvU6pxPKyrQsAx1JW
         bsMTtsZz88zu1IPJi5KhIxHe9P7EL6LdMU7rwij5AW2RDmiZ0Eg7JAmrP+qbSYwyIVOE
         3RmPOkPbjEw3yrVVN25y2Vv2CcS2/pWuzTogZ5edR1RrOpEb17BaopzIpYwC15np9C37
         +HNg4n3ha2U8jMn38lqEz15PY2SJ+SunLXtVlaZ72Pgpa6UzmCoTxGSvVaupqrPxvSp0
         4nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PsU/slrk28JmyCysqbUZO1ZiE18Wx7mJDBo1ZXvuwys=;
        b=Hw64C/zDaxGhiBsS/lAboaiPlmoIe3Aw1JuYyFeBemIezQQ0nOxaDJrhFLT6itqc2W
         mStENfQRJSygK7ZaSE8FuJDBHFYX+YGQMASWncY0IFn+Qmoo84YGPq9M7h0/KGkXd9xG
         Lh56AQrYTbo3y/I6jCbjJejXnZsl2cjRHoml7zgsYE9hEAiavPyzjkFLvufko+CE9dhq
         OTYl8OkH2ysSOniH2IrTxDckw8wmapLJCt/ky5edabZAcY7xThdbdEr5lmR/pVzIZTgY
         uRHBnPxl5crpWsK0fvhvHJjO+dGVoWbEsa61zguWMAiJbMi2W/h3tYpSRASnCqq5PXs/
         CJVQ==
X-Gm-Message-State: ACgBeo3hdp0brxSxUPO1Dm6gxYuaH663Oh7yMJlsiZq+mbvAxOOQGHL0
        L5Z78MJ7/BbY7Oww4nG7rvE=
X-Google-Smtp-Source: AA6agR6kFVteYifY0p1vHTHgGFs4TO4N8UT2u/CsC8FNzSrz8uIXrdshgBKy188+Urgox7X6Aznx6g==
X-Received: by 2002:a17:902:e74c:b0:177:f3be:2812 with SMTP id p12-20020a170902e74c00b00177f3be2812mr19710861plf.123.1662977152249;
        Mon, 12 Sep 2022 03:05:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p3-20020a654903000000b004215af667cdsm5252280pgs.41.2022.09.12.03.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:05:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     casey@schaufler-ca.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] smack: lsm: remove the unneeded result variable
Date:   Mon, 12 Sep 2022 10:05:36 +0000
Message-Id: <20220912100535.18125-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Return the value smk_ptrace_rule_check() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 security/smack/smack_lsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 16e24a6cdc7c..b6306d71c908 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -497,13 +497,11 @@ static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
  */
 static int smack_ptrace_traceme(struct task_struct *ptp)
 {
-       int rc;
        struct smack_known *skp;

        skp = smk_of_task(smack_cred(current_cred()));

-       rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
-       return rc;
+       return smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
 }

 /**
-- 
2.15.2

