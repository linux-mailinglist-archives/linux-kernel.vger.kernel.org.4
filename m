Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38FD72D6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbjFMBLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMBLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E49010EB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2288D63023
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C74C433EF;
        Tue, 13 Jun 2023 01:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686618703;
        bh=/QyNTNkR1g5xPACODqWCX3YvTN7GVZ+c9Rjb8u5R1EE=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Ev7DlpHHbCu0TXYdYiE5Au8/olQgVOP/YhEef6N8Sj5uOzYefzwc5znBfS5O7UXCh
         YGV5GHDuNjmkbBw8jLRnEpRZbZdATD6tJ2pcf/0rDgLG9lBkY4CKYvBLXOxvgomYAE
         o7l5tordexCtCheRWVzexef1GufnWA2dwy5JZPUBlz+oOclJgIN+E9WnuUtmjQnnbF
         UHYJRiHpscM72Kt4KBhjAVPsoTdm396kphmFJ0Dr2zBaCvBNB5qFNU/2HIpz1wM5FM
         eluvMh2/Ax9H4+F/uJsm+6/C+Ko2MTSOOIPIQNcVCjGk7fAElz8iOmit7jBDUPpgNm
         FeJeFXRhO6XBw==
Message-ID: <cdeb92fd-11c1-2e3d-662d-08022dfe7e7f@kernel.org>
Date:   Tue, 13 Jun 2023 09:11:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <7af0f599-2314-56af-2813-5e63754134e1@kernel.org>
 <ZIc7ek4UWwjB41a5@google.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress tmp files given extension
In-Reply-To: <ZIc7ek4UWwjB41a5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/12 23:36, Jaegeuk Kim wrote:
> On 06/12, Chao Yu wrote:
>> On 2023/6/7 4:36, Jaegeuk Kim wrote:
>>> Let's compress tmp files for the given extension list.
>>
>> Could you please check below commit? IIRC, it was introduce to avoid compressing
>> file which has unpredictable tmp file, e.g. foo.sox.
>>
>> Could you please describe the case you encounter?
> 
> I don't know what I need to describe more tho, looking at how to compress

Oh, I just like to know which case you want to cover: foo.so.tmp or foo.sotmp.

> abc.so.tmp and abc.so, given compress_extension=so.

Copied.

> 
> So, your concern is somehow abc.soa? If so, we need to fix is_extension_exist.

Yes, is_extension_exist(, true) accepts optional '.' while parsing file extension.

[filename + '.' + extension + (optional: '.' + temp extension)]

It is used to support parsing common prefix for cold file's extension, we can add
a parameter for is_extension_exist() to disable prefix parsing for compress file
extension?

const char *media_ext_lists[] = {
	/* common prefix */
	"mp", // Covers mp3, mp4, mpeg, mpg
	"wm", // Covers wma, wmb, wmv
	"og", // Covers oga, ogg, ogm, ogv
	"jp", // Covers jpg, jpeg, jp2
...
}

Thanks,

> Will check what's going on here.
> 
>>
>> commit 4a67d9b07ac8dce7f1034e0d887f2f4ee00fe118
>> Author: Chao Yu <chao@kernel.org>
>> Date:   Tue May 18 17:54:58 2021 +0800
>>
>>      f2fs: compress: fix to disallow temp extension
>>
>>      This patch restricts to configure compress extension as format of:
>>
>>       [filename + '.' + extension]
>>
>>      rather than:
>>
>>       [filename + '.' + extension + (optional: '.' + temp extension)]
>>
>>      in order to avoid to enable compression incorrectly:
>>
>>      1. compress_extension=so
>>      2. touch file.soa
>>      3. touch file.so.tmp
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/namei.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>> index 3e35eb7dbb8f..cdc94c8e60f7 100644
>>> --- a/fs/f2fs/namei.c
>>> +++ b/fs/f2fs/namei.c
>>> @@ -161,7 +161,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
>>>    	/* Compress wanting extension. */
>>>    	for (i = 0; i < ext_cnt; i++) {
>>> -		if (is_extension_exist(name, ext[i], false)) {
>>> +		if (is_extension_exist(name, ext[i], true)) {
>>>    			set_compress_context(inode);
>>>    			return;
>>>    		}
