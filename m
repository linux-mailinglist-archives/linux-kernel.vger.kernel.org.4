Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE80607FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJUUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJUUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:24:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38962EF2A;
        Fri, 21 Oct 2022 13:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5DCBB82D4A;
        Fri, 21 Oct 2022 20:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A11C433D6;
        Fri, 21 Oct 2022 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666383880;
        bh=+AVx5SV5r/tSMDS/xVQQrQ6GZyuBqXfn99TrHMsZq2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sY18lwjF9NMGyRWndJF/89uK3hP/CUv48OX6gL4ugZmharMVNn0K50kXHipp4Av0l
         Te4WtPlqyN73O6k4RO6Se5J/xNq/r+MBkQ4PdWnNtmAcCu+vw3gcXw20uR8H9awbMP
         mJM2OoKEnAakMv7wMRh9ENSKVIrUOfzq+7D1Z7cW92W+nlWNFs/RKfSjPYiqNhQHs6
         6UG5gr2Bxqj265fCi2ohRxGh8wuvKeNYXi/dZpP6gzlek8Gjp9GuORSzIAs58HRcGB
         5PizU1eoJplVJNyarA838+XhkHuOO9EGCHZ/W9SFkCvJMO81ONP2LjOBE5HmYVOi9u
         RplhnzLRp/4qw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] sh: remove unnecessary __BUILD_IOPORT_PFX()
Date:   Fri, 21 Oct 2022 15:24:23 -0500
Message-Id: <20221021202424.307531-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021202424.307531-1-helgaas@kernel.org>
References: <20221021202424.307531-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The only reason __BUILD_IOPORT_PFX() existed was to accept a "bus"
parameter, but nothing ever used that.  Remove __BUILD_IOPORT_PFX() and
collapse it into BUILDIO_IOPORT().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/include/asm/io.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 193640bd9563..e29e8870dc3b 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -161,13 +161,10 @@ static inline type in##bwlq##p(unsigned long port)			\
 	return __val;							\
 }
 
-#define __BUILD_IOPORT_PFX(bwlq, type)					\
+#define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_SINGLE(bwlq, type,)				\
 	__BUILD_IOPORT_SINGLE(bwlq, type, _p)
 
-#define BUILDIO_IOPORT(bwlq, type)					\
-	__BUILD_IOPORT_PFX(bwlq, type)
-
 BUILDIO_IOPORT(b, u8)
 BUILDIO_IOPORT(w, u16)
 BUILDIO_IOPORT(l, u32)
-- 
2.25.1

