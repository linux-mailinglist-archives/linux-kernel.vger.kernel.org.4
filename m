Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257526D1642
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 06:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCaEOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 00:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCaEOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 00:14:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CF11EBD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:14:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a11so21752219lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680236055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuL6F8Lmv9Dt1yjSJ3G7sSdjffwXcfbl1vKoo3CVilA=;
        b=EgKhzO/qEiMhZk22PfTO/XpwTNEp9fE39mhkNQ2s+rxpsWb+Kq18zSbBPUfAJKBpW7
         at6t4LyDfQNSkltnlyiRODtyTQxdoPpeWvEI3XEGOLl5uBSPSf3kVf2cKazb1JMkml+U
         OPmjGJknf2fDKB8VuB4dIK8ZEvb7yZ6p/uaDz8WCniMVLkgV42DxIye2t5PtIvG+JvS6
         Al5X+jURwQuVB1mnc2sZD9srLlgaCdlnBtn3DyQnwGND5iu/D6X3KZsVEsmepMV23Eg0
         d/f5r4A680t9o1Snke6BbtZBI3HrbDW16PGBh1C87EJCY8/XZdpyQCP9FPQ/+raQBOq4
         edog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680236055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuL6F8Lmv9Dt1yjSJ3G7sSdjffwXcfbl1vKoo3CVilA=;
        b=PuNRiOVHtU+xX1SD99NtgW5Ijt9ARLiVPzrIQ1gCZTAwDdH49NO89+2xjSVvwsE9oI
         CLd8hBW+Mh+hzz+hWaU+qImgi+u6rXMgvOXWSl97k5TD6CxM+0SalgrTxPxf5+5j89Az
         t1IPbi1go5tafrht1QqICwRIKI9kIxy+FxBpNfq1PPv8wfLhbpXz1gMzmSMLYOS4h6jH
         Xq3vA3P00LCLzd6Je3hIKvivQinnH4f/vycKsTkKTmvP/aH7A/J8g/X2m2txhwySNEdI
         1gj/XOnM55OnTW0uSjLv+32NeOdfhH/v6MtVz6Q9+2595xfXFW//FrJkdI9uBR7iOBXF
         LZyA==
X-Gm-Message-State: AAQBX9eOirpV66YN6Js3jV+GIIeJbnTQ6xWog+itHSNYGvZdDlacW5cv
        aSap8vFon5etG+iclVhH5zR4EQ==
X-Google-Smtp-Source: AKy350Ybi7XHqypfH7rO2FGO73yVMky09II+4xJ5vdVCxxMGyluZmfWjEbxjkTnFPOxMi3NQat9VKQ==
X-Received: by 2002:a2e:9b50:0:b0:298:ab4c:a946 with SMTP id o16-20020a2e9b50000000b00298ab4ca946mr7413533ljj.37.1680236054735;
        Thu, 30 Mar 2023 21:14:14 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t2-20020a2e9d02000000b002a5f97eaef0sm181972lji.126.2023.03.30.21.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 21:14:14 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Subject: [PATCH RESEND] checkpatch: move duplicate sign off to separate warning type
Date:   Fri, 31 Mar 2023 07:14:13 +0300
Message-Id: <20230331041413.1908787-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some maintainers prefer to allow duplicate signatures if that provides
additional details about the patch flow. E.g. if the original patch
author pulls the patch from the patchwork into the kernel branch, this
can result in duplicate SOB tags from him, however this reflects the
patch flow (one SOB for being the author, one SOB for pulling the patch,
adding (and maybe fixing) tags and pushing the patch further.

To facilitate easily handling this kind of warnings, separate duplicate
SOBs into the separate warning class ('DUPLICATE_SIGN_OFF').

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patch was initially sent half of a year ago. It received the only
comment from Joe, "I think that's poor process, but whatever..."

Could you please consider this patch for inclusion or possibly advise on
how to modify our process or why this is considered a poor practise (if
that matters, we are talking about drm/msm).

---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c9..b30a868375e1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3134,7 +3134,7 @@ sub process {
 			$sig_nospace =~ s/\s//g;
 			$sig_nospace = lc($sig_nospace);
 			if (defined $signatures{$sig_nospace}) {
-				WARN("BAD_SIGN_OFF",
+				WARN("DUPLICATE_SIGN_OFF",
 				     "Duplicate signature\n" . $herecurr);
 			} else {
 				$signatures{$sig_nospace} = 1;
-- 
2.39.2

