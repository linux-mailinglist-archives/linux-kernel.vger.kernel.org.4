Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469047042F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjEPBfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEPBfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:35:12 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E34689;
        Mon, 15 May 2023 18:35:11 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-76c524a7c8eso655244439f.3;
        Mon, 15 May 2023 18:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684200910; x=1686792910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfMq5VPhXmSgVIl4izCr+h2NNcyoXUmZGZhe3CkCadc=;
        b=DL6SfiVb0N0bpOlD/oss8pVJKW29R5ay300bYLjgtyZBRzjmtK5xM1QtBp3vELmULl
         FD5AzrIwkGe0D0fk+WTWD0V6rVl+2A/TyICEC68K4SGVt2helmDoRnDPq2CwH+mQAjHd
         9Wnac3SOqBHkuQS6H4PNJgX4hNSyqy/uSOa2WRcpQ2Sl1M4xaqQJOJgmQKUNXtublCIh
         fVIH1UFiBxVYnxevU981JGEGY/AvX7HoY7/ZlBzLz3RyCuAuPWRmLEvU+EZnuUbporzf
         LC7uF1R7LoSngZmn1RT2lljm5lDzM9z2hv8d0kLlyY/F1UW5DBWTuPGx7HYTxe0ne0wO
         ocNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200910; x=1686792910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfMq5VPhXmSgVIl4izCr+h2NNcyoXUmZGZhe3CkCadc=;
        b=gqqgRDfYxSXGHmQNjRrdQ9gXWGaZ7G7v6pJl046GS+ZqT+S/RbrlSH9OHhw9KGlmL6
         zYV4X2O/qkMW5li4ulLgNkULjWKz9sxJL3pTeolibpIjzzDxOFrRQxLVwrgNQ0YbkdwY
         7wPObdgZ1qGmW3jbkVPI9ZJhCGWv6IF8OXxOI8OsdL/H5j/OwuDdhfYIV5ibFn0xk8ZM
         Qb7T+HKGeesBNxvB1hTFcl1MhEF3X7iLoIGDeVycudU/hIjSekCzPasruQWwvEkCQmt6
         xhSFVdpcv8whUJMl7DjzrZGQ99ivWCzQon1A4JArhocZpaxBu62q5ZuWQZ56VAEEZpET
         UdPA==
X-Gm-Message-State: AC+VfDzKqQgJJu4wIUAbu8oB7ZtZCtLW4hQfCrHcjIWvAsE/FExrwwTL
        8uIhUEv4974UM4JKgyINQho=
X-Google-Smtp-Source: ACHHUZ4jocbo3PPrgaTFG406oGnLtE74uCIgWlP2ps4o2hQyHzgMF8ItqbvKi1sQv6YhezP7PklAvQ==
X-Received: by 2002:a5d:9759:0:b0:76c:5641:130 with SMTP id c25-20020a5d9759000000b0076c56410130mr1080260ioo.0.1684200910324;
        Mon, 15 May 2023 18:35:10 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id b23-20020a5d8057000000b00763da065395sm7304596ior.3.2023.05.15.18.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 18:35:09 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     azeems@google.com, Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: bfa: Replace all non-returning strlcpy with strscpy
Date:   Tue, 16 May 2023 01:33:45 +0000
Message-ID: <20230516013345.723623-1-azeemshaikh38@gmail.com>
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
 drivers/scsi/bfa/bfa_fcbuild.c   |    4 ++--
 drivers/scsi/bfa/bfa_fcs.c       |    4 ++--
 drivers/scsi/bfa/bfa_fcs_lport.c |   20 ++++++++++----------
 drivers/scsi/bfa/bfa_ioc.c       |    2 +-
 drivers/scsi/bfa/bfa_svc.c       |    2 +-
 drivers/scsi/bfa/bfad.c          |   10 +++++-----
 drivers/scsi/bfa/bfad_attr.c     |    2 +-
 drivers/scsi/bfa/bfad_bsg.c      |    4 ++--
 drivers/scsi/bfa/bfad_im.c       |    2 +-
 9 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcbuild.c b/drivers/scsi/bfa/bfa_fcbuild.c
index df18d9d2af53..773c84af784c 100644
--- a/drivers/scsi/bfa/bfa_fcbuild.c
+++ b/drivers/scsi/bfa/bfa_fcbuild.c
@@ -1134,7 +1134,7 @@ fc_rspnid_build(struct fchs_s *fchs, void *pyld, u32 s_id, u16 ox_id,
 	memset(rspnid, 0, sizeof(struct fcgs_rspnid_req_s));
 
 	rspnid->dap = s_id;
-	strlcpy(rspnid->spn, name, sizeof(rspnid->spn));
+	strscpy(rspnid->spn, name, sizeof(rspnid->spn));
 	rspnid->spn_len = (u8) strlen(rspnid->spn);
 
 	return sizeof(struct fcgs_rspnid_req_s) + sizeof(struct ct_hdr_s);
@@ -1155,7 +1155,7 @@ fc_rsnn_nn_build(struct fchs_s *fchs, void *pyld, u32 s_id,
 	memset(rsnn_nn, 0, sizeof(struct fcgs_rsnn_nn_req_s));
 
 	rsnn_nn->node_name = node_name;
-	strlcpy(rsnn_nn->snn, name, sizeof(rsnn_nn->snn));
+	strscpy(rsnn_nn->snn, name, sizeof(rsnn_nn->snn));
 	rsnn_nn->snn_len = (u8) strlen(rsnn_nn->snn);
 
 	return sizeof(struct fcgs_rsnn_nn_req_s) + sizeof(struct ct_hdr_s);
diff --git a/drivers/scsi/bfa/bfa_fcs.c b/drivers/scsi/bfa/bfa_fcs.c
index d2d396ca0e9a..5023c0ab4277 100644
--- a/drivers/scsi/bfa/bfa_fcs.c
+++ b/drivers/scsi/bfa/bfa_fcs.c
@@ -761,7 +761,7 @@ bfa_fcs_fabric_psymb_init(struct bfa_fcs_fabric_s *fabric)
 	bfa_ioc_get_adapter_model(&fabric->fcs->bfa->ioc, model);
 
 	/* Model name/number */
-	strlcpy(port_cfg->sym_name.symname, model,
+	strscpy(port_cfg->sym_name.symname, model,
 		BFA_SYMNAME_MAXLEN);
 	strlcat(port_cfg->sym_name.symname, BFA_FCS_PORT_SYMBNAME_SEPARATOR,
 		BFA_SYMNAME_MAXLEN);
@@ -822,7 +822,7 @@ bfa_fcs_fabric_nsymb_init(struct bfa_fcs_fabric_s *fabric)
 	bfa_ioc_get_adapter_model(&fabric->fcs->bfa->ioc, model);
 
 	/* Model name/number */
-	strlcpy(port_cfg->node_sym_name.symname, model,
+	strscpy(port_cfg->node_sym_name.symname, model,
 		BFA_SYMNAME_MAXLEN);
 	strlcat(port_cfg->node_sym_name.symname,
 			BFA_FCS_PORT_SYMBNAME_SEPARATOR,
diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
index b12afcc4b189..008afd817087 100644
--- a/drivers/scsi/bfa/bfa_fcs_lport.c
+++ b/drivers/scsi/bfa/bfa_fcs_lport.c
@@ -2642,10 +2642,10 @@ bfa_fcs_fdmi_get_hbaattr(struct bfa_fcs_lport_fdmi_s *fdmi,
 	bfa_ioc_get_adapter_fw_ver(&port->fcs->bfa->ioc,
 					hba_attr->fw_version);
 
-	strlcpy(hba_attr->driver_version, (char *)driver_info->version,
+	strscpy(hba_attr->driver_version, (char *)driver_info->version,
 		sizeof(hba_attr->driver_version));
 
-	strlcpy(hba_attr->os_name, driver_info->host_os_name,
+	strscpy(hba_attr->os_name, driver_info->host_os_name,
 		sizeof(hba_attr->os_name));
 
 	/*
@@ -2663,13 +2663,13 @@ bfa_fcs_fdmi_get_hbaattr(struct bfa_fcs_lport_fdmi_s *fdmi,
 	bfa_fcs_fdmi_get_portattr(fdmi, &fcs_port_attr);
 	hba_attr->max_ct_pyld = fcs_port_attr.max_frm_size;
 
-	strlcpy(hba_attr->node_sym_name.symname,
+	strscpy(hba_attr->node_sym_name.symname,
 		port->port_cfg.node_sym_name.symname, BFA_SYMNAME_MAXLEN);
 	strcpy(hba_attr->vendor_info, "QLogic");
 	hba_attr->num_ports =
 		cpu_to_be32(bfa_ioc_get_nports(&port->fcs->bfa->ioc));
 	hba_attr->fabric_name = port->fabric->lps->pr_nwwn;
-	strlcpy(hba_attr->bios_ver, hba_attr->option_rom_ver, BFA_VERSION_LEN);
+	strscpy(hba_attr->bios_ver, hba_attr->option_rom_ver, BFA_VERSION_LEN);
 
 }
 
@@ -2736,19 +2736,19 @@ bfa_fcs_fdmi_get_portattr(struct bfa_fcs_lport_fdmi_s *fdmi,
 	/*
 	 * OS device Name
 	 */
-	strlcpy(port_attr->os_device_name, driver_info->os_device_name,
+	strscpy(port_attr->os_device_name, driver_info->os_device_name,
 		sizeof(port_attr->os_device_name));
 
 	/*
 	 * Host name
 	 */
-	strlcpy(port_attr->host_name, driver_info->host_machine_name,
+	strscpy(port_attr->host_name, driver_info->host_machine_name,
 		sizeof(port_attr->host_name));
 
 	port_attr->node_name = bfa_fcs_lport_get_nwwn(port);
 	port_attr->port_name = bfa_fcs_lport_get_pwwn(port);
 
-	strlcpy(port_attr->port_sym_name.symname,
+	strscpy(port_attr->port_sym_name.symname,
 		bfa_fcs_lport_get_psym_name(port).symname, BFA_SYMNAME_MAXLEN);
 	bfa_fcs_lport_get_attr(port, &lport_attr);
 	port_attr->port_type = cpu_to_be32(lport_attr.port_type);
@@ -3229,7 +3229,7 @@ bfa_fcs_lport_ms_gmal_response(void *fcsarg, struct bfa_fcxp_s *fcxp,
 					rsp_str[gmal_entry->len-1] = 0;
 
 				/* copy IP Address to fabric */
-				strlcpy(bfa_fcs_lport_get_fabric_ipaddr(port),
+				strscpy(bfa_fcs_lport_get_fabric_ipaddr(port),
 					gmal_entry->ip_addr,
 					BFA_FCS_FABRIC_IPADDR_SZ);
 				break;
@@ -4667,7 +4667,7 @@ bfa_fcs_lport_ns_send_rspn_id(void *ns_cbarg, struct bfa_fcxp_s *fcxp_alloced)
 		 * to that of the base port.
 		 */
 
-		strlcpy(symbl,
+		strscpy(symbl,
 			(char *)&(bfa_fcs_lport_get_psym_name
 			 (bfa_fcs_get_base_port(port->fcs))),
 			sizeof(symbl));
@@ -5194,7 +5194,7 @@ bfa_fcs_lport_ns_util_send_rspn_id(void *cbarg, struct bfa_fcxp_s *fcxp_alloced)
 		 * For Vports, we append the vport's port symbolic name
 		 * to that of the base port.
 		 */
-		strlcpy(symbl, (char *)&(bfa_fcs_lport_get_psym_name
+		strscpy(symbl, (char *)&(bfa_fcs_lport_get_psym_name
 			(bfa_fcs_get_base_port(port->fcs))),
 			sizeof(symbl));
 
diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 5740302d83ac..e1ed1424fddb 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -2788,7 +2788,7 @@ void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc_s *ioc, char *manufacturer)
 {
 	memset((void *)manufacturer, 0, BFA_ADAPTER_MFG_NAME_LEN);
-	strlcpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strscpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
 }
 
 void
diff --git a/drivers/scsi/bfa/bfa_svc.c b/drivers/scsi/bfa/bfa_svc.c
index 4e3cef02f10f..c9745c0b4eee 100644
--- a/drivers/scsi/bfa/bfa_svc.c
+++ b/drivers/scsi/bfa/bfa_svc.c
@@ -330,7 +330,7 @@ bfa_plog_str(struct bfa_plog_s *plog, enum bfa_plog_mid mid,
 		lp.eid = event;
 		lp.log_type = BFA_PL_LOG_TYPE_STRING;
 		lp.misc = misc;
-		strlcpy(lp.log_entry.string_log, log_str,
+		strscpy(lp.log_entry.string_log, log_str,
 			BFA_PL_STRING_LOG_SZ);
 		lp.log_entry.string_log[BFA_PL_STRING_LOG_SZ - 1] = '\0';
 		bfa_plog_add(plog, &lp);
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index 529b73a83d69..62cb7a864fd5 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -965,19 +965,19 @@ bfad_start_ops(struct bfad_s *bfad) {
 
 	/* Fill the driver_info info to fcs*/
 	memset(&driver_info, 0, sizeof(driver_info));
-	strlcpy(driver_info.version, BFAD_DRIVER_VERSION,
+	strscpy(driver_info.version, BFAD_DRIVER_VERSION,
 		sizeof(driver_info.version));
 	if (host_name)
-		strlcpy(driver_info.host_machine_name, host_name,
+		strscpy(driver_info.host_machine_name, host_name,
 			sizeof(driver_info.host_machine_name));
 	if (os_name)
-		strlcpy(driver_info.host_os_name, os_name,
+		strscpy(driver_info.host_os_name, os_name,
 			sizeof(driver_info.host_os_name));
 	if (os_patch)
-		strlcpy(driver_info.host_os_patch, os_patch,
+		strscpy(driver_info.host_os_patch, os_patch,
 			sizeof(driver_info.host_os_patch));
 
-	strlcpy(driver_info.os_device_name, bfad->pci_name,
+	strscpy(driver_info.os_device_name, bfad->pci_name,
 		sizeof(driver_info.os_device_name));
 
 	/* FCS driver info init */
diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
index 5a85401e9e2d..e96e4b6df265 100644
--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -834,7 +834,7 @@ bfad_im_symbolic_name_show(struct device *dev, struct device_attribute *attr,
 	char symname[BFA_SYMNAME_MAXLEN];
 
 	bfa_fcs_lport_get_attr(&bfad->bfa_fcs.fabric.bport, &port_attr);
-	strlcpy(symname, port_attr.port_cfg.sym_name.symname,
+	strscpy(symname, port_attr.port_cfg.sym_name.symname,
 			BFA_SYMNAME_MAXLEN);
 	return sysfs_emit(buf, "%s\n", symname);
 }
diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index 79d4f7ee5bcb..520f9152f3bf 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -119,7 +119,7 @@ bfad_iocmd_ioc_get_attr(struct bfad_s *bfad, void *cmd)
 
 	/* fill in driver attr info */
 	strcpy(iocmd->ioc_attr.driver_attr.driver, BFAD_DRIVER_NAME);
-	strlcpy(iocmd->ioc_attr.driver_attr.driver_ver,
+	strscpy(iocmd->ioc_attr.driver_attr.driver_ver,
 		BFAD_DRIVER_VERSION, BFA_VERSION_LEN);
 	strcpy(iocmd->ioc_attr.driver_attr.fw_ver,
 		iocmd->ioc_attr.adapter_attr.fw_ver);
@@ -307,7 +307,7 @@ bfad_iocmd_port_get_attr(struct bfad_s *bfad, void *cmd)
 	iocmd->attr.port_type = port_attr.port_type;
 	iocmd->attr.loopback = port_attr.loopback;
 	iocmd->attr.authfail = port_attr.authfail;
-	strlcpy(iocmd->attr.port_symname.symname,
+	strscpy(iocmd->attr.port_symname.symname,
 		port_attr.port_cfg.sym_name.symname,
 		sizeof(iocmd->attr.port_symname.symname));
 
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index c335f7a188d2..a9d3d8562d3c 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -1046,7 +1046,7 @@ bfad_fc_host_init(struct bfad_im_port_s *im_port)
 	/* For fibre channel services type 0x20 */
 	fc_host_supported_fc4s(host)[7] = 1;
 
-	strlcpy(symname, bfad->bfa_fcs.fabric.bport.port_cfg.sym_name.symname,
+	strscpy(symname, bfad->bfa_fcs.fabric.bport.port_cfg.sym_name.symname,
 		BFA_SYMNAME_MAXLEN);
 	sprintf(fc_host_symbolic_name(host), "%s", symname);
 

