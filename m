Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BBA6F4664
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjEBOx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjEBOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA01BDC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683039150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=39H8o/WYNMIxSuDxFFED2TSVcxZKUVm3q5t98mbwd40=;
        b=dQ3RpHHiSWx+3Mcu4QmoRiTrIck5q0c8XOCVFmY9DQ5hkEWBFcnZ537QUsJ19CnnnRuyhV
        hHHL7MxrkyYJNQFk1pHsypyv72CaBAJFfLSBresAJLfvWPq4QeLiRYCz6IGRIYH31G2JqT
        gGO61L9fOq6Op9PWe7/ONCcRma8oSyE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-ufUjEMwROx2f8HxDORpCsA-1; Tue, 02 May 2023 10:52:29 -0400
X-MC-Unique: ufUjEMwROx2f8HxDORpCsA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3ef691d1eebso20685461cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 07:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683039148; x=1685631148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39H8o/WYNMIxSuDxFFED2TSVcxZKUVm3q5t98mbwd40=;
        b=bBnulG2vrEejA4SgP15OKyc/9vBUWcKZgUL959LX9rjfnmqWJApnc3tIHvs8X9PWpb
         NNuY0DWA4Pwa85+3pE91+tCJsQYFDLWnKX9Dpsy/+YSDKs7I7vjsNUjYcXIKz0Vq1HdY
         yLKjhs9/uGyDjmBaDdXQPL56FQe9gvtlAcpGQn2ZFUw0lavGSVUdkkBVjjXZQgL20+4q
         FFDPW6/vQi7Xe8Ma3wDCYCD4tvQaueWBWn5e9zhC2oqJNrHmW1ZJ/sarvwH+GUkeM/Nx
         SyF7EOP3Uzk9+jSCKJQUgcZSYmFbS5VlXpQCIcV3QN76yQxec5oRUIWmdg5qOezy9mIZ
         EjxA==
X-Gm-Message-State: AC+VfDzgAVDJINVKlUYr5hOIfsmtH5Wij7UnEgH0k2/MpVcFxhCY8qzN
        xsUQMXCWx7KlLp4cBEAVk15uGnJYbiDpBlNDPZbQZo1YJJU3sWxepvCuHiGHxoZhW14zv2uGvrb
        cLoZhpnyC9cqoVKhxmYPAJld6
X-Received: by 2002:ac8:5906:0:b0:3f1:2f86:16f5 with SMTP id 6-20020ac85906000000b003f12f8616f5mr26312946qty.36.1683039148554;
        Tue, 02 May 2023 07:52:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zUo84GOf8jEDVJshu2K6baM5lRSX2/svIVFutQz6kP1HvwP8S+DFuxA1CV7aRgNaINLsvRQ==
X-Received: by 2002:ac8:5906:0:b0:3f1:2f86:16f5 with SMTP id 6-20020ac85906000000b003f12f8616f5mr26312928qty.36.1683039148313;
        Tue, 02 May 2023 07:52:28 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id br13-20020a05620a460d00b0074e0abe59a0sm9719593qkb.78.2023.05.02.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:52:27 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] pds_core: add stub macros for pdsc_debufs_* when ! CONFIG_DEBUG_FS
Date:   Tue,  2 May 2023 10:52:20 -0400
Message-Id: <20230502145220.2927464-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DEBUG_FS is not defined there is this representative link error
ld: drivers/net/ethernet/amd/pds_core/main.o: in function `pdsc_remove':
main.c:(.text+0x35c): undefined reference to `pdsc_debugfs_del_dev

Avoid these link errors when CONFIG_DEBUG_FS is not defined by
providing some empty macros.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/amd/pds_core/core.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index e545fafc4819..0b39a6dc65c8 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -261,6 +261,7 @@ int pdsc_dl_enable_validate(struct devlink *dl, u32 id,
 
 void __iomem *pdsc_map_dbpage(struct pdsc *pdsc, int page_num);
 
+#ifdef CONFIG_DEBUG_FS
 void pdsc_debugfs_create(void);
 void pdsc_debugfs_destroy(void);
 void pdsc_debugfs_add_dev(struct pdsc *pdsc);
@@ -270,6 +271,17 @@ void pdsc_debugfs_add_viftype(struct pdsc *pdsc);
 void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
+#else
+#define pdsc_debugfs_create()
+#define pdsc_debugfs_destroy()
+#define pdsc_debugfs_add_dev(pdsc)
+#define pdsc_debugfs_del_dev(pdsc)
+#define pdsc_debugfs_add_ident(pdsc)
+#define pdsc_debugfs_add_viftype(pdsc)
+#define pdsc_debugfs_add_irqs(pdsc)
+#define pdsc_debugfs_add_qcq(pdsc, qcq)
+#define pdsc_debugfs_del_qcq(qcq)
+#endif
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
-- 
2.27.0

