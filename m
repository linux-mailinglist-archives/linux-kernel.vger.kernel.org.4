Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2C74C449
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGINM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGINMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:12:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829E4E8;
        Sun,  9 Jul 2023 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2cDoatD0/AjqY1m3sYNVOY3cUbqseUN0a46qVrSc9Tg=; b=g7SOFTcjMxs1/Kkx1PUV5n7aBT
        tUroOjmF429bxZW+AcJuV3tqAkUlkHkj7dYxk3Gq6+kyaefF/ieGr1uhTd59NUtB/LU+FmfXEO6Sf
        1OKGAXce3JNnydexdNfapg6XYMP+/RFtKuQSpYAGIJ4BIFCO8REgM+AhyBFeTEC4UROBkgbZDBeHg
        L/kQ2wJuSA4NA4kgf4E0imF7gHih4TLoD1zY7CeSnnto674fmsNzKt7gZVygoXsmV5Ht3pIJ1e6fb
        03/wUDU5iYAWbiy7bClZMxl4KU+jYWQ+IMV5B9DB9m6cKq+gJ5kVMpb7Q13fBy6EHh3GoJCVozVNZ
        ukR5/uww==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIUD8-0098z0-2I;
        Sun, 09 Jul 2023 13:12:22 +0000
Message-ID: <5037d22d-cc63-d8af-70a9-3c793f07fce2@infradead.org>
Date:   Sun, 9 Jul 2023 06:12:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Build regressions/improvements in v6.4 (wireless/airo)
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
 <20230626081950.2090627-1-geert@linux-m68k.org>
 <39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org>
 <2f6ffd1c-a756-b7b8-bba4-77c2308f26b9@infradead.org>
 <CAMuHMdU30BzfzQ=xEDFCd2bXG=VD68sQz-60Ok8GethLsnEH8A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdU30BzfzQ=xEDFCd2bXG=VD68sQz-60Ok8GethLsnEH8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/23 01:27, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Sun, Jul 9, 2023 at 4:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 6/26/23 01:24, Geert Uytterhoeven wrote:
>>> On Mon, 26 Jun 2023, Geert Uytterhoeven wrote:
>>>> JFYI, when comparing v6.4[1] to v6.4-rc7[3], the summaries are:
>>>>  - build errors: +1/-0
>>>
>>>   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45
>>
>> I cannot reproduce this build error. (I don't doubt the problem, just having a problem
>> making it happen for me.)
>> I have tried it with gcc-11.1.0, gcc-11.3.0, and gcc-13.1.0.
> 
> Which is similar to kisskb, using sh4-linux-gcc (GCC) 11.3.0...
> 
>> I'm surprised that this is the only instance that gcc found/warned about.
> 
> Indeed.
> 
>>
>> I have a patch for this one instance, but there are 40+ instances of
>>         readStatusRid()
>>         readConfigRid()
>>         readSsidRid()
>>         readStatsRid()
>>         readCapabilityRid()
>> that don't check the return status of the function calls.
>>
>> I suppose that a patch can quieten the compiler error/warning, but given
>> the 40+ other problems, it won't make the driver any noticeably better IMO.
> 
> Indeed...
> 
>>> sh4-gcc11/sh-allmodconfig
>>> seen before
>>>
>>> This is actually a real issue, and it's been here since basically forever.
>>>
>>> drivers/net/wireless/cisco/airo.c:
>>>
>>>     static int airo_get_rate(struct net_device *dev,
>>>                              struct iw_request_info *info,
>>>                              union iwreq_data *wrqu,
>>>                              char *extra)
>>>     {
>>>             struct iw_param *vwrq = &wrqu->bitrate;
>>>             struct airo_info *local = dev->ml_priv;
>>>             StatusRid status_rid;           /* Card status info */
>>>
>>>             readStatusRid(local, &status_rid, 1);
>>>
>>> ==>         vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
>>>             ...
>>>     }
>>>
>>>     static int readStatusRid(struct airo_info *ai, StatusRid *statr, int lock)
>>>     {
>>>             return PC4500_readrid(ai, RID_STATUS, statr, sizeof(*statr), lock);
>>>     }
>>>
>>>     static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len, int lock)
>>>     {
>>>             u16 status;
>>>             int rc = SUCCESS;
>>>
>>>             if (lock) {
>>>                     if (down_interruptible(&ai->sem))
>>>                             return ERROR;
>>>
>>> pBuf output buffer contents not initialized.
>>>
>>>             }
>>>             ...
>>>     }
>>>
>>>
>>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (all 160 configs)
>>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/45a3e24f65e90a047bef86f927ebdc4c710edaa1/ (all 160 configs)
>>
>> I appreciate the synopsis.  Here's a patch.  WDYT?
>> ---
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Subject: [PATCH] wifi: airo: avoid uninitialized warning in airo_get_rate()
>>
>> Quieten a gcc (11.3.0) build error or warning by checking the function
>> call status and returning -EIO if the function call failed.
>> This is similar to what several other wireless drivers do for the
>> SIOCGIWRATE ioctl call.
>>
>> drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Link: lore.kernel.org/r/39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: linux-wireless@vger.kernel.org
>> ---
>>  drivers/net/wireless/cisco/airo.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff -- a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
>> --- a/drivers/net/wireless/cisco/airo.c
>> +++ b/drivers/net/wireless/cisco/airo.c
>> @@ -6157,8 +6157,11 @@ static int airo_get_rate(struct net_devi
>>         struct iw_param *vwrq = &wrqu->bitrate;
>>         struct airo_info *local = dev->ml_priv;
>>         StatusRid status_rid;           /* Card status info */
>> +       int ret;
>>
>> -       readStatusRid(local, &status_rid, 1);
>> +       ret = readStatusRid(local, &status_rid, 1);
>> +       if (ret)
>> +               return -EIO;
> 
> That's about the best we can do without further surgery.
> E.g. PC4500_readrid() should return a proper error code instead of
> just ERROR/SUCCESS.
> The case gcc complains about is when lock = 1 and the call to
> down_interruptible() fails, for which -EBUSY would be appropriate.

Yes, I saw that return value as one of the options.
I'll change it to that and submit it.

Thanks.
-- 
~Randy
