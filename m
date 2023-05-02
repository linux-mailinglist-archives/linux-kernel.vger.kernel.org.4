Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A06F45B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjEBOCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjEBOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:02:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499EA1AE;
        Tue,  2 May 2023 07:02:35 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A12B6603232;
        Tue,  2 May 2023 15:02:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683036153;
        bh=xq+GCvhWDrpI4kqWLTSjKMKXim4TcqGGOuePu/Nq+us=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mt6IWboNQ0mOLVpDukyzH4UNRI1F1ButfAO3t2pVQpqK0dNm87o1QXydpVJNNwMV2
         CsgV8zzxN4MY6W+oLs1rqQztOBNk1tHs3vCCivnS1ri9bLC9l+gtKvrbn5ABYJdKZH
         8uYRrlf21McuoEpn3kX0JQ22547y+gQnV5wKwTsPDHQr4wSrJMEuWpyOBhdX806MkE
         aFcJiv6RMR9+ouhCse0WR/3uP6ZGOBmzihGpsoDEXQKcQcHHXgcWPD9bhukmCwex94
         YZzPDFjUZ10zcZXXP8STALbsRodu7kd99cwh4qIw49SIgCZM0nbSMTX+RNf9t70Vje
         Oe07oyFxXDyqg==
Message-ID: <5cfdd715-a59a-3bb2-1bec-1cc59e9b05c4@collabora.com>
Date:   Tue, 2 May 2023 19:32:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, robert.mader@collabora.com,
        nicolas.dufresne@collabora.co.uk, ezequiel@vanguardiasur.com.ar,
        festevam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        hverkuil-cisco@xs4all.nl, linux-imx@nxp.com,
        kernelci@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        ricardo.canuelo@collabora.com,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
 <20230220104849.398203-2-benjamin.gaignard@collabora.com>
 <26addb7d-bb9d-34e8-d4fe-e323ff488101@collabora.com>
 <dcd317db-3c24-895d-572b-1b139c370ff7@leemhuis.info>
 <05da00c0-2180-62ee-6276-8553ad9341c4@collabora.com>
 <5a070053-2151-56d7-26a2-03871e1e4e8e@leemhuis.info>
Content-Language: en-US
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <5a070053-2151-56d7-26a2-03871e1e4e8e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On 02/05/23 16:42, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 02.05.23 08:56, Benjamin Gaignard wrote:
>> Le 01/05/2023 à 09:21, Thorsten Leemhuis a écrit :
>>> On 27.04.23 00:19, Shreeya Patel wrote:
>>>> On 20/02/23 16:18, Benjamin Gaignard wrote:
>>>>> Setting context source and destination formats should only be done
>>>>> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
>>>>> the targeted queue is not busy.
>>>>> Remove these calls from hantro_reset_encoded_fmt() and
>>>>> hantro_reset_raw_fmt() to clean the driver.
>>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> KernelCI found this patch causes a regression in the
>>>> baseline.dmesg.alert test [1] on rk3399-rock-pi-4b [2],
>>>> see the bisection report for more details [3].
>>>>
>>>> Let us know if you have any questions.
>>>>
>>>> [1]
>>>> https://github.com/kernelci/kernelci-core/blob/main/config/rootfs/debos/overlays/baseline/opt/kernelci/dmesg.sh
>>>> [2] https://linux.kernelci.org/test/case/id/6442e825f19134d74c2e865d/
>>>> [3] https://groups.io/g/kernelci-results/message/40740
>>> Thx for the report. FWIW, regzbot noticed there is a patch that refers
>>> to the culprit that might have been landed in next after your test ran
>>> for the last time (and meanwhile it was mainlined): f100ce3bbd6 ("media:
>>> verisilicon: Fix crash when probing encoder")
>> Yes that patch should fix the probing issue.
>> Marek is working on an additional one to fix pixel format negotiation
>> but that doesn't impact the boot.
> Great, thx for the reply.
>
> Shreeya, normally I believe developers in cases like this and would have
> included
>
>   #regzbot fix: f100ce3bbd6
>
> in this mail (without the space in front of the #) to mark the
> regression as resolved. Would that be okay for you and other kernel.ci
> people? Or do you want to confirm this first?

I checked the commit pointed out and also double checked with Benjamin 
internally so
we are good to mark this as fixed.


#regzbot fix: f100ce3bbd6a


Thanks,
Shreeya Patel

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
