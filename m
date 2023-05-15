Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB57030A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbjEOOzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEOOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:55:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6610C2;
        Mon, 15 May 2023 07:55:30 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pyZbg-0007JP-V0; Mon, 15 May 2023 16:55:25 +0200
Message-ID: <1079eef3-b770-8d65-1dd8-70d5d476417f@leemhuis.info>
Date:   Mon, 15 May 2023 16:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
Content-Language: en-US, de-DE
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
 <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
 <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
 <20230510090527.25e26127@sal.lan>
 <55d5ec29-f30f-4596-a3b9-7e5b8adf0582@kernel.org>
 <CAMuHMdV=b8j=X3XEBWsAghsHrPT58xp7peaMiTZisqf7wRJf3w@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAMuHMdV=b8j=X3XEBWsAghsHrPT58xp7peaMiTZisqf7wRJf3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684162530;f13a0cd8;
X-HE-SMSGID: 1pyZbg-0007JP-V0
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.23 09:46, Geert Uytterhoeven wrote:
> On Sun, May 14, 2023 at 1:01 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 10/05/2023 10:05, Mauro Carvalho Chehab wrote:
>>> And another CI job testing bisect breakages as I receive pull requests,
>>> applying patch per patch and using both allyesconfig and allmodconfig,
>>> also on x86_64 arch with W=1:
>>>
>>>       https://builder.linuxtv.org/job/patchwork/
>>>
>>> The rule is to not merge stuff on media tree if any of those jobs
>>> fail. I also fast-forward merging patches whose subject states that
>>> the build has failed.
>>>
>>> In order to help with that, on normal situation, I usually take one week
>>> to merge stuff from media_stage into media_tree, doing rebases at
>>> media_stage if needed to avoid git bisect build breakages at media_tree
>>> (which is from where I send my update PRs to you).
>>>
>>> Unfortunately, currently we don't have resources to do multiple randconfig
>>
>> Is you media staging tree included in LKP (kernel test robot)? You would
>> get huge build coverage after every push to your staging repo.
> 
> As (multiple[*[) fixes for the build issues were submitted before the
> opening of the merge window, there must have been some build coverage,
> with even some people acting upon it...
> 
> [*] General note, not limited to media: please apply build fixes and
>     regression fixes ASAP, to avoid multiple people running into the
>     same issues, and spending time on bisecting, investigating,
>     fixing, ...
>     Thanks a lot!

FWIW, I proposed a rewritten section of
Documentation/process/handling-regressions.rst that is closely related
to this. The new text says:

```
+ * Do not consider regressions from the current cycle as something that
can wait
+   till the end of the cycle, as the issue might discourage or prevent
users and
+   CI systems from testing mainline now or generally.
[...]
+ * Aim to mainline a fix within two or three days, if the issue is
severe or
+   bothering many users -- either in general or in prevalent conditions
like a
+   particular hardware environment, distribution, or stable/longterm
series.```

For details and context see
https://lore.kernel.org/linux-doc/6971680941a5b7b9cb0c2839c75b5cc4ddb2d162.1684139586.git.linux@leemhuis.info/

Let me known if you think I should be more explicit; I could simply add
a "this includes, but is not limited to fixes for build errors" to the
second segment mentioned above. But well, that yet again would make the
text longer. :-(

Ciao, Thorsten
