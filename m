Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A962FF32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiKRVMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKRVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:12:12 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B049A25B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:12:11 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z26so6037801pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZy40ckMJK9PstrSORSMVw9LuD5M42HuElen5aK+uEs=;
        b=YsibLVMHY4zS47SGC2k6c12KtYewhksNOs+sYyriWf5/rkBDw8uC3HDs/f2Wj2L3Gj
         BVm78lwkUPik7ocGkhAa3Kl4tsNM2qjas5VtByHPDLiqfCZ7H6xt+RUmd0nfLpgVFGa+
         TGWDzas1X6ndUC9LeJnozesYDmetjh/aAn8Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZy40ckMJK9PstrSORSMVw9LuD5M42HuElen5aK+uEs=;
        b=mNVYlhVgY4ssqgRtj/rBadbtEqojmFWrdUhQZ67Io/ZcLCxtMbNhmlbu6k88uZ7hxf
         fYNNhoCiPMyiLAY3pRHqbvpglmNLyVGVWS9SGcVnH/vMCv67eNjeuSE8r2z8JsRgNs7v
         QRjZSED1qe0VQ3mYmU/GtpxxBpaoi1B5crJmYYyCxASUHH9c3cbHkNCidKTELFIEB6b9
         iNSxUADlU7jrX5mBCafgMnj205S8oPKwJCe5M2UkwfG81O58Ul09kH8t3QMWNCuJbGeD
         pQPFwG+SDBv85WKL0vUa1GyjSU+ihSCsWl+Y84UXEXBV+SPh4jX5Mqahq93K77RZeR1w
         xx4Q==
X-Gm-Message-State: ANoB5pnJLnFKishx8TD9/IpobrT3UkgxmlRa4rZuqyI/jVPegCUdJcWb
        SSnADmH6H5b6gOQou7vrkjYlKg==
X-Google-Smtp-Source: AA0mqf7K8L+3ggQrBqjW5sllCMvwU8TlFsM8+MyfYc4TYEHJRKBuT3Ac3K/jUbWeUkf/xTrdlksb6Q==
X-Received: by 2002:a63:5c59:0:b0:440:3cc0:c062 with SMTP id n25-20020a635c59000000b004403cc0c062mr8308527pgm.10.1668805930887;
        Fri, 18 Nov 2022 13:12:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b00186a437f4d7sm4218924plg.147.2022.11.18.13.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:12:10 -0800 (PST)
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
Subject: [PATCH] drm/nouveau/fb/ga102: Replace zero-length array of trailing structs with flex-array
Date:   Fri, 18 Nov 2022 13:12:08 -0800
Message-Id: <20221118211207.never.039-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; h=from:subject:message-id; bh=X9HCxkhxMUKHNvL3i6xwv+DIq3QBR7MiLcT0RJeQqIY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjd/UoT/JDrfBTo/vcofpBixe5bpHWDrFyzZ1EdUlt Es/j9QSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3f1KAAKCRCJcvTf3G3AJhAtEA CYWhughNKE0OapwIXiefhx+jOiRBDaUC8hfzPm33xTb1ARxGJxY9kRrmeToWC8sE1VDug0m8vukcy5 QgKz72Po6nwKPbCqifUHhkVlNVW1c4PZxpf03G50RR3ly2UCPVXjBtKPilwvXblNyMMzOLM6aZ2+Uo Y7B+ZnxNP7RDoPiEk6EDqeBuXW0eFpjan4RIoURtXVRTj8cnh5GvN24iwWJiU07GKNSb7rUSMnyc+e TfTLqSbV7JrEuCQ5rtVUG5x+lbqlxzBURXXlz0P6+qZ9YbK+t2cc67oQJNi267V48nMO2KK3pT3rjz wAuqSiMoJAxtvJSd2O5qlCNiMTPE07V0aAecujkq+mm26kIvR9Enpvh5ZxDPUUy35TQeezQmq6jn/i F4CtMYWFkfD5lS40SBlR+47zlf9gvQHLkTJ9APICVfRmI2OurXDqtsz0OEoXv9hlsGEopLnYW39TWZ CYF0mAo/DMBgUMx6PnJ7SGyfsPnqjD4vhebC/RwGvx8KpDlfpfL58/PNMuO0PBe58TV97WjBDuhd7L 3pTrWdpxtaojtEUyLi+5Cya2YUt2Id8kn3VHa10utEc7F/jrEzFYHH8sgKuRR9d7Vv8Ql/Ucl3MOOP tqfaieDGKT4+2+1/nRGn5/zf4FLvKPJRW24HNWPRMJBkDXu9JgdzMkE4vLnA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

