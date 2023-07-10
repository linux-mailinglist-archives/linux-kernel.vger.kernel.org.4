Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2074C95C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 02:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGJA5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 20:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 20:57:41 -0400
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E9CE5
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688950662; x=1720486662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CfcO7Q8FTml/EPGaN7PkFNGOFbP2iGYa0hUM6yvnJCA=;
  b=EhNfIL9Zp986+PNLhXsnpwK3+491c65sedzVa30BVd0QjmrgrbhuzFej
   6LbQBZ3/FEzzfaogduWvkHG1rGykDypmNbSVx8CRafH2pGbFbo/YlFFqU
   ZETXPe3zF3FBirSyIF4SGfJxebiJs8ZrFW8RCARgKjo82OkS0I7KdAdkh
   Jz55c1IdIllL+3BzDNYYBIpKRunrmbAnyGvSjiOMS4Jko7To+b+ezkWlj
   QDgFeZtPkppgK3uAxSdNnIr/knU1uulD/qqetQqTGpqrK8yBzJkdvGpYs
   AHI73fNMBeAUsjeNL/BMQ6cd/ivYzzT85tvLlaKaEMJ3uB7QnzXiaOzCl
   A==;
Received: from mail-il1-f197.google.com ([209.85.166.197])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2023 17:57:42 -0700
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3461839c45cso13089525ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688950660; x=1691542660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wAseA0ncrRwgDlHK9AT72liWPmh1dR/ULxlrBgaw0E=;
        b=PCZ7tOhGGzN4Lh+QOYtBmRv4JUg9lSnrPJtC8zPsnQl8lx0mMRkBcvC0YBa8hYyvR9
         hCEhGG5qUvP883GIXfCH+81V3jLlSWdkYpcKJCi07FnCqOwv/bcz+e9No9pBf3dcQiy3
         3kAo2ooYvVu5S/XQXUNgj7fMzENSl5aPK3Us8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688950660; x=1691542660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wAseA0ncrRwgDlHK9AT72liWPmh1dR/ULxlrBgaw0E=;
        b=HTL5q6UM884OaQSNEtXStL/Tjr6r8VKZjcYhpldpBg+HOmxaFo0p5Zxpj+WzycbiRT
         jb1cu9SyblqwkMrW06Mf9jhCaKDo1U0uQNHpntcSEI5ODxW8tcHn90Vx8QTmYbGBHzlR
         pgbGPKH1ECAcS8FxE1UZllFrs4k7FtdHy6oPxr8WJvuw0hZQGoC5/obr5PEFhLsKx0NN
         2RBhJyCTNkB9cCrW1UC/tnieqLGP3pzKeNDgscKRssx/o5AU1sCenQXX3Lccql1nIHmO
         avvEt1u2qzhIHn7AvhuyTVHhivXoi46OqMelv+lvyacQOnOxeLaaYTiVbHOOiQktFfiC
         II3A==
X-Gm-Message-State: ABy/qLa4hZgfy9ww4sw6zGp4GehEF3Sv3ONVBsuLdo0q9DyFarhtBsow
        iLyQUjYCsaQbbcvTGL8ZwuyaKNZTM7AXDLeSQICzwbF6+zracwWlFMIpzvoB9JIPb5+CrYgnAD7
        C1aWQmzTMEiq3f4uL45JUly90Qg==
X-Received: by 2002:a92:cc44:0:b0:346:3554:4d68 with SMTP id t4-20020a92cc44000000b0034635544d68mr9878860ilq.17.1688950659904;
        Sun, 09 Jul 2023 17:57:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCflDL0AvD7yBlFIGgUph6Hoi9nSjWAOdNgwDcpPpYLlABzmbu4jcmo4yCsnaE5mK6ijEVOw==
X-Received: by 2002:a92:cc44:0:b0:346:3554:4d68 with SMTP id t4-20020a92cc44000000b0034635544d68mr9878849ilq.17.1688950659634;
        Sun, 09 Jul 2023 17:57:39 -0700 (PDT)
Received: from yuhao-ms.. ([2600:6c51:4700:3f7c:3e6a:a7ff:fe52:5148])
        by smtp.gmail.com with ESMTPSA id d17-20020a92d791000000b0034587c5533fsm3155651iln.51.2023.07.09.17.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 17:57:39 -0700 (PDT)
From:   Yu Hao <yhao016@ucr.edu>
Cc:     Yu Hao <yhao016@ucr.edu>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: e1000e: Fix possible uninit bug
Date:   Sun,  9 Jul 2023 17:57:35 -0700
Message-Id: <20230710005736.3273464-1-yhao016@ucr.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable phy_data should be initialized in function e1e_rphy.
However, there is not return value check, which means there is a
possible uninit read later for the variable.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 771a3c909c45..a807358a8174 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6909,7 +6909,7 @@ static int __e1000_resume(struct pci_dev *pdev)
 
 	/* report the system wakeup cause from S3/S4 */
 	if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
-		u16 phy_data;
+		u16 phy_data = 0;
 
 		e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
 		if (phy_data) {
-- 
2.34.1

