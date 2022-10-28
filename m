Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6758611486
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ1O1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiJ1O1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:27:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6900303CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:26:47 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF1981EC0523;
        Fri, 28 Oct 2022 16:26:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666967205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=el2mP9InyE78h3IW1FW4zNaQQl77po30/ZmCSwmJRyA=;
        b=inb0PmBlddp4Z44qCNETn+PC8IH7lcHE/lsanimeD0H9l9VMVrw6DnI34koqHZOwerThgs
        J8DIQ6SifUpRbeW+lyNFKBus7xUe0dRFZU82MoI6gLKive+EzUziTy02o4gRSGCfewMc4U
        UgWnhsF7x2qhlwa9AEqzjTxLKmX6uIM=
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] x86/microcode: Clean up the init path
Date:   Fri, 28 Oct 2022 16:26:33 +0200
Message-Id: <20221028142638.28498-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The microcode loader init path had a lot of old and unnecessary gunk.
Rip it out.

No functional changes.

Borislav Petkov (5):
  x86/microcode: Rip out the subsys interface gunk
  x86/microcode: Simplify init path even more
  x86/microcode: Kill refresh_fw
  x86/microcode: Do some minor fixups
  x86/microcode: Drop struct ucode_cpu_info.valid

 arch/x86/include/asm/microcode.h      |   4 +-
 arch/x86/kernel/cpu/intel.c           |   1 -
 arch/x86/kernel/cpu/microcode/amd.c   |   5 +-
 arch/x86/kernel/cpu/microcode/core.c  | 205 +++++---------------------
 arch/x86/kernel/cpu/microcode/intel.c |   3 +-
 5 files changed, 43 insertions(+), 175 deletions(-)

-- 
2.35.1

