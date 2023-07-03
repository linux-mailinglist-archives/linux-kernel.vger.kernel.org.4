Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB82745554
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGCGQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGCGQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:16:17 -0400
Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CBAB6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=MazIOif3lLV6SFCROm/GljE5HwzfQ7ahiongMeWeRm0=;
        t=1688364974;x=1688454974; 
        b=DSZ3gV+7R1D1z/g0dkFMzSJCcwW1u8gAvZx6pd3HRCxj1Ur6QtS/LQdrqq/SvLJToHVO0Ix5jkh6jdG8UDKVXTns8EEoJmy+LK0eBNfbm4h6Q56/b9FPBdlEtO1wVaWvEvjhxUQEfUwjGuZopNnoJ4amMze/w9U9AGW+RlAHCwlQvjgs9HhsfnsOsmuEfArlW6lZQ1v1e0qyRWk7zSHkolVbaKnClSY8yYh3bwmvltiWP26FKvYilbL98KxVIci+TCFqEEc1fDowZ1OJ+jBT5gNgKj8XdNBexHU8Lb0ta69x1WWwBrDDFT1PC6IplIMzQFadQyqPwgJDlhDuEedDow==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qGCr2-0003HA-MC; Mon, 03 Jul 2023 09:16:09 +0300
Message-ID: <a8198e25-50e3-3f65-e77c-8d2f1dd263b8@inbox.ru>
Date:   Mon, 3 Jul 2023 09:16:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] ASoC: dwc: Add TDM mode support
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
References: <20230622200031.120168-1-fido_max@inbox.ru>
Content-Language: en-US
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20230622200031.120168-1-fido_max@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F8F06A4ADC2A029E60F9D100B8369818A3E0BBAE754148E9182A05F538085040A4262E5FDE2DADA8065A64F063AC0E76EAC05CA1D51FD5C747C09391A81BBA96
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE789805A6418246A1AEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA79770243194FEC6FEE9381017E3C1ECE20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C07734D68A6916D8318941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063713EF0ED8E3D4D567389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735D2D576BCF940C736C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A57AA3ED14E14571D9CA369EC02EF08F78F3F7BE3BDBBFE2DEF87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D346B71C4B0698719D72AAC31652476799CB0C072FA6C4537F39A6D188E2D9E89B125A033658C64F9061D7E09C32AA3244C92AE93559CC76549D0EA1D594C87808295A9E0DC41E9A4CF4D814BAB3645D38B5DA084F8E80FEBD3498BCAF62EB65D490083D0702184784583DB18EBE73F7D69
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqbm8KbRhf34VIfWJ9TUNMw==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BEA861E876B01A27A9936350E2CD17AD398CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2023 23:00, Maxim Kochetkov wrote:
> Depending on hardware implementaion of DWC I2S controller may support
> TDM mode if enabled in SoC at design time.
> Unfortunately there is no way to detect TDM capability for DWC by
> reading registers. Anyway, if such capability enabled, TDM mode
> can be enabled and configured by dai-tdm-slot-* DT options.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>

Do we need some extra steps to upstream this patch?
