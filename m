Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18656F2038
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbjD1VoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbjD1VoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7310D26AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682718207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rkn6IrE/1wPx281zaEZo+27hctd8JO9FCinWB/Ya0Z0=;
        b=bElHuq/rstftKgXURT0p7HxF9Hm1N/FnV+FygTLoWxS5n8vlZALJopJFpM8Nl8VHpgXEll
        xEYZgzlkHXWVojBvfJrQjVdphoG4GP3E9iOCJ9uQjrY6mPZ2ucOqH82zpNVgpmbJejTIGW
        l5HZ1gEsGu4yGQCNkxfZ8/m0CzL0S60=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-T0vSyvdwNRe0SbqPnxMeaQ-1; Fri, 28 Apr 2023 17:43:25 -0400
X-MC-Unique: T0vSyvdwNRe0SbqPnxMeaQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74e04ba5cbbso21386885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682718204; x=1685310204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkn6IrE/1wPx281zaEZo+27hctd8JO9FCinWB/Ya0Z0=;
        b=iZs4wpCxcoFg3YcpDZNXzStPXOGRjR1W0qgRj1IEpPpuH7lX0I7yytua+HQBnZ+nb0
         mhtgsZK0vRXWLeFzPLDztFpx+vz7Qqy8uyUUYtPElZjEBPi/rLtDXjCPgOpNzRwwHco0
         igYpZXcntFfymL0Crv6YAKwh7PfQq1N2v7T5M9tNOsg+H0oWCQbQb3kegnrQoHyZCOeE
         JATVwdpjYy2jHALYypw7nwXEpQpo+aWUG53s66c1pjPfwZjjm4KZa74S+t1KhQCwwU+U
         4YIYPmWgVxVhpeLTEctB2CtvUqBTyWfXQ1GFnA+bZdLWVJIUpcwnomqLLD6EXUmZ42ba
         0SLg==
X-Gm-Message-State: AC+VfDw6u/I54TBba/ztgGoV3VGrBobOSRxwM52aq0HpiTKksZFSywhv
        DHqZYzudEQr1XIs7RJ5LqMrI6+RZKFAFpA+R39QlVZC9xYkWzPA2UG/XR27hAjKM829NM3aW5dn
        qETuvMyANSYQcGUe8Kq+lBJiG
X-Received: by 2002:a05:622a:1810:b0:3ec:48a3:d597 with SMTP id t16-20020a05622a181000b003ec48a3d597mr11924044qtc.60.1682718204760;
        Fri, 28 Apr 2023 14:43:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BclvjqY/ztOGK7ynswcchWqvG+mQWN+yI3Ly6yi6kNabY5gungBzrhTkyRC3+/IXvo4njag==
X-Received: by 2002:a05:622a:1810:b0:3ec:48a3:d597 with SMTP id t16-20020a05622a181000b003ec48a3d597mr11924033qtc.60.1682718204523;
        Fri, 28 Apr 2023 14:43:24 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bj11-20020a05620a190b00b0074e21c3bc8asm7029968qkb.126.2023.04.28.14.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:43:24 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: atlantic: Define aq_pm_ops conditionally on CONFIG_PM
Date:   Fri, 28 Apr 2023 17:43:21 -0400
Message-Id: <20230428214321.2678571-1-trix@redhat.com>
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

For s390, gcc with W=1 reports
drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c:458:32: error:
  'aq_pm_ops' defined but not used [-Werror=unused-const-variable=]
  458 | static const struct dev_pm_ops aq_pm_ops = {
      |                                ^~~~~~~~~

The only use of aq_pm_ops is conditional on CONFIG_PM.
The definition of aq_pm_ops and its functions should also
be conditional on CONFIG_PM.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 8647125d60ae..baa5f8cc31f2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -379,6 +379,7 @@ static void aq_pci_shutdown(struct pci_dev *pdev)
 	}
 }
 
+#ifdef CONFIG_PM
 static int aq_suspend_common(struct device *dev)
 {
 	struct aq_nic_s *nic = pci_get_drvdata(to_pci_dev(dev));
@@ -463,6 +464,7 @@ static const struct dev_pm_ops aq_pm_ops = {
 	.restore = aq_pm_resume_restore,
 	.thaw = aq_pm_thaw,
 };
+#endif
 
 static struct pci_driver aq_pci_ops = {
 	.name = AQ_CFG_DRV_NAME,
-- 
2.27.0

