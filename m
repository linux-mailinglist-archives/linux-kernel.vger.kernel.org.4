Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED805E8AA9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiIXJU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIXJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:20:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7598D06
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:20:18 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZNfD2r06zHtkL;
        Sat, 24 Sep 2022 17:15:32 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 17:20:09 +0800
Received: from huawei.com (10.67.175.88) by kwepemm600017.china.huawei.com
 (7.193.23.234) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 17:20:08 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <linux@armlinux.org.uk>
CC:     <lizetao1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] arm/softfloat: Remove unused variable "bSign"
Date:   Sat, 24 Sep 2022 09:16:21 +0000
Message-ID: <20220924091621.4009468-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.88]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc report warning as follows:

arch/arm/nwfpe/softfloat.c: In function ‘floatx80_rem’:
arch/arm/nwfpe/softfloat.c:3071:17: error: variable ‘bSign’
  set but not used [-Werror=unused-but-set-variable]

arch/arm/nwfpe/softfloat.c: In function ‘float64_rem’:
arch/arm/nwfpe/softfloat.c:2247:17: error: variable ‘bSign’
  set but not used [-Werror=unused-but-set-variable]

arch/arm/nwfpe/softfloat.c: In function ‘float32_rem’:
arch/arm/nwfpe/softfloat.c:1349:17: error: variable ‘bSign’
  set but not used [-Werror=unused-but-set-variable]

Only assign value to variables "bSign", no final use. Fix by
  removing them.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 arch/arm/nwfpe/softfloat.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/nwfpe/softfloat.c b/arch/arm/nwfpe/softfloat.c
index ffa6b438786b..cbfba26a54af 100644
--- a/arch/arm/nwfpe/softfloat.c
+++ b/arch/arm/nwfpe/softfloat.c
@@ -1346,7 +1346,7 @@ according to the IEC/IEEE Standard for Binary Floating-point Arithmetic.
 */
 float32 float32_rem( struct roundingData *roundData, float32 a, float32 b )
 {
-    flag aSign, bSign, zSign;
+    flag aSign, zSign;
     int16 aExp, bExp, expDiff;
     bits32 aSig, bSig;
     bits32 q;
@@ -1359,7 +1359,6 @@ float32 float32_rem( struct roundingData *roundData, float32 a, float32 b )
     aSign = extractFloat32Sign( a );
     bSig = extractFloat32Frac( b );
     bExp = extractFloat32Exp( b );
-    bSign = extractFloat32Sign( b );
     if ( aExp == 0xFF ) {
         if ( aSig || ( ( bExp == 0xFF ) && bSig ) ) {
             return propagateFloat32NaN( a, b );
@@ -2244,7 +2243,7 @@ according to the IEC/IEEE Standard for Binary Floating-point Arithmetic.
 */
 float64 float64_rem( struct roundingData *roundData, float64 a, float64 b )
 {
-    flag aSign, bSign, zSign;
+    flag aSign, zSign;
     int16 aExp, bExp, expDiff;
     bits64 aSig, bSig;
     bits64 q, alternateASig;
@@ -2255,7 +2254,6 @@ float64 float64_rem( struct roundingData *roundData, float64 a, float64 b )
     aSign = extractFloat64Sign( a );
     bSig = extractFloat64Frac( b );
     bExp = extractFloat64Exp( b );
-    bSign = extractFloat64Sign( b );
     if ( aExp == 0x7FF ) {
         if ( aSig || ( ( bExp == 0x7FF ) && bSig ) ) {
             return propagateFloat64NaN( a, b );
@@ -3068,7 +3066,7 @@ according to the IEC/IEEE Standard for Binary Floating-point Arithmetic.
 */
 floatx80 floatx80_rem( struct roundingData *roundData, floatx80 a, floatx80 b )
 {
-    flag aSign, bSign, zSign;
+    flag aSign, zSign;
     int32 aExp, bExp, expDiff;
     bits64 aSig0, aSig1, bSig;
     bits64 q, term0, term1, alternateASig0, alternateASig1;
@@ -3079,7 +3077,6 @@ floatx80 floatx80_rem( struct roundingData *roundData, floatx80 a, floatx80 b )
     aSign = extractFloatx80Sign( a );
     bSig = extractFloatx80Frac( b );
     bExp = extractFloatx80Exp( b );
-    bSign = extractFloatx80Sign( b );
     if ( aExp == 0x7FFF ) {
         if (    (bits64) ( aSig0<<1 )
              || ( ( bExp == 0x7FFF ) && (bits64) ( bSig<<1 ) ) ) {
-- 
2.34.1

