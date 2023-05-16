Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5307042C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEPBSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEPBR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:17:59 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1A5E7658B;
        Mon, 15 May 2023 18:17:56 -0700 (PDT)
Received: from [172.30.38.103] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id CEA6218011E9CA;
        Tue, 16 May 2023 09:17:53 +0800 (CST)
Message-ID: <0325060c-0a0a-0754-2d3e-1cadea9b6660@nfschina.com>
Date:   Tue, 16 May 2023 09:17:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] coda: return -EFAULT if copy fails
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <574ad370-cb3a-76db-ca8f-4203d42cc0fc@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/5/16 01:15, Christophe JAILLET wrote:
> Le 15/05/2023 à 08:19, Su Hui a écrit :
>> The copy_to/from_user() functions should return -EFAULT instead of 
>> -EINVAL.
>
> Hi,
>
> just for my understanding, why?
>
> Even if not perfect:
>    git grep -A1 copy_from_user | grep EINV | wc -l
>    15
>
>    git grep -A1 copy_to_user | grep EINV | wc -l
>    12
>
Hi,

maybe return -EFAULT is more better than -EINVAL.

     git grep -A1 "copy_from_user" | grep EFAULT | wc -l

      1985

     git grep -A1 "copy_to_user" | grep EFAULT | wc -l

     1871

Su Hui

> CJ
>
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/coda/upcall.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
>> index cd6a3721f6f6..1517dc3bd592 100644
>> --- a/fs/coda/upcall.c
>> +++ b/fs/coda/upcall.c
>> @@ -510,7 +510,7 @@ int venus_pioctl(struct super_block *sb, struct 
>> CodaFid *fid,
>>           /* get the data out of user space */
>>       if (copy_from_user((char *)inp + (long)inp->coda_ioctl.data,
>>                  data->vi.in, data->vi.in_size)) {
>> -        error = -EINVAL;
>> +        error = -EFAULT;
>>               goto exit;
>>       }
>
>
