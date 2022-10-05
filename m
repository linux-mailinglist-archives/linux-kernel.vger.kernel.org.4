Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432075F58E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJEROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJEROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:14:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9447AC09;
        Wed,  5 Oct 2022 10:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D3A613B3;
        Wed,  5 Oct 2022 17:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FDEC433D6;
        Wed,  5 Oct 2022 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664990060;
        bh=S7lanKefy2QFD+FZGym2xa09dQhswcpvM+aMfQCBD6A=;
        h=From:To:Cc:Subject:Date:From;
        b=JNhRka/j3w5RiAe4UWem3JUqCcvreXsTgbls5sa7bj7BFK7gBZMI3GnGJ9bA3tuzB
         DDvZGrE3lkmRD7DrenlFaoRYiZzZJUXW0VV+Baov/O+AH58A0E3WHmvdtLl3Asjs9X
         fGhngqpQqZDBYeBIE7RUfByNqkW8RTceirUQ6We5Rk0GLuU3yoCgPsPFt1S19XT3VF
         +DPt1rIp7ntRvypF0MPnGrCl203m5onaelnqwZe0YByskynOZpEfSDvTzGjTe1BpdC
         J3r+gcGaeNbpxkd6OnncazOf085GrXIakFtgNu292aeHKSW5MdzNQpIHWRT4fDWUCq
         cvnKVGMZbZqDQ==
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 0/6] RISC-V: stop selecting device drivers in Kconfig.socs
Date:   Wed,  5 Oct 2022 18:13:43 +0100
Message-Id: <20221005171348.167476-1-conor@kernel.org>
X-Mailer: git-send-email 2.37.3
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

As my RFC [0] series doing the symbol name changes has not yet reached
consensus, I've split out the removal of device driver selects into a
new series. I kept the plic as a direct select - although given how Maz
is treating the SiFive plic driver as the RISC-V plic driver, maybe that
should just be selected by default at an arch level...

I assume the individual patches can go via their subsystems & I'll
resubmit the arch/riscv patches a cycle later? I'm not in any rush.

Thanks,
Conor.

0 - https://lore.kernel.org/linux-riscv/20220923185605.1900083-1-conor@kernel.org/

Conor Dooley (6):
  clk: sifive: select by default if SOC_SIFIVE
  serial: sifive: select by default if SOC_SIFIVE
  serial: sifive: select by default if SOC_CANAAN
  riscv: stop selecting the PolarFire SoC clock driver
  riscv: stop selecting SiFive clock and serial drivers directly
  riscv: stop directly selecting drivers for SOC_CANAAN

 arch/riscv/Kconfig.socs    | 8 --------
 drivers/clk/sifive/Kconfig | 4 +++-
 drivers/tty/serial/Kconfig | 2 ++
 3 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.37.3

