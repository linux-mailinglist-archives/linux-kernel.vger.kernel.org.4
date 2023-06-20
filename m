Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B44D736BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjFTMek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjFTMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:34:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27310F4;
        Tue, 20 Jun 2023 05:34:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBaZ5-0001MI-KF; Tue, 20 Jun 2023 14:34:31 +0200
Message-ID: <7e18f4f2-a05a-2738-426b-31482c58af35@leemhuis.info>
Date:   Tue, 20 Jun 2023 14:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] wifi: rtw88: Move register access from
 rtw_bf_assoc() outside the RCU
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, tony0620emma@gmail.com,
        kvalo@kernel.org, pkshih@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <20230108211324.442823-1-martin.blumenstingl@googlemail.com>
 <20230108211324.442823-2-martin.blumenstingl@googlemail.com>
 <20230331125906.GF15436@pengutronix.de>
 <8ab36d80-8417-628f-9f51-e75eaf6b1a51@leemhuis.info>
In-Reply-To: <8ab36d80-8417-628f-9f51-e75eaf6b1a51@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687264474;636107cb;
X-HE-SMSGID: 1qBaZ5-0001MI-KF
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.23 13:30, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 31.03.23 14:59, Sascha Hauer wrote:
>> On Sun, Jan 08, 2023 at 10:13:22PM +0100, Martin Blumenstingl wrote:
>>> USB and (upcoming) SDIO support may sleep in the read/write handlers.
>>> Shrink the RCU critical section so it only cover the call to
>>> ieee80211_find_sta() and finding the ic_vht_cap/vht_cap based on the
>>> found station. This moves the chip's BFEE configuration outside the
>>> rcu_read_lock section and thus prevent "scheduling while atomic" or
>>> "Voluntary context switch within RCU read-side critical section!"
>>> warnings when accessing the registers using an SDIO card (which is
>>> where this issue has been spotted in the real world - but it also
>>> affects USB cards).
>>
>> Unfortunately this introduces a regression on my RTW8821CU chip. With
>> this it constantly looses connection to the AP and reconnects shortly
>> after:
> 
> #regzbot ^introduced c7eca79def44
> #regzbot title net: wifi: rtw88: RTW8821CU constantly looses connection
> to the AP and reconnects shortly after
> #regzbot ignore-activity

Forgot to resolve this in regzbot:

#regzbot resolve: turn's out this wasn't a regression, see
https://lore.kernel.org/lkml/20230403100043.GT19113@pengutronix.de/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
