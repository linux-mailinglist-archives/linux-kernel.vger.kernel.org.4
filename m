Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81AF5B7E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiINBfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINBfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:35:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF251D0EC;
        Tue, 13 Sep 2022 18:35:10 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MS2pq1CblzlVkT;
        Wed, 14 Sep 2022 09:30:59 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 09:34:56 +0800
Message-ID: <7897d2c5-eb48-006f-5e7a-bf78e258dfc5@huawei.com>
Date:   Wed, 14 Sep 2022 09:34:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next 1/2] Kconfig: remove unused argment 'ch'
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, "weiyongjun (A)" <weiyongjun1@huawei.com>
References: <20220912094838.2398580-1-zengheng4@huawei.com>
 <20220912094838.2398580-2-zengheng4@huawei.com>
 <CAK7LNASrH740T45VvbOZyfxF3C8aqMesbMBkEyBsv78Sz4D1AQ@mail.gmail.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <CAK7LNASrH740T45VvbOZyfxF3C8aqMesbMBkEyBsv78Sz4D1AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I would replace sym_set_choice_value with sym_set_tristate_value at v2.


在 2022/9/14 0:35, Masahiro Yamada 写道:
> On Mon, Sep 12, 2022 at 6:41 PM Zeng Heng <zengheng4@huawei.com> wrote:
>> Remove unused argment 'ch' in sym_set_choice_value
>>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>
> Can you remove sym_set_choice_value() and
> call sym_set_tristate_value(chval, yes) directly?
>
>
>
>
>
>> ---
>>   scripts/kconfig/conf.c | 2 +-
>>   scripts/kconfig/lkc.h  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
>> index 4178065ca27f..635265a18a07 100644
>> --- a/scripts/kconfig/conf.c
>> +++ b/scripts/kconfig/conf.c
>> @@ -551,7 +551,7 @@ static int conf_choice(struct menu *menu)
>>                          print_help(child);
>>                          continue;
>>                  }
>> -               sym_set_choice_value(sym, child->sym);
>> +               sym_set_choice_value(child->sym);
>>                  for (child = child->list; child; child = child->next) {
>>                          indent += 2;
>>                          conf(child);
>> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
>> index fa8c010aa683..279d56a44136 100644
>> --- a/scripts/kconfig/lkc.h
>> +++ b/scripts/kconfig/lkc.h
>> @@ -124,7 +124,7 @@ static inline struct symbol *sym_get_choice_value(struct symbol *sym)
>>          return (struct symbol *)sym->curr.val;
>>   }
>>
>> -static inline bool sym_set_choice_value(struct symbol *ch, struct symbol *chval)
>> +static inline bool sym_set_choice_value(struct symbol *chval)
>>   {
>>          return sym_set_tristate_value(chval, yes);
>>   }
>> --
>> 2.25.1
>>
>
