Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DDC6B873F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCNAw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCNAwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6CF2CFD1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678755125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wU6C1kTdlo/msCLzsd7D9dBPtH6geyYmQsAT7wO3k7E=;
        b=Qoj8iTHAJeEDL4GB5g5fjdGGYeVKAi+tRnLLjykFRfdPIb+idnrSIyxIQxMirza1azRW+I
        J3IhMpof3TGMTnxf5widCuAXhmOLRzWLg6gJr5Z/AKi4XZrYlM2Gn4oUCDEGdN1zc24eLu
        uKivnuInDCHH28F306Dk2Msuqx/36X0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-tLezDPD2N62R4YFVX_MWEg-1; Mon, 13 Mar 2023 20:52:04 -0400
X-MC-Unique: tLezDPD2N62R4YFVX_MWEg-1
Received: by mail-qk1-f200.google.com with SMTP id o9-20020a05620a228900b0074585d47b77so2333639qkh.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678755123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU6C1kTdlo/msCLzsd7D9dBPtH6geyYmQsAT7wO3k7E=;
        b=Z9irVuYMdNxrxxbS2+Vm9nHpOAtOBJObrwIQrpRJGDWT0sSKUM+lY0mVkxLJdFdFbY
         8flmokJ+9jDD6HiCaDTVubyRlfDrce9SuhE/mcEH8kx9PQ6UJ2i0s/QShYS6FkWIZnef
         4o6NdKcLcTnPuuZ4CoSeJhsXfzU7wEo1Ei7zQDANEx7GSFN4DXL+Agx1kFSPhK/k9QY0
         SABctkAmOO80QioL0hTdpu0xAYrbTLuE3nd6KW30hQKTtyS6Tzk1ZHniAq/82K3/BCt9
         l44SimDKfJsKX6qwFESE20JkFewC5MuHnoXaHa2EkOugrKwZmebNUq76gIteo2Tnw2g4
         51vw==
X-Gm-Message-State: AO0yUKWBJdJ1xS7esoJG6LEC5oqgSrPJobGNIvlsiTBvr/2XB7vWmsvj
        D9f2TAlNjHq06stYaRBJBhNDTqyK52blwe/4Mhb7CbtA2IuD5Nd+I5AzSnt2nDKvshhjFbp14eK
        2xljbL7VKffD3+J2mjAHXDsDWT/e8iRjm
X-Received: by 2002:a05:622a:1c6:b0:3bf:d9d2:2d2c with SMTP id t6-20020a05622a01c600b003bfd9d22d2cmr29417192qtw.53.1678755123449;
        Mon, 13 Mar 2023 17:52:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set/ozd7azivE/r/qnhMQCbLcegLfllz4fDRiotnm8AMyDXscbNGUliFwubGahh0fisCqegbzDg==
X-Received: by 2002:a05:622a:1c6:b0:3bf:d9d2:2d2c with SMTP id t6-20020a05622a01c600b003bfd9d22d2cmr29417169qtw.53.1678755123231;
        Mon, 13 Mar 2023 17:52:03 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id do54-20020a05620a2b3600b0073b929d0371sm780531qkb.4.2023.03.13.17.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 17:52:02 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: be2iscsi: set some be_main.c variables storage-class-specifier to static
Date:   Mon, 13 Mar 2023 20:51:57 -0400
Message-Id: <20230314005157.536918-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports several warnings
drivers/scsi/be2iscsi/be_main.c:148:1: warning:
  symbol 'dev_attr_beiscsi_log_enable' was not declared. Should it be static?
drivers/scsi/be2iscsi/be_main.c:158:1: warning:
  symbol 'dev_attr_beiscsi_drvr_ver' was not declared. Should it be static?
drivers/scsi/be2iscsi/be_main.c:159:1: warning:
  symbol 'dev_attr_beiscsi_adapter_family' was not declared. Should it be static?
drivers/scsi/be2iscsi/be_main.c:160:1: warning:
  symbol 'dev_attr_beiscsi_fw_ver' was not declared. Should it be static?
drivers/scsi/be2iscsi/be_main.c:161:1: warning:
  symbol 'dev_attr_beiscsi_phys_port' was not declared. Should it be static?
drivers/scsi/be2iscsi/be_main.c:162:1: warning:
  symbol 'dev_attr_beiscsi_active_session_count' was not declared. Should it be static?
drivers/scsi/be2iscsi/be_main.c:164:1: warning:
  symbol 'dev_attr_beiscsi_free_session_count' was not declared. Should it be static ?

These variables are only used in be_main.c, so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/be2iscsi/be_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 50a577ac3bb4..e3a07084c7e7 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -139,7 +139,7 @@ beiscsi_disp_param(_name)\
 beiscsi_change_param(_name, _minval, _maxval, _defval)\
 beiscsi_store_param(_name)\
 beiscsi_init_param(_name, _minval, _maxval, _defval)\
-DEVICE_ATTR(beiscsi_##_name, S_IRUGO | S_IWUSR,\
+static DEVICE_ATTR(beiscsi_##_name, S_IRUGO | S_IWUSR,\
 	      beiscsi_##_name##_disp, beiscsi_##_name##_store)
 
 /*
@@ -155,14 +155,14 @@ BEISCSI_RW_ATTR(log_enable, 0x00,
 		"\t\t\t\tConfiguration Path	: 0x20\n"
 		"\t\t\t\tiSCSI Protocol		: 0x40\n");
 
-DEVICE_ATTR(beiscsi_drvr_ver, S_IRUGO, beiscsi_drvr_ver_disp, NULL);
-DEVICE_ATTR(beiscsi_adapter_family, S_IRUGO, beiscsi_adap_family_disp, NULL);
-DEVICE_ATTR(beiscsi_fw_ver, S_IRUGO, beiscsi_fw_ver_disp, NULL);
-DEVICE_ATTR(beiscsi_phys_port, S_IRUGO, beiscsi_phys_port_disp, NULL);
-DEVICE_ATTR(beiscsi_active_session_count, S_IRUGO,
-	     beiscsi_active_session_disp, NULL);
-DEVICE_ATTR(beiscsi_free_session_count, S_IRUGO,
-	     beiscsi_free_session_disp, NULL);
+static DEVICE_ATTR(beiscsi_drvr_ver, S_IRUGO, beiscsi_drvr_ver_disp, NULL);
+static DEVICE_ATTR(beiscsi_adapter_family, S_IRUGO, beiscsi_adap_family_disp, NULL);
+static DEVICE_ATTR(beiscsi_fw_ver, S_IRUGO, beiscsi_fw_ver_disp, NULL);
+static DEVICE_ATTR(beiscsi_phys_port, S_IRUGO, beiscsi_phys_port_disp, NULL);
+static DEVICE_ATTR(beiscsi_active_session_count, S_IRUGO,
+		   beiscsi_active_session_disp, NULL);
+static DEVICE_ATTR(beiscsi_free_session_count, S_IRUGO,
+		   beiscsi_free_session_disp, NULL);
 
 static struct attribute *beiscsi_attrs[] = {
 	&dev_attr_beiscsi_log_enable.attr,
-- 
2.27.0

