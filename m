Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8E6BE828
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCQLd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCQLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:33:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE8A8EA6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id ix20so4987620plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iadPnAZmhsjWHxwMakcLwCHZfPYJGTmA/4ZcjoDKLE=;
        b=cNxNwaDBvRQmJinsBZUY5SpY/BRLnT3sn/ZuYenOqjV8bNs9gzBJiP8XDNNipnex/d
         SSAxhnm9/x33lz7Ci6LsaOyUrcsVsqeVAlSvpj93Dhv0BrS3/tQajdxU+ThT0QLf1QhT
         01l1nQFqaS3kyaRht0ChqovhYp9DmbW6DWyC0zNMk6AwnA3fuqmrP/EwTnN4fFJ2MFyj
         NW8slonzbP2p9sfvse/Kgj5gTlxWFONglv5lUsMAzS7ort8BTaACKPwbX9u0aErVTvy5
         Kotlud6lIbgckHk7othS57WotvkRtLyG0heCxiFJZsOai8nFdAKFqRaDV8bV73dOo9o8
         72EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iadPnAZmhsjWHxwMakcLwCHZfPYJGTmA/4ZcjoDKLE=;
        b=7EdPdnyDpNNGaULPj75jAkGx/p03RHxaK0VlorggsNPaxAOY5f4F++XdDDEKETCxPT
         W4U7r+uMZLTjfSl8sZykL0/caL0BmsFsN+d8EfmRotm6ecD/L5gH0vMMYJKPGRW/+Oe0
         gRQ1A6CdPkcGiMMb+23fJaw9Omicx3Yh+Sq6SdJpehM8NNAFcaM7V0XXpFdfNHOUxeZ+
         LzN0KlWk1FU9qf5lKlX56Zsz5vn2YGQUJFDYAm3iik4jp4FPnJI/euc6oHGkGWBgM3Tl
         CXYpU49uYuStNkKVMfVU+NkEEhJX+UaOE6rTIuj6RLn6QMJiFBzcCeOTKYAtdBBBctXK
         KJoQ==
X-Gm-Message-State: AO0yUKWfBIEfY3X7wn2nUzObHWOle10caXn64LkWN+RrPRpbrv+4wM33
        ZbK4FHOM+IJA8LNWzvOKFJ0IZw==
X-Google-Smtp-Source: AK7set/qCnGBA0p9szajAWdSwnN3dFOPj1OdZtTeBXVH2xSXJIPYItlJH9avlXDIJ2Wli9AmPHquFQ==
X-Received: by 2002:a17:90a:1a03:b0:237:2f3c:a1cd with SMTP id 3-20020a17090a1a0300b002372f3ca1cdmr8508780pjk.19.1679052783445;
        Fri, 17 Mar 2023 04:33:03 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:33:03 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 05/11] MAINTAINERS: Add a header file for pci-epf-test
Date:   Fri, 17 Mar 2023 20:32:32 +0900
Message-Id: <20230317113238.142970-6-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
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

Common definitions between pci-epf-test and pci_endpoint_test drivers moves
into the new header file.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 092f9500e0e7..440a7d0d4ac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16131,6 +16131,7 @@ F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
 F:	tools/pci/
+F:	include/linux/pci-epf-test.h
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
 M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
-- 
2.25.1

