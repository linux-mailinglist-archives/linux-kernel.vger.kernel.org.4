Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF86DD5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDKIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjDKIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976D40DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5754C61E67
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86D2C433EF;
        Tue, 11 Apr 2023 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681202048;
        bh=vWRd0M+XDT89DUaEUaER2lgBgrSKrR9GWjWJ1XatS1w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=igmrbDkV7dy8imzW3rW9lvMJZtVqvlk/y2DUky4jxHWm1mbDe+Ddt/1OnbHeFEmbQ
         Eu1t4Do/9FznM383edvHbCxoRfcha8jKCVJitNm2ohnWBfwid0v2KbBDQwb7UQ2kJb
         x2PH9F8hSurDKwSdVvEBRc6fNJIshKUz+4MahxCZf6KqAL3uoyivcW306YXuw79V5K
         qu3KfhgqjldXU4+PvMxa5/i3sdM+kWUzoTnXYmsJA3l62zxN/va34plc9VImY+fCAM
         cz0csbXi0FXsra5Ku3vvmHRFY64L8lHYZ8vYieRWwIKmGh8t9J8O+MBNam81o9i4VX
         VoDZW0AlMC1fw==
Message-ID: <b05d7ce8-ef98-a7ef-9873-4403ec0858c1@kernel.org>
Date:   Tue, 11 Apr 2023 16:34:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] f2fs: remove folio_detach_private() in
 .invalidate_folio and .release_folio
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230410022418.1843178-1-chao@kernel.org>
 <ZDRWdJxP6QzcIU7G@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDRWdJxP6QzcIU7G@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/11 2:33, Jaegeuk Kim wrote:
> On 04/10, Chao Yu wrote:
>> We have maintain PagePrivate and page_private and page reference
>> w/ {set,clear}_page_private_*, it doesn't need to call
>> folio_detach_private() in the end of .invalidate_folio and
>> .release_folio, remove it and use f2fs_bug_on instead.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 4946df6dd253..8b179b4bdc03 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3737,7 +3737,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>>   			inode->i_ino == F2FS_COMPRESS_INO(sbi))
>>   		clear_page_private_data(&folio->page);
>>   
>> -	folio_detach_private(folio);
>> +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
>> +	f2fs_bug_on(sbi, page_private(&folio->page));
> 
> I think we can just check page_private() only.

Why? how about the case PagePrivate was set, but page_private was't? It must
be a bug as well?

Thanks,

> 
>>   }
>>   
>>   bool f2fs_release_folio(struct folio *folio, gfp_t wait)
>> @@ -3759,7 +3760,9 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
>>   	clear_page_private_reference(&folio->page);
>>   	clear_page_private_gcing(&folio->page);
>>   
>> -	folio_detach_private(folio);
>> +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
>> +	f2fs_bug_on(sbi, page_private(&folio->page));
>> +
>>   	return true;
>>   }
>>   
>> -- 
>> 2.25.1
