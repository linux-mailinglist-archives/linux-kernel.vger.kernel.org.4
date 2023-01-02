Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC17665B6AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjABSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjABSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:44:11 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55664BC92;
        Mon,  2 Jan 2023 10:44:09 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id D4BC340D72;
        Mon,  2 Jan 2023 19:44:07 +0100 (CET)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1672685045; x=1674499446; bh=PE2QbDuec+iFICdEPvX
        1KX5WQKys9UPqNPqt1/TRius=; b=tTVaFoqI6mGYv8yD8vJv9KQ3h+IlXVXEL89
        74+C5z71UA5asqkUsnu8tv0nMrcVcDrDx3qsm5j9oLN+jW+DK5u3O1HIHCuBDQO8
        xTuZakfM2KG/khjPdHSNETxJZmKGwixPFa52LIrR7sYgNooIrla5q5H1nJwdoRVk
        SJCIGlaZXKKlbOTnoZ/pEo5izMyAzwS5XxXrhXIPqYZJ/kBV4f2omEaorXficA1M
        Q5Bv/hJVgFPluF/+RaH7Ac8R0Lryi2qTcm70UFKFhBBDkbK3aSazVw7YQ479k5se
        kT8rFwppx+PDcMMdkgWTgkeJMjmPGlNo0ik/m1Zx4dBxVrL/KZvHwx1q2UhoFsjI
        LPSM16Fh6yfBXBj2NR5UFmNUTBwZz/B54d2HR3HGiFLrMkMISkNiDXVEoxHoPS5C
        DoJMOKDX2118vMxM7nMAvBCZ15o8w7+mgSL/hBLGo1ZCxTFAd/eo+lobohXX5z0Q
        yCfXiCyv+LNhpEVmme8iz7Z4dEupRbPcupdY/1mizkfl01nse/2rSZi73gYb+SG7
        I4U1ATM5699hROcpsKyqyb1m0XOkjpiscKjZoUD/lw0bQZH/6fB7w2QG1h3DL61t
        NkE2V1+TjracUomgj4UdslnTlnmkPUhnJbQVw45mEVrfpb6VRv5NZtc1wCGVNgK/
        wQgfzKJ0=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AujhSXFK8cEn; Mon,  2 Jan 2023 19:44:05 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 2B2AF40CA1;
        Mon,  2 Jan 2023 19:44:05 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id A4D311B6F;
        Mon,  2 Jan 2023 19:44:04 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: add kernel-doc comment for u64_to_user_ptr
Date:   Mon,  2 Jan 2023 19:43:49 +0100
Message-Id: <20230102184349.10399-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel-doc comment in kernel.h to document the macro
`u64_to_user_ptr`.

As of today, this macro is mentioned in the documentation in
'ioctl.rst' and 'botching-up-ioctls.rst'

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 include/linux/kernel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index fe6efb24d151..8bcd126f64f2 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -56,6 +56,10 @@
 
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
+/**
+ * u64_to_user_ptr - convert an unsigned 64bit number into a user pointer
+ * @x: the number to convert
+ */
 #define u64_to_user_ptr(x) (		\
 {					\
 	typecheck(u64, (x));		\
-- 
2.30.2

