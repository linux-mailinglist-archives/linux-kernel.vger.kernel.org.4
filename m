Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65071714862
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjE2LOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjE2LOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:14:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF74DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:14:16 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230529111414epoutp04380aaa0704f9fb048bef761c913a2aea~jmPLiv9Y10560905609epoutp04g
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:14:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230529111414epoutp04380aaa0704f9fb048bef761c913a2aea~jmPLiv9Y10560905609epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685358854;
        bh=nFYqgya5b+48MlA+S9yA8hdVhuiXp1AXTaJCiqdhPwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOgFM1V4qcZwZ8vsBMA9LoLMlgoUuETPxncFK0SPdVCsjw1Ghx4aV0gt6P9mGf+Jk
         8YZIpUbAMRsFzlq+9S+afpr/CFYG8takm7gMaysfH1LA3pJdfsGvyO7vQs+zEw/uQP
         B3QWof1Kk/R6WCAUjprorl8fuvlEO0jLBtcHQoZ0=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230529111413epcas5p4d0506d2d94d74a6f6d057e8153fbfeb3~jmPK7gicZ1149511495epcas5p4Q;
        Mon, 29 May 2023 11:14:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.B3.04567.50984746; Mon, 29 May 2023 20:14:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5~jmPCRWKek2607826078epcas5p2y;
        Mon, 29 May 2023 11:14:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230529111404epsmtrp239eb7b3d01e1d317ed1bee4850a666b7~jmPCQGplT2617326173epsmtrp2N;
        Mon, 29 May 2023 11:14:04 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-26-647489059eb0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.32.27706.CF884746; Mon, 29 May 2023 20:14:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230529111401epsmtip1f7be17df8f56a26e756da0d5a7b41e96~jmO-efKyL2687226872epsmtip1F;
        Mon, 29 May 2023 11:14:01 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, keescook@chromium.org,
        nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com,
        gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com,
        wedsonaf@google.com
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
Date:   Mon, 29 May 2023 16:43:37 +0530
Message-Id: <20230529111337.352990-2-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmui5rZ0mKwf7XehZ/Z29nt3i4u4XF
        4s6k5+wWF8+8ZrQ4051r8b5lB5vF5V1z2Cx+f//HanF4fhuLxZaGQ2wWG44GW/x8cYPFYuX8
        5YwWK3o+sFr8f/wVSLw7wmTRsXglo4Ogx+yGiyweX2+eY/JY9LKBxWNJ5y8mj52z7rJ7LNhU
        6rFpVSebx4RFBxg9zs9YyOgxcU+dR9+WVYwe67dcZfH4vEkugDeKyyYlNSezLLVI3y6BK6Px
        0CS2gsscFQ9Ob2RsYFzM3sXIySEhYCLx7GU3cxcjF4eQwG5Gid0XDzFBOJ8YJZ7Mm8UI4Xxj
        lHiz6g1QhgOspWuPFER8L6PEzC9PWSCcL4wS29e9AZvLJqAnsWrXHrCEiEArk8SNw6fZQBxm
        gY2MEn/3rGIEGSUs4CTRuz8LpIFFQFVix7dVzCA2r4CtxOS7l1ggDpSXmHnpO9hQTgE7iVmH
        W9ggagQlTs58AlbDDFTTvHU22BMSAi84JE5t3AjV7CKxrOElE4QtLPHq+Baor6UkPr/bywbx
        TrnE1gn1EL0tjBL750xhg6ixl3hycSErSA2zgKbE+l36EGFZiamn1jFB7OWT6P39BGo8r8SO
        eTC2qkTLzQ2sELa0xOePH1kgVnlI3PxSBQmsiYwS8yf3sk1gVJiF5J1ZSN6ZhbB5ASPzKkbJ
        1ILi3PTUYtMCw7zUcr3ixNzi0rx0veT83E2M4PSo5bmD8e6DD3qHGJk4GA8xSnAwK4nw2iYW
        pwjxpiRWVqUW5ccXleakFh9ilOZgURLnVbc9mSwkkJ5YkpqdmlqQWgSTZeLglGpgMhGS21bw
        wDhySRhD0vQHU+tYrvsxFerdOX9ibVXAwvVGDl1zTrAqJ/0Ki7LY7P1qu1fMaoujf4PmlJT7
        XlqU+tgwYbp4VzLn6xkzf99ZMsGDl3VTzJKdvf5ng4+m2Bh9WNj5QkB31bSH/rMm39+k0qZx
        qu/x8ovtbKcanZ5c8GrhaHL+o3evk0sv8O0efoeOhOcnbLXfzcwpmfua2XXVhWcTJrV8tHnj
        znTcpjySwyV9+lzFY+vKlwQdN901lyfVuKZ2/x29hVOjkwIO/WFwVWjTqj4XV2FWu2pBQbXK
        unu6h77aTV5tlKjDV6F4406iRJWipcT9Fs7blpWe3Zks7Y9YHmd7Tonh41ZyUHyjxFKckWio
        xVxUnAgAeiMedv4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnO6fjpIUg+Nt0hZ/Z29nt3i4u4XF
        4s6k5+wWF8+8ZrQ4051r8b5lB5vF5V1z2Cx+f//HanF4fhuLxZaGQ2wWG44GW/x8cYPFYuX8
        5YwWK3o+sFr8f/wVSLw7wmTRsXglo4Ogx+yGiyweX2+eY/JY9LKBxWNJ5y8mj52z7rJ7LNhU
        6rFpVSebx4RFBxg9zs9YyOgxcU+dR9+WVYwe67dcZfH4vEkugDeKyyYlNSezLLVI3y6BK6Px
        0CS2gsscFQ9Ob2RsYFzM3sXIwSEhYCLRtUeqi5GLQ0hgN6PE7peHWbsYOYHi0hI//71ngbCF
        JVb+e84OUfSJUaJ50SSwBJuAnsSqXXtYQBIiAlOZJKa8vs8GkmAW2MooseRKPcgGYQEnid79
        WSBhFgFViR3fVjGD2LwCthKT716CWiAvMfPSd3YQm1PATmLW4RawMUJANSv7j7JC1AtKnJz5
        hAVivLxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4
        ArU0dzBuX/VB7xAjEwfjIUYJDmYlEV7bxOIUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7G
        CwmkJ5akZqemFqQWwWSZODilGpg6S4wMnm2cefW7/ffdKzfU+ORdv9rKx3hkwues27lZEyw7
        Nsjv//DC5M6Gi9OWXFp7VOUcl+qyo5l1k3a27WG3Krr1hcF6Q/lyTobyj4+dZYJ3rXDb+CQw
        cOEJoY9eK69mv4+pPin+X6z9isfbTaeeRfGHdi5XbJLOeBdcJ2v09laRqfy8i5FWq36dqrN7
        GF3ruGFJRCnfki/7yxKc3xS/usa3U3aXPkPplPCQ8onr5v+ett/8ePmbVRN28gVtZufMkf5Z
        sbtktlj26yc8F7/7id5R+XXMnevM9eV9Ph3HAzN9VTy/zy+yZpDNrF/wMvBJ7mqG/X+dj1t9
        FDD+18F8ek/JIY+TpmJZEXXyotI6SizFGYmGWsxFxYkAD4HklS8DAAA=
X-CMS-MailID: 20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5
References: <20230529111337.352990-1-maninder1.s@samsung.com>
        <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
writes on index "KSYM_NAME_LEN - 1".

Thus array size should be KSYM_NAME_LEN.

for powerpc it was defined as "128" directly.
and commit '61968dbc2d5d' changed define value to 512,
So both were missed to update with new size.

Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 728d3c257e4a..70c4c59a1a8f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -88,7 +88,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];
-- 
2.17.1

