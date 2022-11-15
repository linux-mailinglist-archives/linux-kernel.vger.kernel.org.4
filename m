Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3A628F61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiKOBgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKOBgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:36:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA613F6A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED878614EF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DDC433D6;
        Tue, 15 Nov 2022 01:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668476170;
        bh=u+r7M+gVUdsXzOnX5qWOPAIFTRPi6iT3MfWb6GlBZws=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I0ErSM1hAmys7z2U16mv9a1MT7eBIFJVPIfjyvg81jFMNwBnLRJyARfzElfsnmiQd
         VtnxPfl7TmoR3emO9ycDk2TlmlEHC/EyNORUx0M61PAtRcZCFCpK5ZB8r/VNS94yHJ
         PcCS11/1FCKLF6E5++CjJwr4ybrVjFh/6PApcHeMmklLWLlBqHQ0pbPfBy18wHcnjb
         TaH9c7QFC4gj3i3+lP9ncnYQqgVYZD4fS8itvjomED7mBjwiU6GNeCMswOMXi08Q86
         4nuTBW3x5dW/wJb7ychgSpt/prCHjxFvH1pJA1BbfC2j4d6rOHeoCSZLD0Mt+8lhJA
         TgvE7oN/+F7BQ==
Message-ID: <9c5d267e-d040-0e67-27fc-d6ff6e5dae25@kernel.org>
Date:   Tue, 15 Nov 2022 09:36:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: remove submit label in __submit_discard_cmd()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221111161349.60689-1-frank.li@vivo.com>
 <Y3LF7SjCLKaz7OWi@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y3LF7SjCLKaz7OWi@google.com>
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

On 2022/11/15 6:49, Jaegeuk Kim wrote:
> On 11/12, Yangtao Li wrote:
>> Complaint from Matthew Wilcox in another similar place:
>>
>> 	"submit?  You don't submit anything at the 'submit' label.
>> 	it should be called 'skip' or something.  But I think this
>> 	is just badly written and you don't need a goto at all."
>>
>> Let's remove submit label for readability.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/f2fs/segment.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 3654c30e0517..0a72e787c585 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1144,13 +1144,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>>   		if (time_to_inject(sbi, FAULT_DISCARD)) {
>>   			f2fs_show_injection_info(sbi, FAULT_DISCARD);
>>   			err = -EIO;
>> -			goto submit;
>> -		}
>> -		err = __blkdev_issue_discard(bdev,
>> +		} else
>> +			err = __blkdev_issue_discard(bdev,
>>   					SECTOR_FROM_BLOCK(start),
>>   					SECTOR_FROM_BLOCK(len),
>>   					GFP_NOFS, &bio);
> 
> Thanks. I added {} to meet the coding style.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>> -submit:
>>   		if (err) {
>>   			spin_lock_irqsave(&dc->lock, flags);
>>   			if (dc->state == D_PARTIAL)
>> -- 
>> 2.25.1
