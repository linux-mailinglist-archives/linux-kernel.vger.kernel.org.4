Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB438720D4D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjFCCba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjFCCb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:31:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C9E41
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:31:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75b04e897a5so309791485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 19:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685759487; x=1688351487;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pW1rdqqbkEtPfg32gPMaFYxqvJDDH52eSLMUxtdjdeA=;
        b=H4HacM23qksu9BnchKnhSbcxJI8fYuoGcOOrjtWGl0q6/72VzVLfqRjpaVOGjnPQPJ
         QSbWFwVbR++PqWMvbDwWq0CLAm9VUpYiZPb3ltJsJtngZCGhwefGP82AFOrmacQdCWVN
         bvbw8w3+udaH5c+tE5m/06sSPlVBLwaVlQgLnJquvve9jGs9GYkGtE4JjiNBE5v7a4W4
         6T7gVTd8YHJoCNC9rM+1GzBTa67xSgvNNZAm3KzMAzPK1ZhzvFmLiw9vGCgtfTyGFGR7
         5/GJ/nYaGKhwOoVQXdz0c2/KwfMsFMCbZeSenspA8l5rnPQkyxzTWQLQ478IrswHH1N5
         IiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685759487; x=1688351487;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pW1rdqqbkEtPfg32gPMaFYxqvJDDH52eSLMUxtdjdeA=;
        b=FtCynI3+2H977pEOijWRkWLHC0CLeh9ojtM5CPdvJuR6xD3tXywhcpJ4gGaFlB9y7u
         xUjNzBWvDCNei5B7ZLWxFNAoCbMW6rGqb4qO4a6FdONjOWsnczeiDrRyvtt3ZdwexdMf
         UKpVBC4uLWGHOKCaHu/8oQp1f7agzooQUNt+hKHa8rsAf/sERtMBwnsOnsT8duXEtULz
         oMxa1IAm0f5jjydenrxBHKxK8oz+myUeQdmjs3SZ6+GX59VPWmST+UJYjpxzz9b0E0L/
         Ll8+ZL1BRXne8+633AXJwkXPAikczjjlcbR3jExmqC1j3gBhmFg4waaovOa5cKTLIoWm
         o5eg==
X-Gm-Message-State: AC+VfDywWR5F8lu/Xf1myWiWuim+W6gkm0yJnWQvDED4z3krgj4aMvrX
        /xnwXkMyGrhROH6v0ZTcRIT1Jn8OLNZEOtiSU7S3xDr7SgE=
X-Google-Smtp-Source: ACHHUZ4CFazECbW1+uvM4ZkwvzK4e+C7zW/jZxxm1NMGAOGWazDOIC9LapzKqLGSfBc/j017YHi1X7KXLeX+XI1ik88=
X-Received: by 2002:a05:620a:1a24:b0:75b:23a1:3625 with SMTP id
 bk36-20020a05620a1a2400b0075b23a13625mr17612753qkb.54.1685759487100; Fri, 02
 Jun 2023 19:31:27 -0700 (PDT)
MIME-Version: 1.0
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Sat, 3 Jun 2023 10:31:16 +0800
Message-ID: <CACZJ9cU6t5sLoDwE6_XOg+UJLpZt4+qHfjYN2bA0s+3y9y6pQQ@mail.gmail.com>
Subject: [PATCH] mm:Improve the execution efficiency of early_ioremap_setup()
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the number of invalid loops of the function early_ioremap_setup()
to improve the efficiency of function execution

Signed-off-by: LiamNi <zhiguangni01@gmail.com>
---
 mm/early_ioremap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
index 9bc12e526ed0..ce06b2884789 100644
--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -72,12 +72,10 @@ void __init early_ioremap_setup(void)
 {
    int i;

-   for (i = 0; i < FIX_BTMAPS_SLOTS; i++)
-       if (WARN_ON(prev_map[i]))
-           break;
-
-   for (i = 0; i < FIX_BTMAPS_SLOTS; i++)
+   for (i = 0; i < FIX_BTMAPS_SLOTS; i++) {
+       WARN_ON_ONCE(prev_map[i]);
        slot_virt[i] = __fix_to_virt(FIX_BTMAP_BEGIN - NR_FIX_BTMAPS*i);
+   }
 }

 static int __init check_early_ioremap_leak(void)
-- 
2.25.1
