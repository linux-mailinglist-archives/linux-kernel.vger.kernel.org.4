Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDEB6F4259
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEBLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjEBLM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:12:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C6F9;
        Tue,  2 May 2023 04:12:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ptnwE-0005l8-N6; Tue, 02 May 2023 13:12:54 +0200
Message-ID: <5a070053-2151-56d7-26a2-03871e1e4e8e@leemhuis.info>
Date:   Tue, 2 May 2023 13:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, robert.mader@collabora.com,
        nicolas.dufresne@collabora.co.uk, ezequiel@vanguardiasur.com.ar,
        festevam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        hverkuil-cisco@xs4all.nl, linux-imx@nxp.com,
        regressions@lists.linux.dev
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
 <20230220104849.398203-2-benjamin.gaignard@collabora.com>
 <26addb7d-bb9d-34e8-d4fe-e323ff488101@collabora.com>
 <dcd317db-3c24-895d-572b-1b139c370ff7@leemhuis.info>
 <05da00c0-2180-62ee-6276-8553ad9341c4@collabora.com>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <05da00c0-2180-62ee-6276-8553ad9341c4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683025977;3af8922a;
X-HE-SMSGID: 1ptnwE-0005l8-N6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.05.23 08:56, Benjamin Gaignard wrote:
> Le 01/05/2023 à 09:21, Thorsten Leemhuis a écrit :
>> On 27.04.23 00:19, Shreeya Patel wrote:
>>> On 20/02/23 16:18, Benjamin Gaignard wrote:
>>>> Setting context source and destination formats should only be done
>>>> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
>>>> the targeted queue is not busy.
>>>> Remove these calls from hantro_reset_encoded_fmt() and
>>>> hantro_reset_raw_fmt() to clean the driver.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> KernelCI found this patch causes a regression in the
>>> baseline.dmesg.alert test [1] on rk3399-rock-pi-4b [2],
>>> see the bisection report for more details [3].
>>>
>>> Let us know if you have any questions.
>>>
>>> [1]
>>> https://github.com/kernelci/kernelci-core/blob/main/config/rootfs/debos/overlays/baseline/opt/kernelci/dmesg.sh
>>> [2] https://linux.kernelci.org/test/case/id/6442e825f19134d74c2e865d/
>>> [3] https://groups.io/g/kernelci-results/message/40740
>> Thx for the report. FWIW, regzbot noticed there is a patch that refers
>> to the culprit that might have been landed in next after your test ran
>> for the last time (and meanwhile it was mainlined): f100ce3bbd6 ("media:
>> verisilicon: Fix crash when probing encoder")
> 
> Yes that patch should fix the probing issue.
> Marek is working on an additional one to fix pixel format negotiation
> but that doesn't impact the boot.

Great, thx for the reply.

Shreeya, normally I believe developers in cases like this and would have
included

 #regzbot fix: f100ce3bbd6

in this mail (without the space in front of the #) to mark the
regression as resolved. Would that be okay for you and other kernel.ci
people? Or do you want to confirm this first?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
