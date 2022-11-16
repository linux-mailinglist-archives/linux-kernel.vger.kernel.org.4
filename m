Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A462BAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiKPLGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiKPLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:05:42 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DDC4C242
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:52:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x21so21297818ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boYFusMhw3G11i9yi3Rn2Pq4n201pIIehUv93eqtXLI=;
        b=b6CMlIjkEubLoLcx9mJZnlNO6idRQolGiSGIvdTA9Flqr4dN9fekRlUxaAN3w92fVL
         5A65vna+64WnhQnZ3OJqTkWNW41pCRpAvaiaTRLaCvVe7T1tILdkNsZYfe3bReU6qrls
         rr6TjkCKGgTAP/gUpvVakr9JooYOULf3uN1rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boYFusMhw3G11i9yi3Rn2Pq4n201pIIehUv93eqtXLI=;
        b=7Ouwihm/C8XFe1EzpWrv1P1iGWCFL53CTgLGhdUpPr58znyF5tjAbsdYpfa2PSskH5
         95J0pJ7qf8YJHaIXmMbKeptk4fq3F/Lgy31ex7gTxjACSUvyIx7gm/63bs0e16qWaaMb
         OjaSP/2egpywY87I/PttOUw2WccGFf4mESobcWzvMKQpJAWXgoPS1dOo6zd4L6UYF1uv
         Tzg9CiALTH9VIvt+xKmyYow6qUrjPixVuAkZnDF93FXeZ7KQ9PuqdyG2MEvo00/aowOC
         DfcV3N29WUGMsGLFNR0PMOVkwVcgY5MEa2agj0C8CsPCeAPHad45YDICSVWm6LBxt0iR
         g1dg==
X-Gm-Message-State: ANoB5pkluF4r9sfMh6zT3ZDiGPQ+u2Jni/lO80TEv9JWGM+L5QwwmK/N
        jIzF3AE7pvjlSa1OqFHzbthRQw==
X-Google-Smtp-Source: AA0mqf7yX6uhPbO4HWQ1vf40mIJbfBYIMAKSkfI3irFiFqkYer+kY5sE8ODw1zVz4ucTymYNsHywaw==
X-Received: by 2002:a2e:871a:0:b0:277:766:b715 with SMTP id m26-20020a2e871a000000b002770766b715mr7096225lji.416.1668595932308;
        Wed, 16 Nov 2022 02:52:12 -0800 (PST)
Received: from localhost.localdomain ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id g42-20020a0565123baa00b004b094730074sm2547119lfv.267.2022.11.16.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:52:11 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] net: dsa: set name_assign_type to NET_NAME_ENUM for enumerated user ports
Date:   Wed, 16 Nov 2022 11:52:04 +0100
Message-Id: <20221116105205.1127843-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221116105205.1127843-1-linux@rasmusvillemoes.dk>
References: <20221115074356.998747-1-linux@rasmusvillemoes.dk>
 <20221116105205.1127843-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user port does not have a label in device tree, and we thus
fall back to the eth%d scheme, the proper constant to use is
NET_NAME_ENUM. See also commit e9f656b7a214 ("net: ethernet: set
default assignment identifier to NET_NAME_ENUM"), which in turn quoted
commit 685343fc3ba6 ("net: add name_assign_type netdev attribute"):

    ... when the kernel has given the interface a name using global
    device enumeration based on order of discovery (ethX, wlanY, etc)
    ... are labelled NET_NAME_ENUM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 net/dsa/slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index dfefcc4a9ccf..821ab79bb60a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2388,7 +2388,7 @@ int dsa_slave_create(struct dsa_port *port)
 		assign_type = NET_NAME_PREDICTABLE;
 	} else {
 		name = "eth%d";
-		assign_type = NET_NAME_UNKNOWN;
+		assign_type = NET_NAME_ENUM;
 	}
 
 	slave_dev = alloc_netdev_mqs(sizeof(struct dsa_slave_priv), name,
-- 
2.37.2

