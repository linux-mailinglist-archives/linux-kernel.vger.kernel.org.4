Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58565722261
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjFEJiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFEJix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:38:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84349BD;
        Mon,  5 Jun 2023 02:38:51 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q66fq-0003YR-1m; Mon, 05 Jun 2023 11:38:50 +0200
Message-ID: <439d143b-1de7-6365-cf64-f1b44fd6d1cf@leemhuis.info>
Date:   Mon, 5 Jun 2023 11:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
Content-Language: en-US, de-DE
To:     Hyunwoo Kim <imv4bel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org
In-Reply-To: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685957931;59343b37;
X-HE-SMSGID: 1q66fq-0003YR-1m
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

On 30.05.23 13:12, Thomas Voegtle wrote:
> 
> I have the problem that sometimes my DVB card does not initialize
> properly booting Linux 6.4-rc4.
> This is not always, maybe in 3 out of 4 attempts.
> When this happens somehow you don't see anything special in dmesg, but
> the card just doesn't work.
> 
> Reverting this helps:
> commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
> Author: Hyunwoo Kim <imv4bel@gmail.com>
> Date:   Thu Nov 17 04:59:22 2022 +0000
> 
>     media: dvb-core: Fix use-after-free on race condition at dvb_frontend
> 
> 
> I have:
> 03:00.0 Multimedia video controller [0400]: Conexant Systems, Inc.
> CX23887/8
> PCIe Broadcast Audio and Video Decoder with 3D Comb [14f1:8880] (rev 04)
>         Subsystem: Hauppauge computer works Inc. Device [0070:c138]
>         Kernel driver in use: cx23885

Hmmm, that was posted last Tuesday and received not a single reply. :-/

Hyunwoo Kim: could you please look at it, as it's a regression caused by
a commit of yours (one that would be good to solve before 6.4 is
finalized!)? And in case you are unable to do so let us know?

But FWIW:

Mauro: I wonder if this is something you or someone else has to look
into, as Hyunwoo Kim posted a few times per months to Linux lists, but
according  to a quick search on lore hasn't posted anything since ~two
months now. :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> zcat /proc/config.gz | grep ^CONFIG_DVB
> CONFIG_DVB_CORE=y
> CONFIG_DVB_MMAP=y
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=8
> CONFIG_DVB_DYNAMIC_MINORS=y
> CONFIG_DVB_USB=y
> CONFIG_DVB_USB_TTUSB2=y
> CONFIG_DVB_M88DS3103=y
> CONFIG_DVB_STB0899=y
> CONFIG_DVB_STB6100=y
> CONFIG_DVB_STV090x=y
> CONFIG_DVB_DRXK=y
> CONFIG_DVB_SI2165=y
> CONFIG_DVB_CX24116=y
> CONFIG_DVB_CX24117=y
> CONFIG_DVB_DS3000=y
> CONFIG_DVB_STV0299=y
> CONFIG_DVB_STV0900=y
> CONFIG_DVB_STV6110=y
> CONFIG_DVB_TDA10071=y
> CONFIG_DVB_TDA10086=y
> CONFIG_DVB_TDA8261=y
> CONFIG_DVB_TDA826X=y
> CONFIG_DVB_TS2020=y
> CONFIG_DVB_TUA6100=y
> CONFIG_DVB_DIB7000P=y
> CONFIG_DVB_SI2168=y
> CONFIG_DVB_STV0367=y
> CONFIG_DVB_TDA10048=y
> CONFIG_DVB_TDA1004X=y
> CONFIG_DVB_ZL10353=y
> CONFIG_DVB_TDA10021=y
> CONFIG_DVB_TDA10023=y
> CONFIG_DVB_LGDT330X=y
> CONFIG_DVB_S5H1409=y
> CONFIG_DVB_S5H1411=y
> CONFIG_DVB_MB86A20S=y
> CONFIG_DVB_PLL=y
> CONFIG_DVB_TUNER_DIB0070=y
> CONFIG_DVB_A8293=y
> CONFIG_DVB_LNBP21=y
> 
> 
