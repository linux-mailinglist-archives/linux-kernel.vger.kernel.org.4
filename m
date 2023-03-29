Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6F6CDABB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjC2N0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjC2N0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8653525C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680096291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rtS7QVAtuYQjDEY7nXHnoqbfop6chvBfZPGcSLcnwDU=;
        b=R7G5+qa2bAPZzw5b+Fb/3gBgSFVZQ1nWAdHUXQR9Di0sjpvOTL9HLnhyMRLogWQmCC6HKN
        j9FJSey9TgocpvbXH2ty11PbEofqDlQEjsSCe9lM85MBoDsX3XjV7o+g7e4Ko76s3JILFD
        TCFlgU+la7kMRjIKhaz/DmASQ7s8P1k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-96dUWv1mP6ekk0qSnN520A-1; Wed, 29 Mar 2023 09:24:50 -0400
X-MC-Unique: 96dUWv1mP6ekk0qSnN520A-1
Received: by mail-qt1-f197.google.com with SMTP id l13-20020a05622a174d00b003e4df699997so8064164qtk.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680096290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtS7QVAtuYQjDEY7nXHnoqbfop6chvBfZPGcSLcnwDU=;
        b=PUyQewZvwPUgj7iwLfEBnqxnL++uQnNTmnPWhCtoKDE1XWMpSSWVrw79C6/gxChlEo
         lbd8swjY1/HIiqEImPuwO0L7soSkeIuvA7Oikz2DpUq1Iblg1bV1edKZRo2xVnIb7tqT
         De0DnQFYnt1k2ohrbpGKE9yvSFIjES3KOZBAMJxOi3ShDmdJS+8t0XQLlqC8SY1s3aQX
         hy0gytzGsq6Gfax+/tLDPBdXXt2mklkNlmNiWDv9QuQysrmULJQ1YB9MYHtU40VmVpq1
         PcQUcO+5+PZQAl1nq5W04AaT5Mb8+VDjztY4Ai0bLUkBLHO6nR/Jv2/WEhzSSZ4Sey3s
         PXnA==
X-Gm-Message-State: AO0yUKVvarw/usvxfKEvAMfmUkT0gnl00lGlN2U3dIb0jdbW1ChmvUhz
        FEsonNka3Xp+/bwUxzvS8iXWFvUGS92AWEx81/tKgm41jdiVbMGefn15QV6kvwerxFE0UT5SYXl
        47yk3wvFuQnCOgpJ0NkVP5j8Y
X-Received: by 2002:a05:622a:1903:b0:3e3:982b:f535 with SMTP id w3-20020a05622a190300b003e3982bf535mr35038322qtc.33.1680096290100;
        Wed, 29 Mar 2023 06:24:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set/pxHT+zYmnDLN7+oI3EGOeAUDzDtVHPAhTMokbOjOy3WQMS3mqH9rtro9CtstXRdGMpp050g==
X-Received: by 2002:a05:622a:1903:b0:3e3:982b:f535 with SMTP id w3-20020a05622a190300b003e3982bf535mr35038289qtc.33.1680096289729;
        Wed, 29 Mar 2023 06:24:49 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l6-20020ac848c6000000b003bfb0ea8094sm9803279qtr.83.2023.03.29.06.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:24:49 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: target: core: remove unused prod_len variable
Date:   Wed, 29 Mar 2023 09:24:21 -0400
Message-Id: <20230329132421.1809362-1-trix@redhat.com>
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
drivers/target/target_core_spc.c:229:6: error: variable
  'prod_len' set but not used [-Werror,-Wunused-but-set-variable]
        u32 prod_len;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/target/target_core_spc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index 5bae45c3fb65..89c0d56294cc 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -226,7 +226,6 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned char *buf)
 	struct t10_alua_lu_gp_member *lu_gp_mem;
 	struct t10_alua_tg_pt_gp *tg_pt_gp;
 	unsigned char *prod = &dev->t10_wwn.model[0];
-	u32 prod_len;
 	u32 off = 0;
 	u16 len = 0, id_len;
 
@@ -267,10 +266,6 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned char *buf)
 	 * T10 Vendor Identifier Page, see spc4r17 section 7.7.3.4
 	 */
 	id_len = 8; /* For Vendor field */
-	prod_len = 4; /* For VPD Header */
-	prod_len += 8; /* For Vendor field */
-	prod_len += strlen(prod);
-	prod_len++; /* For : */
 
 	if (dev->dev_flags & DF_EMULATED_VPD_UNIT_SERIAL)
 		id_len += sprintf(&buf[off+12], "%s:%s", prod,
-- 
2.27.0

