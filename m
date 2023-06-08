Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9444A7275FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjFHEL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjFHELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA22103;
        Wed,  7 Jun 2023 21:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE2764788;
        Thu,  8 Jun 2023 04:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B683BC433EF;
        Thu,  8 Jun 2023 04:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686197480;
        bh=DSH0+M06pJVuiYq4hobnTz4ISp38m37GUzm/tJ7iW2g=;
        h=Date:From:To:Cc:Subject:From;
        b=qdAUd4C4ylFG61+SGH///Dv9II9UFcfIYOiBVRtiXAL4ew3U1sETw5bTjGcEEjXhy
         rP4LZJniTKwC3BScLE6jnuRRqwN+rWXvcBQAQ4Vvr8q7ipqHzbJRZo6J09zwabGFko
         JFXhq++chO85GFOfsfvqUfYcn9vti/8nIFwSpgtbrjECll6jC7LX3+dRhpw9B4hgGA
         ok0EosExhs93H4kYdm3gfP79P4DYZEbZK9/e/+7xxOGDHfxd9vUQ4WlKMg9F20iTOC
         2Q2npUvhw345cp8/uZO7x7KguoMwSRMR+NvurZYSQf7iFhc7k4y8Ffs3oq3pZLkvK0
         2/MZvq8jq2K5Q==
Date:   Wed, 7 Jun 2023 22:12:11 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>,
        Kevin Hilman <khilman@deeprootsystems.com>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ARM: OMAP2+: Fix -Warray-bounds warning in
 _pwrdm_state_switch()
Message-ID: <ZIFVGwImU3kpaGeH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If function pwrdm_read_prev_pwrst() returns -EINVAL, we will end
up accessing array pwrdm->state_counter through negative index
-22. This is wrong and the compiler is legitimately warning us
about this potential problem.

Fix this by sanity checking the value stored in variable _prev_
before accessing array pwrdm->state_counter.

Address the following -Warray-bounds warning:
arch/arm/mach-omap2/powerdomain.c:178:45: warning: array subscript -22 is below array bounds of 'unsigned int[4]' [-Warray-bounds]

Link: https://github.com/KSPP/linux/issues/307
Fixes: ba20bb126940 ("OMAP: PM counter infrastructure.")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/20230607050639.LzbPn%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/arm/mach-omap2/powerdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 777f9f8e7cd8..5e05dd1324e7 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -174,7 +174,7 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		break;
 	case PWRDM_STATE_PREV:
 		prev = pwrdm_read_prev_pwrst(pwrdm);
-		if (pwrdm->state != prev)
+		if (prev >= 0 && pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
 		if (prev == PWRDM_POWER_RET)
 			_update_logic_membank_counters(pwrdm);
-- 
2.34.1

