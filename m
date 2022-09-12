Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09D5B52D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiILDXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:23:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738525C45
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 20:23:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t65so7056645pgt.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=01auDevlyZEsy9VNCmbrrsxvCF/1+AqShCC158mTMG4=;
        b=EQS6g+jqMTBKxQNNXTAg0/Jv5BUDoOzo/sjlXjUjvOykigv57iMUKGPzB+BW7aRK75
         eJq2ew80JptMG8itesP/xpHAq7cdw5moWnqHq44GjTscK2EaGstllG2V4U7c4dzYWiTP
         vMAgoC+RgWtORXboDw/ZXJZF3dpwjW0a6SJ3x9xVg7IQJaRGfbOhE2Pg11M71F+Jve1t
         X5NOQmTe2YyJjjhVxftW6XG8twaS7SE0+PoswBEPSoU2fu0O5RaisG3S60lbFb0jRBCh
         MgS0clo3Bj/5mJcp1AVKE7J7AZbOwELc1fEH9NkciPeZshTRiQAZRg5NxGO/NhgUJSyN
         u8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=01auDevlyZEsy9VNCmbrrsxvCF/1+AqShCC158mTMG4=;
        b=FUNo/WWEJXc8k/4PzdyoLmpMdvV1gPJ08woXG0JbYf4tAisYrWloywSqyvIAYxBBOp
         NDG0r8hPppJCA2mjNyGBnkyy8aCigQqzRWlRI3YKnZuUmI7WEeIkJfx+vD0E8L+Cj4Jh
         DySBeKc7ZAHIW/HHRz5wLZqgoJEeEu7KVTb4233Ncj+eMUYOc35X9nTQhHJKxvdbPXuK
         zoM23konPeHPQyw7La6zsg/YMg+PytAWmdlWSWHQ+k7Tim5M+cDn94riWbwkNrkbilJS
         +TakexaPufKy4HTddcaC3UtxVaynmbwWtMe84vjqF0SXAaNktgCMrU4LrCbD+6OVczb5
         K8Lw==
X-Gm-Message-State: ACgBeo3ikobvjfRHFVrKA2M4pObUvWVmmM/7b6xVfNP+ZZ/Fo+nKpPnh
        xxE2hflNjEwyK3Uw3yhlSuU=
X-Google-Smtp-Source: AA6agR42AMxdHeUm/hcZICJ4/B6hDejHuEWpIM4gBttsevn8sQyeXqBFzVnr4TVL7Bqrxu5DLJuwig==
X-Received: by 2002:a05:6a00:1910:b0:52f:13d7:44c4 with SMTP id y16-20020a056a00191000b0052f13d744c4mr24769860pfi.32.1662952981579;
        Sun, 11 Sep 2022 20:23:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id gc10-20020a17090b310a00b001fd6066284dsm4107754pjb.6.2022.09.11.20.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 20:23:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     sunpeng.li@amd.com
Cc:     Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        aurabindo.pillai@amd.com, roman.li@amd.com, Wayne.Lin@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amd/display/amdgpu_dm: remove duplicate included header files
Date:   Mon, 12 Sep 2022 03:22:42 +0000
Message-Id: <20220912032241.16259-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

soc15_common.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a93162633ae..0e42bf496a73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -98,8 +98,6 @@
 #include "soc15_common.h"
 #include "vega10_ip_offset.h"

-#include "soc15_common.h"
-
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"

-- 
2.15.2

