Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E86E7349
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjDSG3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjDSG3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D5B774
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0870363B72
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F635C433EF;
        Wed, 19 Apr 2023 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681885716;
        bh=985/Kh3t1ZuC33aqHLJddpQN44KiQbFNY0oeobBOvOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UCuMd2kWq7lnS3b/8L76RDxr3quWOCJnAaMOBzRrnIBatf+HhJVzCNZWl2XLCDYw5
         Pa9Q0+XRBo0phjqWcZ9dTaZ5l4gmWxTrSSkOFaTgrZ59g6OPCQeJKkQ5KWyiM25O6n
         KOrKXTKWLpw4TcjhmFgHPsiclrrtXE2ALtGFOvlAps7cIY1SJT1AN8IEgMwwmi6zBm
         oKwCkbw20bzWNHEgUVbPZ+f3+fhgrwakSFYKkJkKfh3LKEEWz0p5tOXCSdJ2qC3aI+
         wkDtN5Lfe6/04b20GREdHiWCeiig/UeE1dXajukVS5NmBhkh4JA7RKOypw/MsbHz3m
         tk7SlmerkOqWw==
Message-ID: <91a05857-c916-cae5-d61d-bbec6f1ae052@kernel.org>
Date:   Wed, 19 Apr 2023 14:28:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] f2fs: allocate trace path buffer from names_cache
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Wu Bo <bo.wu@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <20230414104308.6591-1-bo.wu@vivo.com>
 <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
 <ZD7AJT7ZYPji8TWk@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZD7AJT7ZYPji8TWk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/19 0:07, Jaegeuk Kim wrote:
> On 04/18, Chao Yu wrote:
>> On 2023/4/14 18:43, Wu Bo wrote:
>>> It would be better to use the dedicated slab to store path.
>>>
>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>> ---
>>>    fs/f2fs/file.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 15dabeac4690..27137873958f 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -4361,7 +4361,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>>>    	struct inode *inode = file_inode(iocb->ki_filp);
>>>    	char *buf, *path;
>>> -	buf = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
>>> +	buf = __getname();
>>
>> How about:
>>
>> buf = f2fs_kmem_cache_alloc(names_cachep, GFP_KERNEL, NULL, F2FS_I_SB(inode));
> 
> This looks like a hack using names_cachep?

names_cachep was exported in fs.h.

 > Using f2fs_kmem_cache_alloc is able to inject malloc error.
 > But here is a trace event, is it ok to inject error in a trace path?

Yes, the fail path handling is very simple, so it's fine to leave it
as it is.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>>>    	if (!buf)
>>>    		return;
>>>    	path = dentry_path_raw(file_dentry(iocb->ki_filp), buf, PATH_MAX);
>>> @@ -4374,7 +4374,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
>>>    		trace_f2fs_dataread_start(inode, iocb->ki_pos, count,
>>>    				current->pid, path, current->comm);
>>>    free_buf:
>>> -	kfree(buf);
>>> +	__putname(buf);
>>
>> kmem_cache_free(names_cachep, buf);
>>
>> Thanks,
>>
>>>    }
>>>    static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
