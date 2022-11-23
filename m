Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FF2634E93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiKWEDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiKWEDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:03:15 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C651C1C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:03:08 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221123040302epoutp015609eeea44a89d0bb6a4c65bd1efebba~qGuTzFZwJ2517825178epoutp01e
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221123040302epoutp015609eeea44a89d0bb6a4c65bd1efebba~qGuTzFZwJ2517825178epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669176182;
        bh=4+LuTRetsOem5wM3LudAqA6LHPacm1Zpfhf1LB2Q0Zw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kn/Y2ulBjaM4M9AePNRLjLoOs7S+rup4qbdcyC5n1487xzG9GOoMQzKxk0QdzlVFH
         Xoiv4RyOGbbQRy6IBVo6oMefu11kZNIdCt8Xp9y497uwQDK6X/oX/DbRs4XfuKHnnv
         a+lmBBEGmGJ9wTqaKMMu+GccMTMxHrVbwK8ORZ64=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221123040301epcas5p3a9ed4c6e147feb62168616a4dcc82ffe~qGuTQ-cw02089920899epcas5p3R;
        Wed, 23 Nov 2022 04:03:01 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NH6sw2CnSz4x9Ps; Wed, 23 Nov
        2022 04:03:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.0C.56352.47B9D736; Wed, 23 Nov 2022 13:03:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123040259epcas5p25b09846a349e11a7e23374c75d87cdc3~qGuRVMssL1465614656epcas5p2l;
        Wed, 23 Nov 2022 04:02:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221123040259epsmtrp100a0f7c01c65134584dbf0a4fcb9a1c9~qGuRUYhUC0849508495epsmtrp1d;
        Wed, 23 Nov 2022 04:02:59 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-9c-637d9b7435d4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.03.18644.37B9D736; Wed, 23 Nov 2022 13:02:59 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221123040257epsmtip12d9d20da3d0131f69cab802adebc1001~qGuPM437-0646406464epsmtip1z;
        Wed, 23 Nov 2022 04:02:57 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Xiu Jianfeng'" <xiujianfeng@huawei.com>,
        <krzysztof.kozlowski@linaro.org>, <s.nawrocki@samsung.com>,
        <tomasz.figa@gmail.com>, <cw00.choi@samsung.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <dianders@chromium.org>, <yadi.brar@samsung.com>,
        <mturquette@linaro.org>
Cc:     <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20221123032015.63980-1-xiujianfeng@huawei.com>
Subject: RE: [PATCH] clk: samsung: Fix memory leak in
 _samsung_clk_register_pll()
Date:   Wed, 23 Nov 2022 09:32:56 +0530
Message-ID: <000001d8fef0$79cb1c70$6d615550$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI0s+zTjYHKjxc1/SfsBPJ2IwYZMwIWIRkVrYPHnYA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmhm7J7NpkgyP7eC2uf3nOanF22UE2
        i72vt7JbfOy5x2pxedccNosZ5/cxWVw85WrxdMJFNovDb9pZLf5d28hisWrXH0aL7bN2MDrw
        eLy/0cruMbvhIovHzll32T1ajrxl9di0qpPN4861PWwefVtWMXp83iQXwBGVbZORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
        386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj3ZwtLAXNPBXf
        7razNzCu4epi5OSQEDCRmD6rhbGLkYtDSGA3o8TibfvZIJxPjBIzJzVBOZ8ZJRa0XGaHaela
        sIIZxBYS2MUo8Wu/I4T9klFi7c8wEJtNQFdix+I2sGYRgblMErt232YFSTALpEmsOLUFbBCn
        gI3ExrXLweLCAsESE7d2sIHYLAKqEhunPAOzeQUsJS4+XMYMYQtKnJz5hAVijrzE9rdzmCEO
        UpD4+XQZ2BwRASuJ/wfWs0PUiEu8PHqEHeQICYErHBKdqzczQjS4SMx/s5sJwhaWeHV8C9Rn
        UhIv+9uAbA4g20Ni0R8piHCGxNvl66Fa7SUOXJnDAlLCLKApsX6XPsQqPone30+YIDp5JTra
        hCCqVSWa311lgbClJSZ2d7NC2B4Sx89tYpzAqDgLyWOzkDw2C8kDsxCWLWBkWcUomVpQnJue
        WmxaYJyXWg6P7uT83E2M4KSs5b2D8dGDD3qHGJk4GA8xSnAwK4nw1nvWJAvxpiRWVqUW5ccX
        leakFh9iNAWG9kRmKdHkfGBeyCuJNzSxNDAxMzMzsTQ2M1QS5108QytZSCA9sSQ1OzW1ILUI
        po+Jg1OqgSlcYP+S7u13f6qpBEQlJggt11khemNTYf/je/+3Z2SYdUaJn9vkJhG+p4hd2ODv
        GrNVkVLVgrk2v2cy+b6xLdi0JUFm4jTxhGMrYu1lPFMUXE+fSXzAHBeh/Fxn+qGW9cHH72i7
        1M+POvTE73bky7Ktu2wuSiqYmaRf+qwpb/V6O5v8zq7iBouGOxLX0nnXaF3qZOpQKE+/tkSM
        TUxzXudM+9uMu47OnXnmR+X5+xs/VK6Wznnq925BWKgB19Wd5cJ3jf+wmpzb7Hz0hoLC0vz7
        YdszVDlKn2Qdq55moBvM5H82jONNhsXmI/VmYg9NT4t480n8nfU9eLr//jNrHFyUL3mF9DeV
        WXAe5jlRqMRSnJFoqMVcVJwIAFo481JTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnG7x7NpkgxXv9Syuf3nOanF22UE2
        i72vt7JbfOy5x2pxedccNosZ5/cxWVw85WrxdMJFNovDb9pZLf5d28hisWrXH0aL7bN2MDrw
        eLy/0cruMbvhIovHzll32T1ajrxl9di0qpPN4861PWwefVtWMXp83iQXwBHFZZOSmpNZllqk
        b5fAlfFuzhaWgmaeim9329kbGNdwdTFyckgImEh0LVjB3MXIxSEksINRou/gdVaIhLTE9Y0T
        2CFsYYmV/56D2UICzxkltuyPBbHZBHQldixuYwNpFhFYziTx6dV5JpAEs0CGxKFr79kgpvYy
        Sjz7sR2sm1PARmLj2uVgG4QFAiUe7drABmKzCKhKbJzyDMzmFbCUuPhwGTOELShxcuYTli5G
        DqChehJtGxkh5stLbH87hxniOAWJn0+XgY0UEbCS+H9gPTtEjbjEy6NH2CcwCs9CMmkWwqRZ
        SCbNQtKxgJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcGxqae1g3LPqg94hRiYO
        xkOMEhzMSiK89Z41yUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJ
        MnFwSjUwzdDxXPm3WDFwJYfNJ9Xzz/qUE3b0SElvf75VV+No3cquJtuf9SrXWCM5drzY26D3
        kOmt+Gwtg3MZCba/Cv5M39nq8jb75YFtsTNvnZ+4zVGh9mbU1Ey26XEi59J/rnTsLjmbdSnX
        63aZu8mDn2IBC3ZXL2g/7pSpWl+e+G92knPEO43jOhcbf0XcbvNUKrv7nN/ynZjGoVndJbtr
        RSb/atzBUX78/4MVk+c5yRsYh69cO/XBt60/dz/9FHCEl6NGQqxk7VKDQ8XVHtwmkn9O7Xl6
        gFuYWfqplt30NZs6efe62OffsLr43KFDrzx31pfjxQ6u7k4/livo7piypCmh/vvsCQu3MFzZ
        eXHarRknopRYijMSDbWYi4oTAY55XfM8AwAA
X-CMS-MailID: 20221123040259epcas5p25b09846a349e11a7e23374c75d87cdc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123032321epcas5p235a61ac36bf6c90dc4f0fbf516646dd9
References: <CGME20221123032321epcas5p235a61ac36bf6c90dc4f0fbf516646dd9@epcas5p2.samsung.com>
        <20221123032015.63980-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiu

>-----Original Message-----
>From: Xiu Jianfeng [mailto:xiujianfeng@huawei.com]
>Sent: Wednesday, November 23, 2022 8:50 AM
>To: krzysztof.kozlowski@linaro.org; s.nawrocki@samsung.com;
>tomasz.figa@gmail.com; cw00.choi@samsung.com;
>alim.akhtar@samsung.com; mturquette@baylibre.com; sboyd@kernel.org;
>dianders@chromium.org; yadi.brar@samsung.com; mturquette@linaro.org
>Cc: linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: [PATCH] clk: samsung: Fix memory leak in
>_samsung_clk_register_pll()
>
>If clk_register() fails, @pll->rate_table may have allocated memory by
>kmemdup(), so it needs to be freed, otherwise will cause memory leak issue,
>this patch fixes it.
>
>Fixes: 3ff6e0d8d64d ("clk: samsung: Add support to register rate_table for
>samsung plls")
>Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>---
Thanks!

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/clk/samsung/clk-pll.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index
>fe383471c5f0..0ff28938943f 100644
>--- a/drivers/clk/samsung/clk-pll.c
>+++ b/drivers/clk/samsung/clk-pll.c
>@@ -1583,6 +1583,7 @@ static void __init _samsung_clk_register_pll(struct
>samsung_clk_provider *ctx,
> 	if (ret) {
> 		pr_err("%s: failed to register pll clock %s : %d\n",
> 			__func__, pll_clk->name, ret);
>+		kfree(pll->rate_table);
> 		kfree(pll);
> 		return;
> 	}
>--
>2.17.1


