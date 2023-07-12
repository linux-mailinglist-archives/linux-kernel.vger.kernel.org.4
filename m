Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF37504AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjGLKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjGLKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:35:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C64119B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:34:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJXBM-0007gb-IQ; Wed, 12 Jul 2023 12:34:52 +0200
Message-ID: <55bffc21-5f19-765f-9dbc-1b565c880426@leemhuis.info>
Date:   Wed, 12 Jul 2023 12:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] KVM: arm64: Use BTI for nvhe
Content-Language: en-US, de-DE
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Mostafa Saleh <smostafa@google.com>
Cc:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com, qperret@google.com,
        will@kernel.org, catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230530150845.2856828-1-smostafa@google.com>
 <20230704134136.a5znw4jupt5yp5kg@bogus>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230704134136.a5znw4jupt5yp5kg@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689158098;54b2c16c;
X-HE-SMSGID: 1qJXBM-0007gb-IQ
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 04.07.23 15:41, Sudeep Holla wrote:
> On Tue, May 30, 2023 at 03:08:45PM +0000, Mostafa Saleh wrote:
>> CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.5-BTI.
>> However, the nvhe code doesn't make use of it as it doesn't map any
>> pages with Guarded Page(GP) bit.
> [...]
> I was chasing a bug in linux-next yesterday with protected nVHE(pKVM) and
> cpuidle enabled. The system fails to boot. I just bisected the issue to this
> patch and also saw this patch landed in the linus tree yesterday/today.
> Not sure if this is something to do with the fact that pKVM skips to
> __kvm_handle_stub_hvc in __host_hvc.
> 
> Let me know if you want be to try something.

Thanks for the report. Seems the fix is slow to progress. Hence to be
sure the issue doesn't fall through the cracks unnoticed, I'm adding it
to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced b53d4a272349
#regzbot title KVM: arm64: boot failures due to missing bti instructions
#regzbot monitor:
https://lore.kernel.org/all/20230706152240.685684-1-smostafa@google.com/
#regzbot fix: KVM: arm64: Add missing BTI instructions
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
