Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2606DA023
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbjDFSo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjDFSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0697ED2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680806647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KuWqlFWscCHky7PklpK8/27+L+0fHpmQONWaBu1fu8I=;
        b=K6OYPsX+ZWiRS9e71T4GOq7A45vrsQ3zFNR/Y1qA0IxhRmDAiF2I+LZw+D9gJlyualB0Uj
        V4AhkbuA7i+x3Y4EE11/dTRw0Zc00cRP80NG6GrFPa5AFdlIpQqQnSVPntax7P5NaPNd8O
        7S2ryvXA89oHf9/i3c9N9YivVmjkSok=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-h_sci8GkNkOiz3lqrilhGA-1; Thu, 06 Apr 2023 14:44:06 -0400
X-MC-Unique: h_sci8GkNkOiz3lqrilhGA-1
Received: by mail-qk1-f199.google.com with SMTP id d187-20020a3768c4000000b00746864b272cso18171338qkc.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuWqlFWscCHky7PklpK8/27+L+0fHpmQONWaBu1fu8I=;
        b=A/GUu+RinCdNfJTEuCoWjM7XO042fH3XzM5dGZUEpuqHqNdRmCflI4kd7jWrkOyLzF
         plQztHha03foI72ohUAX0klJVnz5Rj7Opvk25t/b4e4KlguW0RRyQpTB6NSb2Q5+GtUa
         eoIepw+jrveROubANAuGrW6VcNmCif9mtmU5fRgiKCKOegU4Q64Xu9iouGxsV8bEktjf
         NaOFw3rEEwD5k3VTSfjsOLCS1xhVaXWyGObVGR/avjOcxH8fGakR65pylfe/14mYTo9t
         p6D7EhzufjKeKAYmUd3BziUJyTBoouwHuqt8/+cKD+HSBGMZwOxfFiNMYr3qwwavxn4Z
         73jg==
X-Gm-Message-State: AAQBX9fvlymRamttj6Y8bkcB7aRmHaXB2OLx6SVRYAch6NF5Ugy7bZP7
        3CHGqLffRV0UNTtNDMGM7tOei1c7lERrztxa8e4PD6CrB4OEhoFhXniwAilR73+5sQcIBbdYjF9
        2G5dLc0vb4MFuSPACFf6Y/anB
X-Received: by 2002:a05:6214:e43:b0:56f:728:19d4 with SMTP id o3-20020a0562140e4300b0056f072819d4mr395410qvc.26.1680806645964;
        Thu, 06 Apr 2023 11:44:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350b2ByVQmJQEcdujhQzaXx6wnS67JdUovCAIB/18ORCzUQZUmTu9kF7vDna0IuEg2GJV05SvOw==
X-Received: by 2002:a05:6214:e43:b0:56f:728:19d4 with SMTP id o3-20020a0562140e4300b0056f072819d4mr395378qvc.26.1680806645607;
        Thu, 06 Apr 2023 11:44:05 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c79-20020ae9ed52000000b0074411b03972sm668481qkg.51.2023.04.06.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:44:05 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        p.zabel@pengutronix.de
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: apple: apple-pmgr-pwrstate: set varaiable apple_pmgr_reset_ops storage-class-specifier to static
Date:   Thu,  6 Apr 2023 14:44:02 -0400
Message-Id: <20230406184402.1956429-1-trix@redhat.com>
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
drivers/soc/apple/apple-pmgr-pwrstate.c:180:32: warning: symbol
  'apple_pmgr_reset_ops' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/apple/apple-pmgr-pwrstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
index a3e2bc1d2686..e456f6e04658 100644
--- a/drivers/soc/apple/apple-pmgr-pwrstate.c
+++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
@@ -177,7 +177,7 @@ static int apple_pmgr_reset_status(struct reset_controller_dev *rcdev, unsigned
 	return !!(reg & APPLE_PMGR_RESET);
 }
 
-const struct reset_control_ops apple_pmgr_reset_ops = {
+static const struct reset_control_ops apple_pmgr_reset_ops = {
 	.assert		= apple_pmgr_reset_assert,
 	.deassert	= apple_pmgr_reset_deassert,
 	.reset		= apple_pmgr_reset_reset,
-- 
2.27.0

