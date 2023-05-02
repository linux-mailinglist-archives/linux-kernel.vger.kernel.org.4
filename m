Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CD6F3DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjEBGur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjEBGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:50:41 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8240ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:50:31 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230502065027epoutp04673fc8ef7282a182e6e298a6ef22a017~bQOKBs7qf2364223642epoutp04Y
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230502065027epoutp04673fc8ef7282a182e6e298a6ef22a017~bQOKBs7qf2364223642epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683010227;
        bh=/zhDcDts5LBX2HV/3UzZnXw4YVjg9uzB6LOd9LsN6rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSLTli2ccnyF0XCiccrYSVijYzIU3y3bJXBAj2Hegl68T1IaAJACxw8eIMKGPYbYZ
         CmwcSf8jTFPIzc3/YVHoa2h1tlJ+69u1Fw0S+Di62TvfXtpbuZTW5SZUNBMAIX2PVD
         Zgtsp5eUDKWeBmKfaYXvBT1LTeKtdlXQPhpO3Qes=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230502065026epcas2p3c3bbced9152859a716e6d108432f7e32~bQOJiEnwJ1371613716epcas2p3O;
        Tue,  2 May 2023 06:50:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Q9W1F6vkzz4x9Q6; Tue,  2 May
        2023 06:50:25 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.9B.08199.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epcas2p4143c8ff3d44b7676ea8667c14618f2cd~bQOIKsCsr1117211172epcas2p4A;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230502065025epsmtrp200b9f15f59b5d2422a3f2ee79378198c~bQOIJ-j0d2944229442epsmtrp2M;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-fd-6450b2b1a730
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.C8.27706.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epsmtip13f5f5d62791d4d87df09e34b99a140c0~bQOIAexil1675316753epsmtip1U;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3 1/3] spi: s3c64xx: change polling mode to optional
Date:   Tue,  2 May 2023 15:28:11 +0900
Message-Id: <20230502062813.112434-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230502062813.112434-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmqe7GTQEpBu/maVo8mLeNzWLxj+dM
        FlMfPmGzuLxf22JHwxFWi72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdgcvj+pJPzB6bVnWy
        edy5tofNY/OSeo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6g
        V5yYW1yal66Xl1piZWhgYGQKVJiQndGwZwNzwQq+itlnr7E1MP7i7mLk5JAQMJFYsXotaxcj
        F4eQwA5GiTnH70E5nxglzv9oZYZwvjFK7H7zggWmZdWtdnaIxF5GiUfL1rGCJIQEPjJKvP/m
        AmKzCWhLfF+/GGyUiMBiRokFV3eCdTAL3GCU6H6zGWyUsICrxMLrVxhBbBYBVYmG26/A4rwC
        dhL7L8xkglgnL7F6wwFmEJtTwF7iXlML2FQJgUfsEucu90MVuUi0TvrGCGELS7w6voUdwpaS
        +PxuLxuEnS3RPv0PK4RdIXFxw2youLHErGftQL0cQNdpSqzfpQ9iSggoSxy5BXYOswCfRMfh
        v+wQYV6JjjYhiEY1iftTz0ENkZGYdGQl1DEeEgtvdzBCwmQSo8TOm5ITGOVmIcxfwMi4ilEs
        taA4Nz212KjAGB5jyfm5mxjBCU/LfQfjjLcf9A4xMnEwHmKU4GBWEuH9UOiXIsSbklhZlVqU
        H19UmpNafIjRFBh0E5mlRJPzgSk3ryTe0MTSwMTMzNDcyNTAXEmcV9r2ZLKQQHpiSWp2ampB
        ahFMHxMHp1QDk4HDoSJfTtPTl9m/77CvvnhI8O1lFflVuzam/9c3/PzX+tzXBXePyq/t0GLn
        SVzsUNI3p2Zqsv221LVS0+t2Z0z/+vdl/OubJ4TNr899nB6qcnG54v53MuFGMa91dpqtlJGb
        sWqm60vhP7b7v3UszswSa4/ktll8evNOdpbsV1Imv1bf0mU3+OR3xE3wv962shPPDBlv393U
        0p69veuzfy3/SS+mVFt5h3+cM0t25Nz78knuVdXOGMnmDaXhP6VZzC89zCvUXdPjGP/OzblT
        8zxX+Pp2y6n55fVMla8LtK7tNLzGPCMjlPFBp9uSe8mnJr/xV1klt+qah+qqzV+nf+E7ac2p
        P6XkUrr7e66uNCWW4oxEQy3mouJEAHDLC9wBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO7GTQEpBhs3Clo8mLeNzWLxj+dM
        FlMfPmGzuLxf22JHwxFWi72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdgcvj+pJPzB6bVnWy
        edy5tofNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKaNizgblgBV/F7LPX2BoYf3F3
        MXJySAiYSKy61c7excjFISSwm1FiZe9lZoiEjMTyZ31sELawxP2WI6wQRe8ZJdo7DrKAJNgE
        tCW+r18MlhARWMoo8XjPYxYQh1ngHqPEy0nfmECqhAVcJRZev8IIYrMIqEo03H4F1s0rYCex
        /8JMJogV8hKrNxwAW80pYC9xr6mFFcQWAqq50vuVdQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6
        xYm5xaV56XrJ+bmbGMHhqaW5g3H7qg96hxiZOBgPMUpwMCuJ8H4o9EsR4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgalft9y15KivRW9m2J/H6mmXf+re
        erTjisVv0bDLU9sy/k1zMGu/GpHj///WWqs1d17ez29Lv9ToHxluWmQTVbrm6WTTMvPTIb8T
        POPzK93vqit4n3v4TZiLl/WvitCiM/F+G/rZbyaJxNUnOth2RO9m3aG01CiEmf+/n1nlFIvp
        q9MOqpabrcyS+P3TZuoi+2V1kvEpW6/XLJq1R0at51S8Q2rY8r89FrmbRA0THsZM+nMjTM09
        OnV3y4ePbzvvv7jmlZe06/RDb5aaiP9yGsc7dsa+ynhwViHwP9OhNsVH9RHqOzaH511ZwR0f
        sb9tL5cZa9OHPQ8urd78x/BO6m3Tuo/cx3c3Xrq9ZuLtciWW4oxEQy3mouJEAAg5wce+AgAA
X-CMS-MailID: 20230502065025epcas2p4143c8ff3d44b7676ea8667c14618f2cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502065025epcas2p4143c8ff3d44b7676ea8667c14618f2cd
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
        <CGME20230502065025epcas2p4143c8ff3d44b7676ea8667c14618f2cd@epcas2p4.samsung.com>
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

Previously, Polling mode was supported as quirk for SOC without DMA.
To provide more flexible support for polling mode, it changed to polling
mode when the 'dmas' property is not present in the devicetree, rather than
using a quirk.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c                 | 4 ++--
 include/linux/platform_data/spi-s3c64xx.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 71d324ec9a70..66ac94022a1b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -19,7 +19,6 @@
 #include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		12
-#define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -116,7 +115,7 @@
 #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
+#define is_polling(x)	(x->cntrlr_info->polling)
 
 #define RXBUSY    (1<<2)
 #define TXBUSY    (1<<3)
@@ -1068,6 +1067,7 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 	}
 
 	sci->no_cs = of_property_read_bool(dev->of_node, "no-cs-readback");
+	sci->polling = !of_property_present(dev->of_node, "dmas");
 
 	return sci;
 }
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 5df1ace6d2c9..cb7b8ddc899f 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -35,6 +35,7 @@ struct s3c64xx_spi_info {
 	int src_clk_nr;
 	int num_cs;
 	bool no_cs;
+	bool polling;
 	int (*cfg_gpio)(void);
 };
 
-- 
2.17.1

