Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4D718325
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjEaNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbjEaNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF529E7B;
        Wed, 31 May 2023 06:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE4FF636E2;
        Wed, 31 May 2023 13:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C759C4339E;
        Wed, 31 May 2023 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540631;
        bh=rJ4/TuBUV7TUlNl0eyT+AG9mKGL/fA+RhX3jj2Jg250=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNey6RTXfn4DBVlw3RYHPtkXaK2E33Jpgrd56qTpOVCnElj1QzngW43tlRfvcZC9E
         RM5K7+59GE2oGrRoDols8wFCsiOwXQN47ph4dj2NhwngGFoumhe/E1Lmw+fa+nwCQm
         U47oROFOvWUzJEP36KAxwDK5RCj+y8J1zlTfkTLSddYiYIfB8bt8IfD/HKzW0yDqap
         yqASKQsMwEg9auggxBqBqHpmFhzAtEruCc/vNr6whJUs5acPpuJGkuh1sbcUN1EglA
         hibcTvrzOrtRRm00NIfmGI/yaHeCh3iWIgSQmWaTBjKI8Egd5JFlK5Hv5Lj2b7MZ23
         x1k7YvvXmQnGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, jiaxun.yang@flygoat.com,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 18/24] MIPS: Restore Au1300 support
Date:   Wed, 31 May 2023 09:43:14 -0400
Message-Id: <20230531134320.3384102-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
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
index 7c861e6a89529..df40880d84495 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1565,6 +1565,10 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		}
 		break;
+	case PRID_IMP_NETLOGIC_AU13XX:
+		c->cputype = CPU_ALCHEMY;
+		__cpu_name[cpu] = "Au1300";
+		break;
 	}
 }
 
@@ -2005,6 +2009,7 @@ void cpu_probe(void)
 		cpu_probe_mips(c, cpu);
 		break;
 	case PRID_COMP_ALCHEMY:
+	case PRID_COMP_NETLOGIC:
 		cpu_probe_alchemy(c, cpu);
 		break;
 	case PRID_COMP_SIBYTE:
-- 
2.39.2

