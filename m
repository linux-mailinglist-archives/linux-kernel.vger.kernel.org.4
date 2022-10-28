Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EDB610E00
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJ1J6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJ1J5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B936B4BA65
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951058; x=1698487058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JydiMbJm91qt7Dzdbzqgf9FuIhgVG9u78TP21lC8mbE=;
  b=KcqwFCXt6O6YYo0VqzY0Me9E/fyCCDsQ5pS6d+uchlsR6pfAYcE38KaH
   zL3Nyd6VCNkwgENEYAkiYiRYf5L4+YWCLZ//qUgVFZcBkqtTgeR7KZ9im
   M/LbwmdZOXbQARep2jIoOIFyzyqNQuoubb+9Aaql0hyGJF9jTP7sY4PBv
   B+Y7TmIxwg9NunNhk4knfd+8Y3FY/WTV7WX2nOIaMURQg5NwbM10PYy+U
   KYL44YTXUCoVez0Q7+oe+6ssLd/FHqir3gsvO3bet5bC4GPnCpXJxFTkm
   cbwshbucx7Y00TvIfuVlD5LMhU097Mc47QyQsI+ulhh7du69UdgPkK2kP
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="327068528"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:57:37 +0800
IronPort-SDR: aVnYPSrmKr4bWmI4qyDuy+K3i84Aflr90WQnTX6VLCTC1wMv/NdL+iqYo4LT4774+2zoJ5n/1p
 B7dGqFRgMfepGdqmyBIQUwa/25/iJjJkm0fZtUfQKiTMIUolM6GiseJK2ZLf9ZAxxnbNQZOPUL
 hgpk1g83tnPFYipT1EWiS0kVUMSQKtxTvMN2akXrA0eAC0LmqPvZzsAn0OxIj1LBTySbHq0LN3
 IK/gVJ9xS1Sor5sicwDYmkpUrb/Om5velLX7b+wCf7QFJ9ZjWQyz4ipbjiadQodCOG4DRQ+MRe
 d8MCESJeKCKanq3jcP2iduRs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:11:14 -0700
IronPort-SDR: OkxcFIkieMD7AV5nA6FtG9LqsBVlqL6u4VB+xMqHYZnXllmjW/gLasypTY2jm6kg7sFyjMYQs/
 YW339jqmZLO63PumM/azGNhmw3apMMCZGqFq326JSoHfOJt9m/sJkGDBu2aMVjympnQz6OQxu1
 GwxVpsHqbiyoQ7O+a7zwuuSvr29Bz2S6OJcTf8E5ms0Ap1GoSh+Wyryo++/LUOrq1usxOdDqjG
 BrSxDm3fY75qsYkcBKFRVoRBDmV3hI//yiRNhQvZDWTOhh9667d4xB8j7YsFNfIhYEP1KOiRYp
 SRM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:57:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHz45yL5z1SHkN
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951055; x=1669543056; bh=JydiMbJm91qt7Dzdbz
        qgf9FuIhgVG9u78TP21lC8mbE=; b=j4RPkeDxD2OMqX5Kxa/3L32kWsZVpnmHr6
        BX+yIlhNHMvGj8A/k3T1hWRpUdDmrQWD7bum2uaSPmy7PgQtfwWQh9jsrpx9aLai
        twJ3Qb4KRS3qMqAY5VyHySyh/tP8wknTEYHCs061Qq7tKyih2RzCagzYSo+nsAQH
        dvvF8wU4J247DKqVq+cPiysOHuqw5sByri8/ct5ZjmjXPD6smYx/xm7TL4i5AZvh
        i539ZC1YkSepuErIJctkmpHBUR4i5HAeJgJKBBDQ/doWP8SbVzFX+EErBI3DA9hF
        vGgkNwGT29RTkowIHP/Zy/Wu4zNaPL+MlyFdv2ud1IqiEU2U1i/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8d7oQvq_s8MR for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 02:57:35 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHyy43gyz1RvLy;
        Fri, 28 Oct 2022 02:57:30 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, dave@stgolabs.net,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        dvhart@infradead.org, mark.rutland@arm.com, peterz@infradead.org,
        arnd@arndb.de, alistair23@gmail.com,
        linux-riscv@lists.infradead.org, mingo@redhat.com,
        alistair.francis@wdc.com, atish.patra@wdc.com
Subject: [PATCH 6/6] selftests: futex: Use futex_waitv helper function
Date:   Fri, 28 Oct 2022 19:56:32 +1000
Message-Id: <20221028095632.1081262-7-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
References: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Use the publically exposed __kernel_futex_syscall_waitv() helper
function for the futex_waitv tests.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20211209235857.423773-6-alistair.francis@opensource.wdc.com>
---
 tools/testing/selftests/futex/include/futex2test.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/t=
esting/selftests/futex/include/futex2test.h
index 9d305520e849..fdc0a0a270cd 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -5,6 +5,7 @@
  * Copyright 2021 Collabora Ltd.
  */
 #include <stdint.h>
+#include <linux/futex_syscall.h>
=20
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
=20
@@ -18,5 +19,5 @@
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsi=
gned long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
-	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, cloc=
kid);
+	return __kernel_futex_syscall_waitv(waiters, nr_waiters, flags, timo, c=
lockid);
 }
--=20
2.37.3

