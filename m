Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD46D0983
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjC3P1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjC3P0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A539E2111
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680189855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PzFkckvDWfLP+fS3N43jVyaoo/K7ZKGXS7ytUztG/V8=;
        b=WG+JKm5NmxilncyIAQkr3hfUnWTfahBzUZHYidreujuONYWBDix+eikpBvDo94P48ewkfZ
        0nk0+HNRB1ku401i3tfZHMBZAJbE2vB2Z3VlGRQSj1ODufgfpJuAaml3dEArO5N/j775gy
        fRjHM+BS6hQvqVIlqzdFKk1ucX9+7+w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-3OLKAg20PtKFMUwYxsKlSQ-1; Thu, 30 Mar 2023 11:21:02 -0400
X-MC-Unique: 3OLKAg20PtKFMUwYxsKlSQ-1
Received: by mail-qv1-f71.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso8376071qvw.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzFkckvDWfLP+fS3N43jVyaoo/K7ZKGXS7ytUztG/V8=;
        b=eqzoRYgzwmHE8JJy1HaThl5SDwE3FsKW09iqlxp5wbZriI3PTJIA6Jwntm+ymu+aHy
         xkglewFHj/JKysviQOgu15ym9E5ulmbeXLhs2QzhxhaQaIQasZwBBd/wxwqi1bT1rdKR
         xVK6d8naOCJs8ueRQE5sFzOL/fB/iuq/v+W5bOhhEH3MtK5uRUJmVnH8lEnmEkoTXnVZ
         4jCR94D8GvFAJuzgYwyOWKL1TZVLREH2exBJ7Ju+GmFzuAhdfu0dPJr88+xkU+eHyJqz
         +d4t3S1MYKI45Aq2djjx7u1mZjOamlshac4P+S8j4WIs+5HW3PtwUaCr70ywbl2eTSv0
         Sphg==
X-Gm-Message-State: AAQBX9cdZthRrZcSpQwJEvAltRa8F5S1c1Sn796TwSYAHlwZUnVDtW8x
        YBG5HI2XBH9frOLH1ExwWITNLEBGFEB9kAwkT0tU5zCwqSw7eq0LPI/SkAciQK8etScih4ieL88
        OxKSwfaLCCFeiHlbhmWda6o4c
X-Received: by 2002:a05:6214:1243:b0:56e:b1c8:381b with SMTP id r3-20020a056214124300b0056eb1c8381bmr43628858qvv.31.1680189662021;
        Thu, 30 Mar 2023 08:21:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350bnlSDboIbJVBw8O6nujKKyr0Y08gCZuIWQYE9jVjpUWoFJ1aWyINmV1swnxyoxwYXTAvU/Jw==
X-Received: by 2002:a05:6214:1243:b0:56e:b1c8:381b with SMTP id r3-20020a056214124300b0056eb1c8381bmr43628820qvv.31.1680189661785;
        Thu, 30 Mar 2023 08:21:01 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cc691000000b005dd8b9345absm2264239qvj.67.2023.03.30.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:21:00 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: remove unused sq_int_priv variable
Date:   Thu, 30 Mar 2023 11:20:40 -0400
Message-Id: <20230330152040.1838353-1-trix@redhat.com>
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
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v11.c:282:38: error: variable
  'sq_int_priv' set but not used [-Werror,-Wunused-but-set-variable]
        uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
                                            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 0d53f6067422..bbd646c0dee7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -279,7 +279,7 @@ static void event_interrupt_wq_v11(struct kfd_dev *dev,
 {
 	uint16_t source_id, client_id, ring_id, pasid, vmid;
 	uint32_t context_id0, context_id1;
-	uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
+	uint8_t sq_int_enc, sq_int_errtype;
 	struct kfd_vm_fault_info info = {0};
 	struct kfd_hsa_memory_exception_data exception_data;
 
@@ -348,13 +348,6 @@ static void event_interrupt_wq_v11(struct kfd_dev *dev,
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
 				print_sq_intr_info_inst(context_id0, context_id1);
-				sq_int_priv = REG_GET_FIELD(context_id0,
-						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
-				/*if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(dev, pasid,
-						KFD_CTXID0_DOORBELL_ID(context_id0),
-						KFD_CTXID0_TRAP_CODE(context_id0),
-						NULL, 0)))
-					return;*/
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				print_sq_intr_info_error(context_id0, context_id1);
-- 
2.27.0

