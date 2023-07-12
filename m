Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E2750A01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjGLNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGLNvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:51:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C119A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:51:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-557790487feso5044681a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1689169863; x=1691761863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TI/9mwThD0EXzG5gjilsVwhp7evcdhgh2WPnV+bXJ78=;
        b=WYz07NOSDuwXlaS5UfuI97CPUuXEDwuHLQr2p9Yo+QesQBOp4bUNaSJgHczx3tvfVP
         LPWQ0fQ2xTMLbWaNHIlRWdkXIs/5NQTVb6nInndk/ARdW2BC35vHj/5HaZkWFAK+m9D1
         eyF3yoCKz25XW21nC2U6G0jN/RJOiYptQ5W9zBmEsWfh+Jh0+MxjJfdU6Bf/XDR9u0Wy
         cSaH037a4O4YlAHWacFwZP/cHoBMEF2D0E+s8hyAu4wtyHthB6X6sP4Bq1q6EBKegKfi
         FHnUxn+RYEBE1uiU+4dfI772eM0PMlRua6CuyReOyFIpN0aKcIqgXIQWF/ilGHviKR/O
         vjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169863; x=1691761863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TI/9mwThD0EXzG5gjilsVwhp7evcdhgh2WPnV+bXJ78=;
        b=B47fviCb2drIx8a/qZt09ZcrrPlygjzqwscJJzeSK8nNWGOVoAwlUdwj4KM/moTJ9e
         8+ojTB8u4P7ne7DcJjSdYoHM2yvfgjyah59sSOA8R0jXDUwcNSJFDhtMYhlmplv+rfxD
         hvQgf5nDBCi+8JdZsF7AtCUPMp2rnuQTMAtp6lQHkZGyC6T8x+8G60DbekWxlHhKcbfq
         tJ78h8wwkpsNgKiv0UYQBtcg6Plb8Tm90cp1YvGRBD5F6N3eIhSvn+FIvc8cYpZ4dXqZ
         yNuh8omT2GL3WmrMxVVqKbKoIjruj1FQGiBJI7yHTYBE5YnLfFC60fzkQbAYeWlbvEi0
         uPKg==
X-Gm-Message-State: ABy/qLbnQH4sIK2YPFQoEP7YCqd/X4pTOnU/Ptu9Q+9803AxvPQKNdTH
        puF2H4Rm4MwHJkHwBGkama04LA==
X-Google-Smtp-Source: APBJJlH4Ln66xJcSv96ugiUVmv3fe6pFBvSRRTt4u7Q/TWI6JScqGRDdsTmf1STJac/9OI8O6BecOw==
X-Received: by 2002:a17:90a:f182:b0:263:312:611f with SMTP id bv2-20020a17090af18200b002630312611fmr18585171pjb.3.1689169863331;
        Wed, 12 Jul 2023 06:51:03 -0700 (PDT)
Received: from localhost.localdomain ([47.75.78.161])
        by smtp.googlemail.com with ESMTPSA id n10-20020a17090aab8a00b00262e604724dsm9996047pjq.50.2023.07.12.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:51:03 -0700 (PDT)
From:   Xueshi Hu <xueshi.hu@smartx.com>
To:     akpm@linux-foundation.org, mhocko@suse.com,
        quic_charante@quicinc.com, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, Xueshi Hu <xueshi.hu@smartx.com>
Subject: [PATCH] mm: remove clear_page_idle()
Date:   Wed, 12 Jul 2023 21:49:59 +0800
Message-Id: <20230712134959.145373-1-xueshi.hu@smartx.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers have now been converted to call folio_clear_idle().

Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
---
 include/linux/page_idle.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index 5cb7bd2078ec..d8f344840643 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -144,9 +144,4 @@ static inline void set_page_idle(struct page *page)
 {
 	folio_set_idle(page_folio(page));
 }
-
-static inline void clear_page_idle(struct page *page)
-{
-	folio_clear_idle(page_folio(page));
-}
 #endif /* _LINUX_MM_PAGE_IDLE_H */
-- 
2.40.1

