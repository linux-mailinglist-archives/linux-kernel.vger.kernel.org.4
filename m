Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD2718405
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjEaN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbjEaN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BA3A81;
        Wed, 31 May 2023 06:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B626C63B90;
        Wed, 31 May 2023 13:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744B2C4339C;
        Wed, 31 May 2023 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540681;
        bh=hncwNqVEXm8eqkHXtyGq34ysexxS31Duz4VWZsXkbTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqG/bKpj00rVVAe0kiH5kSrNwP7J87jSoKrt152yW7f2qt8gZgXc+sCXrVQg9UOJS
         cpkPnnRbSyXrI1XP+C0tlz+DDGeJZkTyhv8HAmTo4iQIn4F83Lgs0XJosVs6J5vPPb
         EHm50kfMUtbFPiUVMKHWXMCLdgC5KmQVptVM8e12l0ddcvYZhXZ1TH++EChMqQG+zt
         LfchhXaG8auqTQD+Gee6qheeHFAffKbkKgVgoZD3E7lKbQoHV03JX2YJB1cYCepKSE
         /lGYuLrpfN6dIQV1kCtqcXdnWJ+HUthcqe5WkGO4NkxZyaFFtO6jtPozYb20n/3Rjn
         HfxZM23i3smjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, jiaxun.yang@flygoat.com,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/21] MIPS: Restore Au1300 support
Date:   Wed, 31 May 2023 09:44:09 -0400
Message-Id: <20230531134415.3384458-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134415.3384458-1-sashal@kernel.org>
References: <20230531134415.3384458-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manuel Lauss <manuel.lauss@gmail.com>

[ Upstream commit f2041708dee30a3425f680265c337acd28293782 ]

The Au1300, at least the one I have to test, uses the NetLogic vendor
ID, but commit 95b8a5e0111a ("MIPS: Remove NETLOGIC support") also
dropped Au1300 detection.  Restore Au1300 detection.

Tested on DB1300 with Au1380 chip.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/cpu-probe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d120201910acf..954ef0513c404 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1555,6 +1555,10 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		}
 		break;
+	case PRID_IMP_NETLOGIC_AU13XX:
+		c->cputype = CPU_ALCHEMY;
+		__cpu_name[cpu] = "Au1300";
+		break;
 	}
 }
 
@@ -1992,6 +1996,7 @@ void cpu_probe(void)
 		cpu_probe_mips(c, cpu);
 		break;
 	case PRID_COMP_ALCHEMY:
+	case PRID_COMP_NETLOGIC:
 		cpu_probe_alchemy(c, cpu);
 		break;
 	case PRID_COMP_SIBYTE:
-- 
2.39.2

