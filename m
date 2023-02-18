Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3C69BDFD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBRXmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBRXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:42:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034213DC1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 15:42:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676763747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZfNxsI7L8MCxv+cU8Wm5VrQr4Yl+lq86a4e/TvMo7s8=;
        b=YEjO+F9jV+WouyWEYIOdTnZSCBrQC0S9v4VgopnUa90uKEQorkF2s6VxUSS/pIeDE4wiHS
        aaf6CS3qLQcvvjIvKzNYv4igjpw9sZGXnC+75ToRnxbdsBqyDhhLr+TxwZwmW/80Kb1lM2
        QCY0WaxfXJVDQVxvS8Y9Jcr2dIbaciYkD8cp17BWL9MZK45gfbjX2SWbaqVG9ghNL81JCj
        CtB7fwhxqPx2XbgLcK26RRWq2OFl/uiAXherhoTRnv0+1azApQqn1Ie+C5uExg0/dlKMvq
        cxppJKrj10lDoEILYWDKxQwPCWwbb2RiLakq2P1jaMs7aLYt6YNJTUVDvriu9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676763747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZfNxsI7L8MCxv+cU8Wm5VrQr4Yl+lq86a4e/TvMo7s8=;
        b=nrg2yKh6c+lOBcS4UsMfUzSWAkRjoo7b/FWeGpNWXknhCyntZNgsCg1HljNmKhiCGMR5+W
        Vh13pLoSENDUqBBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.2
References: <167676366161.269954.1941292974323519398.tglx@xen13>
Message-ID: <167676366450.269954.1214202439225962646.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Feb 2023 00:42:26 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-=
02-19

up to:  f9f57da2c2d1: x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr=
_type() for MTRR disabled case")


A single fix for x86:

  Revert the recent change to the MTRR code which aimed to support
  SEV-SNP guests on Hyper-V. It cuased a regression on XEN Dom0
  kernels.

  The underlying issue of MTTR (mis)handling in the x86 code needs some
  deeper investigation and is definitely not 6.2 material.

Thanks,

	tglx

------------------>
Juergen Gross (1):
      x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR=
 disabled case")


 arch/x86/mm/pat/memtype.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index fb4b1b5e0dea..46de9cf5c91d 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -387,8 +387,7 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 		u8 mtrr_type, uniform;
=20
 		mtrr_type =3D mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type !=3D MTRR_TYPE_WRBACK &&
-		    mtrr_type !=3D MTRR_TYPE_INVALID)
+		if (mtrr_type !=3D MTRR_TYPE_WRBACK)
 			return _PAGE_CACHE_MODE_UC_MINUS;
=20
 		return _PAGE_CACHE_MODE_WB;

