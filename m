Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACEA63DC44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiK3RoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiK3RoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:44:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DAA45A06
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669830188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=voK5XLV56Q9FI5eyVszeBGUsLnZ4M62G6sR/KUxS2MY=;
        b=G+w8sI4cVrcBaR1WhD13eqcRZ3Fyd0LDd9BiYWVXdBKguGG00u2j0sd//ZCEN43T5XnUeA
        ilVpDMcE2e+996LbjZPPHSXgfUrBUGUG7lm/7M4IkKlSCeXqdPqX9gyNebH1bhvvzTaglu
        5YQddmTdVewnMaf8ezCyDOemYiZGo6w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-EyUi-REFMla6CcfttnjSHg-1; Wed, 30 Nov 2022 12:43:07 -0500
X-MC-Unique: EyUi-REFMla6CcfttnjSHg-1
Received: by mail-qv1-f71.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so27254643qva.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voK5XLV56Q9FI5eyVszeBGUsLnZ4M62G6sR/KUxS2MY=;
        b=v0HQQs0xqn1++GoClpn8xC2y33a5U+4E6aVIe7w1accKnW64kg90FBIHWRWHDlEoL1
         qpd8klr3QAsyncNMWRMoiaTSguRN+3wfuBM0tAHQgJq8UbS9TJtc6yR6x8CmQvsNDoxW
         ePN8eBsuUrJz9yT9dh1Q89fbMRMDSO4UnVjwf+WyxNMQAqWUQbzp8ZkN8wgjCNaj/SJV
         d95eZNLd5Bmp3QGtCR64k3ggaesDD5kMa06Ek03+FUkI1UDIXjEdVJP6VHzNLcxJPDfE
         aFQ9vfV4l8XKZE37JTueNz8nLiVScfK/R/jXi4YVS3ddbSvjtXf0cKEqGOeI0IqdbjO9
         KGHQ==
X-Gm-Message-State: ANoB5pnD6L+1oYhr0YOqAge3ia9bPHz7jgQpQJUhZRSsPdj8gDUMDk8f
        d+9Ox/kDdpQlmbUlUCO1w2Dz9LySOnbuEXTfGu+ytCNP6/piL0txi7835Ta+aF4L7YQs8BJlU4m
        Au0028Ozh6389U3ADhgTJ+iw2
X-Received: by 2002:ac8:1416:0:b0:3a5:6822:1a42 with SMTP id k22-20020ac81416000000b003a568221a42mr44920276qtj.174.1669830186982;
        Wed, 30 Nov 2022 09:43:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6WAPHf8bd6gCmpsnoP2kOmMN0tOtqukSeMA0xoipZdye6rc5uujfvMb4ufBL+lhjVaLVVJug==
X-Received: by 2002:ac8:1416:0:b0:3a5:6822:1a42 with SMTP id k22-20020ac81416000000b003a568221a42mr44920254qtj.174.1669830186742;
        Wed, 30 Nov 2022 09:43:06 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a29d200b006fba0a389a4sm1666087qkp.88.2022.11.30.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:43:06 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        cth451@gmail.com
Subject: [PATCH] net: atlantic: fix check for invalid ethernet addresses
Date:   Wed, 30 Nov 2022 12:42:59 -0500
Message-Id: <20221130174259.1591567-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
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

The Qualcomm sa8540p automotive development board (QDrive3) has an
Aquantia NIC wired over PCIe. The ethernet MAC address assigned to
all of the boards in our lab is 00:17:b6:00:00:00. The existing
check in aq_nic_is_valid_ether_addr() only checks for leading zeros
in the MAC address. Let's update the check to also check for trailing
zeros in the MAC address so that a random MAC address is assigned
in this case.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 06508eebb585..c9c850bbc805 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -293,7 +293,8 @@ static bool aq_nic_is_valid_ether_addr(const u8 *addr)
 	/* Some engineering samples of Aquantia NICs are provisioned with a
 	 * partially populated MAC, which is still invalid.
 	 */
-	return !(addr[0] == 0 && addr[1] == 0 && addr[2] == 0);
+	return !(addr[0] == 0 && addr[1] == 0 && addr[2] == 0) &&
+		!(addr[3] == 0 && addr[4] == 0 && addr[5] == 0);
 }
 
 int aq_nic_ndev_register(struct aq_nic_s *self)
-- 
2.38.1

