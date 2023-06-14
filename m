Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3120172F4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbjFNGaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbjFNG3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:29:35 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178121FDD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:29:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgwW86gX5zBR9Zh
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:29:24 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686724164; x=1689316165; bh=klrFd4m/LXdoMGxRTnZu0esLRgA
        FT+1tJ+pjxp3tsB0=; b=NbQNkOjN3Hq7r4uDFUsqSI0dVzvCb0dk9hFctJvCWeI
        VXqOfnKaqGYIGG9xNCXNZ79dQ42LreK1K+PhVYD3u/hvME+RJ7yd0P0FzlzA+xPt
        fzn39gnuhe+hXIaF+/usVbkaT1WIDc1Bi9XDZLyg7pVvn0BLayxd2cw1IWmVZsEj
        crIhkkzGgSMonolTPg9qxR4+7zMTsRSdKhqL32i/9xI4Gwz/reWxWzk4W/cHK4uq
        izPgoW6ICqgL+P6uA+dpIGaIUpLhFahe72fCB/nKxtTsmZWu/VF8K8p8wb1+EDVf
        NMK6eAgG7BzeXQTSRnM4yxGvup86iKecCEmY7KU5ZhA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kSEH0qrAKzEz for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 14:29:24 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgwW83Nz8zBQgpC;
        Wed, 14 Jun 2023 14:29:24 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:29:24 +0800
From:   xuanzhenggang001@208suo.com
To:     davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Remove unneeded variable
In-Reply-To: <e980bbb2536d4c35ce90a4666b3e8bf6@208suo.com>
References: <20230610124403.36396-1-denghuilong@cdjrlc.com>
 <e980bbb2536d4c35ce90a4666b3e8bf6@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <f65f9d0caf6a315f21eb09e7a29a8189@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

arch/x86/net/bpf_jit_comp32.c:1274:5-8: Unneeded variable: "cnt".

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/x86/net/bpf_jit_comp32.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c 
b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..bc71329ac5ed 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1271,7 +1271,6 @@ static void emit_epilogue(u8 **pprog, u32 
stack_depth)
  static int emit_jmp_edx(u8 **pprog, u8 *ip)
  {
      u8 *prog = *pprog;
-    int cnt = 0;

  #ifdef CONFIG_RETPOLINE
      EMIT1_off32(0xE9, (u8 *)__x86_indirect_thunk_edx - (ip + 5));
@@ -1280,7 +1279,7 @@ static int emit_jmp_edx(u8 **pprog, u8 *ip)
  #endif
      *pprog = prog;

-    return cnt;
+    return 0;
  }

  /*
