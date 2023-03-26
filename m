Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08646C91DA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 01:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCZAdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 20:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjCZAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 20:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A6BDF9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679790748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vvl/Cszr83QpVo2zLAzWMSGgk3m+9bIrTI3yG08ent8=;
        b=Yof+X1952AFQ5Mr1Vb8u1Bo36boUn4JNixyITWM8TmPaZLCHa3ZU2bYbo1wovj+6/XA/3O
        TAutJ+8WBxZQr1iLuinLh036har6c27/533BCwoZeMpxb7lnv3zFhsiT+UnsRYi6rbl8DQ
        DxwDnbyGvevi0d2JHjlnKD0XObMHuY8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-n31KTZv7PsKjQacXhX6SDQ-1; Sat, 25 Mar 2023 20:32:26 -0400
X-MC-Unique: n31KTZv7PsKjQacXhX6SDQ-1
Received: by mail-qk1-f200.google.com with SMTP id 203-20020a370ad4000000b00746981f8f4bso2345346qkk.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 17:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679790746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vvl/Cszr83QpVo2zLAzWMSGgk3m+9bIrTI3yG08ent8=;
        b=3EyiCJqgXcVn5rZwj+dhiL41va81ICWsJsV0a932yWHZYa/oaxywCfngGKVp+VYShP
         RkJpTr1kgLjk7/r3jHwL9UYLzFzYaRcmXPyF5ji/7mgfwtSImRTL3/hukScN+W3/e5EI
         xdx4M3yXXgxh0j8UsF0PvVmdm4bq4YolsnOQPg9vQGokwUnM4rXFiaq3drEGtuVVY1jc
         rdE1EtGLCeruqdkKEI9o/u4kOMyiyHlryDa5Kz5/sYhb8lwlDsNGNOHOeoJVm5Cxm/h/
         /ehamVo2+U5xCoQLgMSkqtj2V9KuK2jJS330zFVosLYzYDCDQJRds48k8bYwAYK+nn3B
         9+pQ==
X-Gm-Message-State: AO0yUKW95QhNHK66g3L7QccyfQn34zLB9Apm8L+fIGhuUwAVd+/MM4v/
        +bV4KUVnrDZRnJX6aekgMfBfqIKYD8Lf/yoMPgh97IrH+KjwJswkRw99to9DkUUkdgWFdOTDyW5
        GkKHnEzvUOSodMvv1PrJEEYkc
X-Received: by 2002:a05:6214:2aa5:b0:5dd:b12c:7536 with SMTP id js5-20020a0562142aa500b005ddb12c7536mr11178017qvb.15.1679790746265;
        Sat, 25 Mar 2023 17:32:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350b+Pa/uA21H+Zv/sD23H6AYDuKi2PaRBJzNHIHJxF75572oevVIi5sKRN9bea14HCN3kO7fDw==
X-Received: by 2002:a05:6214:2aa5:b0:5dd:b12c:7536 with SMTP id js5-20020a0562142aa500b005ddb12c7536mr11178000qvb.15.1679790745992;
        Sat, 25 Mar 2023 17:32:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g1-20020a37b601000000b00743592b4745sm15389120qkf.109.2023.03.25.17.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 17:32:25 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: scsi_transport_fc: remove unused desc_cnt variable
Date:   Sat, 25 Mar 2023 20:32:22 -0400
Message-Id: <20230326003222.1343671-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/scsi/scsi_transport_fc.c:908:6: error: variable
  'desc_cnt' set but not used [-Werror,-Wunused-but-set-variable]
        u32 desc_cnt = 0, bytes_remain;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/scsi_transport_fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index f12e9467ebb4..64ff2629eaf9 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -905,7 +905,7 @@ fc_host_fpin_rcv(struct Scsi_Host *shost, u32 fpin_len, char *fpin_buf,
 {
 	struct fc_els_fpin *fpin = (struct fc_els_fpin *)fpin_buf;
 	struct fc_tlv_desc *tlv;
-	u32 desc_cnt = 0, bytes_remain;
+	u32 bytes_remain;
 	u32 dtag;
 	enum fc_host_event_code event_code =
 		event_acknowledge ? FCH_EVT_LINK_FPIN_ACK : FCH_EVT_LINK_FPIN;
@@ -932,7 +932,6 @@ fc_host_fpin_rcv(struct Scsi_Host *shost, u32 fpin_len, char *fpin_buf,
 			fc_fpin_congn_stats_update(shost, tlv);
 		}
 
-		desc_cnt++;
 		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
 		tlv = fc_tlv_next_desc(tlv);
 	}
-- 
2.27.0

