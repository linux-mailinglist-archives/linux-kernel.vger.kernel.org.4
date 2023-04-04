Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B637B6D55B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjDDBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjDDBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF61FC7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680570106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/kgwTdEq8eWs80cfso32AdLhlnP5Vyd62XPeXkyQic8=;
        b=Q71GmNd6pmCX48OUdll+OLXcS+Ewn5PXmER/kNrOHrSZy7dsNfc8UWzzTLli0bU5bELu4T
        9LM3YLyuPm4iGkMD3p0Gkg5E3xlb0X2OXj5aT+V3c9JyurcD9WX+vehRMMlV7oVnDlbQqE
        GkehqvEyYCuiGqM5MxlQbbXpMYN11Iw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-v5JsMpPwPf-S1wJ647z-mw-1; Mon, 03 Apr 2023 21:01:45 -0400
X-MC-Unique: v5JsMpPwPf-S1wJ647z-mw-1
Received: by mail-qk1-f198.google.com with SMTP id v5-20020a379305000000b0074a37810157so2409113qkd.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680570105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kgwTdEq8eWs80cfso32AdLhlnP5Vyd62XPeXkyQic8=;
        b=DB/RlaVESRAt4apWPFxLX2AaaypQ83e3G9kscW+dRs3WOjgnqYPyZ0O7yYCJtLfxjn
         TpUlkf5bSLMMywq5SJywVd03hCpd4p4EO+1zOFRMyfmF5LUCrcmEB5+4vr9KJFo5YA3w
         ixgPmQ2pj14W2+DVr3It2Naw7XZt+dVDJrtXT2K6e3kel0qPgmOXxIf0blJVMZskJadu
         tSNoNxvM3knMKYaMfl573O99lRcaZyEk1w1WQkGvk1PcFzNfnWIkvfQspFxnwET0H5Hz
         xt1B2rAzXxdGzuUIHtfMPOL0HR6BsTpHofH4mlG9njHeOqE5fggJD4/0JuWfDH4+YUNN
         8UTg==
X-Gm-Message-State: AAQBX9dNqD48yPGfUFum1sIj9Hb7u/07kOt1LuLemsQC6gpzPqmylRiP
        sZNDB5FaFSp651H+gif5B7v/lW16bu3h/22OB0aptIfNMLO7DghnFHb9rGE4zucfLw/oBjYsMWE
        k5/KSxlm7oDWqWDjmPSjV1cpO
X-Received: by 2002:a05:622a:100b:b0:3e3:8035:7bf5 with SMTP id d11-20020a05622a100b00b003e380357bf5mr961138qte.20.1680570104820;
        Mon, 03 Apr 2023 18:01:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350bNXHbG+GGFq1pygRDtwRxuoxPCHH2JeIrzvilbJxlSawKX6UyrBx97SzhYID2kaxXtUzkiyg==
X-Received: by 2002:a05:622a:100b:b0:3e3:8035:7bf5 with SMTP id d11-20020a05622a100b00b003e380357bf5mr961106qte.20.1680570104565;
        Mon, 03 Apr 2023 18:01:44 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n15-20020ac8674f000000b003d65e257f10sm2886209qtp.79.2023.04.03.18.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:01:44 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] KVM: x86: set varaiable mitigate_smt_rsb storage-class-specifier to static
Date:   Mon,  3 Apr 2023 21:01:41 -0400
Message-Id: <20230404010141.1913667-1-trix@redhat.com>
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

smatch reports
arch/x86/kvm/x86.c:199:20: warning: symbol
  'mitigate_smt_rsb' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8bb8f226f51f..4ce3411d35f3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -196,7 +196,7 @@ bool __read_mostly eager_page_split = true;
 module_param(eager_page_split, bool, 0644);
 
 /* Enable/disable SMT_RSB bug mitigation */
-bool __read_mostly mitigate_smt_rsb;
+static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
 /*
-- 
2.27.0

