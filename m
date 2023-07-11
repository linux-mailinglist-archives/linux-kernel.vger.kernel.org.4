Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82974F0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjGKN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGKN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:56:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A4BC;
        Tue, 11 Jul 2023 06:56:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJDqV-0002HE-4j; Tue, 11 Jul 2023 15:56:03 +0200
Message-ID: <2f53de7c-e9db-6bf5-6e9e-65edadd4d754@leemhuis.info>
Date:   Tue, 11 Jul 2023 15:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] HID: logitech-hidpp: rework one more time the retries
 attempts
Content-Language: en-US, de-DE
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
 <2023062156-trespass-pandemic-7f4f@gregkh>
 <qbvmv3eexohswyagmllfh3xsxoftwa3wbmsdafmwak2bxlnlft@jz74dijlfxlz>
 <31ce32e018a9fa410e9e1f3e5900621b16a56091.camel@hadess.net>
 <CAO-hwJLFSUJaGK5DAOz30+YyC1hGgHnbeJbc5iQ47jxBcbRSCg@mail.gmail.com>
 <cfa28818-9eaf-0dc9-cb4a-1b3de318e627@leemhuis.info>
 <CAO-hwJLc0wzv2a3JARkPDW+ZgbnvwggfRHcAJmWsKy_FMA13=g@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAO-hwJLc0wzv2a3JARkPDW+ZgbnvwggfRHcAJmWsKy_FMA13=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689083767;ef056e90;
X-HE-SMSGID: 1qJDqV-0002HE-4j
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.07.23 15:40, Benjamin Tissoires wrote:
> On Tue, Jul 11, 2023 at 3:10 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 26.06.23 16:02, Benjamin Tissoires wrote:
>>> On Sun, Jun 25, 2023 at 10:30 AM Bastien Nocera <hadess@hadess.net> wrote:
>>>> On Fri, 2023-06-23 at 10:37 +0200, Benjamin Tissoires wrote:
>>>>> On Jun 21 2023, Greg KH wrote:
>>>>>> On Wed, Jun 21, 2023 at 11:42:30AM +0200, Benjamin Tissoires wrote:
>>>>>>> Make the code looks less like Pascal.
>>>>>>>
>>>>>>> Extract the internal code inside a helper function, fix the
>>>>>>> initialization of the parameters used in the helper function
>>>>>>> (`hidpp->answer_available` was not reset and `*response` wasn't
>>>>>>> too),
>>>>>>> and use a `do {...} while();` loop.
>>>>>>>
>>>>>>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when
>>>>>>> device is busy")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>>>> ---
>>>>>>> as requested by
>>>>>>> https://lore.kernel.org/all/CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
>>>>>>> This is a rewrite of that particular piece of code.
>>>>>>> ---
>>>>>>>  drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++--
>>>>>>> --------------
>>>>>>>  1 file changed, 61 insertions(+), 41 deletions(-)
>>> [...]
>>>
>>> Some people on the Bz were able to reproduce with multiple reboots.
>>> But it's not as urgent as previously, and we were close to the 6.4
>>> final when I sent it. I'll make sure this goes into 6.5 and gets
>>> proper stable backports FWIW.
>>
>> Did that happen? Doesn't look like it from here, but maybe I'm missing
>> something. Where there maybe other changes to resolve the remaining
>> problems some users encounter sporadically since the urgent fixes went in?
> 
> No, there were no other changes that could have solved this. I guess
> the randomness of the problem makes it way harder to detect and to
> reproduce.
> 
> I'll send a v2 of that patch with the reviews today or tomorrow and we
> can probably get it through the current 6.5 cycle.

Great, many thx!

Ciao, Thorsten
