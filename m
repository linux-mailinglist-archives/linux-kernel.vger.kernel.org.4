Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844CC67293B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjARUYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjARUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:24:05 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA30C5D904
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:24:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g23so186772plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7nQ+g2J8OLWVvtfKxW9hliY4Yc3cv4OwnKnX3U91hE=;
        b=MhP7CFPKMusVUiw6o4PRowhujO/e8aU5sJEsYfnFGzwkO0eKdjfTpPALqtQqB5Zy6j
         4HhX1moUWoFgSiTgqdNnBCZ6fwdpJ4C8Af74LEg3m+WUiFaqrMImOxuHx3uDzpXXalR4
         tushRG6S03QNI9iVt8BOoggY9UMF8Cxi+zYGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7nQ+g2J8OLWVvtfKxW9hliY4Yc3cv4OwnKnX3U91hE=;
        b=0cCGaGR+o74Jurh08/XntGl4chNuLyQNl/iVzNTm+edtBn78KWjWbdbjtPN6+MlzuZ
         NLobh3+wVme06DtsTCRLN/nlyaXpmVNjIncsq8oRs/3BgEj0csqqLNiVjoO58/klOo4b
         2+YepXczjwwUb6KFrNxznz/IsE7FYOscOV/i0547T5oQDHEwmBImUAfqTnPm9CCvWdqY
         MvZRNHOreAxVyzAxU4MzkeKUekBFhTAfcYZEykYnoMZAFOf1Rk9SQVvlvOVs8BuLqLAb
         Ivh67f5gjwPMfheLgVVT58CXobyuBpr+g5HoPDXEvuECUhchsHAUq2JD2wtDLVWPT5/f
         Hn2g==
X-Gm-Message-State: AFqh2kpYWvrfwSKyaMOxJIuOcDW5YtHpMnGDnb/xuCtB2S7ZF9xJH+5a
        fLAjOHcyz9BBym1IIOjTJbCreg==
X-Google-Smtp-Source: AMrXdXuvhtr6QYHTUipL1E7izXxzP6eU9ELvbbiqPHuu407BTk2+78EO8VAixW82hWCQezgP9BpVtw==
X-Received: by 2002:a17:903:32d1:b0:188:fc0c:b736 with SMTP id i17-20020a17090332d100b00188fc0cb736mr34331887plr.67.1674073444029;
        Wed, 18 Jan 2023 12:24:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001891a17bd93sm23667416plh.43.2023.01.18.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:24:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: Reorganize gimple includes for GCC 13
Date:   Wed, 18 Jan 2023 12:24:02 -0800
Message-Id: <20230118202355.never.520-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; h=from:subject:message-id; bh=vukSS8cdZdqqtgn6apidKMhxtj1t0IFOu1S+KhQ8h60=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjyFVhjOBNRZYH+UzANpQMnfOjTUf8wrb94vsB2GjK IDs1+4mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY8hVYQAKCRCJcvTf3G3AJmyREA CcSyhCMz+CA+i5K0m3iYOM2pKAQebVxf9SOeiSsHQ9qtRdv7a5z6CkN/4dhLFAdsSWkvEpnms+0XUp h7G4EIyluvBiJiLLXDusha33r5D26q/YU4jyPKPLBpRAnSG9NjYaQzhgZ/D5rdJZHfnFFMsRbNtUM2 fNoIlLb8dPW61nIg5aa3q+OytDBECibjwTGhfTRfKMCXTxSHQACjBshgbDZiFJjq3KQskjX0oaoueB rbnd4ZVAiK7cFr+Tl7mAqFIj0mfZ/GYFGvI7DTuFjSPlvrSCtNARfYN5JWT6jkdQNjkRChzbN7Wk4e t1oo8yy1+5Z4TatJUjAQ+MHPLTkG29N7QDn+tq3EN+PGbPgQxV9n+EgPv1S6oAw4/mNWVSqaautpSu aQTzy443t5hxKSBar1lgdimhQ0ftdCqgY2054yImNbbpTXWNDsJMIvgIlsXHpYUt/IBSqhudau5ey8 vnb073zDoc8LgAQSkN0a3SCjYfPNc7vqt+xoJuZVr5DZs/mpyTIA6STUfj9QJkiVfflaPqdAIaWC3f S2VjdKhhaFXnp24XgMKV43Cz53EiTQ1/EDN91PauJOI5LmHJb7AfX9vrtnmnTC3uFxJKwybVBVMEi8 0wjQFuS1iUmK4YrLAuqcXE/aA2kCRBRASAN/wkM2oNrPucr9pt8HJ4fSszkg==
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

The gimple-iterator.h header must be included before gimple-fold.h
starting with GCC 13. Reorganize gimple headers to work for all GCC
versions.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/all/20230113173033.4380-1-palmer@rivosinc.com/
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/gcc-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9a1895747b15..84c730da36dd 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -71,7 +71,9 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#include "gimple.h"
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -85,10 +87,8 @@
 #include "tree-eh.h"
 #include "stmt.h"
 #include "gimplify.h"
-#include "gimple.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 
-- 
2.34.1

