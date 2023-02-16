Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD34699491
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBPMle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBPMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:41:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19510F3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:41:32 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A66711EC0930;
        Thu, 16 Feb 2023 13:41:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676551290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=yknwMfWqTf5eyJox4GKcMbuJh77tfAxUiWzzn4pkdpM=;
        b=q+S0UTe9xZhM0Ft5LzYbHjMi2xYADfQoXTP0z3zNnxpJX7z81Swk3GwKZFotKy7ypP29RH
        LvK2hL5Q5IgNuh5wI6ZcrmuX2fNzdd83poWAZ5XLO76zDa8VzPtOyYswj0tcqKc9hcgLOd
        pXlbM7P+UADEHtahDxPmk+N/4VvbpDQ=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: [PATCH 00/11] SEV: Cleanup sev-guest a bit and add throttling
Date:   Thu, 16 Feb 2023 13:41:09 +0100
Message-Id: <20230216124120.26578-1-bp@alien8.de>
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

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

so I've been looking at Dionna's patches adding the SEV guest throttling
and that request issuing spaghetti was getting on my nerves. And it
would've become even worse with more stuff piling ontop so here's
a first round of cleanups before adding more stuff and making it an
unmaintainable mess.

The final result is a lot easier to read with proper separation of
functionality between functions. I want to get rid of more input/output
params being passed back'n'forth and use a struct instead and Nikunj's
patches have stuff which goes in that direction but first things first.

After the cleanup, the new stuff being added is a lot less code and
almost trivial. But I've been staring at this for a while now so it
could be only me who thinks it is trivial now. But we'll see.

Initial smoke testing seems to work ok but I might've introduced some
funky bugs, ofc.

Comments and suggestions are appreciated, as always.

Thanks and thanks, Tom, for the help!

Borislav Petkov (AMD) (7):
  virt/coco/sev-guest: Check SEV_SNP attribute at probe time
  virt/coco/sev-guest: Simplify extended guest request handling
  virt/coco/sev-guest: Remove the disable_vmpck label in
    handle_guest_request()
  virt/coco/sev-guest: Carve out the request issuing logic into a helper
  virt/coco/sev-guest: Do some code style cleanups
  virt/coco/sev-guest: Convert the sw_exit_info_2 checking to a
    switch-case
  crypto: ccp: Get rid of __sev_platform_init_locked()'s local function
    pointer

Dionna Glaze (3):
  virt/coco/sev-guest: Add throttling awareness
  virt/coco/sev-guest: Double-buffer messages
  x86/sev: Change snp_guest_issue_request()'s fw_err argument

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   |  20 ++-
 arch/x86/include/asm/sev-common.h       |   3 -
 arch/x86/include/asm/sev.h              |   4 +-
 arch/x86/kernel/sev.c                   |  33 +++--
 drivers/crypto/ccp/sev-dev.c            |  22 +--
 drivers/virt/coco/sev-guest/sev-guest.c | 169 +++++++++++++++---------
 include/uapi/linux/psp-sev.h            |   7 +
 include/uapi/linux/sev-guest.h          |  18 ++-
 8 files changed, 181 insertions(+), 95 deletions(-)

-- 
2.35.1

