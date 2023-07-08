Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57274BF09
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGHTxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:53:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15101A8;
        Sat,  8 Jul 2023 12:53:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so34606431fa.2;
        Sat, 08 Jul 2023 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688845995; x=1691437995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd/OTL9JJ4g0ctWvp+yQjq+k1Dv81Da3Ont6OS8gpmM=;
        b=Pr0I5Nrju8Xex+X8hwKdCSd1RNBP95MOQ+KjwApe/SsMpvWgo5HD2EUl/7zcBUEF5M
         TjLxObozvAopxpEu4ANPwSPeBp+DnAnuysFqGCgKT0HeUzBq+B5B3vIvwi1tFI905xhr
         kgrQ2UMZuBq3wYlOwLVdCIxi4KWgFDMp9lqQBaCHjXIfOEtIzoUiMCl0Qled4Uq9v9b1
         dsXBiyCdopl9Lc+Vp9RmHfj4958i5VfAkyEFzAVQAEfMJpg76M+ffPSwhcHM0punUr27
         8g/X3iOnp4jjUJ8BKGZnU488eVaSVp2vjLEM4qIq+w7oGuvkMmFf5BbIrdY1OM+XSJxq
         yoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688845995; x=1691437995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd/OTL9JJ4g0ctWvp+yQjq+k1Dv81Da3Ont6OS8gpmM=;
        b=NOajp7W85HoQSjUd4+qZhfO70qoEewaRFs2nwltf9BW7iTmomE4pOOxdNRNAoonHQH
         ywId5CEa6+mXfkJuxTuUxwhjwupZUetUUu53W2uLvozWqAfBimoosQSvD+K3H9A/6XAw
         41ZhGQlOyN+k0qeDJGbkp9x+dpMnh8HMSaMmQVrs9a6SwwsUGwtepoq/S6CYmLJWLBTK
         cYKNalFDwbhAYzGSzm4nvncTK/yr8isDusxXf5Wkx/plGjwmWeA1ATSpewGdws1astNi
         5AP6nHw/afjNyOcEZMuOtP1jY4J44R4QRx958Y9sjInlgMrbwqM0tXiVuZQhmJWnL8xd
         28Ew==
X-Gm-Message-State: ABy/qLbq5abA1TKY7rfKwQMm8TA4xwb+fHB8G2V6XB3ItfTD4F2uLZeS
        +22XM1iohN3pnNDGqWU51Ro=
X-Google-Smtp-Source: APBJJlGSB0ZQoCtZDNstqgsZlpSEmiwE24sW1RNE6yn3QrQl15Es+pAVRNsAVBA0EF7vnnSCwfMA1Q==
X-Received: by 2002:a2e:b04a:0:b0:2b6:d0fc:ee18 with SMTP id d10-20020a2eb04a000000b002b6d0fcee18mr5650493ljl.19.1688845994571;
        Sat, 08 Jul 2023 12:53:14 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id md8-20020a170906ae8800b0098dfec235ccsm3846747ejb.47.2023.07.08.12.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 12:53:14 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mailmap: add entry for Jonas Gorski
Date:   Sat,  8 Jul 2023 21:53:09 +0200
Message-Id: <20230708195309.72767-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230708195309.72767-1-jonas.gorski@gmail.com>
References: <20230708195309.72767-1-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The openwrt.org email address is long defunct, but still pop ups from
time to time when asking get_maintainer.pl. So add an entry to my
currently used address.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * include the right people

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index bf076bbc36b1..e1f8c928a5c2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -237,6 +237,7 @@ John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
 <jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>
 <jon.toppins+linux@gmail.com> <jtoppins@redhat.com>
+Jonas Gorski <jonas.gorski@gmail.com> <jogo@openwrt.org>
 Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
 <josh@joshtriplett.org> <josh@freedesktop.org>
 <josh@joshtriplett.org> <josh@kernel.org>
-- 
2.34.1

