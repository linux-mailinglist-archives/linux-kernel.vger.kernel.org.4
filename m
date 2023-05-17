Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011E70630F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjEQIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEQIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C13C1E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF54643C6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48818C433EF;
        Wed, 17 May 2023 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684312621;
        bh=awX7GTJ2Wx17K0IkbJEWyVtj8sz41Jnnhewfqplzsis=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ZdcNShYE/SSjsuQ3S5AOWATMcA39cqrFPyxq748K2G+OiBo1aXQMQ9xso+9orlp4M
         g3lihFE+QvjAPSFjeUP0Krispdcb6s2CossAHuDyi4pHiht9WpFUh1qvgTPBoiLjQf
         nNtIfyZaKufU9jRshkouw3o0D4DYWJRVdiu8jM5u+1Al+jglkauY1y4LaHlcQhw8Cd
         ENrzJlu4nQEzD0zqMKlA5piROoTIH8+Oq4p9SI9HDSANlGaZoLHg8EsUKEN1gA0dI1
         DIx096I1PkItZr5CIqS9exupFZhgXFJtdIazdDXGALwjfk7mhXW57Qe4un39WvEyES
         MvfS9tiCzJ/9g==
Message-ID: <94958409-f726-9da6-3b9f-76efa022ee9d@kernel.org>
Date:   Wed, 17 May 2023 16:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <45eb63c6-a147-776a-99b5-7ac06848ede8@kernel.org>
 <20230517035953.47810-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: pass I_NEW flag to trace event
In-Reply-To: <20230517035953.47810-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/17 11:59, Wu Bo wrote:
> On 2023/5/17 10:44, Chao Yu wrote:
>> On 2023/5/16 20:07, Wu Bo wrote:
>>> Modify the order between 'trace_f2fs_iget' & 'unlock_new_inode', so the
>>> I_NEW can pass to the trace event when the inode initialised.
>>
>> Why is it needed? And trace_f2fs_iget() won't print inode->i_state?
> 
> When connect a trace_probe to f2fs_iget, it will be able to determine whether
> the inode is new initialised in order to do different process.

I didn't get it, you want to hook __tracepoint_f2fs_iget() w/ your own callback?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>> ---
>>>    fs/f2fs/inode.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index cf4327ad106c..caf959289fe7 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -577,8 +577,8 @@ struct inode *f2fs_iget(struct super_block *sb,
>>> unsigned long ino)
>>>            file_dont_truncate(inode);
>>>        }
>>>    -    unlock_new_inode(inode);
>>>        trace_f2fs_iget(inode);
>>> +    unlock_new_inode(inode);
>>>        return inode;
>>>      bad_inode:
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
