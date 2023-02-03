Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636596898CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjBCMce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjBCMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:32:28 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5D18B7DB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:32:23 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230203123221euoutp028056bb4c234d7b94fff36060b0f597f5~AUHjqnhLx1893218932euoutp026
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:32:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230203123221euoutp028056bb4c234d7b94fff36060b0f597f5~AUHjqnhLx1893218932euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675427541;
        bh=jrd78e2TSBcwd4YObsmVJSB5ylRxUh73JYv+kU3KIVg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AJP59wkhJ0y9ma4BKw1SYIlRI9PS673ij7y31RloO6akktsWOa4K/3hC8d3pwND2e
         83jt0i+AAlccmSsKLj+VlDe/IZA1sytWV2qUemDzkZFrmP0OoU7n9T9huKjvI9keje
         r/ZIHSCuSYKFcEl5BExGz7WxjXwFlGKpcYlHYxxE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230203123221eucas1p233ed4ab39a0acf63bb6a471e38de7a70~AUHjbvlJ51305413054eucas1p2W;
        Fri,  3 Feb 2023 12:32:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.40.01471.5DEFCD36; Fri,  3
        Feb 2023 12:32:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230203123220eucas1p2f9686f08bcb22cf1e21aefd25070282a~AUHi_nHlI2615426154eucas1p2S;
        Fri,  3 Feb 2023 12:32:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230203123220eusmtrp23b7a9130a65b6690117982824b71c813~AUHi_BKC10250002500eusmtrp2O;
        Fri,  3 Feb 2023 12:32:20 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-57-63dcfed515f9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.33.02722.4DEFCD36; Fri,  3
        Feb 2023 12:32:20 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230203123220eusmtip10d1c9be36668380ec1be20775266c3e2~AUHizcWRb1911019110eusmtip1T;
        Fri,  3 Feb 2023 12:32:20 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] merge_config.sh: do not report some differencess between
 input and output
Date:   Fri,  3 Feb 2023 13:31:40 +0100
Message-Id: <20230203123140.2227880-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466;
        i=l.stelmach@samsung.com; h=from:subject;
        bh=wonFUdzmaAET0/ORzWMrO5UfaSRF0d8PF1Z0JaBmN3w=;
        b=owEBbQGS/pANAwAIAbCuHpyYpYAQAcsmYgBj3P6cnRq6mmDach9RedYQYRNcHmge7XlDGtUTY
        kDQBuUgiqiJATMEAAEIAB0WIQRem7KqOr2QYRWv1RCwrh6cmKWAEAUCY9z+nAAKCRCwrh6cmKWA
        ED0VB/9vBRDNjeXEwg7siBxqqhDl7a5TQfwMYNdCyekDLxaUf9aaZtu5xXlNy9STHV6rNn1odU2
        MT98tdlsqXHjsqgrJSjCglbIjRc2ks3jgX05XaEgYWi/lSffYT4GkFidpOIWx+84zz/GdYq3uVN
        DtzwbqUyMxf6DLrbuX5sTkvwOTmA+LekAggOUMydyodyDfnMOYaNWD1ahu6Vv7cQ04kHV5h1mWs
        IJM7KEImPHZSSiuTvmhh34W8YA6wtfXcqO/YAxorESDQ9dI0EbcRQ1oeihTs+3BO24nGigjNOnZ
        9eQpZ6+/FEQiRNfYiQ+D62UMDdBQEoybKIWH3kxYClxj3oRz
X-Developer-Key: i=l.stelmach@samsung.com; a=openpgp;
        fpr=A2B9843766B15A4D32BCBF0DEC1B3A02E80CD5C8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduznOd2r/+4kG9yaI2px89AKRos/u3Yw
        WVzeNYfNYu2Ru+wWDx/cYHVg9di0qpPNo2/LKkaPz5vkApijuGxSUnMyy1KL9O0SuDJ+rv7P
        WLCHu2LvzRvsDYxLObsYOTkkBEwkFvZ9ZOpi5OIQEljBKPHn7Qko5wujxNvDT1khnM+MEje2
        bGSHaVlx5A4bRGI5o8T2VSuhWl4wSsyZMpcZpIpNwFGif+kJVhBbREBL4s7SDrBRzAJrGCUu
        919nAkkIC8RIrPlwgRHEZhFQlTh88j+YzStgK7Fv/Q9miHXyEm3Xp0PFBSVOznzCAmLzAw1d
        03SdBWSohMBsVon+m5egGlIkHl5uBWtgBmpu3jqbGaLoCIdEy6TjUE+4SDRePAJlC0u8Or4F
        ypaR+L9zPhNEQzujRNOVhawQzgRGic8dTUwQVdYSd879AgYBB9AKTYn1u/Qhwo4SNw4uZAQJ
        SwjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1SoS6/r3sExgVJ6F5LdZSM6ehTB/ASPzKkbx1NLi
        3PTUYsO81HK94sTc4tK8dL3k/NxNjMBUcvrf8U87GOe++qh3iJGJg/EQowQHs5II7/LTd5KF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MOlEH1ZlTVW6
        Unn5XgHr0s8frAN+nt2269//bW9OFq5QqV6w51bg8QqPvJ3a3q9+z7WN+xxZWrDm9z7e9q7K
        niqvM5Ii4aJ6kXKXLL3TpaSDo84b/TmnuNRlz7yIT/5ff3FN7+OZfzCUgTHg6hS+g3dZeXgl
        i5a9Ej+zV219yGzdhIy5S/gNHm9ann5YoUHqNP93wQedfMkT/FRefvvWJK8ddLbmoNvJYwUv
        72+5zRhQyzn3WMTJJ8bv/nPx9MR6v1i55bi0z4NeW42lDguS/wmnz7xVUHm5e/21qXxu89zl
        b7vVTxVXScqedNIjqFxtx++HsdFp/O//H8i6Uf33wOKLHQ/1OZ/PMU2eYPh8T60SS3FGoqEW
        c1FxIgCunI27lAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd0r/+4kG5y4Y2Rx89AKRos/u3Yw
        WVzeNYfNYu2Ru+wWDx/cYHVg9di0qpPNo2/LKkaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ+rv7PWLCHu2LvzRvsDYxLObsYOTkk
        BEwkVhy5w9bFyMUhJLCUUeLhhKVADgdQQkpi5dx0iBphiT/XuqBqnjFKrHrcyQySYBNwlOhf
        eoIVxBYR0JK4s7SDFaSIWWAdo8TcqT/ZQRLCAlES5z70MoHYLAKqEodP/mcEsXkFbCX2rf/B
        DLFBXqLt+nSouKDEyZlPWECOYBZQl1g/TwgkzA80f03TdRaQ+RICnawS644fh+pNkjiwfh1Y
        LzPQnOats5knMArNQjJqFsKoWUiqFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMmW3H
        fm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeJefvpMsxJuSWFmVWpQfX1Sak1p8iNEU6LWJzFKiyfnA
        qM0riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamA6GKGkWdV0dEn8
        I0nOvQFvP006l/EqXiPu7EajH/3Tvz6KP7D6mvuBPQVCpr55Bz5N+ij1fOGMra+n/Ctpj//q
        veYGT8LBPa63Jplslw+3n7JRVvmL0bf+pUenOv5e8GG5gMK0cA6nzy+5GX/838uR89fqqL/X
        tqZLO3fwaz+eM/PmxAifZR5RjU/3B8Usnp/ydJXk8dKuz7/fPXeo3b1uGeePWw2bZ3C08Ouc
        rTu4dP7DlsXWS5cI7vO6MP/91poH243cmNINJ9j/uy9UcFx+8vJc/es7jf3LTTbOv1Z7Ssl8
        zlqtoywRnNkXtBtEuidEMHBm1n2d3nDDJWqdF2dI/o3YeWKfeSc5zT37pe066zQlluKMREMt
        5qLiRAAuZH3aIgMAAA==
X-CMS-MailID: 20230203123220eucas1p2f9686f08bcb22cf1e21aefd25070282a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230203123220eucas1p2f9686f08bcb22cf1e21aefd25070282a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203123220eucas1p2f9686f08bcb22cf1e21aefd25070282a
References: <CGME20230203123220eucas1p2f9686f08bcb22cf1e21aefd25070282a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an input config file contains CONFIG_FOO=n the output one
will contain a line '# CONFIG_FOO is not set'. merge_config.sh
should not report it as difference because the end result of
CONFIG_FOO being disabled is achieved.

Inexistence of CONFIG_FOO (because of unment dependencies) in case
CONFIG_FOO=n is requested, should also be ignored.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/kconfig/merge_config.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index e5b46980c22a..c6fd6722f1a4 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -196,9 +196,13 @@ for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_FILE); do
 	REQUESTED_VAL=$(grep -w -e "$CFG" $TMP_FILE)
 	ACTUAL_VAL=$(grep -w -e "$CFG" "$KCONFIG_CONFIG" || true)
 	if [ "x$REQUESTED_VAL" != "x$ACTUAL_VAL" ] ; then
-		echo "Value requested for $CFG not in final .config"
-		echo "Requested value:  $REQUESTED_VAL"
-		echo "Actual value:     $ACTUAL_VAL"
-		echo ""
+		if [ "x$REQUESTED_VAL" != "x$CFG=n" -o \
+		     \( "x$ACTUAL_VAL" != "x"  -a \
+			"x$ACTUAL_VAL" != "x# $CFG is not set" \) ]; then
+			echo "Value requested for $CFG not in final .config"
+			echo "Requested value:  $REQUESTED_VAL"
+			echo "Actual value:     $ACTUAL_VAL"
+			echo ""
+		fi
 	fi
 done
-- 
2.30.2

