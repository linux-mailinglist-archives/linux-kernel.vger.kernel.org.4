Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028D162F2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiKRKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbiKRKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:44:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF9C11A23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:44:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41D7DB822D8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D930C433C1;
        Fri, 18 Nov 2022 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668768282;
        bh=Zsivvvk2gpJhrY509GmGOEwieY9oWQM8lDocUkP/2WY=;
        h=From:To:Cc:Subject:Date:From;
        b=g6exTW6ru7T3Sfj15Q+RujKe7pFAl5kXHnNkTwImEVhEN1SZ3LevD0ynzCibr16ye
         t5vsPUl0vmigv0Aw0HYAWm5/hI6LSS0O41OMQctBXQi2OGOea7A58yoDb5rgPjbSn1
         x9JgSWTbcUrGXhAxbTB5F7hU4BEL0TMr2zMq8gc8mtBpKQMUR9np1b7lfTd3IpI/Hy
         eX6SElZXYmzaGKeberzF7A/TsZ8YrfA9RfFV2LmhKprOcAJsgGk4yqbVLZ/7nF404G
         bojFIYTR7xn4QQ2O28bh1edjtunSNcJRmPFuz1BxsvinNYorJq50TrI9LVxwC3aEMb
         ubt006J7kNhTg==
From:   Conor Dooley <conor@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 0/3] RISC-V interrupt controller select cleanup
Date:   Fri, 18 Nov 2022 10:42:58 +0000
Message-Id: <20221118104300.85016-1-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey Marc, Anup, Palmer,

Submitted a patch yesterday defaulting the SiFive PLIC driver to
enabled [0], and in the ensuing conversation Marc suggested just doing a
select at the arch level and dropping the user selectability completely.

Since we're already selecting SIFIVE_PLIC in Kconfig.socs for all of the
supported SoCs & selecting RISCV_INTC in the arch Kconfig itself,
patches 1 & 2 can go via the irqchip tree without any impact.

@Anup, by the same logic - I think we can also enable the AIA stuff via
selects at the arch level? Dumping as much from Kconfig.socs as possible
is the plan, so adding them there for SOC_VIRT kinda goes contrary to
that.

I spoke with Palmer today about putting my various bits of Kconfig.socs
cleanup on a branch, so I'll take patch 3. It's only in this series as
it is related work, rather due to any sort of dependency between the
patches.

Thanks,
Conor.

[0] https://lore.kernel.org/linux-riscv/86wn7tnx9a.wl-maz@kernel.org/

Conor Dooley (3):
  irqchip/sifive-plic: remove user selectability of SIFIVE_PLIC
  irqchip/riscv-intc: remove user selectability of RISCV_INTC
  RISC-V: stop selecting SIFIVE_PLIC at the SoC level

 arch/riscv/Kconfig      |  1 +
 arch/riscv/Kconfig.socs |  5 -----
 drivers/irqchip/Kconfig | 21 ++-------------------
 3 files changed, 3 insertions(+), 24 deletions(-)

-- 
2.37.2

