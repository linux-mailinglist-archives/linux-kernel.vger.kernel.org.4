Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98438633D20
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiKVNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiKVNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:07:54 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242BE10E2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:07:50 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1669122466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lwqi47KLlf+3se6EowjmL8XqQoZpHqyKwAHzX3T03qY=;
        b=i2VYqD2MMJrb7FwHOZ5DvkAcxlMqgQBYCi1LOlVzp/AZxHfAe1oPPzhs667NWMtJydanlX
        PGW6skwbrIfUs2wdJkzZjMxSqIXhAmyR96qq78Ppbzg1iZuqm7S2yR4LEHn1yRn1CAGXMG
        WASvflA1/G2zE+JGw+jL+JFMtc0BG6U=
To:     Evan Quan <evan.quan@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: 
Date:   Tue, 22 Nov 2022 16:07:46 +0300
Message-Id: <20221122130746.24432-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Tue, 22 Nov 2022 15:51:44 +0300
Subject: [PATCH] powerplay: hwmgr: added result check

The return value of the 'div64_s64'
function called in ppevvmath.h:371
was not checked.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
index dac29fe6cfc6..82aa7130d143 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
@@ -357,6 +357,7 @@ static fInt fDivide (fInt X, fInt Y)
 {
 	fInt fZERO, fQuotient;
 	int64_t longlongX, longlongY;
+	int64_t result;
 
 	fZERO = ConvertToFraction(0);
 
@@ -367,10 +368,11 @@ static fInt fDivide (fInt X, fInt Y)
 	longlongY = (int64_t)Y.full;
 
 	longlongX = longlongX << 16; /*Q(16,16) -> Q(32,32) */
+	longlongY = longlongY << 16;
 
-	div64_s64(longlongX, longlongY); /*Q(32,32) divided by Q(16,16) = Q(16,16) Back to original format */
+	result = div64_s64(longlongX, longlongY);
 
-	fQuotient.full = (int)longlongX;
+	fQuotient = ConvertToFraction((int)result);
 	return fQuotient;
 }
 
-- 
2.25.1

