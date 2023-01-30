Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18115680B95
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjA3LFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjA3LFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:05:16 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2633466
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:04:25 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pMRxX-00009o-UI; Mon, 30 Jan 2023 12:04:23 +0100
Message-ID: <62fb7c9a-179a-f3f0-93b6-5e74f88dad63@leemhuis.info>
Date:   Mon, 30 Jan 2023 12:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: CIFS NTLM regression still annoying people (was: Re: Linux
 regressions report for mainline [2023-01-29])
Content-Language: en-US, de-DE
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
References: <167501403214.1314424.14370223374691112185@leemhuis.info>
 <CAHk-=wgnBBJ7hDSz5T+2FMF0JhE1Jmf6=tZEytQ6n1jZ4m2s=w@mail.gmail.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <CAHk-=wgnBBJ7hDSz5T+2FMF0JhE1Jmf6=tZEytQ6n1jZ4m2s=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675076665;76f21fbb;
X-HE-SMSGID: 1pMRxX-00009o-UI
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.01.23 20:32, Linus Torvalds wrote:
> On Sun, Jan 29, 2023 at 9:42 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> * Andrew afaics didn’t sent a revert[1] from Vlastimir your way
> Ok, I applied this one as tiny and clear and hitting actual user loads.

Great, many thx!

>> * A fix[1] for a stack_depot/kmemleak issue is in next for a while already too[2]
> This one I left alone, since it's a bit more involved and the use-case
> is more esoteric too.

Totally fine with me and yeah, a bit esoteric. But when somebody bisects
and report a problem (in this case: Boris) that already fixed in next
for a few days, my mind yells "what a waste or energy, this could have
been prevented by mainlining the fix a bit more quickly" -- that's why I
brought it up.

> And in other news, the input regression revert you mentioned earlier
> got pulled this morning.

Ahh, great.

BTW, there is one thing that still bugs me: every few weeks there is yet
somebody new[1] complaining about the removal of support for NTLM and
weaker authentication algorithms from cifs some time ago in
76a3c92ec9e0. The situation[2] was improved slightly in 2f6f19c7aaad
("cifs: fix regression in very old smb1 mounts"), but it seems some
users of Apple Time Capsules or some Epson printer/scanner still can't
access their devices which apparently still work fine in Windows and
macOS[1].

Yes, the issue is tricky, as there are security implications here and we
have nobody that tests this, as you pointed out [3]. Is there
nevertheless something somebody committed could do? Would we even be
willing to add that support back in, in case someone commits to maintain
and regularly test that codepath?

Ciao, Thorsten

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216682
[2] https://bugzilla.kernel.org/show_bug.cgi?id=215375
[3]
https://lore.kernel.org/all/CAHk-=wjSBvRk-ksUBOiQzJd=e19UZKvOSZs1UHahK5U0QVh6RQ@mail.gmail.com/
