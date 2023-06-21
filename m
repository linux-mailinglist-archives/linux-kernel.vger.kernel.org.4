Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4780E7382F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjFULyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFULx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:53:58 -0400
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057C170A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Dt0Pfw4hhB64UidxR15sPo8nXNsoSpkcj1h2rZuo8hk=;
        t=1687348436;x=1687438436; 
        b=ErmyDf9eSzTcVcbMKX2BxI7Eg4KGVatBaGgTdUySgH+tR3ZnXuoHTQ52yq39PT5kmLUO4X5Rqu3uu+l4EydxOgiIKwh16CS3uD/MNIfb7fYgZ6p0bRtVMVSfXiGF+fCf/5jDPpKuqUWRkm0sHUFHB+1Zp5shO3gj6nUQi2Y4hzyqkF8ZYm1vv7cj7DHohY3ESPiVrAjCrHEegpNE93NcKG8o9Am/jH3C1/QWYpXI+zdIa9D4lwV5l+RyMyWYb7c1hAZ2LrjKQw01rTgglMn7+e4KjY3CfsBleaXwwIy7mtUNHZB0XN2GleZdgtV+zuttRtNqTMRFzxhPJ6KE+0mnpQ==;
Received: from [10.161.55.49] (port=42924 helo=smtpng1.i.mail.ru)
        by fallback1.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1qBwPK-00FkSl-0R
        for linux-kernel@vger.kernel.org; Wed, 21 Jun 2023 14:53:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Dt0Pfw4hhB64UidxR15sPo8nXNsoSpkcj1h2rZuo8hk=;
        t=1687348434;x=1687438434; 
        b=EhqWlY9UNZPMaYAxaQuA3mpXBqDCSotzyYyYC4ZLQPKnBs9ZH3x4r3Ct60kYm22CfSTx6rjGH97IuGShbwcpoaOWmwBDMzr0Ouj6JoTRj49zl3D5ye1RAEYY/B0xok1iEKzozmbCG1UhYUkMnF6d6whJyj/7QevgCNcu0eGAkkYF8gRkRzHTiqZpkt7cuKrz26wYR7/sMv6/4NYU6yx5tEbg2dnl0/Szc4sbpmlaf33qy5VCYn1K3Ao0DSCbGNzR4ciY77CQVwmTxFrRxLRCoOmjpaEkiUo4xd2Y46iiAHEX5Snb/suCCyyhtALVeAAzHnqXmi7Edo9ZyQEHlPwiHQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qBwP5-0000gW-SZ; Wed, 21 Jun 2023 14:53:40 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     alsa-devel@alsa-project.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ASoC: codecs: max98090: Allow dsp_a mode
Date:   Wed, 21 Jun 2023 14:53:27 +0300
Message-Id: <20230621115328.156457-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC4468B86CD3C8787546E8D189E2EBE9EA182A05F53808504070B069C72436E1D2D5A4E71BD025E4125047B1DA41A3FADE443584DC68319CB8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A140E7B1D51EB231EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374D0D183F14C070BA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83712544A9697989658D127D5918B20866F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3A703B70628EAD7BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520C24E1E72F37C03A0CB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B67393CE827C55B5F775ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A53ED0F0D15519928FD04AAF18DCFED2499590945C3EDE3FF3F87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF874C60ACDD5FE242F57F3AD3431D0F7AB6867A931EA55A5E929DFB5A80A42D569B332213384B5353C17492877F82D9B86CE4D2ACC560A8F38AAD56CD3798406E04DA52CF61C1B8024C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lzKbCaM7tQQkw==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B42AF639ED9E053B675404323CF2E7D5998CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA54E8DC16345F01FC93132BCC4B5F627A4CB647ED114AB003ACB18A032C91B96DF475D01A0B191F359A97BF0508C385DA8C9D94EE637B74D14D
X-7FA49CB5: 0D63561A33F958A594549CC4FF3B142D6E5D536DC6E77C76452CA37571F42238CACD7DF95DA8FC8BD5E8D9A59859A8B67EB76A845F84D5F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdGZgddNfoakPLJDztWF3qfQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDM mode for max98090 is dsp_a compatible. So allow it.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7bc463910d4f..403926254c84 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1635,7 +1635,7 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
 			regval |= M98090_RJ_MASK;
 			break;
 		case SND_SOC_DAIFMT_DSP_A:
-			/* Not supported mode */
+			break;
 		default:
 			dev_err(component->dev, "DAI format unsupported");
 			return -EINVAL;
-- 
2.40.1

