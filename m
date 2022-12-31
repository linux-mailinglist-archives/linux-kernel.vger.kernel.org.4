Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB865A59F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiLaQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLaQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF838A0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672502492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OVTkT6J2Hrxy6D3i2AFBcsY5vLlTPz0/Nv+lU2zXc/I=;
        b=dHypmf1RkvDOF1EV5a5jjEIWfeCCwDVHyzWEbH/Y/+zebxKrtoYSzme0gu0bFwvmmWiTeV
        reRF7O+wZusAccWFllEeoNeuuU+iwn8ZlidXSjyipbhF47BNQO1Q6XnokK8GoInK6nNnZq
        JdV1TQ3ZXEwqTOurAxxYMyHGoPVk+6g=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-kybYcjFYM-eM_ygBPJjIKw-1; Sat, 31 Dec 2022 11:01:29 -0500
X-MC-Unique: kybYcjFYM-eM_ygBPJjIKw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-14fa3e986a2so9039199fac.17
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 08:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVTkT6J2Hrxy6D3i2AFBcsY5vLlTPz0/Nv+lU2zXc/I=;
        b=0rQlUABZZP1jdWlJRVe2P8waL8lrs1FhIKhrdR5t3mh90ERCyVpRjICIHey48zR5fy
         IUGE1xTBbSBQpCPf6N4X9ZE5weArZD+g8YxSGizxLB6tVMCClMHAFOCdfWC7IREZj+py
         UMadNVoqCDu6W8iDaRkdrHeyhLOdnsm/I/hFiXS8Mg+0uqXzQcEkGn7Sbab8Qa1OfJLo
         rXLkgpXV7EYyvAtDIAg5qFnTNwr4kqFqPx2HDoe3uvaPlYxMq7PRDi270Wk8WPUUiyST
         rarF31J8x5TE/AWtE08AwmZqWP846N+Ac+2LQpU6/KsEo9f7aBCGQ8hZCFoRvuUVi32t
         jUVQ==
X-Gm-Message-State: AFqh2kpKvpxuMY5CFZp0sbVK2VQkDENkBqsN1ntlpoJHsdfREWe2fpCg
        XQJV0ZVWAUCi51SiDpQq8XFiq9o1r4Hp3PcIjw32/UJ1LD2D3q/PDiXhHNyPfZGAh9pgjYDYmAY
        oxq+7MvyxlxJwhg7POn/wxyok
X-Received: by 2002:a05:6870:1b87:b0:148:25f1:bf35 with SMTP id hm7-20020a0568701b8700b0014825f1bf35mr17865910oab.28.1672502488377;
        Sat, 31 Dec 2022 08:01:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSM/oqnmzUCIQJkwhDRJi02tD3ISDY+eIi3zQNdrKd2rTGfyr/RZxYwiuZlE+NJ0nqAP3tgw==
X-Received: by 2002:a05:6870:1b87:b0:148:25f1:bf35 with SMTP id hm7-20020a0568701b8700b0014825f1bf35mr17865888oab.28.1672502488165;
        Sat, 31 Dec 2022 08:01:28 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b23-20020ac87557000000b003a5c60686b0sm14601158qtr.22.2022.12.31.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:01:27 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] EDAC: add parameters to edac stub macros
Date:   Sat, 31 Dec 2022 11:01:19 -0500
Message-Id: <20221231160119.2994264-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports this error
[drivers/edac/amd8111_edac.c:175]: (error) failed to expand 'edac_pci_handle_npe',
  Wrong number of parameters for macro 'edac_pci_handle_npe'.

cppcheck is testing the stubs which do not have parameters.
Add parameters to match function call.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/edac_module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 50ed9f2425bb..fe6b4e004432 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -117,8 +117,8 @@ extern void edac_pci_handle_npe(struct edac_pci_ctl_info *pci,
 #define edac_sysfs_pci_teardown()
 #define edac_pci_get_check_errors()
 #define edac_pci_get_poll_msec()
-#define edac_pci_handle_pe()
-#define edac_pci_handle_npe()
+#define edac_pci_handle_pe(pci, msg)
+#define edac_pci_handle_npe(pci, msg)
 #endif				/* CONFIG_PCI */
 
 #endif				/* __EDAC_MODULE_H__ */
-- 
2.27.0

