Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022CC70DAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjEWKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbjEWKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:51:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342E121;
        Tue, 23 May 2023 03:50:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1PbI-0006Kn-VK; Tue, 23 May 2023 12:50:45 +0200
Message-ID: <5d871928-dcd5-3f27-e975-d1639525dad0@leemhuis.info>
Date:   Tue, 23 May 2023 12:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Content-Language: en-US, de-DE
To:     Diederik de Haas <didi.debian@cknow.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hverkuil-cisco@xs4all.nl,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
 <4995215.LvFx2qVVIh@bagend>
 <7c1bf9c4-f14b-30cd-2610-871f5f512d06@collabora.com>
 <12724349.O9o76ZdvQC@bagend>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <12724349.O9o76ZdvQC@bagend>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684839048;0acb48cb;
X-HE-SMSGID: 1q1PbI-0006Kn-VK
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing the Regression list and a bunch of other people that were CCed in
threads that look related:

On 23.05.23 00:38, Diederik de Haas wrote:
> On Monday, 22 May 2023 18:17:39 CEST Benjamin Gaignard wrote:
>> Le 20/05/2023 à 00:34, Diederik de Haas a écrit :
>>> On Thursday, 13 April 2023 21:52:50 CEST Nicolas Dufresne wrote:
> [...]
>>> When I booted into my 6.4-rc1 (but also rc2) kernel on my
>>> Pine64 Quartz64 Model A, I noticed a crash which seems the same as
>>> above, but I didn't have such a crash with my 6.3 kernel.
>>> Searching for 'hantro' led me to this commit as the most likely culprit
>>> but when I build a new 6.4-rcX kernel with this commit reverted,
>>> I still had this crash.
>>> Do you have suggestions which commit would then be the likely culprit?
>>
>> This patch fix the crash at boot time, revert it doesn't seem to be the
>> solution. Maybe this proposal from Marek can help you ?
>>
>> https://patchwork.kernel.org/project/linux-media/patch/20230421104759.2236463-1-m.szyprowski@samsung.com/
> 
> That helped :) After applying that patch I no longer have the crash.
> Thanks!

That regression fix is now a month old, but not yet merged afaics --
guess due to Nicolas comment that wasn't addressed yet and likely
requires a updated patch.

Michael afaics a week ago posted a patch that to my *very limited
understanding of things* (I hope I don't confuse matters here!) seems to
address the same problem, but slightly differently:
https://lore.kernel.org/all/20230516091209.3098262-1-m.tretter@pengutronix.de/

No reply yet.

That's all a bit unfortunate, as it's not how regression fixes should be
dealt with -- and caused multiple people headaches that could have been
avoided. :-/

But well, things happen. But it leads to the question:

How can we finally address the issue quickly now to ensure is doesn't
cause headaches for even more people?

Marek, Michael, could you work on a patch together that we then get
somewhat fast-tracked to Linus to avoid him getting even more unhappy
about the state of things[1]?

Ciao, Thorsten

[1] see
https://lore.kernel.org/all/CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com/
