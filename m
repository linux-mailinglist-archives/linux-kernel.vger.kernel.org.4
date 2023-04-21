Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6296EAED1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDUQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjDUQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:11:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377D1BE2;
        Fri, 21 Apr 2023 09:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2160651A2;
        Fri, 21 Apr 2023 16:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF72C433D2;
        Fri, 21 Apr 2023 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682093499;
        bh=c90AqEKiidJLf8KZtwvOkDfwb/ynOHdlsUMkIyFs9yE=;
        h=From:Subject:Date:To:Cc:From;
        b=KsMdUFQ7RAYytqEu5yiC7RiTDLpxfwzrQhCOZbFOk4nRCZgGe54rlQI93CFEr9ZmI
         9SUMhVRhXspg1GFDGqlbtU2j5hJaRBpp+cIy4/0aott+2sXoDNTS3vytPU6JcjGa5a
         jEkItwL2RmOyezIvUo/jUMKTLT+I0Gbd2cLOGmX+lA6y+u1oq8hF/EdL4tCQuI9S9r
         sCrgMmY7yoylUqIQ3PlIIMimMhewco19YLtAYrVSJY86NgRynjoMnpZjSjxMISOa7/
         gi/pzIWpiUhqHLVvsJAcpxDs9F5KceLEZdA3wE5M3NG/yPdNX7X9VrqzEuAxZJBZdG
         Q07HrinNJjiKQ==
From:   Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 0/2] MIPS: Fix check_bugs() modpost warning
Date:   Fri, 21 Apr 2023 09:11:25 -0700
Message-Id: <20230419-mips-check_bugs-init-attribute-v2-0-60a7ee65d4bf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK21QmQC/42OUQ6CMBBEr0L67RpaLBG/vIchpoWVbpBCtoVoC
 He3cAI/30zyZlYRkAmDuGWrYFwo0OgTqFMmGmd8h0BtYqFyVeQXWcFAU4DGYdM/7dwFIE8RTIx
 Mdo4IuSplXtjWKq1FklgTECwb37hdM5gQkfdiYnzR51h+1IkdhTjy9ziyyD39e3ORIKGSWCK2W
 ttrde+RPb7PI3ei3rbtB4pVg7rmAAAA
To:     tsbogend@alpha.franken.de
Cc:     ndesaulniers@google.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=nathan@kernel.org;
 h=from:subject:message-id; bh=c90AqEKiidJLf8KZtwvOkDfwb/ynOHdlsUMkIyFs9yE=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDClOW3edXXEo5c2qg3dOC1izOSm/jlvcIfR9za6ZAfOmO
 BWLzarh6ChlYRDjYJAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATyephZGjQXXeKRVSdz+99
 hE75rsZuAcVtsk/FXhkrSv82WDhp612Gf9b9FcceP5sbbrpjVnkn15FNWn2vW79ct2SdaWGx+oi
 0PAcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes a modpost warning visible in -next from check_bugs()
and helps avoid a potential, albeit unlikely, warning from
check_bugs_early().

---
Changes in v2:
- Now two separate patches: one to avoid current check_bugs() warning
  and one to avoid potential check_bugs_early() warning.
- Sink body of check_bugs_early() into setup_arch() directly, rather
  than marking it as __init (Nick).
- Add Naresh's reported-by to patch 1, which came after v1 was sent.
- Reword commit messages to note that there is not a problem at run time
  because check_bugs() and check_bugs_early(), while not marked __init,
  are only called from __init functions; modpost does not know this
  though, hence the warning.
- Link to v1: https://lore.kernel.org/r/20230419-mips-check_bugs-init-attribute-v1-1-91e6eed55b89@kernel.org

---
Nathan Chancellor (2):
      MIPS: Mark check_bugs() as __init
      MIPS: Sink body of check_bugs_early() into its only call site

 arch/mips/include/asm/bugs.h | 8 +-------
 arch/mips/kernel/setup.c     | 3 ++-
 2 files changed, 3 insertions(+), 8 deletions(-)
---
base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
change-id: 20230419-mips-check_bugs-init-attribute-026103bdb255

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

