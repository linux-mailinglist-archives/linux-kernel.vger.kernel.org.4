Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825056DD5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDKIhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDKIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3F30FA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1281622D7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8896DC433EF;
        Tue, 11 Apr 2023 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681202229;
        bh=wOKAV9W48PUCbJhAWm/aGptDEIS+77Kp1nJ77iUN0h8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BC5Z3xpJs3+8JSw+1JjCMvvigAq7cu/9pYu38TRi5o5+4I8Wv75Rt8GnQc/cA5bRh
         jTQWRE+iVhf9cG2mE6EnTkUD9iYw4TfeP0g/dl5jixsMs5uLC3/g0Lo0UAxdF4dYed
         S2gzhN23qrT2DTSR5dozsFzOsfFuGPFatR8H/WTydSHS9LE+sM32+v39r9STL8u09u
         CzkcqKQuUuuZU43kARD4mkEwzao1hiq8IeowyjxLmAAeoOOZqPp0BUIg2y/3U47UIG
         4rBOaNEbdI0lHcD28RBj173hNI/KEz0/YlJKON4FvR+XND7FAacLWvSotdx0ARXuA6
         yfiVIusZbOyng==
Message-ID: <05690b56-e7e2-14d5-7a56-00bcddc61c78@kernel.org>
Date:   Tue, 11 Apr 2023 16:37:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] f2fs: clean up with {attach,detach}_page_private()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230410022418.1843178-1-chao@kernel.org>
 <20230410022418.1843178-2-chao@kernel.org> <ZDRZrzROjW5z935R@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDRZrzROjW5z935R@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/11 2:47, Jaegeuk Kim wrote:
> On 04/10, Chao Yu wrote:
>> No logic changes.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h | 32 ++++++++------------------------
>>   1 file changed, 8 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index ec8387da7f74..c378aedcadea 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1416,11 +1416,8 @@ static inline bool page_private_##name(struct page *page) \
>>   #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
>>   static inline void set_page_private_##name(struct page *page) \
>>   { \
>> -	if (!PagePrivate(page)) { \
>> -		get_page(page); \
>> -		SetPagePrivate(page); \
>> -		set_page_private(page, 0); \
>> -	} \
>> +	if (!PagePrivate(page)) \
>> +		attach_page_private(page, (void *)page->private); \
> 
> 		attach_page_private(page, (void *)0);

Correct, thanks for fixing this.

Thanks,

> 
>>   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
>>   	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>>   }
>> @@ -1429,13 +1426,8 @@ static inline void set_page_private_##name(struct page *page) \
>>   static inline void clear_page_private_##name(struct page *page) \
>>   { \
>>   	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>> -	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) { \
>> -		set_page_private(page, 0); \
>> -		if (PagePrivate(page)) { \
>> -			ClearPagePrivate(page); \
>> -			put_page(page); \
>> -		}\
>> -	} \
>> +	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
>> +		detach_page_private(page); \
>>   }
>>   
>>   PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
>> @@ -1464,11 +1456,8 @@ static inline unsigned long get_page_private_data(struct page *page)
>>   
>>   static inline void set_page_private_data(struct page *page, unsigned long data)
>>   {
>> -	if (!PagePrivate(page)) {
>> -		get_page(page);
>> -		SetPagePrivate(page);
>> -		set_page_private(page, 0);
>> -	}
>> +	if (!PagePrivate(page))
>> +		attach_page_private(page, 0);
>>   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
>>   	page_private(page) |= data << PAGE_PRIVATE_MAX;
>>   }
>> @@ -1476,13 +1465,8 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
>>   static inline void clear_page_private_data(struct page *page)
>>   {
>>   	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
>> -	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) {
>> -		set_page_private(page, 0);
>> -		if (PagePrivate(page)) {
>> -			ClearPagePrivate(page);
>> -			put_page(page);
>> -		}
>> -	}
>> +	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))
>> +		detach_page_private(page);
>>   }
>>   
>>   /* For compression */
>> -- 
>> 2.25.1
