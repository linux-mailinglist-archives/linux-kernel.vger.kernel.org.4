Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110B071A226
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjFAPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjFAPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:15:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B1D1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:15:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so385955ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685632521; x=1688224521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+F3XMekuXHuWIgCSsQ++NIeXO+URcOh8EvMjy2nv14=;
        b=doSleAE9iQ/fpG1saj/46RDsYLT1lJm+nUEQsc0hOBi+JduFCGX96cOElqbWWtLJF4
         otk+cVw4cPewhN61uTgHXhQ1aIa4zlsFklZ41SKrLAeCn2hYw4OkhYIZxFjYyPN3BmZL
         awbRRWPTT2o0041A9dZq2lnUA6vVwNL/muHUvut5+YwI+K7PbOeVAqUGmL/+IhXzhNmT
         ZLHEpBB2gMuTXIG542iAz5cyOSEebnKuIhZ4OntHaLZdaeNUhbVUQniG7iHVdRN1q3/f
         bmXELU8QSBhq8dtaUJCuMVD0UCxVP4rDRSwBOmtJLuKLwLWNshaLztUOWIW1m3CB92eP
         h8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632521; x=1688224521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+F3XMekuXHuWIgCSsQ++NIeXO+URcOh8EvMjy2nv14=;
        b=fr65LpS/RebXwiiK/jeP8CVbdH+xBrsmsaqU4/1E0fcibFxDUgDhcXF5G5Yoqt3W6r
         Eppb4YbTMSpJ8HX1WxGD6ByBBDHHyArFx4Qbewjq+/cnQ7oFvKhAb5xTL70HHVHQNQta
         uicjDJRlHk205Z8X9NiL3Upsbwh+nOpyyOa05+YRRU/FoI5rgnhvf2x9ZyD8tZ0vkwR3
         3bDz7Wn5zh3OzjzFnFHae95thq4+gCC/Vpo7lIP17qqMscCt1uKYcxE8B32CO6sZw0Rw
         ieNalRjd/zkwn0xh70hImGbQTCwhi1PqyaoBexFeHDLnrepLg4gGlo+Jj9D+Q6qIiEYW
         9jzQ==
X-Gm-Message-State: AC+VfDwbjOdJ8uJA1fFeMVF7HXLREDoUkhxz99s5jveCaVIMpx15WBn2
        syfIlFbSoAIghswhtY4C+jd6Eg==
X-Google-Smtp-Source: ACHHUZ4aDwWmm0SZGc5Yo3Cxv+brXsxD3GkC3hDRE0VQJCew9TUC5FzFyjCzBbRrX2pALjky/Pryvw==
X-Received: by 2002:a92:3652:0:b0:33b:1b5d:9723 with SMTP id d18-20020a923652000000b0033b1b5d9723mr3255265ilf.3.1685632520982;
        Thu, 01 Jun 2023 08:15:20 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h17-20020a92d091000000b0033079f435f7sm3862149ilh.65.2023.06.01.08.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:14:30 -0700 (PDT)
Message-ID: <416030d0-f8f1-23b0-875c-ad75880aca4f@kernel.dk>
Date:   Thu, 1 Jun 2023 09:14:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230601105006.199a32ee@canb.auug.org.au>
 <012599f4-61cf-47df-0fda-4294d8573b83@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <012599f4-61cf-47df-0fda-4294d8573b83@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 2:27 AM, Johannes Thumshirn wrote:
> On 01.06.23 02:50, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the block tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> In file included from include/linux/slab.h:15,
>>                  from drivers/md/raid1.c:26:
>> drivers/md/raid1.c: In function 'alloc_behind_master_bio':
>> include/linux/gfp.h:320:36: error: passing argument 1 of 'free_pages' makes integer from pointer without a cast [-Werror=int-conversion]
>>   320 | #define free_page(addr) free_pages((addr), 0)
>>       |                                    ^~~~~~
>>       |                                    |
>>       |                                    struct page *
>> drivers/md/raid1.c:1151:25: note: in expansion of macro 'free_page'
>>  1151 |                         free_page(page);
>>       |                         ^~~~~~~~~
>> include/linux/gfp.h:303:38: note: expected 'long unsigned int' but argument is of type 'struct page *'
>>   303 | extern void free_pages(unsigned long addr, unsigned int order);
>>       |                        ~~~~~~~~~~~~~~^~~~
>>
>> Caused by commit
>>
>>   6473bc325644 ("md: check for failure when adding pages in alloc_behind_master_bio")
>>
>> I have used the block tree from next-20230531 for today.
>>
> 
> This obviously has to be:
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index ff89839455ec..3570da63969b 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1148,7 +1148,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
>                         goto free_pages;
>  
>                 if (!bio_add_page(behind_bio, page, len, 0)) {
> -                       free_page(page);
> +                       put_page(page);
>                         goto free_pages;
>                 }
>  
> 
> But I wonder why I dint see it in my allmodconfig build. 
> 
> Jens can you fold that in or do you want me to update the patch?

Done

-- 
Jens Axboe


