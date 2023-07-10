Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64074CA34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGJDHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGJDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:07:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E45F9;
        Sun,  9 Jul 2023 20:07:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77a62a84855so121827839f.1;
        Sun, 09 Jul 2023 20:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688958449; x=1691550449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ4LzUj0QVAIaJdaKsROcbGgUrEytRzB7GK9NjnNLnA=;
        b=TnJ9yuS+dAzbY9H3ryP3EPnR2aM+ZyRp7vei69wycGF4zJkGVDqV9i1SQ5++E5WL++
         jDuQ8hEcLscKBaYBNZHT/ecyPdScjhmPRwPfg3GM74Fz96e1fsBJiabREuZaIUJXyi/L
         3hh2HY3+QQGiAwAn9tMYVA2xa+EekdK+lJ7UExIvVmdLETK4bIn85/8qUm3NPEr14KfF
         WyBlYMKMfuorrSHz0FaR1ueijse8LoESup2wweK7p/O/lHNSW/ZFMkdrSpUs+idCW05X
         zWyGoL/yZa9DnI7yTlsWqGBAiNRA2Igawpob+m1XNLzpPF/aLZz+A+f0eCy1jvgQ9r0+
         DO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688958449; x=1691550449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQ4LzUj0QVAIaJdaKsROcbGgUrEytRzB7GK9NjnNLnA=;
        b=KX02PFRLjbGM99HMnaib4qoiz5JvKe48/wGImz50NW0UAy07Li6pfeOLUKzc6ozPS7
         2CvmUDph7/ZrxtEbQzgVpU8T9sAsuz7PnfRyLyDVfpX7Dl8yEvSE1YoSQTkn9u/2rGXA
         ei0IpSUcRqOXtVlhoiTkWha8w+iNhuC/MUrlV7+AC6499WTL5zeGKWJ5CmE44iw9EQks
         XnREVdf1QdraEDOg7Fov1xxmrjB2Jostfn0lAAxo0jtxqS9s4eWeW1mtlXaOPEaHMnVG
         fCW6mVcRzv3unwIvs/mT0GIdWRABlXLIGIFfbpNg37jjrENu5K1Sau0H08W19HPIRZmw
         qaAA==
X-Gm-Message-State: ABy/qLbNpHlsCA9VxzSNNorDHEqKVmV8h/qX2rmCn7G8Vxh7WIj5o0vs
        L6MgdqzxEZXPpePTLWmYfHY=
X-Google-Smtp-Source: APBJJlHdDk/Ml3RK93f2D3puiLRW5iL8OhOKJGuEsWGdEPCBmjMwRL1eqRNzIRe+/VZRhqOVrGfw9Q==
X-Received: by 2002:a5e:df4a:0:b0:783:40ef:c9f6 with SMTP id g10-20020a5edf4a000000b0078340efc9f6mr11416245ioq.19.1688958449373;
        Sun, 09 Jul 2023 20:07:29 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id y6-20020a02a386000000b0042baffe832fsm926344jak.101.2023.07.09.20.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 20:07:29 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: sched: Replace strlcpy with strscpy
Date:   Mon, 10 Jul 2023 03:07:11 +0000
Message-ID: <20230710030711.812898-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 net/sched/act_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index f7887f42d542..9d3f26bf0440 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1320,7 +1320,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 			return ERR_PTR(err);
 		}
 	} else {
-		if (strlcpy(act_name, "police", IFNAMSIZ) >= IFNAMSIZ) {
+		if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(-EINVAL);
 		}
-- 
2.41.0.255.g8b1d071c50-goog


