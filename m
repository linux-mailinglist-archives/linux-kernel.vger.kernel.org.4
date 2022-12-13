Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94B464AD09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiLMBcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiLMBcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:32:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F01CFD3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:32:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D01FCE134C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4DAC433D2;
        Tue, 13 Dec 2022 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670895132;
        bh=MMyYxqYgaY4WHnCH6AnxCg4u89mm8aCLLlqYAObFnT4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K/wLpSPzCfj2KpgjChoH0dlTLJuOIMuasL4ga6Echu0E8Yr/fdd4CCpTroHZ4+9c/
         mRPUGsfJjiRq71mqlfJ+PRPCYsN63iMr7Vpih+D8deWcAW3AlFRzxV+2zMpxltYu/T
         ihdhFep5s+VyEzE7e0KU+whBF+g6j9wTZGLkhfO24wNQ/RzuS9ge1Piqt6Vb78dwxY
         orhrRS7czNvxWMijq/YRkoPbPtZggZMhEh1hdUVFeqSuZPtjpBzyWChM6ZvuYaP3qw
         XGPso372iE+yHQzGNwh8iSTQhqFHBq6hQA8SMqt+rWFnFQs6ZR18E66KBAWoF7Ss9b
         0V+DkFkig2RaA==
Message-ID: <a364cb12-3241-50a7-fdd5-323825d0a911@kernel.org>
Date:   Tue, 13 Dec 2022 09:32:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when
 discard_cmd_cnt is 0 in f2fs_put_super()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
 <20221212141429.6329-1-frank.li@vivo.com>
 <2f100a4a-592d-f098-b204-efeef58341ee@kernel.org>
 <Y5evHVvzGC/8lMfK@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y5evHVvzGC/8lMfK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/13 6:45, Jaegeuk Kim wrote:
> On 12/12, Chao Yu wrote:
>> On 2022/12/12 22:14, Yangtao Li wrote:
>>> Hi Chao,
>>>
>>>> The difference here is, if we use f2fs_realtime_discard_enable() in
>>>> f2fs_put_super(), we will only write checkpoint w/ CP_TRIMMED flag
>>>> when discard option is enable and device supports discard.
>>>
>>>> But actually, if discard option is disabled, we still needs to give
>>>> put_super() a chance to write checkpoint w/ CP_TRIMMED flag.
>>>
>>> Why do we still have to set the CP_TRIMMED flag when the discard opt is not set.
>>> Did I miss something?
>>
>> Hi Yangtao,
>>
>> I guess it's up to scenario. e.g.
>>
>> mount w/ nodiscard and use FITRIM to trigger in-batch discard,
>> if we set CP_TRIMMED flag during umount, next time, after mount
>> w/ discard, it doesn't to issue redundant discard.
> 
> If fitrim was called with a range, we can get a wrong FI_TRIMMED flag. Isn't it

We can set CP_TRIMMED flag only if fitrim was called on full range w/ 4k granularity,
due to it will check sbi->discard_blks variable to make sure there is no range we
haven't trimmed.

> better to get a full discard range after remount even though some are redundant?

If nodiscard is set, and sbi->discard_blks becomes zero, it says a full range fitrim
was been triggered.

So, previous check condition has no problem, right?

	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
					!sbi->discard_blks && !dropped) {

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thx,
>>> Yangtao
