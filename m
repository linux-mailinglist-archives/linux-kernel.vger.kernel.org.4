Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271C76A2B70
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBYTLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:11:04 -0500
X-Greylist: delayed 1598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Feb 2023 11:11:02 PST
Received: from fallback3.mail.ru (fallback3.m.smailru.net [79.137.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5D136C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=+SVHyggOJAXOkCGWEwoFid2VStygqD2PmQkhU/cgNJ8=;
        t=1677352262;x=1677442262; 
        b=I46Zer4z6igWFHHDQg+EMcnahWNd/LY8UP19+4FGmZOC/TxXbmYcf4PPEEIHZrPzbwvDU/g5ThTsx42xFG4L/BfYB7QGzHwSuDTdPH+Fpb17bP5uaAJE3+O7HjzDuwEjl6pvVqu9Vk0fonQgVtkkBrpDxvQsQ5jxw0sjLGw6srD4M5TVkgIAv67uqoFqIH8J4cyruvYBn+nGdCeRp6WYKVRs0lAarGdxZN/wAkN6k291eyNccaNIGa1ypGBWz37oKdeeBzT/NTzfsPM6lcs9owUfqz7F4DPS8ACOlNzLnUABLWsCUphp/LvIz4g8DjKsSXvNxoh9D3GbokbiNvLkNw==;
Received: from [10.12.4.6] (port=59220 helo=smtp32.i.mail.ru)
        by fallback3.m.smailru.net with esmtp (envelope-from <fomindmitriyfoma@mail.ru>)
        id 1pVzWw-00GeQD-Oc
        for linux-kernel@vger.kernel.org; Sat, 25 Feb 2023 21:44:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=+SVHyggOJAXOkCGWEwoFid2VStygqD2PmQkhU/cgNJ8=;
        t=1677350662;x=1677440662; 
        b=T8lQh/64XezTn9ZASAvX3nW7vCr5q6ONPNkPj3ppYKTDUlR4cL+HBetPYugGUKI1hQm/rh70ERwZeRGbYVuFTbrSrnQgxxdtLMHGnaCVVXxRbRxJGTDXYuyAzY4W9fHH6Zt9f97TIu7jYtESknty6fCvp8scNPcIw4vJ8X8Yyj6lBJjI6Nsh2hR96hwuN/eLdb/AsWy2Qb0wh8DIsrpmPEbjVb07uCwHT/1O4MNWMJiK6ecaFwKVmSlZpHnxVQyiHi2ETG8aJ2T+eJEQwjSFtxQ1Ig8qqHez3e6ooIoHzmh8h+m/+dPzreZKaK9dfNeQF1+2JTKDliyEiievy+q0fg==;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <fomindmitriyfoma@mail.ru>)
        id 1pVzWg-00Gb09-Rx; Sat, 25 Feb 2023 21:44:07 +0300
From:   Dmitry Fomin <fomindmitriyfoma@mail.ru>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Dmitry Fomin <fomindmitriyfoma@mail.ru>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH 1/2] ALSA: ice1712: Do not left ice->gpio_mutex locked in aureon_add_controls()
Date:   Sat, 25 Feb 2023 21:43:21 +0300
Message-Id: <20230225184322.6286-1-fomindmitriyfoma@mail.ru>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9806C989EC2150E33C13C456498AA74328729F4FEF7F411FF182A05F53808504033AAAE0726C56F16331896E9A51F74222811A8ADC78326F51A51D428B884B608
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75840EB8CDBC1001FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063748744D4CD6EC491D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89EC3D66F21EED5AB526FC6B071DC2B136F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7328B01A8D746D8839FA2833FD35BB23D9E625A9149C048EE9647ADFADE5905B1BDFBBEFFF4125B51D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B07CB022245CAE856389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006371668ED4911B0FC8BD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636D81D268191BDAD3D78DA827A17800CE72ECDCBE77879C1BDEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C37C6C241D9975906435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5FB16B92C4FB9DA8B228B4F7132AA19AAD1565FE801DD37014EAF44D9B582CE87C8A4C02DF684249C2E763F503762DF50F2237FE565727C05
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3475AE8838CC1BF58E3569D1E0318C65E6D56B877276685904F273E15A90B83A804D38885EFCD0ECAB1D7E09C32AA3244C941EA7C31609A35F71A0D9ABC07956E0F26BFA4C8A6946B88D5DD81C2BAB7D1D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEITt8lw84meLaXSAxMVtxw==
X-Mailru-Sender: 5C3750E245F36200A6D18CED7D1071013E214C08E0B704BA3C7BCD20960ADBDAC5AC0816EEA6E42AAA53FFDDC28CFB2AE047E8EF59C4A8C5CB2BD3896A7551E65350DE7942F9BA8DF4CD7D804643C5AF3E90D834D112973461E9E6D348337FCC993B91D010849960EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48F971C29D06D6C0B4F378AFA56BA89B93F3F0FDC209CE118049FFFDB7839CE9ED3673F440215217F4BCB515902E84032B9A3026F1A8F11F6A413D9C059B1D10E
X-7FA49CB5: 0D63561A33F958A56AC7FE46752524BB41B7555661B5CC23A00CAC3E8FE9AE4FCACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C1DAA61796BF5227B302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B679E85A9FDE02C04A75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEITt8lw84mfUZt7C7ZQw6Q==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If snd_ctl_add() fails in aureon_add_controls(), it immediately returns
and leaves ice->gpio_mutex locked. ice->gpio_mutex locks in
snd_ice1712_save_gpio_status and unlocks in
snd_ice1712_restore_gpio_status(ice).

It seems that the mutex is required only for aureon_cs8415_get(),
so snd_ice1712_restore_gpio_status(ice) can be placed
just after that. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dmitry Fomin <fomindmitriyfoma@mail.ru>
---
 sound/pci/ice1712/aureon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 9a30f6d35d13..40a0e0095030 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1892,6 +1892,7 @@ static int aureon_add_controls(struct snd_ice1712 *ice)
 		unsigned char id;
 		snd_ice1712_save_gpio_status(ice);
 		id = aureon_cs8415_get(ice, CS8415_ID);
+		snd_ice1712_restore_gpio_status(ice);
 		if (id != 0x41)
 			dev_info(ice->card->dev,
 				 "No CS8415 chip. Skipping CS8415 controls.\n");
@@ -1909,7 +1910,6 @@ static int aureon_add_controls(struct snd_ice1712 *ice)
 					kctl->id.device = ice->pcm->device;
 			}
 		}
-		snd_ice1712_restore_gpio_status(ice);
 	}
 
 	return 0;
-- 
2.37.2

