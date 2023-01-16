Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00966B84F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjAPHjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjAPHi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:38:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6455BA
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:38:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE7C560ECC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBBAC433EF;
        Mon, 16 Jan 2023 07:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673854735;
        bh=hGkAuM1wsrP/rKI77ybxsAx4D4SSyg0EvajNB+hLnDM=;
        h=From:To:Cc:Subject:Date:From;
        b=OTmObwC5u5eBy9nVs0ctz4+zKQXFVwn1tHK5PHVdPKcM2XELGKyhHP0coAbcD4x2o
         62hqNTRDceOLlPYU/79owcd+1n7m+vZw0houlyhV5/jqyTd/dBXTVJ2spKe4gj9rTJ
         V2C4lLX794g+j6SSiGZ/rUY6XkkaS0Whew+ajsDHZFl1W7C2kPoDGrjKBhJlekVfpr
         XCTnLwoIalXrh00DwV/NRIVIpw8W1abpODOFiWuIIoEPvp0WJ+CnwI3eRel5Rh/Isx
         RWUx8UtcBZl7iGot8mAot2H4GU7sLOhEBCv3Wd4dx8r2FQifvz9766Y3hdkD3/KXTr
         NS7N1PsQ3V33Q==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: Dump faulting instructions in oops handler
Date:   Mon, 16 Jan 2023 08:38:32 +0100
Message-Id: <20230116073834.333129-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

RISC-V does not dump faulting instructions in the oops handler. This
series adds "Code:" dumps to the oops output together with
scripts/decodecode support.

Thanks,
Björn

v1->v2: Dump instructions in 16b parcels (Andreas)

Björn Töpel (2):
  riscv: Add instruction dump to RISC-V splats
  scripts/decodecode: Add support for RISC-V

 arch/riscv/kernel/traps.c | 25 ++++++++++++++++++++++++-
 scripts/decodecode        | 12 +++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)


base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.37.2

