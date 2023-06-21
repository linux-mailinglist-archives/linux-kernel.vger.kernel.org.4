Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EABB7379BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFUDa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFUDaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:30:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08AEB3;
        Tue, 20 Jun 2023 20:30:13 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5701810884aso49943117b3.0;
        Tue, 20 Jun 2023 20:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687318213; x=1689910213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNV6wouyQqRPOtwOR4KYe1F+n00tweHR7R0i7NJCnW4=;
        b=db63QhPA56quEpkVEMR4dzz+ae3wlR3Gw8CaCU/nO/gBqN0V+aqxKINsCxs6WNHE2t
         OXK6MFi3nvBPUhhOm6cfqW7Xr3yjVaTpa7jv1jSA4SVK4h/a9IRxp3+9gUQHi74fHN46
         PxB7tuAPT6gjAf4tpF4WzCzr99QKJda+CYZMwR1Z0tlDOvV585rnZ9Ey4zCiwhJiD+vT
         /igMxI4oXgASt6yooPZGGfdT4BudWi97HBYM1zwZYoNG0OCIWyZv2vcT976bMG+C31Z7
         HvuxRE58hFxLMhnyQElF4DZeP1adxBoeLJAR/1RGkAr5OOyj1C+py7V8LgwmADi8QO1y
         hXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687318213; x=1689910213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNV6wouyQqRPOtwOR4KYe1F+n00tweHR7R0i7NJCnW4=;
        b=BxEd0ON8xSABHbczAfvKaHo6jetLa/Enlbs4VmO436sAxR/3FyG8i0BQXjlRprLuGN
         /Qg9Ui02ahVBe56MCqoD0dJXvty4UL65YHCb9hZ+OQLe0HpPBjq3DYT7sBL9JJhxhTWa
         H38Czjxbvn79z4T1RSSeSIaXTg5S7YmCWkHVjQHa4mWKl31U60jmm3wY/tmOWXe7p3l6
         YBmjfGZlaMjL1HYGh9kUimQnSYiEJD7uSiyxLMiiKCxwpE/HrltjsuJk2gV0v08In1un
         Mr0ykU0mq78SvcBp+pwOCuUdSgKxbrEeTR+PhmLtrYy9TzhK6TtNI32fs+oKvJnKkGUZ
         AiaA==
X-Gm-Message-State: AC+VfDxZERFi58AUrormxlXToOEFiOZB/z+0y+LmLuYELyuhqMa1ePv1
        p1dMz3IGl4U5NpTsWM8Bc6U=
X-Google-Smtp-Source: ACHHUZ5frbTX4q0Jupvc9jdlpo9vsgFXolS4+udT2wCvrs27uFQ4yGa96pFumCwVQt4eZiEv93TrjQ==
X-Received: by 2002:a0d:ca86:0:b0:56d:2d67:cb38 with SMTP id m128-20020a0dca86000000b0056d2d67cb38mr5951174ywd.34.1687318211562;
        Tue, 20 Jun 2023 20:30:11 -0700 (PDT)
Received: from sohom-te15.lan (2603-6081-2401-85c7-0000-0000-0000-1112.res6.spectrum.com. [2603:6081:2401:85c7::1112])
        by smtp.gmail.com with ESMTPSA id b142-20020a0dd994000000b0056974f4019esm885147ywe.6.2023.06.20.20.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 20:30:11 -0700 (PDT)
From:   Sohom <sohomdatta1@gmail.com>
X-Google-Original-From: Sohom <sohomdatta1+git@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Sohom <sohomdatta1+git@gmail.com>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: Don't parse CTCP message if shorter than minimum length
Date:   Tue, 20 Jun 2023 23:29:53 -0400
Message-ID: <20230621032953.107143-1-sohomdatta1+git@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the CTCP message is shorter than 10 + 21 + MINMATCHLEN
then exit early and don't parse the rest of the message.

Signed-off-by: Sohom <sohomdatta1+git@gmail.com>
---
 net/netfilter/nf_conntrack_irc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 5703846bea3b..703b5a123cb5 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -157,8 +157,12 @@ static int help(struct sk_buff *skb, unsigned int protoff,
 	data = ib_ptr;
 	data_limit = ib_ptr + datalen;
 
+	if (data >= data_limit - (10 + 21 + MINMATCHLEN)) {
+		goto out;
+	}
+
 	/* Skip any whitespace */
-	while (data < data_limit - 10) {
+	while (data < data_limit) {
 		if (*data == ' ' || *data == '\r' || *data == '\n')
 			data++;
 		else
-- 
2.41.0

