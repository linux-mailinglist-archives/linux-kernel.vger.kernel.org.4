Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6026AB642
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCFGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCFGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:11:07 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B8BDBC2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 22:11:01 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230306061059epoutp02e51cc675a98d0465d10731922e23a484~Jv6bIYz_O1592815928epoutp02c
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:10:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230306061059epoutp02e51cc675a98d0465d10731922e23a484~Jv6bIYz_O1592815928epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678083059;
        bh=3yCvnupaDKfeeAicMjJxLXQOfhwjR6IX1kcMDQMTi+4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LTOTFakG2acn9flwrYpbiHhGK+MMart2lE1uUnGC0i1qoMPeuHM/0uCdhkqNmTS9h
         9d4OFpl9NKkaB3omaTHx/wT4wEtWcKg7YU1lmDALAH0Vfje2vhw9XCoEW+vVOPuMNB
         YJbbfmtZbnRqPFdJFPKcI0LGdMFqpz87oU38iuZU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230306061058epcas1p20925ca9c12aa8f3ce3d7fa5945286d4a~Jv6atBY4Q1322713227epcas1p2X;
        Mon,  6 Mar 2023 06:10:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.250]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PVSr20g84z4x9Pq; Mon,  6 Mar
        2023 06:10:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.45.54823.1F385046; Mon,  6 Mar 2023 15:10:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230306061057epcas1p17def087649be56b75c7830385ff2fb2f~Jv6ZgrQVj0149601496epcas1p15;
        Mon,  6 Mar 2023 06:10:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230306061057epsmtrp17bc5936972b9abcb628a977b8a739d9f~Jv6Zee4XO0556405564epsmtrp1s;
        Mon,  6 Mar 2023 06:10:57 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-f5-640583f13bec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.12.31821.1F385046; Mon,  6 Mar 2023 15:10:57 +0900 (KST)
Received: from VDBS1328.vd.sec.samsung.net (unknown [168.219.243.40]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230306061057epsmtip24bf4b9fc82add7e663912da25c6ebf9a~Jv6ZVOGH03016030160epsmtip2y;
        Mon,  6 Mar 2023 06:10:57 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
        amit.kachhap@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, js07.lee@samsung.com, js07.lee@gmail.com
Subject: [PATCH 2/2] arm/mm : Report actual image regions in /proc/iomem
Date:   Mon,  6 Mar 2023 14:51:55 +0900
Message-Id: <1678081915-12599-2-git-send-email-js07.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmnu6nZtYUgzdrmSymfNjBavHzy3tG
        i79z3jFZPLr5m9XiTHeuxZQ/y5ksNj2+xmpxedccNotL/ROZHDg91sxbw+hx+dpFZo/ZDRdZ
        PHbOusvusWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZnw92sBUcFar4+uQecwPjB74uRk4O
        CQETiWOt19m6GLk4hAR2MEos/z0PyvnEKPHx/isWCOczkPN6OnMXIwdYy4TNWRDxXYwSx7ft
        ZwIZJSTwi1Hi3SdXEJtNQEvixu9NrCBFIgKvGCV+tSwEKxIW8JBom/4dzGYRUJVY9u4d2FBe
        AReJ6y+zIE6Sk7h5rpMZxOYUcJVYcfUV2EUSAm/ZJbZv2ccEUeQicXjre3YIW1ji1fEtULaU
        xMv+Nii7XGJD3zQmiOYWRolF29+yQSSMJd69XQu2mFlAU2L9Ln2IsKLEzt9zGUFsZgE+iXdf
        e1ghHuaV6GgTgihRknjzoIUFwpaQuPC4F6rEQ2L75TpImMxglHj/4Rj7BEbZWQgLFjAyrmIU
        Sy0ozk1PLTYsMIVHUnJ+7iZGcKrTstzBOP3tB71DjEwcjIcYJTiYlUR4eUpZUoR4UxIrq1KL
        8uOLSnNSiw8xmgLDbiKzlGhyPjDZ5pXEG5pYGpiYGZlYGFsamymJ84rbnkwWEkhPLEnNTk0t
        SC2C6WPi4JRqYOJf/O5f/F7li/4CxsKasjvTp+2zdNHV2arUa7r4qPbRhaf7fjwrfN5mzLTU
        cMb0vQuk11S7Tv6/wfH8SyXVe9KO69Z82V6msl/WIete6pnJW8TevakRYZv8P5+PJedW0vZt
        Cbvr3ZseHHzr6a3yQyJivmdlm/tMt/3WFn+Pd+67d3m9/8uCXcu9JzjmNDfwcZlw3nmZ9NZ4
        XqOa6afvWjmrvi/1/slwlGfrJj6OEM6Frodiv5709Kk80Nq3bZnFNYsetuuTZsif+Gk1I/+i
        tpTY6c+NIU09SS7yWQc+PLx9fZv4a03B18aJRswvXqjsUdx78eCpAx/eKs61bovLPv47snZl
        z6ELLVMmSKkqPb2pxFKckWioxVxUnAgAqTQqNP4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO7HZtYUg0kvxC2mfNjBavHzy3tG
        i79z3jFZPLr5m9XiTHeuxZQ/y5ksNj2+xmpxedccNotL/ROZHDg91sxbw+hx+dpFZo/ZDRdZ
        PHbOusvusWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5AM4oLpuU1JzMstQifbsErozPBzvYCo4K
        VXx9co+5gfEDXxcjB4eEgInEhM1ZXYycHEICOxglOhujQGwJAQmJRzu/sECUCEscPlzcxcgF
        VPKDUaL3w102kBo2AS2JG783sYIkRAS+MEpcnHWaCSQhLOAh0Tb9O5jNIqAqsezdO2aQQbwC
        LhLXX2ZBzJeTuHmukxnE5hRwlVhx9RUbxA0uEgt+NzBOYORdwMiwilEytaA4Nz232LDAKC+1
        XK84Mbe4NC9dLzk/dxMjOCC1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFenlKWFCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYJknufHamhqlyyZszK3448t7s
        nBrHpfhz+ubrKzgnTPx8xnnOJ/vMkA+M/ZxiLotX1S3Ije77oT5rb3vR/eC5UTwfXwipeYev
        P8LPdGRblQMPh+3CTgf5FRF6rVucb3CueJKq5ZYx6RKbI/OPUL16kTm1W/96zfASz9k2Y7nh
        TRWOeS7LlXc1XLFbc37d9xiuiXcuXV1+qE2Ib9O/aGeLlxHBq6e9Fn5sHDHDcSavWPObFouv
        O/vjItfeXvFxwlyR5qg4u6yz6x9p3jI2PaGc2/Zs8fk/J89HsJ68NbNffJ/DPfatSybK2L7m
        az6wObzs71vztme+O0uu7zllIaj+fcdxoTdhC+vcUm+/Pif9yFKJpTgj0VCLuag4EQBiefiL
        twIAAA==
X-CMS-MailID: 20230306061057epcas1p17def087649be56b75c7830385ff2fb2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230306061057epcas1p17def087649be56b75c7830385ff2fb2f
References: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
        <CGME20230306061057epcas1p17def087649be56b75c7830385ff2fb2f@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The resource reservations in /proc/iomem made for the kernel image did
 not reflect the gaps between text, rodata, and data.
 Add the "rodata" resource and update the start/end calculations.

 Before :
04000000-2f7fffff : System RAM
  04100000-04cfffff : Kernel code
  04e00000-05369a27 : Kernel data

 After :
04000000-2f7fffff : System RAM
  04100000-049fffff : Kernel code
  04a00000-04cb2fff : Kernel rodata
  04e00000-05369a27 : Kernel data

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 arch/arm/kernel/setup.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3059860..85af967 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -181,6 +181,12 @@ static struct resource mem_res[] = {
 		.flags = IORESOURCE_SYSTEM_RAM
 	},
 	{
+		.name = "Kernel rodata",
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_SYSTEM_RAM
+	},
+	{
 		.name = "Kernel data",
 		.start = 0,
 		.end = 0,
@@ -188,9 +194,10 @@ static struct resource mem_res[] = {
 	}
 };
 
-#define video_ram   mem_res[0]
-#define kernel_code mem_res[1]
-#define kernel_data mem_res[2]
+#define video_ram     mem_res[0]
+#define kernel_code   mem_res[1]
+#define kernel_rodata mem_res[2]
+#define kernel_data   mem_res[3]
 
 static struct resource io_res[] = {
 	{
@@ -866,7 +873,9 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 	u64 i;
 
 	kernel_code.start   = virt_to_phys(_stext);
-	kernel_code.end     = virt_to_phys(__init_begin - 1);
+	kernel_code.end     = virt_to_phys(_etext - 1);
+	kernel_rodata.start = virt_to_phys(__start_rodata);
+	kernel_rodata.end   = virt_to_phys(__end_rodata - 1);
 	kernel_data.start   = virt_to_phys(_sdata);
 	kernel_data.end     = virt_to_phys(_end - 1);
 
@@ -912,6 +921,9 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 		if (kernel_code.start >= res->start &&
 		    kernel_code.end <= res->end)
 			request_resource(res, &kernel_code);
+		if (kernel_rodata.start >= res->start &&
+		    kernel_rodata.end <= res->end)
+			request_resource(res, &kernel_rodata);
 		if (kernel_data.start >= res->start &&
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
-- 
2.7.4

