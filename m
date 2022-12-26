Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966DE65629F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiLZMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:39:55 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F3F55A3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XYnRF2VTmU+021Ef+kG+wnbau/xKv0SAMZ8szpiVoo0=; b=ggrjntgsxEcg923Bln5EMx4Iob
        W9k+F8FdIb3izvp3dpwhrRUTY1RjjaLVectHd11mYicNslFwiR2AvoIqFJV/mwTuJaBFwfvAxn1gl
        5dzmAOgk0GoM4znTksBNOyLwit5G4BYF5y+C8u6HRdRD1mFbWlK0j1WBwkOekMsJ49hg6dwualMSY
        XUhzVL9zaDjPzBjKAB+I610yQMiH7O2kLeQbCHYDIwyyicP53OEzIkxpNJoz3AzarlDTXHOmeTls1
        D/jDEfcBvJwBlRCPbd8IG7DAMTxc+HT9+slFdBmwjG6FzxKtuuqUurbMyaiaOw2Dqz6EJKZH8Et1M
        tp4E/U8Q==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1p9mlE-007wbn-0K; Mon, 26 Dec 2022 12:39:19 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anuradha Weeraman <anuradha@debian.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: add header to fix missing-prototypes warning
Date:   Mon, 26 Dec 2022 18:08:48 +0530
Message-Id: <20221226123850.531597-1-anuradha@debian.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=515; i=anuradha@debian.org; h=from:subject; bh=DwJB0IVKOiC0n6AJBGdJoHiNy0IOX/udDymd15Ulb+U=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBjqZXZu9SegvyM4xNIMD7i/cUt6nwVgqGb7ZGi+Zt1 AqiHIQSJAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCY6mV2QAKCRBjbbWh2Rhg/dhBD/ 98kIEmsqkrAyiKCns7DeNakVkeBF3YAmvtmCjXnLbKMVqh0+OSDM9/gC2zwhhUsDOGb8q4M5PJqUJH Kvk5gjrRXuhLziyWY+CJKUXlwaNc6Pacha+YRXkiBIJZyMqc0pGeCiSn2j97Xhv8WsyKOkd1i1fPKr 9ucnFYeg9eZSmkRF1iejiX6hxmC/1xCGiLYcLX9TO/rmaA58mxBsfQHhoctDv07UxDncJ6GoHD1JtL vtAUHs7XI6duvanQhKxM8VBiQkUzWsqjiCHrML7ukVjOwkQrmVc0DRTX4st9u220AGhLX3ZV3kT/K4 f/2Y4LHAMGN+yMS2HCYhSe/Ic5X/34sp6/wpOYhAny3A/NXHxiyvhcgZsxKz9snkZ2oZuz5KwSKWbo 5Td1ljRphYkE0Hlj6/0V3KELzwz/eGpVX4v6sC17Tz+kRZnVr/0tKUHx6Av92fY/ZzYfOB7Ea2Ie5Q n6jAfXH/2EoSB4qJhnZecVVnYnjcrUkV+VONOrAzen6/NzzfeN9JlelqAZ/wvHGoBlGYO7L/zfUwIb y6joYCms97QCef5X8MU5gKkdjMs+KTGgZd8dkscrP7fCIhRNF0aooZ7FLCCxvF/0axErbbAseSKkI5 PAiqcMLSTQn8/xPHVBr+4jcBMLyPWqFn7M93MTZ+SKAjCZzJu75nz7dMBqDA==
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

