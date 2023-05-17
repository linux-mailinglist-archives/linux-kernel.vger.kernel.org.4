Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57B8706B33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjEQOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjEQOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:34:20 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674BE7DBB;
        Wed, 17 May 2023 07:34:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76c791e2d8dso63943639f.3;
        Wed, 17 May 2023 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684334057; x=1686926057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xg5+64VwYu4jgIPdssL1KkUeDoxI9Z+GcnNgZYWkm3Q=;
        b=f7UYkofNs9JL4XDKdmmVxJ/FcOm5c66Vjo4sEzVNJyE+QNiDrsJAcOsggp0ry46ks5
         pC0ZEl/aJVWXPMDYYIqTgRkVW0CTWqrQ+m47hPfjJD1sUHnOkYcjJwInI9r2Cas5bwyk
         Aua+3xLxe0y93uSylEtAyy/SQCrXy3pu8EjWDQLqjDH9ZJfndfVuKp+AQ+2x+hmDX3CZ
         UqukqOATp6ip9bYcd7D94O/5mcfgeoZikKSahbzqvqYo9ZVI9AXlQw01Vs9ecDPagjDm
         ObObYN+/r8lDfrV7UZMd/9qWJEzIjlXTqJxInZK04mizR0Mt3KHXnwbWEZtG/Z7iSvnn
         hyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334057; x=1686926057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xg5+64VwYu4jgIPdssL1KkUeDoxI9Z+GcnNgZYWkm3Q=;
        b=eND5pR/aaPVhNVJQBiGajEqF/4FqjyJdZpCTnt6o2mmu8W4KKNMMkweFxqxr7hJyZ7
         BqsayxMrplauZRiBVoHDVsy1N0dI6zTDu19JfRH9r/DV+x7UVOuqg5Qd4sfgLNzkf1q8
         ybrDg7OYkmg8oCoUa3kBf4NEfQP79g7HxXvsvdkLpjjfkyN1emD6WQkljx/fp6sMb/+1
         0aKcSq8LIQQgNmH4hOt/mO0MvFAkFqCne+UGHZqn+uBhipx4SA7zHOmsyBfvWyycLjGq
         0pV++1NwnpNA4Bs6oDQx/v+92cWqBNN5TfpLQqj0oVW4E6NxEvxYvQwG6qljM0FDwKLu
         YZYg==
X-Gm-Message-State: AC+VfDwWH3L2KI7Cna/1Lxspo2sfkuhcCBq5iZV+/u3lx05HZB+0TZvs
        MwW6qTeJSOVFNIqc63YCIBM=
X-Google-Smtp-Source: ACHHUZ6/nzU7Vyvyb5FH1f/FdNchYPWuX2uGRdwnvozU3JU2C4g5sXFhidMNl8Ac9liRJBzkXOCIgg==
X-Received: by 2002:a6b:e910:0:b0:763:5cf8:65eb with SMTP id u16-20020a6be910000000b007635cf865ebmr4854888iof.9.1684334057611;
        Wed, 17 May 2023 07:34:17 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id n16-20020a027150000000b0040fa0f43777sm8491190jaf.161.2023.05.17.07.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:34:17 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] scsi: ibmvscsi: Replace all non-returning strlcpy with strscpy
Date:   Wed, 17 May 2023 14:34:09 +0000
Message-ID: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/scsi/ibmvscsi/ibmvscsi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 63f32f843e75..59599299615d 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -250,7 +250,7 @@ static void gather_partition_info(void)
 
 	ppartition_name = of_get_property(of_root, "ibm,partition-name", NULL);
 	if (ppartition_name)
-		strlcpy(partition_name, ppartition_name,
+		strscpy(partition_name, ppartition_name,
 				sizeof(partition_name));
 	p_number_ptr = of_get_property(of_root, "ibm,partition-no", NULL);
 	if (p_number_ptr)
@@ -1282,12 +1282,12 @@ static void send_mad_capabilities(struct ibmvscsi_host_data *hostdata)
 	if (hostdata->client_migrated)
 		hostdata->caps.flags |= cpu_to_be32(CLIENT_MIGRATED);
 
-	strlcpy(hostdata->caps.name, dev_name(&hostdata->host->shost_gendev),
+	strscpy(hostdata->caps.name, dev_name(&hostdata->host->shost_gendev),
 		sizeof(hostdata->caps.name));
 
 	location = of_get_property(of_node, "ibm,loc-code", NULL);
 	location = location ? location : dev_name(hostdata->dev);
-	strlcpy(hostdata->caps.loc, location, sizeof(hostdata->caps.loc));
+	strscpy(hostdata->caps.loc, location, sizeof(hostdata->caps.loc));
 
 	req->common.type = cpu_to_be32(VIOSRP_CAPABILITIES_TYPE);
 	req->buffer = cpu_to_be64(hostdata->caps_addr);

