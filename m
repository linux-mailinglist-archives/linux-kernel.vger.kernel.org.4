Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B54718FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjFABXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFABXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:23:11 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A9101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:23:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjzF489_1685582586;
Received: from 30.221.128.174(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VjzF489_1685582586)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 09:23:07 +0800
Message-ID: <4e3eafe6-7f5d-6458-9d0f-f80ad93704dd@linux.alibaba.com>
Date:   Thu, 1 Jun 2023 09:23:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: check new file size on fallocate
 call
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     =?UTF-8?Q?Lu=c3=ads_Henriques_via_Ocfs2-devel?= 
        <ocfs2-devel@oss.oracle.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Heming Zhao <heming.zhao@suse.com>,
        linux-kernel@vger.kernel.org
References: <20230529152645.32680-1-lhenriques@suse.de>
 <20230531151147.3d98aa2fb1d7f659bccef37b@linux-foundation.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230531151147.3d98aa2fb1d7f659bccef37b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/23 6:11 AM, Andrew Morton wrote:
> On Mon, 29 May 2023 16:26:45 +0100 Luís Henriques via Ocfs2-devel <ocfs2-devel@oss.oracle.com> wrote:
> 
>> When changing a file size with fallocate() the new size isn't being
>> checked.  In particular, the FSIZE ulimit isn't being checked, which makes
>> fstest generic/228 fail.  Simply adding a call to inode_newsize_ok() fixes
>> this issue.
>>
>> ...
>>
>> --- a/fs/ocfs2/file.c
>> +++ b/fs/ocfs2/file.c
>> @@ -2100,14 +2100,20 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
>>  	struct ocfs2_space_resv sr;
>>  	int change_size = 1;
>>  	int cmd = OCFS2_IOC_RESVSP64;
>> +	int ret = 0;
>>  
>>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>>  		return -EOPNOTSUPP;
>>  	if (!ocfs2_writes_unwritten_extents(osb))
>>  		return -EOPNOTSUPP;
>>  
>> -	if (mode & FALLOC_FL_KEEP_SIZE)
>> +	if (mode & FALLOC_FL_KEEP_SIZE) {
>>  		change_size = 0;
>> +	} else {
>> +		ret = inode_newsize_ok(inode, offset + len);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
> 
> So userspace can exceed rlimit(RLIMIT_FSIZE).
> 
> Do we think this flaw is serious enough to justify backporting the fix
> into earlier -stable kernels?

I think it's worth ccing stable kernel as well.

Thanks,
Joseph
