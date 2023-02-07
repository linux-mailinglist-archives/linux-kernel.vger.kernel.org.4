Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B418E68DFF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjBGS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjBGS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:27:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AFA171A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:26:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l12so8342745edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEO7JT8019FhjWA5ozs5gXujOBuHxjwPw/lAImXKXkU=;
        b=Fjd4nNnVBzF8pslJBnpYO5rEpmABVH/CrSTCmK1WOBRzEZ9SsgX6LowdJoZUVsfB6a
         38vQxFTbWk1o3a6VbFBpgSmMtZeNPvfSECEjOkn+dX9HVztfqE6iO2D/fKl6x2HcQQyT
         6MlvOX8ECzGiZJNv+9Pcd74ex+IjjhIjXp6po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEO7JT8019FhjWA5ozs5gXujOBuHxjwPw/lAImXKXkU=;
        b=HMzE//nK4kdd/jPUmBlBXYYfG5K2HI7qzVRUtHGU/C3t6ferR+O3nhlZr/tyGF26q5
         NcBWHe3HAifQeL1sshi7YWXYgM9h6PbZP74WPI0ARGhtIMOTGrCW4YP0Y9k2k/naKL9c
         AUVVTNmnUp1nm75huzHIPgGXQCHlvFcTvyi51jfN1JSbim+QGxO/667HW4LZYzAQ5abs
         mle4B+PmMM8OIeFkW4IDuJqAWvu4CoDFM1PkFKInaIrVpl9W1sJXrtT+CIZODFZojoEW
         hKpDufACaBILHC0GJKj9t9LT7JYhouk5lhb8BctAQETQdAUKYRq+7tbsyN6TUnrU6edv
         wgtA==
X-Gm-Message-State: AO0yUKWIBj4AD8CBn0eCZ2KSCALNbajNMPPb+o2R8wZvdyjmyqYdJMnV
        tq/w1gUoawPi2lA0LsqY6JTUUA==
X-Google-Smtp-Source: AK7set+PXrHx0uLdMpAosgecovGqzJL8DzLU8MH7S8DnG/Vz54LjVo9mtSHk7hbVr28cICLkzlV4oA==
X-Received: by 2002:a50:d747:0:b0:4a2:1b97:228c with SMTP id i7-20020a50d747000000b004a21b97228cmr4826317edj.28.1675794405089;
        Tue, 07 Feb 2023 10:26:45 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7dc12000000b004a9b5c957bfsm6274121edu.77.2023.02.07.10.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:26:44 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Tue, 07 Feb 2023 18:26:34 +0000
Subject: [PATCH net v3] rds: rds_rm_zerocopy_callback() use
 list_first_entry()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-rds-zerocopy-v3-1-83b0df974f9a@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIANmX4mMC/32NQQ6CMBBFr0K6toQWEOvKexgXbRlhFrRkio1Iu
 LsFt8TNJH9+/nsLC0AIgV2zhRFEDOhdCuUpY7bXrgOObcpMFrIs0uHUBv4B8taPMzeglLlUohT
 2wtLE6ADckHa230aDDhPQVowET3zvnjtzMLFHevYYJk/z7o5ir441UXDBlQRTV81ZVY26tai7/
 OWQ/KBFjj9elP8YMjGsUqqp66KpW3PAWNf1C6JJGJkRAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675794404; l=1516;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=0nDPNqBG+YTRTLjDtzI+UrYDaq7bsigQYB2rylSsaYE=;
 b=/tCvGrSqKoGTZNGYci4wbRhXJ9NKe1TOM7hwyPh99q7AKMHOdeSOagLFKA0z6Gp3BBEaP7KQj75U
 0bydtkoYCArlmntYw4V4XbHrjW388Mg7lbEPZT2uZg71+5CwbH7F
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
Changes in v3:
- target net
- Link to v2: https://lore.kernel.org/r/20230202-rds-zerocopy-v2-1-c999755075db@diag.uniroma1.it
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

