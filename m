Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F35687A65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjBBKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBBKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:38:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5556193CB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:38:45 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m13so1360694plx.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dF0HiUsu4mW2e29lJBwC8i5KwR/+inl5fESFZO2VSzA=;
        b=55h9pe0aCKrdPvt0QF2E95uOmwsJdhqe+dNk42AhcKiLn2+7Gt7EItqSo9wvjPWFIC
         YJra0Nm1deoCC2kHBdv7Ug/Wt63zY8mkdz9pHtMM0L7AMC9UlvJWKblsnRuh/sm/PWBP
         Sh3TlfwE72zBFIOMSWGgVHEMmg3bRwHnyiSb78qCtHkosfV9VsxQC+EM7SEWwyNa8zc3
         9qd+YzwNUY4Y0X6ArhBh1aOq5sQNFNj0penTrmix9T7hocgQVLMVKDpn8/EiHCmuRIl3
         vPHz0BxcxpvPOxbtmP7NKAu5uZEHgeMG8w/lbhCz26LJUw3EEKpLMPnGiM8Tn9jbIW7j
         yGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF0HiUsu4mW2e29lJBwC8i5KwR/+inl5fESFZO2VSzA=;
        b=txaalzh1dWhuLe4eEX9YS/Gltzo0hIkIsHTChiXhtQK0uMFC4tAlBL9l4S9UVcZ49S
         LJO0C8KsoJKQjZujyyCB7bQ9zURvcpYG1GqsG5otLKenAXBOsfwS4X7S7wo/+eAUl0h4
         kleET9RJVXgPYV+E5uHd84ud8O2i7MJTO16r8DPMyY96jUpvIEi6dnsuoiWTZ0mi7B26
         6v1I45imWnIe0NFyTzGEtBkrOK82wDhDp+eT253+QtTwfGLoOFw+5XvEer7+BItJJVB2
         mVXjCkUU7DNj6c19MPrtVwkF14ZLJTQ6JeuS3Cbfo9ukr+SlL8w1fEwOV2pFLsRjd3uP
         ozEQ==
X-Gm-Message-State: AO0yUKUGPGxx3ZPG/u1Q6lqd6AbGmfmb9jczWbPczvl6oqAGEPEeEK5E
        W40o3izahDeAgSNJwjNmeT1RYw==
X-Google-Smtp-Source: AK7set++uSAKtJhOxAtK9tHcjvV0tuO6IMF1d+/J/BkEsdn5Qo3dj8FKrorqXx5ri2I+oLPTb/98Ug==
X-Received: by 2002:a17:902:c7d3:b0:194:892b:8654 with SMTP id r19-20020a170902c7d300b00194892b8654mr5254714pla.17.1675334325474;
        Thu, 02 Feb 2023 02:38:45 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902e8c900b001897e2fd65dsm1449114plg.9.2023.02.02.02.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:38:44 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix a Kconfig prompt of vNTB driver
Date:   Thu,  2 Feb 2023 19:38:32 +0900
Message-Id: <20230202103832.2038286-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vNTB driver and NTB driver have same Kconfig prompt. Changed to make it
distinguishable.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 9fd560886871..8efb6a869e7c 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -27,7 +27,7 @@ config PCI_EPF_NTB
 	  If in doubt, say "N" to disable Endpoint NTB driver.
 
 config PCI_EPF_VNTB
-	tristate "PCI Endpoint NTB driver"
+	tristate "PCI Endpoint Virtual NTB driver"
 	depends on PCI_ENDPOINT
 	depends on NTB
 	select CONFIGFS_FS
-- 
2.25.1

