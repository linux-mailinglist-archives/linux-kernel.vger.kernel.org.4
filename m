Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E151F7169ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjE3Qlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjE3Qlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:41:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975F6F9;
        Tue, 30 May 2023 09:41:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-76c64da0e46so131049239f.0;
        Tue, 30 May 2023 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685464894; x=1688056894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxSEcH8XMhad+l3757OBmVZiqWVuwlAI7XsQ8Ql9GBg=;
        b=ldetHcwivAH9hVYdV2CfRIcyuc61rIzapE+qyz2t/m97jOZHGzsNiVUd45x7s+8UL8
         rCOeR27eyPrrhK3PUlcz2ZbryZXFfOiCJVD4zj75ckfvNiDWMfM27EE62ZLqEtLzn68P
         +bWRRv2CD2gIlWYjvr0XlDref1iAldl36VKGQlUhi+3pIMRe9eBgxFUbmByqApMisoyn
         eXL1kFbB1xow/c+dymFzgHcGyprrmJd2c6pC3ufh14PJ/hV/08ORmehUXGJaOJZnEP1L
         Saa1AayrCDJF5/ycm39fd+pGF+IeHwzXprxDAZn9EJO2Z5oPgUBgp/mecb891XovaogK
         mnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464894; x=1688056894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxSEcH8XMhad+l3757OBmVZiqWVuwlAI7XsQ8Ql9GBg=;
        b=EFAUmtaBTYngoPqNZd8El4mrxwkWE0dh23IuRi5GsGqGQ+r+jcNDKLoHJwwgu0fOYy
         JQlp3aLEQVwMz0sR4GEIeSpT76rHmvnJeZ0MjpUs0bThTttm5X8DBT17TVDxPM1vICMU
         n1jJSUF6JC412Y6HsyWwZKiqlTk1aD1DhOYHF7wa7gSRYWBhiTn5WcKfg1uIGg3Qnp9S
         Gw5tvzokyxL5Rj/VUh8q2QwZds6sNO6MyCNsDJ4JioN0M8N/FtKLuIz5pMMo/69bBMMB
         gMaQ/kRmqdC0ZuUfzvwdX61wLkUk2IJC2kwLAorHqRpCtYAH9BATt7auluLHi+WqdQtt
         TNwg==
X-Gm-Message-State: AC+VfDxXIidyfKBx7IVOx8Qtwz4uziQhmWtVoux9R+1KQGK5szXoYz8B
        5h7+ghN4xuHBhTVt2ohON90L2Bfhhsh3nw==
X-Google-Smtp-Source: ACHHUZ7h6h6Eq4wXXvU4DGcSXirjIMhqpxh4fzQEe6FxgI8QuLAp8ANtFCztbuHT2NEDst+MhgAR4g==
X-Received: by 2002:a5d:87c2:0:b0:774:7a6d:8753 with SMTP id q2-20020a5d87c2000000b007747a6d8753mr1970436ios.9.1685464894493;
        Tue, 30 May 2023 09:41:34 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id q22-20020a5ea616000000b007767a221ea0sm3255267ioi.11.2023.05.30.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:41:34 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: ufs: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:41:31 +0000
Message-ID: <20230530164131.987213-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/ufs/core/ufs-fault-injection.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-fault-injection.c b/drivers/ufs/core/ufs-fault-injection.c
index 7ac7c4e7ff83..5b1184aac585 100644
--- a/drivers/ufs/core/ufs-fault-injection.c
+++ b/drivers/ufs/core/ufs-fault-injection.c
@@ -54,7 +54,7 @@ static int ufs_fault_set(const char *val, const struct kernel_param *kp)
 	if (!setup_fault_attr(attr, (char *)val))
 		return -EINVAL;
 
-	strlcpy(kp->arg, val, FAULT_INJ_STR_SIZE);
+	strscpy(kp->arg, val, FAULT_INJ_STR_SIZE);
 
 	return 0;
 }

