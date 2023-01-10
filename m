Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C06664C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjAJThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjAJThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:37:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88E4FCF2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673379382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yj+HBuTUncC5lE81l2Gg3tjvcbmvnq4VCsptZAErNXM=;
        b=EDqIVNwMk+NlXv5UZfQf6pWVOSQLhvGZWx7/lZRA1KyfESh0M8YlGGUQ9+veteGrCvobH2
        fZO1umMVcTC1LlkKzElT/1s8YmiwinnOSo16MHLPZUpeXWqhxjxA0F248HLX4EwKGCqf9K
        La9ijymnnGXooKMk6m10oBOKFaNwi7s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-_8qJScVYN-iAwDciW3Qilg-1; Tue, 10 Jan 2023 14:36:21 -0500
X-MC-Unique: _8qJScVYN-iAwDciW3Qilg-1
Received: by mail-pg1-f197.google.com with SMTP id s76-20020a632c4f000000b0049ceb0f185eso5581496pgs.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj+HBuTUncC5lE81l2Gg3tjvcbmvnq4VCsptZAErNXM=;
        b=Mb3mBJmbLt5nA7gNUgSXOEN5jGrNBi1QnTB58MEXZQ/46W16MikJj6AX10EjIuPmqR
         bw/14i+gIhT/LJpahrXh0jmihl0vd8+gEtE7GkKzl9Wm1sv/tXwDfi/Z1SJFQBpC3gXu
         9L5zTgidSuNb5JU2pPR11JIzFSh5cOs5yyk4O2kE4dVs7/B0+gQgSVovDJbAx3ZkadBN
         bRx6MNAeGbQn4pjfdGj3VVPKpdevdkX8MKFqiPYeXISDrwZmzJ3293ZdQYkGRxonARKO
         X2hg5Z4r6lI2DRhcLRzfU+5gEnxK4lRMYS8Z0Ppj2dLZwx+oYDyngpzOoWgRYFGuohOL
         +nUg==
X-Gm-Message-State: AFqh2kqmkUxm6KkDAHbdsx78/FP7DQ+4v5oISGIHlZm8wz2Hp1wg+Kkb
        mxuDoa6iosFcs5mejaFb+XXgH7f5AKPRPHWxq0cCiJRllFQfNpnX6xUlzWfrdFUlLnct06RDUEA
        UTPXEpiAc9c4KSitsysdAJSJG
X-Received: by 2002:a05:6a20:47c8:b0:9d:efbe:204b with SMTP id ey8-20020a056a2047c800b0009defbe204bmr76827474pzb.1.1673379380010;
        Tue, 10 Jan 2023 11:36:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCtPTYrYlOZy/4MsymT5iev0oOLVLTuxBLZWISSRSnYz9AF4e8Uu0T/HgOGW4RT0ynfsSHjQ==
X-Received: by 2002:a05:6a20:47c8:b0:9d:efbe:204b with SMTP id ey8-20020a056a2047c800b0009defbe204bmr76827465pzb.1.1673379379776;
        Tue, 10 Jan 2023 11:36:19 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 14-20020a630c4e000000b00478f87eaa44sm7005552pgm.35.2023.01.10.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:36:19 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     bleung@chromium.org, groeck@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/chrome: cros_ec_lpc: initialize the buf variable
Date:   Tue, 10 Jan 2023 14:36:11 -0500
Message-Id: <20230110193611.3573777-1-trix@redhat.com>
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

Clang static analysis reports this problem
drivers/platform/chrome/cros_ec_lpc.c:379:13: warning: The left operand
  of '!=' is a garbage value [core.UndefinedBinaryOperatorResult]
    if (buf[0] != 'E' || buf[1] != 'C') {
         ~~~~~~ ^

The check depends on the side effect of the read.  When the read fails
or is short, a buf containing garbage could be mistaken as correct.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 3708fa75feb1..68bba0fcafab 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -350,7 +350,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	struct acpi_device *adev;
 	acpi_status status;
 	struct cros_ec_device *ec_dev;
-	u8 buf[2];
+	u8 buf[2] = {};
 	int irq, ret;
 
 	/*
-- 
2.27.0

