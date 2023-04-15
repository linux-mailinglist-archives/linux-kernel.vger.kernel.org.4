Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6412E6F0B29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbjD0Rmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbjD0Rmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:42:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 252565599;
        Thu, 27 Apr 2023 10:42:16 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8806821C33E1;
        Thu, 27 Apr 2023 10:42:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8806821C33E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617335;
        bh=sj6LPYNvymIeZEc3MyNCG2Y2lTHGTHDS4BHT1bAwr3Y=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=Z63G6khxN1OPq0ZG7hjZeqCgnQ5dGb2R4fM1LshMq7Ib3jI0XzV9Hjp1g+/hL2TBe
         1B3HjnIiQHcC967R9SnMk6mY1Jtmh8zcJ2gIhGAwmINGBN2VpJODCf0+HD1hue4DwR
         NMtoUFf36vlRNMFGNZ1dUod0jepQDsbhlr+RbQ2o=
Subject: [PATCH 4/7] hexagon: asm/io.h: Expect immutable pointer in
 virt_to_phys prototype
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 15 Apr 2023 04:17:42 -0700
Message-ID: <168155746272.13678.16103862954212080276.stgit@skinsburskii.localdomain>
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

These helper function - virt_to_phys - doesn't need the address pointer to
be mutable.

In the same time expecting it to be mutable leads to the following build
warning for constant pointers:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Brian Cain <bcain@quicinc.com>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Mark Brown <broonie@kernel.org>
CC: linux-hexagon@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/hexagon/include/asm/io.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 46a099de85b7..facbd7467dd3 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -46,7 +46,7 @@ extern void __raw_writesl(void __iomem *addr, const void *data, int wordlen);
  * virt_to_phys - map virtual address to physical
  * @address:  address to map
  */
-static inline unsigned long virt_to_phys(volatile void *address)
+static inline unsigned long virt_to_phys(const volatile void *address)
 {
 	return __pa(address);
 }


