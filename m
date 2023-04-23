Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896FD6EC0D2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDWPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275110EC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682264072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6SqLgVIvmYoBeVscKlefF4YVXTcxu2vwftyHT1Y86s4=;
        b=Byc64FphTMTCQFbsyc+fIhCpdXeEtKBj2GrMXcVXwIb6ardbcHYfabp6ifnS/t6BAr9Vx2
        IeEdtxT+//YUK5yssKoXKdR0o8gSruDfLDLWhAYYoWl2u1vCRMmA34mhp4T+Lt0zGJvD/O
        +RPO58Hv9nJCtLKrDwPLiJCmmCDy4mQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Do7uGsaMNFuZP97CVHqkFw-1; Sun, 23 Apr 2023 11:34:31 -0400
X-MC-Unique: Do7uGsaMNFuZP97CVHqkFw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ef6c0a9212so5467151cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682264071; x=1684856071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SqLgVIvmYoBeVscKlefF4YVXTcxu2vwftyHT1Y86s4=;
        b=NntB4LAPKDA/XK2pn3skFbZvlJn2TherUkDxc+p7RHm1dstCflauhOVaxttC66qSMh
         m4IVgWbag1Ogs8L8b34sJhvnDD2VJz04Gmicux8Ml7MpbKjwqdloNDpj1EMVnicLK4BY
         OH29hwbbkSvxExgPf7PY5qg9QKJ3dnq8GE1sg265N4QcWeJmU/ZZDLHmgNe6uqMull5a
         Cr7R4m4bwKZFK6metoyfraWDI2EYlhmVuq+KrCU5xe/RVp/6ANmypy13M2I8PUywtdjz
         GznMoQPuxR+Ud2qJXqauWTU4ibjPOlLzFtaVVBgxHwekrcBrfxpdDISHaB+s08d3v9fC
         7cZA==
X-Gm-Message-State: AAQBX9d+2uOUOwRHClf2bSVg4Sy6FicXWemXEoPApllckfKL8mWezVxE
        qeIAW4G+ReXj3boQcCPkOAX3DSRePIC1PQsg+h2dZ53QZ7KWJSONf8PqRdx1t8Ll34rS2ghTsnD
        7OVICFITfS7ATs7FORmw+R+nP
X-Received: by 2002:a05:622a:353:b0:3ef:3cdf:c29d with SMTP id r19-20020a05622a035300b003ef3cdfc29dmr19870207qtw.52.1682264070985;
        Sun, 23 Apr 2023 08:34:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350a3Nh0lPR6tJZeIU/ILJ6y6gRnF/+mxuC2FZU4C6ru1VswVmKRM5wNg2IwQGrBj2ocevTHgSw==
X-Received: by 2002:a05:622a:353:b0:3ef:3cdf:c29d with SMTP id r19-20020a05622a035300b003ef3cdfc29dmr19870187qtw.52.1682264070767;
        Sun, 23 Apr 2023 08:34:30 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id ey19-20020a05622a4c1300b003ef324c6fa3sm2334416qtb.52.2023.04.23.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 08:34:30 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mark.rutland@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] firmware: smccc: set variables smccc_soc_id_version,revision storage-class-specifier to static
Date:   Sun, 23 Apr 2023 11:34:28 -0400
Message-Id: <20230423153428.3938525-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/firmware/smccc/smccc.c:20:21: warning: symbol
  'smccc_soc_id_version' was not declared. Should it be static?
drivers/firmware/smccc/smccc.c:21:21: warning: symbol
  'smccc_soc_id_revision' was not declared. Should it be static?

These variables are only used in their defining file so should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/firmware/smccc/smccc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index db818f9dcb8e..0cf4c45de417 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,8 +17,8 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
 bool __ro_after_init smccc_trng_available = false;
 u64 __ro_after_init smccc_has_sve_hint = false;
-s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
-s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
+static s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
+static s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
 
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 {
-- 
2.27.0

