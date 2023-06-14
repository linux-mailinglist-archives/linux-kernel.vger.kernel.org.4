Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23D72F441
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbjFNFp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjFNFpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:45:55 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87911BC3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:45:52 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgvXr71M9zBQJYQ
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:45:48 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686721548; x=1689313549; bh=x9um8RhKCy7/xRgr+qA0V6DCZvo
        zgU/1cnaCwHpZPyU=; b=srThXymOP6NhU86+ixQu8Qu64EQMKFZLWbxEitzXadB
        9nb8mJH4wfU8cyXxe4XnSJ+01LtVRYFHBUopm1qLld92Jmb6C3f4y6+Gyo+NyQqu
        XchyrnUJooKvn0G3h4N1B03Q/d9Jq3X3AiXxKzY5SAZe9FY7AGCbM413wG4yVSnO
        3p22/jWIl7KW+AEZJw75XfW0HNADNmnad9o0Z2ky5TZ3+ZwuzxlVQj2VSPPy6A61
        vMN2+bBHSBH1wyhBWh3kQ+Xk8xRFGnAU3trfQfzf26G7WfU/IaUgCygQT3+sacHt
        kAkz9FlYpFN2M1wk05hxmpjP7XSI32iK9kD8rHROdqA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PwB1Mx0i2BWO for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 13:45:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgvXr4pPszBJLB3;
        Wed, 14 Jun 2023 13:45:48 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 13:45:48 +0800
From:   wuyonggang001@208suo.com
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div() function
In-Reply-To: <0dc9409b662180ed29cbc281f0f076b7@208suo.com>
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com>
 <0dc9409b662180ed29cbc281f0f076b7@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/clk/baikal-t1/ccu-pll.c:81:1-7: WARNING: do_div() does a 
64-by-32 division, please consider using div64_ul instead.

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/clk/baikal-t1/ccu-pll.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/baikal-t1/ccu-pll.c 
b/drivers/clk/baikal-t1/ccu-pll.c
index 13ef28001439..d41735c6956a 100644
--- a/drivers/clk/baikal-t1/ccu-pll.c
+++ b/drivers/clk/baikal-t1/ccu-pll.c
@@ -66,7 +66,7 @@ static inline unsigned long 
ccu_pll_lock_delay_us(unsigned long ref_clk,
  {
      u64 us = 500ULL * nr * USEC_PER_SEC;

-    do_div(us, ref_clk);
+    div64_ul(us, ref_clk);

      return us;
  }
@@ -78,9 +78,9 @@ static inline unsigned long ccu_pll_calc_freq(unsigned 
long ref_clk,
  {
      u64 tmp = ref_clk;

-    do_div(tmp, nr);
+    div64_ul(tmp, nr);
      tmp *= nf;
-    do_div(tmp, od);
+    div64_ul(tmp, od);

      return tmp;
  }
