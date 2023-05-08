Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4276A6F9E95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjEHEJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEHEJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:09:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2526EB5;
        Sun,  7 May 2023 21:09:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965ac4dd11bso814618466b.2;
        Sun, 07 May 2023 21:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683518967; x=1686110967;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/stI2xLuu/+Bk6mWcj3fMw5988PC9cZKxhWWqcngefs=;
        b=mndtmghHF96zxCkNPDH6VwIjXKnoqgwMjPfLFKD/dUxB0glA3xAfF2p1khIxjmE8qr
         BdrL2dWgtian5sbp8iFlVxtrWB7so2gIYt/3RZVhCYJO+fJGHy39GgrkBpBpkslLtuAL
         giVbUmj9KM2X795y53Neve9sU2sqy8z9CMgtsDOOWxUwBItQyzG7bw2rDZQ0UfTLw/XK
         XMvu5QcyN815kquC13wN/TpcWvizsuVdV31Wev9nU12dFPSc4QtvBjo+IdyLL43H4g39
         LKfaqd5OBbO/8lR17GyXSV+WvDEztieHhgwIdzPxCkI3Stxl+htge11G6Y45Mop5K+/f
         bDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683518967; x=1686110967;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/stI2xLuu/+Bk6mWcj3fMw5988PC9cZKxhWWqcngefs=;
        b=KjMJGAEqgqVdKsGxBx04XXfJPdqdrZzOyL1YOaeyukARs8oNS8nZsPu7F7Tr8YbNJB
         PF/uD7rDe1khYBuWsyQ0uC8Q9t4RhojohFrHP9zpdc7Jgmqy631x8Ff3Dze3GIM/Vp19
         iHUfWjhYhxdCBFpnQOHIhlS/wz/pWzGjnxH9ViR/aewl6G53/AMFIM12xph8OnzK9DBm
         0x/Ph9veNKPfkq8YXgZdNg+7rR2j5xjKBSiSR6u9LJBX/Q7mIPYCpp3vmRtHS/Tlg+St
         GenRyAuo5oxhA7fuazz0FhvFCAEedJMIzWfrdcmxsOwdz6QXgqN3Y4RLgmoiIhzRK2xB
         boUA==
X-Gm-Message-State: AC+VfDydpb2rbJELGlyimqHCnfnN/c0RsL6YV3WVKI7cMNUJnj6qwkCe
        uQNswcXBpZdrn3WIU5Wvqio=
X-Google-Smtp-Source: ACHHUZ5Dr2OhNvFUs+sEGJt4AGYVYn1QPnGShhbOuQHlv02lNyCrmoMRYODTfIKd9tYYio1GPProyA==
X-Received: by 2002:a17:907:a41e:b0:94a:4b7a:9886 with SMTP id sg30-20020a170907a41e00b0094a4b7a9886mr8664774ejc.12.1683518967237;
        Sun, 07 May 2023 21:09:27 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:8906:f99a:ce33:2033])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090619d700b008cecb8f374asm4372475ejd.0.2023.05.07.21.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 21:09:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] s390/Kconfig: remove obsolete configs SCHED_{BOOK,DRAWER}
Date:   Mon,  8 May 2023 06:09:16 +0200
Message-Id: <20230508040916.16733-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f1045056c726 ("topology/sysfs: rework book and drawer topology
ifdefery") activates the book and drawer topology, previously activated by
CONFIG_SCHED_{BOOK,DRAWER}, dependent on the existence of certain macro
definitions. Hence, since then, CONFIG_SCHED_{BOOK,DRAWER} have no effect
and any further purpose.

Remove the obsolete configs SCHED_{BOOK,DRAWER}.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/s390/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 548b5b587003..1627c7f841d3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -468,19 +468,11 @@ config SCHED_SMT
 config SCHED_MC
 	def_bool n
 
-config SCHED_BOOK
-	def_bool n
-
-config SCHED_DRAWER
-	def_bool n
-
 config SCHED_TOPOLOGY
 	def_bool y
 	prompt "Topology scheduler support"
 	select SCHED_SMT
 	select SCHED_MC
-	select SCHED_BOOK
-	select SCHED_DRAWER
 	help
 	  Topology scheduler support improves the CPU scheduler's decision
 	  making when dealing with machines that have multi-threading,
-- 
2.17.1

