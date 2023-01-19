Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C8674BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjATFHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjATFGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:06:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04131C45B7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:54:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91DB9B82107
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D872C433EF;
        Thu, 19 Jan 2023 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674114489;
        bh=UBy2lf9QPDUeI0P/AEbXMIS0GaU0lPZlJILHV4CWMg4=;
        h=From:To:Cc:Subject:Date:From;
        b=VFmIGrptY9lhoeESaA20rr5/B9gyn6+sATEFSRU3aF91619O2dyuZLtA4Ggyn+XQk
         0XYIYgn42+x2JKX+VlHArb4bnjlYgPoNPMAip/72+dTqV5/eE5KkpdsZzFNRzg2JGp
         JkxEu4h0BQzBLNusHMQWihe5ix4ge0fBo2LiMI1cpfPDcnVI0sJvGzdljT3jSrjm6x
         hRBkp7t277aWYHKjMMqxAtS+4W671zwUz4DJ407w0uIblfuVSQiN9INl8IvC2RiqQv
         T542/nwJ4X4ySTV0GXKUF8ItVvz4v4zbB640zrcrLA84UsW9HbExXDIROIuogQ1iUS
         hiIJb9uifrb2g==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] riscv: Dump faulting instructions in oops handler
Date:   Thu, 19 Jan 2023 08:47:36 +0100
Message-Id: <20230119074738.708301-1-bjorn@kernel.org>
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

v2->v3: Simplifications/getting rid of casts (Geert)
v1->v2: Dump instructions in 16b parcels (Andreas)

Björn Töpel (2):
  riscv: Add instruction dump to RISC-V splats
  scripts/decodecode: Add support for RISC-V

 arch/riscv/kernel/traps.c | 25 ++++++++++++++++++++++++-
 scripts/decodecode        | 12 +++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)


base-commit: 7287904c8771b77b9504f53623bb477065c19a58
-- 
2.37.2

