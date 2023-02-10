Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B507691797
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBJEca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBJEc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:32:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CD6BD0E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=L6w+LKYr+oy8oYFGccrSIKm2TVmoLHFlvAgUlre5XUw=; b=JQSVy8t7ZNA3npQ4IhEY8FYiTn
        sTrnqQcA0C50Zt4+2Zo3c+nquIeeVfaJ9gpzOw+oPAGNULsgb19JxLMhLonPC2avQJyMCKkPAqcXF
        ekpuWyuBZSqcI1qY8IGSQlHhQtf9yuh/rU6Pu+DwYs1I6pUVH4l/nSjdzN6F5Q/ysBPa74nJKbtkm
        zSKK0ijR+rilUF1DOylcWEODUoUkBHxBULT79RIf7sUrm5zd6zWW4TIAGyXlQ4XWXOU839vntsMO0
        0timGq2kqW+R0FfY3lSnLUkUKkV7lZwGfFcU99DSns6pevqSpqddCmLn5RNIOFoDh6W5F+Y9R4cQn
        cRgL8ktQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQL5C-004CXG-B5; Fri, 10 Feb 2023 04:32:22 +0000
Message-ID: <655f44cf-1d39-c2c1-1a93-d8eec39064b4@infradead.org>
Date:   Thu, 9 Feb 2023 20:32:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] mm/damon/dbgfs: print DAMON debugfs interface
 deprecation message
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230210042428.55864-1-sj@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230210042428.55864-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/9/23 20:24, SeongJae Park wrote:
> Hi Randy,
> 
> On Thu, 9 Feb 2023 19:26:43 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Hi,
>>
>> On 2/9/23 11:20, SeongJae Park wrote:
>>> DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
>>> kernel is released.  And, v6.1.y has announced to be an LTS[1].
>>>
>>> Though the announcement was there for a while, some people might not
>>> noticed that so far.  Also, some users could depend on it and have
>>> problems at  movng to the alternative (DAMON sysfs interface).
>>>
>>> For such cases, warn DAMON debugfs interface deprecation with contacts
>>> to ask helps when any DAMON debugfs interface file is opened.
>>>
>>> [1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c
>>>
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>> ---
>>>  mm/damon/dbgfs.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
>>> index b3f454a5c682..e551a20b35e3 100644
>>> --- a/mm/damon/dbgfs.c
>>> +++ b/mm/damon/dbgfs.c
>>> @@ -20,6 +20,11 @@ static int dbgfs_nr_ctxs;
>>>  static struct dentry **dbgfs_dirs;
>>>  static DEFINE_MUTEX(damon_dbgfs_lock);
>>>  
>>> +static void damon_dbgfs_warn_deprecation(void)
>>> +{
>>> +	pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).  If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
>>> +}
>>
>> Line length of 234 is a bit over the limit.
>> I think it would be OK to split it at the end of the first sentence, like:
>>
>> 	pr_warn_once("DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).\n");
>> 	pr_warn_once("If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
>>
>> or would that [2 pr_warn_once() calls] not work for some reason?
>>
>> Or even:
>>
>> 	pr_warn_once(
>> "DAMON debugfs interface is deprecated, so users should move to the sysfs interface (DAMON_SYSFS).\n");
>> 	pr_warn_once(
>> "If you depend on this and cannot move, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.\n");
>>
>> although some people might gag at that one.
> 
> Thank you for your opinion.
> 
> I considered that, but I was worrying if some other messages come between those
> two separated messages.

I see.

> 
> What do you think about breaking the string like below?  I first tried to do so
> like memcg hierarchy[1], but ended up to this version because of checkpatch.pl
> outputs[2].  However, if others doesn't care, I think this is ok.

It's OK to ignore checkpatch sometimes. :)

> 
> 	pr_warn_once("DAMON debugfs interface is deprecated, "
> 		     "so users should move DAMON_SYSFS. If you depend on this "
> 		     "and cannot move, please report your usecase to "
> 		     "damon@lists.linux.dev and linux-mm@kvack.org.\n");
> 
> If breaking user-visible string is not ok, maybe we could make it as short as
> your above example.
> 
>  	pr_warn_once("DAMON_DBGFS is deprecated; please contact to damon@lists.linux.dev and linux-mm@kvack.org if you depend on it.\n");
> 
> May I ask your opinion?

I'm OK with either one of these, but I prefer your first example over the second one.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memcontrol.c?h=v6.1#n3643
> [2] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings

Thanks.
-- 
~Randy
