Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE2707675
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEQXdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjEQXdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:33:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627840EF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:33:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae4f28454bso10997985ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684366396; x=1686958396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsdBaiO+SLRmvoF1oxELdQlQ303GgQ3he6ImyAqilwM=;
        b=J/MaOic+T6lZSX9z6Crj6gInRjMD4E+E+bGF8IeK/gvj8+kVm52/pHWph1u3U31zYE
         jIREYD7YA8vdvmTFseMWbpy5Nv0+FJ9aDZeIyNdd6yH1d6RIjSOmxQv7oWoVirv0X/E3
         +iEcRGwC9ZGFbWfLGxA7xjhE6A9XCca1Op/D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684366396; x=1686958396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsdBaiO+SLRmvoF1oxELdQlQ303GgQ3he6ImyAqilwM=;
        b=M5Zsg7bMpUrFq2fNnXjKycKxrfq1n0pzqn+Rup56OfMUjBTmjNaF5Lwf6NmwzQtZF5
         C+cTRAyOgkH5/zvBW3gmnzusey2dUIsBDRssPxzg/ebzjZAx+s4TcDKaUMK1fQkBEc2B
         ZjoF3cDbMDMkFfcQv450XBxhN2UNxHnc3IQZ98lXWKLwl9VpCFDCkF/8qfYxXzcRAhL9
         aVEqG+kaCdJmegTiE7ZO14BsANRXBBFsTzWGjYHaxV6i6YmEpK3lMHC+/Pa0oZM/qgCB
         mAtFI4TqmWowHA29R/SzCkuLLQn+vNkpBENCXW5K52gcUQ9tBToYZIcb0wxOwmlOWmyS
         3L9A==
X-Gm-Message-State: AC+VfDzL6QhR+CjFOZrE/iT25tH9uRwfqEUP0t4cI1o9zgywkcofHsev
        Vc7Pz7ekCD/EzLSqJnuaypNv+A==
X-Google-Smtp-Source: ACHHUZ6E2Rw/PI0VAhjazUgu2RxKRx7eteRLCIGlE1gszdmLtBUw2S018ls9GRz9WQsxYdPoqGDQIQ==
X-Received: by 2002:a17:903:441:b0:19d:1bc1:ce22 with SMTP id iw1-20020a170903044100b0019d1bc1ce22mr456930plb.5.1684366396668;
        Wed, 17 May 2023 16:33:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a04d27ee92sm18103534plk.241.2023.05.17.16.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:33:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Song Liu <song@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] md/raid5: Convert stripe_head's "dev" to flexible array member
Date:   Wed, 17 May 2023 16:33:14 -0700
Message-Id: <20230517233313.never.130-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; h=from:subject:message-id; bh=dQaDdwwfJIKVOpP+xhSN1JdgX+awrlBT4qD4Mzl0Qq4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkZWQ6fyNNtbsV/hrySf2Chk5e0QLsK0bNKO8z4CGK W/FZl+6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGVkOgAKCRCJcvTf3G3AJkBVD/ 0VnC+3+XtytL1FbA2D8cGLXcifNdjNC2tFU+YvanxrXpbAXCMZMNbbLI9x/wA+DpnMgDCIorVvmzxp 5qOg6fKbI521D3qFRGLs8+zvjo97zAUnamMh5P10oVxDuR8+/mTpLJqOriXMDpbWQ59PPiue9d7y4i A2Ypz4LBiPgfwTy28j9oMEjIFrJdLJ8f6fDIk/+ylA13ye5HybcjkqMPnw0GFcaqSw9QKPY04SZwdI V3gofJWC4TrHAvO8UlrBXlHn/85ONM/WVetDN2CbBnAtnbhVM5Dvl4q6w/EIEmzpx0qLW2/K+XS/hc TBfQwNA3x/qN4Q05uJL8MOots/9ubwpvVAkP04R2GWnYra7dSuQ/qx9n7o31zZRAxNpLp4sZdCxg/j OPRzEvMElGft2bf2uZBvOhVkAmLIF3g4S9miE4hN112NTumjDidb3fDdAD6QOxN4WmV52AoNbYl9Wn vGAjU36QjmZHLEwcZT6tjXBIN2lZJhV5At1cWpn7wETRK2cf3/9hcvabLdoGem+0uSUPL/5dUtkE06 wgRJw/BNYXNanjMEU7MwSQH3+q/ZO8gs7KWh5tW9ugSylw28UAFJq9ZrkoX553GNAyC3q3cCGxLlEc jpl3o64ZLcZvNX0/+vF8mJpYtCDj+CmiWU6+qpL+68medw17eMHWEIKs1fGQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace old-style 1-element array of "dev" in struct stripe_head with
modern C99 flexible array. In the future, we can additionally annotate
it with the run-time size, found in the "disks" member.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
It looks like this memory calculation:

        memory = conf->min_nr_stripes * (sizeof(struct stripe_head) +
                 max_disks * ((sizeof(struct bio) + PAGE_SIZE))) / 1024;

... was already buggy (i.e. it included the single "dev" bytes in the
result). However, I'm not entirely sure if that is the right analysis,
since "dev" is not related to struct bio nor PAGE_SIZE?
---
 drivers/md/raid5.c | 4 ++--
 drivers/md/raid5.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4739ed891e75..95aa74aea076 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2433,7 +2433,7 @@ static int grow_stripes(struct r5conf *conf, int num)
 
 	conf->active_name = 0;
 	sc = kmem_cache_create(conf->cache_name[conf->active_name],
-			       sizeof(struct stripe_head)+(devs-1)*sizeof(struct r5dev),
+			       struct_size((struct stripe_head *)0, dev, devs),
 			       0, 0, NULL);
 	if (!sc)
 		return 1;
@@ -2559,7 +2559,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 
 	/* Step 1 */
 	sc = kmem_cache_create(conf->cache_name[1-conf->active_name],
-			       sizeof(struct stripe_head)+(newsize-1)*sizeof(struct r5dev),
+			       struct_size((struct stripe_head *)0, dev, newsize),
 			       0, 0, NULL);
 	if (!sc)
 		return -ENOMEM;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index e873938a6125..6cfc74162b41 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -268,7 +268,7 @@ struct stripe_head {
 		unsigned long	flags;
 		u32		log_checksum;
 		unsigned short	write_hint;
-	} dev[1]; /* allocated with extra space depending of RAID geometry */
+	} dev[]; /* allocated with extra space depending of RAID geometry */
 };
 
 /* stripe_head_state - collects and tracks the dynamic state of a stripe_head
-- 
2.34.1

