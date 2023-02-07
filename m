Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6168D927
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjBGNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjBGNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:18:04 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE0D28D0A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:17:41 -0800 (PST)
Received: from [10.10.2.69] (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2417C40737C3;
        Tue,  7 Feb 2023 13:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2417C40737C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675775857;
        bh=E25TN3G2sWZw4MBjPGzfVUQymKl8HogwZguZZLbYBic=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ttvjc8CTUqftLc7JctguIydWkWSbCn+UKql/6qd3wvmh9rOSEG2DY6T52PqqXA8LO
         i57kT3VGlh3lakFZtNLgXesY1CZMnuKMEk7sRZrYSgzpAm4IcorAa+OkW6eQHqlxM6
         dZsEJs9TjQNmXl5UtwIu4sTBlx5RmjNAPuWlOi+M=
Message-ID: <14370523-6167-2bbf-d080-822899c781ea@ispras.ru>
Date:   Tue, 7 Feb 2023 16:17:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] udf: KASAN: slab-out-of-bounds in udf_readdir
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20230206162206.845488-1-VEfanov@ispras.ru>
 <20230207124447.jneehkows3ksulgq@quack3>
Content-Language: ru
From:   =?UTF-8?B?0JXRhNCw0L3QvtCyINCS0LvQsNC00LjRgdC70LDQsiDQkNC70LXQutGB0LA=?=
         =?UTF-8?B?0L3QtNGA0L7QstC40Yc=?= <vefanov@ispras.ru>
In-Reply-To: <20230207124447.jneehkows3ksulgq@quack3>
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

Thank you for the information. Will check this repository in the future.

Vlad.

On 07.02.2023 15:44, Jan Kara wrote:
> On Mon 06-02-23 19:22:06, Vladislav Efanov wrote:
>> The KASAN report is:
>> [ 1922.586560] BUG: KASAN: slab-out-of-bounds in udf_readdir+0xe00/0x19e0
>> [ 1922.586922] Write of size 89 at addr ffff888000cd9ea6 by task rm/18493
>>
>> udf_readdir() tries to write file name out of allocated memory
>> buffer bounds. The UDF_NAME_LEN_CS0 (255) is used as max length
>> for file name in udf_put_filename(). But UDF_NAME_LEN (254) is
>> used as the size for buffer allocation in udf_readdir(). As the
>> result out-of-bounds write happened.
>>
>> Found by Linux Verification Center (linuxtesting.org) with xfstests
>>
>> Fixes: 066b9cded00b ("udf: Use separate buffer for copying split names")
>> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> Thanks for the fix Vladislav! But this code is not there anymore in current
> version of UDF code. It got fixed as part of the directory code rewrite -
> you can check current code state in my tree:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
>
> 								Honza
>
>> ---
>>   fs/udf/dir.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
>> index be640f4b2f2c..b95607c42ad4 100644
>> --- a/fs/udf/dir.c
>> +++ b/fs/udf/dir.c
>> @@ -169,7 +169,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
>>   				nameptr = (char *)(fibh.ebh->b_data + poffset - lfi);
>>   			} else {
>>   				if (!copy_name) {
>> -					copy_name = kmalloc(UDF_NAME_LEN,
>> +					copy_name = kmalloc(UDF_NAME_LEN_CS0,
>>   							    GFP_NOFS);
>>   					if (!copy_name) {
>>   						ret = -ENOMEM;
>> -- 
>> 2.34.1
>>
