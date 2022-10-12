Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3905FCB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJLSx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJLSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:53:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F64FF8D3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:53:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gf8so16024727pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUI2zzepOnCEU2KAh1PakPcQFkZcRivQX+cynj5FE/k=;
        b=G47NFXoBtILJJHsl1h9GdNIzukt6VCgb5/pFLeR7U3O5C4N4qiIoQW1NZPvUsa8st/
         oPEm2Nx/P2qbHAMkKQd6lCihhUbjxai2CtXpicsaa4D5ZMIjuOiplNYvO747uR/eVsS3
         qIYRG3YYLOh0QhkdC4Pj6EJGdWLkY13ZTg5uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUI2zzepOnCEU2KAh1PakPcQFkZcRivQX+cynj5FE/k=;
        b=GBXLJ5maO+G3SMNJMza0Pcem0TU2shzfJk7f3xDOXxnEYehi1wO4/70AsJ7JhmN/LX
         hPDO72l/2j4PHsADi89h/U8kv4EPRBVuE6hGhZmfkXE+4WbN9Uf40hSoOhN33RLTbpM4
         sS86/a/+lTsA7T2b+74ITiG6U0728Jdq0MBatJH6nJbzS+usSfT79wx4Kh42QOt6AFKC
         A0cOpEGlxpc0NTxo/I8t7bC7ZIMDuCp/g+0XfheqEBJCJXx9CY9xlF2RshBYIvLeS+19
         xXohAyfjcMff8yXACwS4IG8M4ivNhxyjRFRhMl3UlwR0QvhHZwv0cDmtKlRBuQvkiE3f
         Y9MA==
X-Gm-Message-State: ACrzQf1B2JtMoTZAOpCxVxkZ2GUBtF0amRB2/6IMj2SdLB/fGtuxKigQ
        zu98OcC+Sh4plDlWWqTNv1U3JQ==
X-Google-Smtp-Source: AMsMyM6tV4/PVbF4fBXiv77LdOk7IfPzalAhIVuB7YI1s3Hec2Euf7PJLzGzNvVQPMDGgGwcWHVGdQ==
X-Received: by 2002:a17:90a:50:b0:20a:b146:e75e with SMTP id 16-20020a17090a005000b0020ab146e75emr6663558pjb.216.1665600803058;
        Wed, 12 Oct 2022 11:53:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7972f000000b00561578478f9sm194609pfg.134.2022.10.12.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:53:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Date:   Wed, 12 Oct 2022 11:53:16 -0700
Message-Id: <20221012185234.never.936-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3429; h=from:subject:message-id; bh=4n3aQuAgsH9cCFaGFV2YF2qCSZt1D1FxI4ZpoSOMr4Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRw0bGTY4oQVYR+ruKC+orN1r6Teh+Od53Fv9waOT HIZn6LuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0cNGwAKCRCJcvTf3G3AJu5FD/ wMubbkTAppw3VbhksSb2rvGtd2RwYLblLaevZVfdiIIxQKesFXrZQi/wS2Cwb6XxaSTXOEgSOffPOa zhEq33SvE4ENM7J5ZqIAPv9VqvtcX+fPBliGpBoGcWAnKCxR667DtFC9LZXMeLhmxjbPMgRAMZoOAU 4//ZxbyuL9UHpu800Xr/8nnEuJ3cMu4nHovmggaKixXK1N5GX1ZdcBWCo5RGdwh5n0Iif3o9HJJjmU s3UwoFQvJHoUqMH+FEZHmdFiJE/XGDbJ5JwNXNfpqU5x4d8xrvyJ3JbsiXmQeugU2GOZoc22W6FrwS NIN2b0hZ4FEl77gdRrWT/Vz2bTj6VuezL7QRwgolwQRuaVG6mAinZCwTnbWDttcvkNvuMy9R5MekK3 aVn0JOcp+BCMyv5VZ12X0equ31lB2Xs9L+eK9VgpfeHoIHN+RjohE6es2z0WiIfiYDtk/CG2t6vwGQ sd9WC3iTu9CgiV3pzaUDGybpycEYkapB5rMindsjvRaLBpSPcIGd89A6P06RRh5/vd72Wpe1tskKRU kYyAUVF5RAeskLkQHaDW3hXYoiW1iMipK+yGMKGoRyl7udlBJOde7Zhj8TDuPKp2KV6kuJmFZl6t/J fwr4H8dbXiTgXoSmQtZNB0kMV9isVsilNsltNeyV26+C8DN9xIJbWZO+Y/+g==
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

Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
Sparse:

drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
drivers/firmware/meson/meson_sm.c:206:9:    expected void *
drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base

While here, fix this warning as well:

drivers/firmware/meson/meson_sm.c:85:24: warning: Using plain integer as NULL pointer

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202210122023.zF56nCzM-lkp@intel.com
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/meson/meson_sm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 77aa5c6398aa..4efde225a580 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -82,7 +82,7 @@ static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
 
 	sm_phy_base = __meson_sm_call(cmd_shmem, 0, 0, 0, 0, 0);
 	if (!sm_phy_base)
-		return 0;
+		return NULL;
 
 	return ioremap_cache(sm_phy_base, size);
 }
@@ -167,7 +167,7 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
 		size = bsize;
 
 	if (buffer)
-		memcpy(buffer, fw->sm_shmem_out_base, size);
+		memcpy_fromio(buffer, fw->sm_shmem_out_base, size);
 
 	return ret;
 }
@@ -203,7 +203,7 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
 	if (!fw->chip->cmd_shmem_in_base)
 		return -EINVAL;
 
-	memcpy(fw->sm_shmem_in_base, buffer, size);
+	memcpy_toio(fw->sm_shmem_in_base, buffer, size);
 
 	if (meson_sm_call(fw, cmd_index, &written, arg0, arg1, arg2, arg3, arg4) < 0)
 		return -EINVAL;
-- 
2.34.1

