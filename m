Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA3631A50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKUH3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiKUH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:28:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF9CC4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669015649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N50omf+v9tTvkyUKa0XY0AIkXRuI62g4muqCOHQCuPo=;
        b=OxK3YWtRNSjv8XUttD1rinf+VSxXa6Xmq7gUNsrlkZ/dZTfDkZR5KyYhdiOCVvRn25jvU+
        g0BzB0MlBkUDesXYBDWjQEUPbt6t6eV6TIwlsvAiUl+AV0FYplCyqdYFX7KTypXxIW5DUi
        OIZ91RmFZK9sWcn2sX3f976hKj5cCh0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-MQ1_dLMSMISCncu11qF1KA-1; Mon, 21 Nov 2022 02:27:28 -0500
X-MC-Unique: MQ1_dLMSMISCncu11qF1KA-1
Received: by mail-pf1-f198.google.com with SMTP id cw4-20020a056a00450400b00561ec04e77aso7046768pfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N50omf+v9tTvkyUKa0XY0AIkXRuI62g4muqCOHQCuPo=;
        b=YvAclsMoVAB/FWKyGozDW5j3WP1WhFr92IUmRxI9X0UqRZ3QtE0n9pVi6VcUJPrLeS
         B8nBOM1O0lc7EF0RlLXlcGzrAbMhmlER4PO2bDUwzAvosbrwwZeAo6M1NCzSgFdDWHAn
         P4N3OXpyppVDbjcC/WRVv9/Y0z82h9bjx74JrP2a8pzuZCqlaTqGN3D9D3cZp+mpvU7I
         k9xpw3/sBo6BS3WxbiYvN7AHFddaTfNozJpN2f0Orx6UJtLEXuPz4l0w0HRif1shchLx
         JUSCBGfc/XifNYLxv3dEM/yUTDDvgsghmFua5SbVY1APFuT2JCEITiuJq4VZ3iXikwC/
         q4sQ==
X-Gm-Message-State: ANoB5plUk3rY5ya4eyyPfokgSgT97fj//cF4HD9XeSAEQb4KD7eMj9Oz
        3ULqcIwIshnjjgofFuwAoiBiu46KrWGN9s/d8LySPFN+0uL0Ydh6eOaE6PN9bHYCurXVBh/qmd2
        B/eaOR1rw+RA3AbIerIePhyHL
X-Received: by 2002:a62:5e41:0:b0:56b:db09:a235 with SMTP id s62-20020a625e41000000b0056bdb09a235mr586958pfb.20.1669015647047;
        Sun, 20 Nov 2022 23:27:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6euZCzCDbMvci+vSLMNOtsuOD0+hYqb6XwMGuSvrXS5hZkDpXsz/SXoxFTRnBj9rTHSs3zgQ==
X-Received: by 2002:a62:5e41:0:b0:56b:db09:a235 with SMTP id s62-20020a625e41000000b0056bdb09a235mr586931pfb.20.1669015646754;
        Sun, 20 Nov 2022 23:27:26 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902b94300b00183c6784704sm1559065pls.291.2022.11.20.23.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:27:26 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] lockdown: s390: kexec_file: don't skip signature verification when not secure IPLed
Date:   Mon, 21 Nov 2022 15:27:15 +0800
Message-Id: <20221121072715.836323-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
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

Currently for s390, lockdown doesn't prevent unsigned kernel image from
being kexec'ed when secure IPL is disabled. Fix it by always verifying
the signature regardless secure IPL is enabled or not.

Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")

Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index fc6d5f58debe..627685426ac2 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -33,10 +33,6 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	unsigned long sig_len;
 	int ret;
 
-	/* Skip signature verification when not secure IPLed. */
-	if (!ipl_secure_flag)
-		return 0;
-
 	if (marker_len > kernel_len)
 		return -EKEYREJECTED;
 
-- 
2.38.1

