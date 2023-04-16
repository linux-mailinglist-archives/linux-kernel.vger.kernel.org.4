Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320E36E398C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDPPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDPPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F37A6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8190460DF7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 15:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D409C433D2;
        Sun, 16 Apr 2023 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681657322;
        bh=MRLPHEMwkW7WtKO6pZWkp15qzWsjqubLCzvGyJsu/gw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hCVuB8yr+cjKfsx9+UMEaxFNnhPLJ4Ud+BU1t/wrEJlnVGGe4X1ZMyoCsYXChhKJ9
         O2Ku+sR6dgueUk8pA4rjo9Xajjy7navCG5+Skt1KmeEV9PBj0TYcQWC+Rx9pOvHXaP
         u+WNUu5NFs4KzgRmv4qB72R7qnWvIlGYX5g+5czJWCdbMxp/WTPpf8rBJ92dddviPj
         LpzjQehLx2tHpbDm7rTt4A045YVD0kREAkaKBImSesYNhJllqzUaCQJDQbMRfj0E04
         DxdFFDisoPV/uVQvoEKx/qenqN7i8h7ryJxi7+zKcDxw3/PwdXnWg4A86Yu2wjJ04O
         G7CFTY714L7Og==
Message-ID: <ea22efd7-3b46-e71c-c64f-0b593691e7e7@kernel.org>
Date:   Sun, 16 Apr 2023 23:02:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: remove bulk remove_proc_entry() and unnecessary
 kobject_del()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230406191629.63024-1-frank.li@vivo.com>
 <2e41d6e0-13bb-fa5d-00aa-75865b8e7c34@kernel.org>
 <ZDglzIoEp3dH3eOS@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDglzIoEp3dH3eOS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/13 23:54, Jaegeuk Kim wrote:
> On 04/13, Chao Yu wrote:
>> On 2023/4/7 3:16, Yangtao Li wrote:
>>> Convert to use remove_proc_subtree() and kill kobject_del() directly.
>>> kobject_put() actually covers kobject removal automatically, which is
>>> single stage removal.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/sysfs.c | 15 ++-------------
>>>    1 file changed, 2 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index dfbd17802549..3aad3500a701 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -1461,25 +1461,14 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>>>    void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>>>    {
>>> -	if (sbi->s_proc) {
>>> -#ifdef CONFIG_F2FS_IOSTAT
>>> -		remove_proc_entry("iostat_info", sbi->s_proc);
>>> -#endif
>>> -		remove_proc_entry("segment_info", sbi->s_proc);
>>> -		remove_proc_entry("segment_bits", sbi->s_proc);
>>> -		remove_proc_entry("victim_bits", sbi->s_proc);
>>> -		remove_proc_entry("discard_plist_info", sbi->s_proc);
>>> -		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
>>> -	}
>>> +	if (sbi->s_proc)
>>> +		remove_proc_subtree(sbi->sb->s_id, f2fs_proc_root);
>>> -	kobject_del(&sbi->s_stat_kobj);
>>
>> - f2fs_register_sysfs
>>   - kobject_init_and_add(&sbi->s_stat_kobj, ..)
>>
>> /**
>>   * kobject_init_and_add() - Initialize a kobject structure and add it to
>>   *                          the kobject hierarchy.
>> ...
>>   *
>>   * This function combines the call to kobject_init() and kobject_add().
>> ...
>>   */
>>
>> /**
>>   * kobject_del() - Unlink kobject from hierarchy.
>>   * @kobj: object.
>>   *
>>   * This is the function that should be called to delete an object
>>   * successfully added via kobject_add().
>>   */
>>
>> Am I missing something?
> 
> kobject_put -> kobject_cleanup was supposed to do it?

Yes, it seems so.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>>    	kobject_put(&sbi->s_stat_kobj);
>>>    	wait_for_completion(&sbi->s_stat_kobj_unregister);
>>> -	kobject_del(&sbi->s_feature_list_kobj);
>>>    	kobject_put(&sbi->s_feature_list_kobj);
>>>    	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
>>> -	kobject_del(&sbi->s_kobj);
>>>    	kobject_put(&sbi->s_kobj);
>>>    	wait_for_completion(&sbi->s_kobj_unregister);
>>>    }
