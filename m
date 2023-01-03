Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1165B9DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjACDr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACDr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:47:57 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A3126FC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 19:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XYnRF2VTmU+021Ef+kG+wnbau/xKv0SAMZ8szpiVoo0=; b=WZS9v5msAugTHfs/yjDkNzmONn
        A2aAqdnM8b+Ml422qzCWG475MdDpIbyiJrEOnlLdS7FF2Nal0O5d2zkfjsMe2KUcHiiM38hx6AdXA
        ek+1QQ/GdiXeq1H1OSP7QJLG2XopoOKrfrzlEapM4tyoV2cLHRbdt5bu/6k+33sGLG2PplUN1Ikf2
        KYZ8xKW37sS/L7BPB9D+mc7DcUnE33sk1QE44xkVgAHmF2Cx1dabq/VD70fFs9rmFcdHm7+JWe4BE
        kBK4PK/jlHNzTdi+ECt9WlnPy1XwqM399imNh/WgtKkehTHWeMOSMPreuzKsUnf8ODqQ26eUwj6iO
        Dz5pDSWw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pCYGv-00EegT-1e; Tue, 03 Jan 2023 03:47:29 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     anuradha@debian.org
Subject: [PATCH] x86: Add header to fix missing-prototypes warning
Date:   Tue,  3 Jan 2023 09:16:34 +0530
Message-Id: <20230103034637.74679-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=515; i=anuradha@debian.org; h=from:subject; bh=DwJB0IVKOiC0n6AJBGdJoHiNy0IOX/udDymd15Ulb+U=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBjs6UbJs3iZkq11WXm7G8mObAdLjGHMXpjIN4BPHoG 3g1Q2V6JAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCY7OlGwAKCRBjbbWh2Rhg/QWpD/ 9ElrMwX+PfTq9cLeEJWIEDG8wtK/1tCux8B3KRt3K5+Kj4q3F9a0VIZg4pMPMyGF7swmrTXNAQqBkx +RC+pxBo1ZKO1Gn9V5kigK7PPZS/wZAk3cQ2ZrBw0Qjc2CsljDqCVmmTCgKW7BfcqNtGKe8KyS7LaP JOmFzlBMHIfmrSAQDny0mgg+ubxW1tk9q5RJjZYcVos/P7fIvhhakw0TFDAIzAZPSTPClsKBtSP+Av fSwSKFDUf3t8sqHVz9fIPDyc32yW7JALe05IJwWN1sOBf4Qy7LmUF2dXvGBGVL8pK5nKZiYgllumF0 6pJ57+p4Z3yrwIULnFrsoi196aB6/8fUteGGfZXDpH2ZiRsvzTxfaF/i7m2coqi/t/WkDjBcSoTt9y R7n7wwzfNDe6yIq0I5Fh1SMo1NoO6KHNk/nNOo1sas7HFhxGO1lhpP7uKFJ84uF5zk3PnwgSLvytvG BBIbFzJp1DHZ0jr+BDzsjeSsCa4cmLrrfmNEgZZo5niO03lsdzBYVv0WgbNLg3HB5XesBle9ExAqu2 +tfYjrqraNA/YHjFIbMWFpmGdHAB8EwSzDhj0vpo4o5VS3pq//MJR3BCpXTwJmFA79BUUlOVvWYyTc WcIoOrJ39+kDAkV7m2cgFmYpLOWFdwugDrqwwJQrkziMvEGRAWl2rdoAU8yQ==
X-Developer-Key: i=anuradha@debian.org; a=openpgp; fpr=F56B8F14E014CDEF5D047FC1636DB5A1D91860FD
Content-Transfer-Encoding: 8bit
X-Debian-User: anuradha
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Included <asm/misc.h> to fix a missing prototypes warning at build time.

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 arch/x86/lib/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/misc.c b/arch/x86/lib/misc.c
index a018ec4fba53..92cd8ecc3a2c 100644
--- a/arch/x86/lib/misc.c
+++ b/arch/x86/lib/misc.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <asm/misc.h>
+
 /*
  * Count the digits of @val including a possible sign.
  *
-- 
2.35.1

