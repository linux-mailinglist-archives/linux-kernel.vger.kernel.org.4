Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F2C5B5C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiILORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiILOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:17:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E925C6B;
        Mon, 12 Sep 2022 07:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A962B80D55;
        Mon, 12 Sep 2022 14:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582EBC433D6;
        Mon, 12 Sep 2022 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662992244;
        bh=jTbsk7yoEK+AZ3vZc8ogcuLE+gwzEOpP/ZeZUQAejUI=;
        h=From:To:Cc:Subject:Date:From;
        b=N2TPTBsaMrUDjAOP8g3X0PYhgmGhVVWX1TIzIUvPGYLN7AmbGJxb2/Ic7DAZhyk42
         eFq6z/JznWLmMAZgq1GXf9n9Wg/VGkhgbyHCGWX/007Zwc9Ux8qoBDAP6C23y0ewil
         y5p02FwkM+hYHeoqwFOG2LkrcWBPDZLMveUnibioOokNllXzjEf6G1eddFSovN6I5K
         P/cWAszPKXKx60FDqyoqqX4cRMSTPEBiFrEYOIu2SixK90Ad9briXm30zOTsT3Uy09
         Qlue/SDeCQ2RUUFFdjBTSmNHI6Apo3H5rfm/b+2kpwAuvxDHWq38glaz9yvf0j7TN6
         TX2iQZrkheScQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Marek Vasut <marex@denx.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next] power: supply: bq25890: Fix enum conversion in bq25890_power_supply_set_property()
Date:   Mon, 12 Sep 2022 07:15:53 -0700
Message-Id: <20220912141553.1743568-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/power/supply/bq25890_charger.c:625:40: error: implicit conversion from enumeration type 'enum bq25890_fields' to different enumeration type 'enum bq25890_table_ids' [-Werror,-Wenum-conversion]
                  lval = bq25890_find_idx(val->intval, F_IINLIM);
                         ~~~~~~~~~~~~~~~~              ^~~~~~~~
  1 error generated.

Use the proper value from the right enumerated type, TBL_IINLIM, so
there is no more implcit conversion. The numerical values of F_IINLIM
and TBL_IINLIM happen to be the same so there is no change in behavior.

Fixes: 4a4748f28b0b ("power: supply: bq25890: Add support for setting IINLIM")
Link: https://github.com/ClangBuiltLinux/linux/issues/1707
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/power/supply/bq25890_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f5368be32843..e6bd60fef0f6 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -622,7 +622,7 @@ static int bq25890_power_supply_set_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		lval = bq25890_find_idx(val->intval, F_IINLIM);
+		lval = bq25890_find_idx(val->intval, TBL_IINLIM);
 		return bq25890_field_write(bq, F_IINLIM, lval);
 	default:
 		return -EINVAL;

base-commit: f52c4d5f0bb486bc515b5f8a56130aea69fb29db
-- 
2.37.3

