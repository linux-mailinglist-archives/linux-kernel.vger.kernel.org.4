Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9569C60B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBTHff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBTHfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:35:33 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23DCC24
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:35:30 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220073528epoutp015e4c68714aef5f16dce40d3b8a250dae~FeCMq7WGh1374113741epoutp01n
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:35:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220073528epoutp015e4c68714aef5f16dce40d3b8a250dae~FeCMq7WGh1374113741epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676878528;
        bh=jSnT7xXsWt3qlCKjvBNBOT2SiDlHAmghETbA9fpzlEs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dxf/ThBwPDWM2VXnt0aKJIn4dsuWlowc6RVAyvewBsXfMxVfEesjAI2s7zmAMoCUu
         32zJuXsUequpl/sNNJEhmyDEFoV1FxYHqm96VeGGVF5AR+TRELCOzBclaObjgG1a/Z
         TfkOuhhLMbVctRpNdY87SlTOiMKg6CoINl5HWFks=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230220073528epcas1p459501f124f0bc21adeb1cee6327fdd5a~FeCMMIB0p3161731617epcas1p4c;
        Mon, 20 Feb 2023 07:35:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.225]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PKvMz5j96z4x9Q1; Mon, 20 Feb
        2023 07:35:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.97.54823.FB223F36; Mon, 20 Feb 2023 16:35:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230220073527epcas1p1e901bfa667b8c51551d26478013131e6~FeCLZT7v31662216622epcas1p1e;
        Mon, 20 Feb 2023 07:35:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220073527epsmtrp180c2ff8448a7486d2916ec82a3666024~FeCLYns5J2290122901epsmtrp1M;
        Mon, 20 Feb 2023 07:35:27 +0000 (GMT)
X-AuditID: b6c32a39-29ffca800000d627-28-63f322bfaa11
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.97.05839.FB223F36; Mon, 20 Feb 2023 16:35:27 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220073527epsmtip1499f9e79152ba4f33d4ce10f2776e6a5~FeCLMvxV00185201852epsmtip1Y;
        Mon, 20 Feb 2023 07:35:27 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sangmoon Kim <sangmoon.kim@samsung.com>
Subject: [PATCH] arm64: pass ESR_ELx to die() of cfi_handler
Date:   Mon, 20 Feb 2023 16:34:41 +0900
Message-Id: <20230220073441.2753-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7bCmru5+pc/JBjN+6VpMffiEzeL9sh5G
        i02Pr7FaXN41h81i6fWLTBa3HjSyWLTcMXVg91gzbw2jx6ZVnWwem5fUe/RtWcXo8XmTXABr
        VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCswK94sTc4tK8dL281BIrQwMDI1OgwoTs
        jOWdV9gKfrJVfOhYz9jAeJ+1i5GTQ0LARGLpy7dsXYxcHEICOxgltl06wQaSEBL4xCjxca4O
        ROIbo8Tko22MMB0bvi9khUjsZZRYeGYpI4TzhVHi0YKDLCBVbAK6El/mXQbrEBHwkdj69zZY
        EbPATkaJBws+gO0QFrCRuHZ2IjuIzSKgKvFregeYzQsUX/1hE9Q6eYnVGw4wgzRLCKxjl7ix
        ah4TRMJF4va9l+wQtrDEq+NboGwpiZf9bewQDf2MEqe6u1ggElMYJeZe04SwjSV6ey4ATeUA
        OklTYv0ufYiwosTO33PBFjML8Em8+9rDClIiIcAr0dEmBFGiJvH41V2o22Qk+u/Mh5ruIXHx
        7lFWSNjFSly89YtxAqPsLIQFCxgZVzGKpRYU56anFhsWmMKjKTk/dxMjOGVpWe5gnP72g94h
        RiYOxkOMEhzMSiK8/3k/JwvxpiRWVqUW5ccXleakFh9iNAUG2ERmKdHkfGDSzCuJNzSxNDAx
        MzKxMLY0NlMS5xW3PZksJJCeWJKanZpakFoE08fEwSnVwCRy8tnNy6vvT7M5eE5a6+rluc+2
        5160j6iL23dOpX+nzsL89b2zL253fPbxwfXwD3c8n2cnzPXXEC+u3KK6WaujZZ1ho1nW2XQF
        vujqhL5/ExOmuZSpevhsqdd0/vDK+mrH+7ffchtm7jmSYKUZqeEksXemYr3TXP2kb4VLt70y
        6E26vUy33P6F260XHV0WhZnVYf9qRfQUEwS+bJXn+/HrSdKMVUtP/gr2NLSs+W58LPzlI9aw
        Gh3b1ZzTJLX3n516wjaqqObVseKVvHaPrrF+0lAyuZ+61rNTr7vh93f//B1XuzY97Twvvasn
        IyTx2uqAhV9S11v9kFWYcvbBo/V8O1tWCjp9DTO9Klz6sEaJpTgj0VCLuag4EQDA0XeG4gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsWy7bCSnO5+pc/JBjcP8VtMffiEzeL9sh5G
        i02Pr7FaXN41h81i6fWLTBa3HjSyWLTcMXVg91gzbw2jx6ZVnWwem5fUe/RtWcXo8XmTXABr
        FJdNSmpOZllqkb5dAlfG8s4rbAU/2So+dKxnbGC8z9rFyMkhIWAiseH7QiCbi0NIYDejRPfv
        x1AJGYmdFzczdTFyANnCEocPF0PUfGKUeD99EgtIDZuArsSXeZcZQWpEBPwknj2rA6lhFtjL
        KLFz6wdmkBphARuJa2cnsoPYLAKqEr+md4DZvEDx1R82MULskpdYveEA8wRGngWMDKsYJVML
        inPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIDSEtzB+P2VR/0DjEycTAeYpTgYFYS4f3P+zlZ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbAPScad5au
        Pf2tYO6RGb3TZ2hH7f/D+fXf0diN1z3ag6o3MrBq5KtMajCO7V/zp3R31bYvd1+t3ya2+YnV
        CskvG5r+q11j9+RR1tw5K+TdxYV+rmsPT343S2Pl0mPV75++4iqoM967fQrb2aAm3p/Ln2d9
        qz7c/zH2t6jsyhd9pd8U5pkeymY+7qerx9Bi7GD7cze3mOKCz2ZHV641vjBHfc8Fvl09LsG8
        q8piUjKjepcomjld/tp+ZEvZs1+ymU5VDjPl4o5fkisruSVSwPx4fw1v81nL6dLtm0RFvhoL
        ht16yVVXGtcp+Hd3Ov/VK0fmzqwUunt+PWeuYZnKXOGMVX8YdkvOkfv6cqltwSMOJZbijERD
        Leai4kQAXlsskI8CAAA=
X-CMS-MailID: 20230220073527epcas1p1e901bfa667b8c51551d26478013131e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220073527epcas1p1e901bfa667b8c51551d26478013131e6
References: <CGME20230220073527epcas1p1e901bfa667b8c51551d26478013131e6@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0f2cb928a154 ("arm64: consistently pass ESR_ELx to die()") caused
all callers to pass the ESR_ELx value to die().

For consistency, this patch also adds esr to die() call of cfi_handler.
Also, when CFI error occurs, die handlers can use ESR_ELx value.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0ccc063daccb..4a623e2e982b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -990,7 +990,7 @@ static int cfi_handler(struct pt_regs *regs, unsigned long esr)
 
 	switch (report_cfi_failure(regs, regs->pc, &target, type)) {
 	case BUG_TRAP_TYPE_BUG:
-		die("Oops - CFI", regs, 0);
+		die("Oops - CFI", regs, esr);
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
-- 
2.17.1

