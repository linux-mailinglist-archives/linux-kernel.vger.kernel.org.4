Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5965F0741
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiI3JLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiI3JLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:11:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DF846852
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:11:00 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE60041473
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664529058;
        bh=3EwN7ICYiqgTYVQO2ot2VfpryeYvkvfH7StD/2CT2TA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=R7k4s/+JvD44S9U+yj/9ffjD3/UYFaO8N7owrxz2+T8ceHqWM5DTIwsZHnM+HjcHH
         lN5XrvVCD1QUw6WrsPINWGHPEbCHD5Stz9je7nwTYu2PtyeqgL+jwWb7UB5AaA6Kl0
         wnBNVja+gL9Z0OFOR917m0x+4eg/ku3h6Cg2o3aEI72qzp133smoYiVDh4hOJ9sBab
         /UERYDza76Um4TQfsNUsjofe6dKY10iNQ5NrS1PCFsu9/94Om/27n8l48iZIRP73Zz
         gVV1FTW0kSekTwQwuKeLecb2huA6K+Pkn2nDKzXZfpcN/GG3Am4Ia+eXz7ogNPc1kd
         wY5Qz8M76PBIg==
Received: by mail-pj1-f72.google.com with SMTP id z9-20020a17090a468900b00202fdb32ba1so2347006pjf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3EwN7ICYiqgTYVQO2ot2VfpryeYvkvfH7StD/2CT2TA=;
        b=6uKbkCUQNgDnKVBWmLiPXXApwebi7WoIZDYdy5Y5urzT7uZAgi1gnoxfOXDVBRPBGt
         LfqRE/f/upo/KFDwQ3kxEq5TCkxjbh5jXVfcRdmRX4Nup2jz9EnsQbQf/QyXZTJECgl4
         0ZnGFjVr3JEeb70qguXjUTy4yuTn+VbgagXs3OEuwAToikJvIJvJEhqeEB9TybTx6Eqv
         gMw3CXdeELIxV3QHpBANsP41C4WwEu2gqj17R9+M7SIuUm7CZMlAiQtuoAUIu+TPXT71
         KSWwk5Ch/IXhGJGTHzV2+m5xAovyWwtRlwcSZjiLYK5SO2pfvvMU5ebvaTO7tX6fkike
         xCAQ==
X-Gm-Message-State: ACrzQf3n9zGqsxmni0n7rUSwvcNUlJelrobjYyILbNBvH1AM94iV13Jl
        E0i9lRKG3uDF7gUaykQwgWwZyIgoq+7YgzfTK7t/4RVdeoTWr2DpTiL89CpnVMzT3QvO0p8MSjJ
        UB+EUYvs1d3DZZhMxJAMb9i4/35n36jHI+uT7SkHKzQ==
X-Received: by 2002:a17:902:e846:b0:17c:a00b:69c1 with SMTP id t6-20020a170902e84600b0017ca00b69c1mr1299090plg.143.1664529057118;
        Fri, 30 Sep 2022 02:10:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7p+cTf1lW/V8rs3eKZXr6tS966Ojg7mXPPBy2dHAgLVDEp55KpJUQ+4bPTnlgIK7SLCre3mw==
X-Received: by 2002:a17:902:e846:b0:17c:a00b:69c1 with SMTP id t6-20020a170902e84600b0017ca00b69c1mr1299066plg.143.1664529056766;
        Fri, 30 Sep 2022 02:10:56 -0700 (PDT)
Received: from u-Precision-5560.mymeshdevice.home (2001-b011-381d-9173-bb82-1440-19c3-59f5.dynamic-ip6.hinet.net. [2001:b011:381d:9173:bb82:1440:19c3:59f5])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902d10100b001785dddc703sm1360115plw.120.2022.09.30.02.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:10:56 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     bhelgaas@google.com, mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] PCI/ASPM: Make SUNIX serial card acceptable latency unlimited
Date:   Fri, 30 Sep 2022 17:10:50 +0800
Message-Id: <20220930091050.193096-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SUNIX serial card advertise L1 acceptable L0S exit latency to be
< 2us, L1 < 32us, but the link capability shows they're unlimited.

It fails the latency check and prohibits the ASPM L1 from being
enabled. The L1 acceptable latency quirk fixes the issue.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..e1663e43846e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5955,4 +5955,5 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999, aspm_l1_acceptable_latency);
 #endif
-- 
2.25.1

