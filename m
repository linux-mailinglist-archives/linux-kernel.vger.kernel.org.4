Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363A6A61D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB1VzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1VzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:55:03 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F532E61
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:54:54 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pX7vm-0005hs-FY; Tue, 28 Feb 2023 22:54:42 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu, heiko@sntech.de,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC 0/2] RISC-V: T-Head vector handling
Date:   Tue, 28 Feb 2023 22:54:33 +0100
Message-Id: <20230228215435.3366914-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

As is widely known the T-Head C9xx cores used for example in the
Allwinner D1 implement an older non-ratified variant of the vector spec.

While userspace will probably have a lot more problems implementing
support for both, on the kernel side the needed changes are actually
somewhat small'ish and can be handled via alternatives somewhat nicely.

With this patchset I could run the same userspace program (picked from
some riscv-vector-test repository) that does some vector additions on
both qemu and a d1-nezha board. On both platforms it ran sucessfully and
even produced the same results.


As can be seen in the todo list, there are 2 places where the changed
SR_VS location still needs to be handled in the next revision
(assembly + ALTERNATIVES + constants + probably stringify resulted in
 some grey hair so far already)


ToDo:
- follow along with the base vector patchset
- handle SR_VS access in _save_context and _secondary_start_sbi


Heiko Stuebner (2):
  RISC-V: define the elements of the VCSR vector CSR
  RISC-V: add T-Head vector errata handling

 arch/riscv/Kconfig.erratas           |  13 +++
 arch/riscv/errata/thead/errata.c     |  32 ++++++
 arch/riscv/include/asm/csr.h         |  31 +++++-
 arch/riscv/include/asm/errata_list.h |  62 +++++++++++-
 arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
 5 files changed, 261 insertions(+), 16 deletions(-)

-- 
2.39.0

