Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34465E6336
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiIVNI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiIVNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:08:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F9EBBCC;
        Thu, 22 Sep 2022 06:08:36 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYFqF54lKzlWfP;
        Thu, 22 Sep 2022 21:04:25 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:08:34 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:08:34 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <ardb@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <anshuman.khandual@arm.com>, <chenzhongjin@huawei.com>
Subject: [PATCH -next 0/3] arm64: Mark constants in .S files as data
Date:   Thu, 22 Sep 2022 21:04:49 +0800
Message-ID: <20220922130452.233323-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some constant numbers insdide .S files which is mixed with
text sections. When tools are reading the ELF files they cannot
distinguish these constants out of normal instructions.

Mark these constants as data symbols by wrapping then with SYM_DATA
macro.

Chen Zhongjin (3):
  arm64: efi-header: Mark efi header as data
  arm64: head: Mark constants as data
  arm64: crypto: Mark constant as data

 arch/arm64/crypto/aes-neonbs-core.S | 14 +++++++-------
 arch/arm64/crypto/poly1305-armv8.pl |  4 ++++
 arch/arm64/crypto/polyval-ce-core.S |  7 +++----
 arch/arm64/crypto/sha512-armv8.pl   | 24 ++++++++++++++----------
 arch/arm64/kernel/efi-header.S      |  2 ++
 arch/arm64/kernel/head.S            |  6 ++++--
 6 files changed, 34 insertions(+), 23 deletions(-)

-- 
2.17.1

