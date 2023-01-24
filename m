Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C1679F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjAXQmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjAXQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:42:38 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0B54B1A3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:42:13 -0800 (PST)
Received: from [10.10.2.69] (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0A77B40737B8;
        Tue, 24 Jan 2023 16:42:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0A77B40737B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1674578528;
        bh=S2g/QYq6udnNCFzlEZWHXd3+KZCP6XQxIcbh0Wc7w+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e6lbjsZbaUtoH65tyYuplBAHTGk6K1vt6Gb/we8gnD+LCcWHpz5kvIfyuL6ZXzrEk
         fCSgsQCejh0lleQOzSf6r36T0W153hk+M3046gPb1PQa5v05rs62TWPbjVd7Xm9xMH
         XisPScl2P1/0fxDu8baYe8BzkjVbBuiRtDoLgz08=
Message-ID: <1bd4feeb-ce77-ff6f-17ca-9ef3621e877a@ispras.ru>
Date:   Tue, 24 Jan 2023 19:42:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] udf: Check return code from udf_update_extents
Content-Language: ru
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230120091028.1591622-1-VEfanov@ispras.ru>
 <20230124084702.xew5wmbvmj6gz4j6@quack3>
From:   =?UTF-8?B?0JXRhNCw0L3QvtCyINCS0LvQsNC00LjRgdC70LDQsiDQkNC70LXQutGB0LA=?=
         =?UTF-8?B?0L3QtNGA0L7QstC40Yc=?= <vefanov@ispras.ru>
In-Reply-To: <20230124084702.xew5wmbvmj6gz4j6@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for information.


Vlad.

On 24.01.2023 11:47, Jan Kara wrote:
> On Fri 20-01-23 12:10:28, Vladislav Efanov wrote:
>> udf_add_aext() does not create new extent and returns ENOSPC if new
>> block was not created by udf_bitmap_new_block(). The caller,
>> udf_insert_aext(), does not check this return code and returns OK to
>> its caller(udf_update_extents). Finally the error is being lost. So
>> an inconsistency in inode.i_size and extents length becomes.
>>
>> Later this inconsistency leads to WARNING:
>>
>> WARNING: CPU: 3 PID: 1104 at fs/udf/truncate.c:226
>>          udf_truncate_extents+0x7e0/0x8e0 fs/udf/truncate.c:226
>>
>> RIP: 0010:udf_truncate_extents+0x7e0/0x8e0 fs/udf/truncate.c:226
>> Call Trace:
>>   udf_write_failed.isra.0+0x173/0x1c0 fs/udf/inode.c:179
>>   udf_write_begin+0x8d/0xb0 fs/udf/inode.c:214
>>   generic_perform_write+0x20a/0x4e0 mm/filemap.c:3333
>>   __generic_file_write_iter+0x252/0x610 mm/filemap.c:3462
>>   udf_file_write_iter+0x2cc/0x4e0 fs/udf/file.c:168
>>   call_write_iter include/linux/fs.h:1904 [inline]
>>   new_sync_write+0x42c/0x660 fs/read_write.c:518
>>   vfs_write+0x75b/0xa40 fs/read_write.c:605
>>
>> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> 
> Thanks for the fix but I have a very similar fix already queued in my tree
> in linux-next: 19fd80de0a8 ("udf: Handle error when adding extent to a
> file").
> 
> 								Honza
