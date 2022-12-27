Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D93656FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiL0VP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiL0VPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:15:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06A26A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:15:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jo4so34383968ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sPoeTLHMh76mrQ+DcS9veOUW/UIwkja5UhRXyzMgz2s=;
        b=NvqLion4Bv9Xgl1bfi2e66Zwg8J8UItFqGhANpG7z4kh2CzSukDSlZLw9rk5uvbpyg
         5JkiMje+C5AlZ48ytnmtmqRxV5MNJLCCQIucQMdj+l/nukfeVeSJv8vputR6VNl5nOZF
         QHxHDfURRTPbWtHwcz5BntHvzV026rSMfZzYSr8WiudujLMWr65tGxjEeMlHZQCdE8sc
         d73LT+ykfyH/8iKy+PDVrGJgLNYSUwuQpX1Ahu/aPB8rtxb3dGaMeGKVp18oSZtpSXnS
         kJC9AkOwH29v6PfXZnJTSxOZK1L5aTBk094W6hfBCMB6Hahu+inpz+EqC2Ev9mKodtLU
         mz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPoeTLHMh76mrQ+DcS9veOUW/UIwkja5UhRXyzMgz2s=;
        b=pE4Aa6t99WJPdvaPeyRCoelowtPOsS9tEsnqX1YXLiL3xe9ZMte3Dj1RWxdIxUsYq8
         KGnLHb6NKI939aPIctpECU8QHaA9xRMi+QPZrd/QvqrT3aPN+kf5mO6JdnUuBB5LJYMp
         kObVS57YLf/xnZ6QTsd0ZoOSP6UKXTl2JGVDHPZosOQ1MaQj6RoyvZmPFcKB2eD2pHMm
         SjzmHWeg9SWCsFxX7OjR3196EwvBxya6DMpgc+kxF3sKJH55JA+aeG+fd7ulaVgB1Mks
         BwtLD0Fvi13tQB6RcR/5SdpliHbzh07iN/vMNzs1TiMBEJM/RVXRB2E20B6NjJ/vTWZe
         3j0Q==
X-Gm-Message-State: AFqh2kr/jEjThwurz689RWrz88E8lDi2P1kLeMD2YyXgtHCwZCsktaDo
        AkWW0R0n3qQ9WSQ4cuhebjM=
X-Google-Smtp-Source: AMrXdXt5trjiiG7WSr4djKK4um0lPo+jjSl1xB0zh8cp5/i2TNjDbIPGz9oCm32C0FHu2cBSoNVCHA==
X-Received: by 2002:a17:907:1759:b0:7ad:d250:b903 with SMTP id lf25-20020a170907175900b007add250b903mr26686546ejc.56.1672175729105;
        Tue, 27 Dec 2022 13:15:29 -0800 (PST)
Received: from [192.168.0.239] (ip5f5ad5e2.dynamic.kabel-deutschland.de. [95.90.213.226])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b007c0d4d3a0c1sm6506852ejc.32.2022.12.27.13.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 13:15:28 -0800 (PST)
Message-ID: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
From:   Tanmay Bhushan <007047221b@gmail.com>
To:     Zhu Lingshan <lingshan.zhu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Dec 2022 22:15:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7eae04667ddaac8baa4812d48ef2c942cedef946 Mon Sep 17 00:00:00 2001
From: Tanmay Bhushan <007047221b@gmail.com>
Date: Tue, 27 Dec 2022 22:02:16 +0100
Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails

ifcvf_mgmt_dev leaks memory if it is not freed before
returning. Call is made to correct return statement
so memory does not leak. ifcvf_init_hw does not take
care of this so it is needed to do it here.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044c6442..44b29289aa19 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const
struct pci_device_id *id)
 	ret =3D ifcvf_init_hw(vf, pdev);
 	if (ret) {
 		IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
-		return ret;
+		goto err;
 	}
=20
 	for (i =3D 0; i < vf->nr_vring; i++)
--=20
2.34.1


