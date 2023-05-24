Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2470EB27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbjEXCMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjEXCMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23507E48;
        Tue, 23 May 2023 19:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4AF2637EF;
        Wed, 24 May 2023 02:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B60C433D2;
        Wed, 24 May 2023 02:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684894315;
        bh=ciYnv1aFoGmFR4E+7iAdi4r/6ifLsJjIccdxEn4Wea8=;
        h=Date:From:To:Cc:Subject:From;
        b=DV34t2dY8RSLHh02ZTuPDRWPJ1LpnWMQ320RRABfgjwF/Vuf+AcGOvOEZxQV/3sg8
         G2Cb5BziE0Nlc74a8DQpi2eU7G3Y27+3/Rctn8VM1PBPzryM2xaqA3S5AJHSFW62V9
         f79v8ey3OcgdkleMit40QgRQcgcI6O15VHNipHz0Mjlw7Cfu2lg+2a00fL4Oc7ped0
         E3DNZ/VWgCfUMdjoRrHxA64HVaHXc7rQuiBfhlVzd2b5e+/eUelcY2KJLRJAQxntXl
         f72UY+bDeXxsev8fxQZ6FfbetVlcC1Z8K3Yy3R+u81+O13TQ0ifpeqzSFA2dakLvua
         tjbFtI2AcgZzg==
Date:   Tue, 23 May 2023 20:12:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: rtw89: coex: Fix __write_overflow_field error
Message-ID: <ZG1ynqdAnXArMfBE@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays as fake flexible arrays are deprecated, and we are
moving towards adopting C99 flexible-array members instead.

Fix the following error seen under GCC-13 and -fstrict-flex-arrays=3:
In function ‘fortify_memcpy_chk’,
    inlined from ‘_append_tdma’ at drivers/net/wireless/realtek/rtw89/coex.c:1579:3:
include/linux/fortify-string.h:583:25: error: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  583 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/21
Link: https://github.com/KSPP/linux/issues/299
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3a586a971e8f..bda0e1e99a8c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -206,7 +206,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 struct rtw89_btc_btf_tlv {
 	u8 type;
 	u8 len;
-	u8 val[1];
+	u8 val[];
 } __packed;
 
 enum btc_btf_set_report_en {
-- 
2.34.1

