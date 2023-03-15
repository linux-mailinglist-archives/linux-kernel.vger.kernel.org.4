Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD036BBAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjCORXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjCORXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:23:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC65132E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:23:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t11so25219432lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678900984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJifvpFXfcZj7CgVIi5zyKFTPeGRYPxTH4ndTXOFv0w=;
        b=X8Z/JyHVqY8egzpwJXfJzm+IE5CaHaoTPUq5eaivaM+N0wgJ1E8lbQ/fcouSQbU/QM
         aEG7SLKLkMM5/GUo+S3iXfhSZ5DWGUIif+oXT8V0nOZWKdVHw8v0m9Gy8//ISinyI104
         4kwc4iM/E5lqioZTl3nePslZCBiD5Vt4fOjVMGmddcnO8ONu6zlIEcrAFwNJMX2IcdnM
         eF3/ZRqtmJV4nbDGmpxH3ba695WPO2vt95NduFBTSs0y3DEYv5eTFwQxEmU/ya6g7ENW
         NiZLNzD+/FXXfmJCkIIItLT1TkYtV5+oiYoAK4L/iBZAhpFUQ8U4InWAWgmXDBxyj8rY
         ASXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJifvpFXfcZj7CgVIi5zyKFTPeGRYPxTH4ndTXOFv0w=;
        b=7WHJ5J9ynOGko8blHD76nXv+inK6H9SYfrU+kXfCA2opa+5R5KQwBu08PzjNMgtyYY
         RC8FMe45zDuL44V10hKR5Y+W+r2oibzpXSxkn3/81iKP4p7pL2Zzbf2tOQtCWHVLRwwu
         FBaaTlQVVClPXogdBtNyqmA2Jx60ZJkSgq++jVoL0dc+tbt36iYuFjjz1GVllTivXovc
         NG2wmqxrbu0kDalk3Ym1D7xEdtPgzFOL8H6jzchBK166RTeMCd2Q7gKkupsILgHAkYpw
         0A2z1xJeS/BSkzvhuubSBO2h6jSCRFxu+wwdkBYIpQ1LORHpGk1+zzLnQZ8K0RkLe+gF
         qTTw==
X-Gm-Message-State: AO0yUKUBZ3sCZM565lTAzIBUt7/6rTHL+4VgyR4/BTRt3NTmsnyRIvYi
        /K88ldsPK7BFg7zjJufWUdQ=
X-Google-Smtp-Source: AK7set+QEQMoMx11T1y2KDhEdMezjlZfz0QqXINeDjGc5qDlXgjxdqXQ69xgU4n/cChYlZe0bPG+qA==
X-Received: by 2002:ac2:44c5:0:b0:4d8:58a7:6d90 with SMTP id d5-20020ac244c5000000b004d858a76d90mr2038085lfm.42.1678900984409;
        Wed, 15 Mar 2023 10:23:04 -0700 (PDT)
Received: from localhost.localdomain ([85.89.126.104])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25104000000b004e802e4e894sm883201lfb.105.2023.03.15.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:23:03 -0700 (PDT)
From:   Ekaterina Orlova <vorobushek.ok@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ekaterina Orlova <vorobushek.ok@gmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] ASN.1: Fix check for strdup() success
Date:   Wed, 15 Mar 2023 20:21:30 +0300
Message-Id: <20230315172130.140-1-vorobushek.ok@gmail.com>
X-Mailer: git-send-email 2.34.1
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

It seems there is a misprint in the check of strdup() return code
that can lead to NULL pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4520c6a49af8 ("X.509: Add simple ASN.1 grammar compiler")
Signed-off-by: Ekaterina Orlova <vorobushek.ok@gmail.com>
---
 scripts/asn1_compiler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index 7b6756a8c15d..4c3f645065a4 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -625,7 +625,7 @@ int main(int argc, char **argv)
 	p = strrchr(argv[1], '/');
 	p = p ? p + 1 : argv[1];
 	grammar_name = strdup(p);
-	if (!p) {
+	if (!grammar_name) {
 		perror(NULL);
 		exit(1);
 	}
-- 
2.34.1

