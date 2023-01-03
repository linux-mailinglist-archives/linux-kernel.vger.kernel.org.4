Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA265CA8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjACXs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjACXsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:48:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5510045
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:48:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 17so34349120pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kDnfWPh2h9/FS+QZS/MSOgsNnMP44C24NODsrzRFUuM=;
        b=JZ8UC9FMNChsjAjclGrQ6PEw9HlE0aeBAxKyAg+tRtQ71C1VRJ9l24kwhapJ7z+l0K
         QAVCJW+NtLO9X/viSTN5RnZV/oz8FFoCixVq1PpSxuniK7kmSWvjcy3oe0GiXLg0WJq9
         54x6qhh/PtzWp3DntyqNr3zplvC2uTHtSQIAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDnfWPh2h9/FS+QZS/MSOgsNnMP44C24NODsrzRFUuM=;
        b=XO06SKd7/XSU4kZw18wJot+Bh9ydIf1r9gN8iNTPZuvBXLpvO41e++6KQj79Y9hOX0
         8rtFdU/zCLXCikBTCeKk5S+7bxag+fXEoo5jBoZZGCq6vU727UrwoeuH7i0Zh3hV0a2N
         63KVWWv1qKa4jKO3Jbqp/dNyeLrL4Ro1OiWoPw8VhR8VCvZ7NsKQIThzk3nR5Qr9A2Pr
         ItF2qWBTYxoWb7hwTyZO29bEHHuPgtmoNIolEZ063CR27VCDZ8rLNseEdwPahelhrb9m
         PbdHwUX1khwp9qqD3m2fDFaax/8e8xktbDR249/AinJlNOhSsDkqC1xJ0wB1x4cXp/i4
         /Bsg==
X-Gm-Message-State: AFqh2krEnfemiw0p6TbAFkz+J+iTgDRUJLg35sZiLWjj+5IhXCT+S0gV
        Oj/8PqMyIPrHo1lzjmCuZXr5PQ==
X-Google-Smtp-Source: AMrXdXuepV8mNjVcT1jIuOIjLZRa7GtnpsPXc2zlWgD4hMVRlZuIUNt/EGTz5ehdWZmXD6nTu/ZW9Q==
X-Received: by 2002:a17:90b:1bc2:b0:212:daa7:590 with SMTP id oa2-20020a17090b1bc200b00212daa70590mr64679889pjb.7.1672789719104;
        Tue, 03 Jan 2023 15:48:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090aa61500b00219463262desm19148364pjq.39.2023.01.03.15.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:48:38 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RESEND][PATCH] drm/nouveau/fb/ga102: Replace zero-length array of trailing structs with flex-array
Date:   Tue,  3 Jan 2023 15:48:36 -0800
Message-Id: <20230103234835.never.378-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; h=from:subject:message-id; bh=yNDAQz5L/StW+b14k9XOZhzSrABBg07i4qvrOt4rnsQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjtL7UV5oPZ4aSWc790jMdrk79oP2SuDFrhpYN3dAV U45tjoCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7S+1AAKCRCJcvTf3G3AJjfoD/ 9eZAMC/zIpdWOvrTeGfrphFv3DowrWpQpy2/jYIqQfGi7/r2Yp9ZLfiIgpABUIQFOEBtxRI6DBYzhn j2Jnr9dC8QT94UIJBjmGYn3FGybpbB9n0xlQs+FvSs+RF9gvvOqA8Eue8I+8S5KCW5gjQOB3zOXP30 A82/LDSd9t6zwmSrjqJ/bDzpZ5W1zZxLIBlE+lkIoo4olaSzK2DQ6Kn78aGPoICV2Rs6a4kduTTT+/ CYX/w+1ba6iK7n/cA0x8z8HNR6BPGBhedyeSQsU0PkxyYKBnJ7+lOeRozCD0mtCrCvCIB8ZCZ3xUov 85+IMnp6earP8cWAh0GGqEJUlZ/R2OaiB7eLG4QqsMZQfcoFe6s6VJUiqqf2F+qI3NjgzfB4aIfFEx zXVZdNH04Mpb/k0nl/PtHO2Uj42hp9eenr6zjMPDBsQl4oMUn6nemlkNrfw6pnJncakLLH00TjFkCY ObgbCLGQDpYqt1sNj3Ogv1CDBgNtNAgXyOfLVbwKxUr/widlNwnCPLvMdGkW+vhkg6mpiFdA9Bzo6Y 3lYANl81UelN34Y7TmyIWAEYr6Hr1XMKAUuubdA3tlCoQLPP0sXfgFv5S3Z3fAeRp4tRqLAMDVJVKW RIHhb0ND8kYXODJQU314xcLTgpvXoaSamYHoUlD6hP8snaFkWc9XRjhuWaMg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace zero-length array with flexible-array member.

This results in no differences in binary output.

[1] https://github.com/KSPP/linux/issues/78

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gourav Samaiya <gsamaiya@nvidia.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Sent before as: https://lore.kernel.org/all/20221118211207.never.039-kees@kernel.org/
---
 drivers/gpu/drm/nouveau/include/nvfw/hs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvfw/hs.h b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
index 8c4cd08a7b5f..8b58b668fc0c 100644
--- a/drivers/gpu/drm/nouveau/include/nvfw/hs.h
+++ b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
@@ -52,7 +52,7 @@ struct nvfw_hs_load_header_v2 {
 	struct {
 		u32 offset;
 		u32 size;
-	} app[0];
+	} app[];
 };
 
 const struct nvfw_hs_load_header_v2 *nvfw_hs_load_header_v2(struct nvkm_subdev *, const void *);
-- 
2.34.1

