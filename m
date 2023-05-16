Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82527043A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEPCyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEPCyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:54:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1CD4EC2;
        Mon, 15 May 2023 19:53:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-76c4e1fe1d7so232651539f.3;
        Mon, 15 May 2023 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684205639; x=1686797639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFByrw5eK0isgrvCD9DVFcZpgpzm03TFArtZkAeD2ws=;
        b=Bp7GzSHXNEJ8kfX0U5h45Gedo11Mnj2MITlGSQTDimBPdTjA6GoL/j/9GCT/qnDM9Y
         8U8ry7ZW/yk+/IrUV9HdcavH3ZBKT53efSwK/xdtz2c1Oy/BhSkjaTLDkprRbBB2xvej
         rmzt7C5VpdqtpmftUctxyHNGUAXSwuxU2ThhXe9dIhG9QdFKZXHnPnm6WwOiCAJce1Ah
         P2pUCu+JpDLlmW+cTNrR9SKsR1KG4cRj9AifTLlA89i5A3y6B9daYkXy5K93+XOgkgm5
         aMlkTYM99otUB8rO9CftNoGv1cD5VGBR7ztV5CQEql3RQZJdcJHR+WSQqMqSjB+t/WB9
         HMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684205639; x=1686797639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFByrw5eK0isgrvCD9DVFcZpgpzm03TFArtZkAeD2ws=;
        b=jJ8plTrh6r6MZDrGNjBTfsm0FvI3NXicSonE4DymBELqyiVGhdUZke6x3Ab8qQ245i
         aVcMoodQ8/k61kSfevdKP50hOS2TNDdabkgzAzoZRPg+4LzLFGoUie8Z99eGjlq1vIBt
         M967Rbj9IpN0wlzFGYOYiyfht6Zi64BrjBZosEgL/5fyRRx9/6Ol5vz0YDb2U1B3MotL
         2L1n4r+Wn8W5r7xH+oeJHALebTdbdzU3XPilGp0FIQo4jz5IjZXbLJl+Dx3pHXJB6gAy
         kdyM6y91+0StimN7DkBVtvakmwMttKKrczYX48dYZ4P6mele3dCw5Kk64z305sX1+nI+
         /Dag==
X-Gm-Message-State: AC+VfDyXMHBOWye4aLFzqAzSaFU1rwoCVbBpTSWCPc7oZgKE12HK8Cnb
        JuMOtrSQNXhn/ylp/zO/99F18B0UXKxeow==
X-Google-Smtp-Source: ACHHUZ6BddaBD2jpqDQpipGoNP18GOfYr8ixEIl9lAJxZyMnKRRFf6+4NwprQTJ/2nswn8cmNBADuw==
X-Received: by 2002:a5d:870f:0:b0:76c:73f6:b3cf with SMTP id u15-20020a5d870f000000b0076c73f6b3cfmr1092645iom.10.1684205639168;
        Mon, 15 May 2023 19:53:59 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id a2-20020a6b6602000000b0076c750dc780sm3856979ioc.29.2023.05.15.19.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 19:53:58 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: qla4xxx: Replace all non-returning strlcpy with strscpy
Date:   Tue, 16 May 2023 02:53:55 +0000
Message-ID: <20230516025355.2835898-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
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
 drivers/scsi/qla4xxx/ql4_mbx.c |    8 ++++----
 drivers/scsi/qla4xxx/ql4_os.c  |   14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index cd71074f3abe..249f1d7021d4 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -1611,8 +1611,8 @@ int qla4xxx_get_chap(struct scsi_qla_host *ha, char *username, char *password,
 		goto exit_get_chap;
 	}
 
-	strlcpy(password, chap_table->secret, QL4_CHAP_MAX_SECRET_LEN);
-	strlcpy(username, chap_table->name, QL4_CHAP_MAX_NAME_LEN);
+	strscpy(password, chap_table->secret, QL4_CHAP_MAX_SECRET_LEN);
+	strscpy(username, chap_table->name, QL4_CHAP_MAX_NAME_LEN);
 	chap_table->cookie = cpu_to_le16(CHAP_VALID_COOKIE);
 
 exit_get_chap:
@@ -1732,8 +1732,8 @@ int qla4xxx_get_uni_chap_at_index(struct scsi_qla_host *ha, char *username,
 		goto exit_unlock_uni_chap;
 	}
 
-	strlcpy(password, chap_table->secret, MAX_CHAP_SECRET_LEN);
-	strlcpy(username, chap_table->name, MAX_CHAP_NAME_LEN);
+	strscpy(password, chap_table->secret, MAX_CHAP_SECRET_LEN);
+	strscpy(username, chap_table->name, MAX_CHAP_NAME_LEN);
 
 	rval = QLA_SUCCESS;
 
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index ee6d784c095c..b2a3988e1e15 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -798,9 +798,9 @@ static int qla4xxx_get_chap_list(struct Scsi_Host *shost, uint16_t chap_tbl_idx,
 			continue;
 
 		chap_rec->chap_tbl_idx = i;
-		strlcpy(chap_rec->username, chap_table->name,
+		strscpy(chap_rec->username, chap_table->name,
 			ISCSI_CHAP_AUTH_NAME_MAX_LEN);
-		strlcpy(chap_rec->password, chap_table->secret,
+		strscpy(chap_rec->password, chap_table->secret,
 			QL4_CHAP_MAX_SECRET_LEN);
 		chap_rec->password_length = chap_table->secret_len;
 
@@ -6052,8 +6052,8 @@ static int qla4xxx_get_bidi_chap(struct scsi_qla_host *ha, char *username,
 		if (!(chap_table->flags & BIT_6)) /* Not BIDI */
 			continue;
 
-		strlcpy(password, chap_table->secret, QL4_CHAP_MAX_SECRET_LEN);
-		strlcpy(username, chap_table->name, QL4_CHAP_MAX_NAME_LEN);
+		strscpy(password, chap_table->secret, QL4_CHAP_MAX_SECRET_LEN);
+		strscpy(username, chap_table->name, QL4_CHAP_MAX_NAME_LEN);
 		ret = 0;
 		break;
 	}
@@ -6281,8 +6281,8 @@ static void qla4xxx_get_param_ddb(struct ddb_entry *ddb_entry,
 
 	tddb->tpgt = sess->tpgt;
 	tddb->port = conn->persistent_port;
-	strlcpy(tddb->iscsi_name, sess->targetname, ISCSI_NAME_SIZE);
-	strlcpy(tddb->ip_addr, conn->persistent_address, DDB_IPADDR_LEN);
+	strscpy(tddb->iscsi_name, sess->targetname, ISCSI_NAME_SIZE);
+	strscpy(tddb->ip_addr, conn->persistent_address, DDB_IPADDR_LEN);
 }
 
 static void qla4xxx_convert_param_ddb(struct dev_db_entry *fw_ddb_entry,
@@ -7781,7 +7781,7 @@ static int qla4xxx_sysfs_ddb_logout(struct iscsi_bus_flash_session *fnode_sess,
 		goto exit_ddb_logout;
 	}
 
-	strlcpy(flash_tddb->iscsi_name, fnode_sess->targetname,
+	strscpy(flash_tddb->iscsi_name, fnode_sess->targetname,
 		ISCSI_NAME_SIZE);
 
 	if (!strncmp(fnode_sess->portal_type, PORTAL_TYPE_IPV6, 4))

