Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8FF68DC4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjBGO6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjBGO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:57:57 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C21350E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:57:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mc11so43741847ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSN+gCXhLmK6XFmTGEQoC/f2vmDaSDoOGNlOWvo6ELM=;
        b=pfYzR9mD7dYztX0PF4DSe69cyNHcWL6JRJwjp6ns70iRKoeGoOqB+fxGKz67ZjwB9j
         2epyEwQmX6VfthGmO6ttM++aLn675tv0A3+m7KgKBCkzpGRkwbuZqPyC6GcxDS/7pLNm
         EDlUOeCZQIQnHvr2ZRVm1E3dnElAlxM2HtNPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSN+gCXhLmK6XFmTGEQoC/f2vmDaSDoOGNlOWvo6ELM=;
        b=eoY5mPRLwQUgiSmDB8qXJTu///f+hVNMdjE8o2kW/9lMf2wN87RI5RB49WjvTPoQbh
         sP3IaE7HQ7fJ9ywrHRyMtfAcJSp1qLfKi8kmFiSEBWyTPyrCoO1qiBkfsvJ46vG7U970
         lqYs1jrDOgVGw9XgN+wJ4vWwaE+JPENoJOeorMh7Vyes/osthp1ULS31X99kH2+shFSd
         Z+/3GMGKJZdiXnE/rQWkXghNfKoQ85oyYoDMllIWb8I/kpdAzJONXl5veAwKVsjW7mYC
         9YD7d+6FK9ybg+0XoEIMdcJLhYwtkOy7ksLfcFP3b7K8g7BVL2lNsm7MyU03eJK62L2+
         /Btg==
X-Gm-Message-State: AO0yUKWYSCd7RNWSfvBvt835zCG8AO0t+n0SENknmXQx2Pa4EBgTSzTZ
        pdEk7h8r2e3Usaos+BiYYD70eg==
X-Google-Smtp-Source: AK7set/uZ4rLCFuor89/DZU+t+30ehfkikR4/mkrOoLFeEJWUaObhM31ZP+pyRjRaao5NZO9ftHgOA==
X-Received: by 2002:a17:907:8e88:b0:8aa:f74:3263 with SMTP id tx8-20020a1709078e8800b008aa0f743263mr2401984ejc.51.1675781873007;
        Tue, 07 Feb 2023 06:57:53 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906564400b0088ee56fb24dsm6963073ejr.103.2023.02.07.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:57:52 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Tue, 07 Feb 2023 14:57:48 +0000
Subject: [PATCH net-next v2] rds: rds_rm_zerocopy_callback() use
 list_first_entry()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-rds-zerocopy-v2-1-c999755075db@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIAOtm4mMC/22OTQ6CMBCFr0K6dggtKNSV9zAu2jLCLGjJFAlIu
 LuFtZuXvHx5P5uIyIRR3LNNMM4UKfhk1CUTrje+Q6A2eaEKVRZJgNsIX+TgwriCRa1tU8lSuka
 kiDURwbLxrj9Cg4kT8gFGxjct585TeJzA4zKJVyI9xSnweh6Y5cn/b80SJGiF9lrVN13V+tGS6
 fKPJw6DkTmlvn3ff0de2ybSAAAA
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675781872; l=1331;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=C5CIo8jerNHCxckEuqqrroe2dMawqbDhJuIQdmf27dA=;
 b=Tvff2+5O2E1YCJSWDaIcctk0TLnj/z5ts1dQryYNGB0frC/Agk0HAfUUsDhBBdSoxjNpb1Is2BZZ
 KG/mOoMCCy5QyfHazEzMSrgQ1+KDvNCk6Zd0xAKENHcaZjQIbwea
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rds_rm_zerocopy_callback() uses list_entry() on the head of a list
causing a type confusion.
Use list_first_entry() to actually access the first element of the
rs_zcookie_queue list.

Fixes: 9426bbc6de99 ("rds: use list structure to track information for zerocopy completion notification")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 net/rds/message.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index b47e4f0a1639..c19c93561227 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -104,9 +104,9 @@ static void rds_rm_zerocopy_callback(struct rds_sock *rs,
 	spin_lock_irqsave(&q->lock, flags);
 	head = &q->zcookie_head;
 	if (!list_empty(head)) {
-		info = list_entry(head, struct rds_msg_zcopy_info,
-				  rs_zcookie_next);
-		if (info && rds_zcookie_add(info, cookie)) {
+		info = list_first_entry(head, struct rds_msg_zcopy_info,
+					rs_zcookie_next);
+		if (rds_zcookie_add(info, cookie)) {
 			spin_unlock_irqrestore(&q->lock, flags);
 			kfree(rds_info_from_znotifier(znotif));
 			/* caller invokes rds_wake_sk_sleep() */

---
base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
change-id: 20230202-rds-zerocopy-be99b84131c8

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>

