Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164A6DCDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDJXMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA653212F;
        Mon, 10 Apr 2023 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168301; x=1712704301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1nnA3+UMtwhKXHQJhoeke18gc8xz62Yzi4vhC4igcco=;
  b=fVnt/qm4yLQ85OxedmG0vaSltMnLh+2DmHnNgZxmDENXUfKHf/17OAHI
   4xYD+JUnLL0BdFAEGJDPX6GKoc/M5JvX7fPd/yQcTVkZtlgiuhtJ96JJm
   590OJtTXuR1wYN6BAem5G+l7CzNy4DWSjy29YMDD0jaGXab1doHttpCuG
   h1NmlLcaTTHOS4vLuQSuxb5O4H+nXPqPeuz2dnA6imcw5WOd3J+RhRilt
   nstoBWUqSn+CcJS8VE/ITJh3YW2isGxgCfqMCc7dAN+xWKbqP0FhBHDnE
   KTe+VySHN0XReTqjPWfWKfeDUMmhkThjuSf3izMZs/xfQuCzpyNjNEjl7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962518"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962518"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757607996"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757607996"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 16:11:39 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 03/12] x86/insn: Add Key Locker instructions to the opcode map
Date:   Mon, 10 Apr 2023 15:59:27 -0700
Message-Id: <20230410225936.8940-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410225936.8940-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following Key Locker instructions to the opcode map:

LOADIWKEY:
	Load an CPU-internal wrapping key.

ENCODEKEY128:
	Wrap a 128-bit AES key to a key handle.

ENCODEKEY256:
	Wrap a 256-bit AES key to a key handle.

AESENC128KL:
	Encrypt a 128-bit block of data using a 128-bit AES key indicated
	by a key handle.

AESENC256KL:
	Encrypt a 128-bit block of data using a 256-bit AES key indicated
	by a key handle.

AESDEC128KL:
	Decrypt a 128-bit block of data using a 128-bit AES key indicated
	by a key handle.

AESDEC256KL:
	Decrypt a 128-bit block of data using a 256-bit AES key indicated
	by a key handle.

AESENCWIDE128KL:
	Encrypt 8 128-bit blocks of data using a 128-bit AES key indicated
	by a key handle.

AESENCWIDE256KL:
	Encrypt 8 128-bit blocks of data using a 256-bit AES key indicated
	by a key handle.

AESDECWIDE128KL:
	Decrypt 8 128-bit blocks of data using a 128-bit AES key indicated
	by a key handle.

AESDECWIDE256KL:
	Decrypt 8 128-bit blocks of data using a 256-bit AES key indicated
	by a key handle.

Details of these instructions can be found in Intel Software Developer's
Manual.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v1:
* Separated out the LOADIWKEY addition in a new patch.
* Included AES instructions to avoid warning messages when the AES Key
  Locker module is built.
---
 arch/x86/lib/x86-opcode-map.txt       | 11 +++++++----
 tools/arch/x86/lib/x86-opcode-map.txt | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 5168ee0360b2..87e9696c47d2 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -800,11 +800,12 @@ cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
 cf: vgf2p8mulb Vx,Wx (66)
+d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: vaesenc Vx,Hx,Wx (66)
-dd: vaesenclast Vx,Hx,Wx (66)
-de: vaesdec Vx,Hx,Wx (66)
-df: vaesdeclast Vx,Hx,Wx (66)
+dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
+dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
+de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
+df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -814,6 +815,8 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
+fa: ENCODEKEY128 Ew,Ew (F3)
+fb: ENCODEKEY256 Ew,Ew (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 5168ee0360b2..87e9696c47d2 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -800,11 +800,12 @@ cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
 cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
 cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
 cf: vgf2p8mulb Vx,Wx (66)
+d8: AESENCWIDE128KL Qpi (F3),(000),(00B) | AESENCWIDE256KL Qpi (F3),(000),(10B) | AESDECWIDE128KL Qpi (F3),(000),(01B) | AESDECWIDE256KL Qpi (F3),(000),(11B)
 db: VAESIMC Vdq,Wdq (66),(v1)
-dc: vaesenc Vx,Hx,Wx (66)
-dd: vaesenclast Vx,Hx,Wx (66)
-de: vaesdec Vx,Hx,Wx (66)
-df: vaesdeclast Vx,Hx,Wx (66)
+dc: vaesenc Vx,Hx,Wx (66) | LOADIWKEY Vx,Hx (F3) | AESENC128KL Vpd,Qpi (F3)
+dd: vaesenclast Vx,Hx,Wx (66) | AESDEC128KL Vpd,Qpi (F3)
+de: vaesdec Vx,Hx,Wx (66) | AESENC256KL Vpd,Qpi (F3)
+df: vaesdeclast Vx,Hx,Wx (66) | AESDEC256KL Vpd,Qpi (F3)
 f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
 f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
@@ -814,6 +815,8 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
+fa: ENCODEKEY128 Ew,Ew (F3)
+fb: ENCODEKEY256 Ew,Ew (F3)
 EndTable
 
 Table: 3-byte opcode 2 (0x0f 0x3a)
-- 
2.17.1

