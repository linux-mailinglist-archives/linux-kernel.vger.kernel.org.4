Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B767E2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjA0LLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjA0LLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:11:31 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E19757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:11:30 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pLMdf-0005UE-0Q; Fri, 27 Jan 2023 12:11:23 +0100
Message-ID: <ea5f2437-e7ce-faea-ed8d-30322160c22a@leemhuis.info>
Date:   Fri, 27 Jan 2023 12:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: regression on aarch64? panic on boot
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
To:     Klaus Jensen <its@irrelevant.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info>
In-Reply-To: <849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674817890;b31b26e5;
X-HE-SMSGID: 1pLMdf-0005UE-0Q
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: there afaics is a fix for the regression discussed in this
thread, but its author did not use a Link: tag to point to the report,
as wanted by Linus and explained in the documentation; this forces me to
write this mail, which sole purpose it to update the state of this
tracked Linux kernel regression.]

On 19.01.23 14:10, Linux kernel regression tracking (#adding) wrote:
> On 16.01.23 22:57, Klaus Jensen wrote:
>>
>> I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
>> guest in roughly 20% of boots on v6.2-rc4. Example panic below.
>>
>> I've bisected it to commit eac3ef262941 ("nvme-pci: split the initial
>> probe from the rest path").
>>
>> I'm not seeing this on any other emulated platforms that I'm currently
>> testing (x86_64, riscv32/64, mips32/64 and sparc64).
>> [...]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced eac3ef262941
> #regzbot title nvme: occasional boot problems due to the newly supported
> async driver probe
> #regzbot ignore-activity

#regzbot monitor:
https://lore.kernel.org/all/20230124171738.2311160-1-kbusch@meta.com/
#regzbot fix: nvme-pci: flush initial scan_work for async probe
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
