Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A826A0360
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjBWHtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:48:59 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0649E4AFC2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:48:55 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230223074852euoutp02693569cfdbcc150a7ffc31db34fe8efd~GZJwU1Hp01250212502euoutp02h
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:48:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230223074852euoutp02693569cfdbcc150a7ffc31db34fe8efd~GZJwU1Hp01250212502euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677138532;
        bh=FHMeuxDQ29NoJR984ZVYqUGWMF3uiw9hNp+xL3i+jhM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y4ZOSUMoUHG2l6Jd1iFQ99s4Dth3d5SKSRERIIHNXe2MCuRhVhoNJDv2zW+vXxn0Z
         PA9yjUlSrXvxbtK47g11aHTDCVp67qxWKYaq6HhXDJEi7iOw+M0GPi13ynswRSrMcR
         LhiVfP4xodi7ic7DeaPHRgiQRfVTzKtRctm17A0o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230223074852eucas1p1dc671cdfb1d6a7bb734ad938c209efaa~GZJwJXQsY1073310733eucas1p1d;
        Thu, 23 Feb 2023 07:48:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.36.13597.46A17F36; Thu, 23
        Feb 2023 07:48:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230223074852eucas1p2c91d153aa806db963711e1809861f76b~GZJvzIgBf1618616186eucas1p2k;
        Thu, 23 Feb 2023 07:48:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230223074852eusmtrp2884a711b837748b0bdbc700d4b765c46~GZJvyie7e2908229082eusmtrp2g;
        Thu, 23 Feb 2023 07:48:52 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-1c-63f71a64361f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.9B.02722.46A17F36; Thu, 23
        Feb 2023 07:48:52 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230223074852eusmtip184fbdd648ced38e8e3af702f2136ea31~GZJvpBLsK2855628556eusmtip1Y;
        Thu, 23 Feb 2023 07:48:52 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP EliteDesk 800 G6 Tower
 PC
Date:   Thu, 23 Feb 2023 08:47:48 +0100
Message-Id: <20230223074749.1026060-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200;
        i=l.stelmach@samsung.com; h=from:subject;
        bh=GMNLgIFNtQnpjHejB6ZnrsRERAgeCSEurCJiJf6wE/A=;
        b=owEBbQGS/pANAwAIAbCuHpyYpYAQAcsmYgBj9xok0rbLx+ROmcNE9ifOZII8l1rQWyEYhD2zd
        5+o6Iqd+bmJATMEAAEIAB0WIQRem7KqOr2QYRWv1RCwrh6cmKWAEAUCY/caJAAKCRCwrh6cmKWA
        EBNrCACsI1MT/eBg/C1UEQVIbL0TijFr0SM5EAlFFXND+JGmRlZSR/7eCSrDKWZxPBuDRJm62aP
        880M534VRT2/yHBGWSygQ8fazKs4qScno7iXlr42DXfIOrS2nd9R4bKD7ydinvStqpqSwCCAaFF
        BemKx2fGa4YUUFWBVjk/Ew/iXXDQfLQlBv1GajfNzH/0HsXAN72xHTpl/R8+DXqDilXKZUYbgZw
        +3hor0Z6zulWJOTD6zkMSI8YVsIC7UOCob9taDoVHnAjOLLOGiaTAcdQOlepso4+viqHGZ7fFli
        sIfOPvqKWL5PkXVYsNyAaYfXLrFOKpeate+UYugvBgmJBqu2
X-Developer-Key: i=l.stelmach@samsung.com; a=openpgp;
        fpr=A2B9843766B15A4D32BCBF0DEC1B3A02E80CD5C8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd0Uqe/JBnf/y1tcuXiIyeLmoRWM
        Fpd3zWGzWHvkLrtF565+VosN39cyOrB5bPjcxOax7+0yNo++LasYPdZvucri8XmTXABrFJdN
        SmpOZllqkb5dAlfG8o09TAWbOCs+fsxrYFzA0cXIySEhYCKxZ9M7pi5GLg4hgRWMEj1z9rJB
        OF8YJfqe7GGBcD4zSjT0/WCBadn3/Tg7RGI5o0THoQZmCOcFo0Tv8g3sIFVsAo4S/UtPsILY
        IgLOEhP3QixhFljNKHF90xKwImGBAIlln46BFbEIqErcPH4CaDkHB6+ArcT5OYIQ2+Ql2q5P
        ZwSxeQUEJU7OfAJ2Bb+AlsSaputg50kIzGaV6L3ewQrRkCLx8HIrWAMzUHPz1tnMEEVXOCTm
        nznHBFHkIrHm70dGCFtY4tXxLewQtozE/53zmSAa2hklmq4sZIVwJjBKfO5oguq2lrhz7hfY
        qcwCmhLrd+lDhB0lvjdOZgIJSwjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1SoS6/r3sExgVJ6F
        5LdZSM6ehTB/ASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMAkc/rf8S87GJe/+qh3
        iJGJg/EQowQHs5II71Sm78lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YW
        pBbBZJk4OKUamDxUPt0LnVvyWdzz/8clYuIe4edrw/ynqvYHPDkhFJp0SaaZacH9E1WVD6/G
        lOpG5rPPP3Pmf2SOxq1fSr+lxK/XbalbnuSZ+yXwyKTVaxU3fL17TWDZwzoV9gTra0drQtPW
        TCufdFxmuqewTG6Oqlf4zux8/j864S692b5be1tnMMQXhGjtkRLtvpahkT9pc4HDoTv6b9zT
        2X4kLHqsuIff91VP0ZrD5RLTjQS4pVOvlXKL9XLvvGrqpbFjm+GrTR4PrBsuiRYdW/qmZtGv
        57wX7tSW7i1Zf7t6f9jPdudjLxLYnB7G/jsSIPr9XlG0xwL+xXOn/tMLsVUISgw9MYWNpaI9
        JlXcd+OBef8FlViKMxINtZiLihMBbyCg3qEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7opUt+TDX6957C4cvEQk8XNQysY
        LS7vmsNmsfbIXXaLzl39rBYbvq9ldGDz2PC5ic1j39tlbB59W1YxeqzfcpXF4/MmuQDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M5Rt7mAo2
        cVZ8/JjXwLiAo4uRk0NCwERi3/fj7F2MXBxCAksZJXb9WAXkcAAlpCRWzk2HqBGW+HOtiw2i
        5hmjxOZtExlBEmwCjhL9S0+wgtgiAq4SV+/dZgQpYhZYCzSoeTtYQljAT6JxRSeYzSKgKnHz
        +Ak2kAW8ArYS5+cIQiyQl2i7Ph1sJq+AoMTJmU9YQEqYBdQl1s8TAgnzC2hJrGm6zgIyXkKg
        k1XiyYqlbBC9SRIH1q8D62UGmtO8dTbzBEahWUhGzUIYNQtJ1QJG5lWMIqmlxbnpucWGesWJ
        ucWleel6yfm5mxiB0bTt2M/NOxjnvfqod4iRiYPxEKMEB7OSCO9Upu/JQrwpiZVVqUX58UWl
        OanFhxhNgT6byCwlmpwPjOe8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+
        Jg5OqQamaRJr5kblRq5w7kxUmPdMJSJ/WeVSudb/6xdO2XbmlapW5ifBxu/Lv3k8/PJT10bf
        Lt7RZFuqpm/neeaEE7/Zv15lPCr3a8bbIy41vVIP98zLdHi0geFDGUel/3a1sur9XjG177pE
        rG8p6NSxeJyQ7o73MFbUvziV+/V/vtuHrtZMT9X2m67K5NEZum95QwR76JRCtqSvWZdXVPon
        ux4TP8Ti+iNTL0WE4+SRxFiGGqm2Cqc9rPOXp2fkzRO9Ld3W6vPlzo+22JI3PMV7lobzB81t
        WJ15fLthk8H+K3fOn3P8p+uYGvdsR2/tVsUXu3XmOs2duP9LfZ3/ky3LXW5skIwS/Dmz4cBt
        jty6nzuVWIozEg21mIuKEwEfqItvLwMAAA==
X-CMS-MailID: 20230223074852eucas1p2c91d153aa806db963711e1809861f76b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230223074852eucas1p2c91d153aa806db963711e1809861f76b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230223074852eucas1p2c91d153aa806db963711e1809861f76b
References: <CGME20230223074852eucas1p2c91d153aa806db963711e1809861f76b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP EliteDesk 800 G6 Tower PC (103c:870c) requires a quirk for enabling
headset-mic.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

Verified by

 echo 0x19 0x01a1913c > /sys/class/sound/card0/device/sound/card0/hwC0D0/user_pin_configs
 echo 1 > /sys/class/sound/card0/device/sound/card0/hwC0D0/reconfig 

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6fab7c8fc19a..ac196db573e4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11599,6 +11599,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0698, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
+	SND_PCI_QUIRK(0x103c, 0x870c, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
-- 
2.30.2

