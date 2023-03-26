Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7EB6C946E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjCZNOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCZNOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BA27ECC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679836401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDmH+gmU6zt3mD2nO7zm/sbyoPAN9cTAbp6KyhpDGG0=;
        b=JMS2p45b2rigsSGrN2MzgTVmk4n8RulvVJdPJv1g3Vx4Nf1bDlo5DbMozkLot2fZwEe4O0
        Gcf5R2k1KFNOMMg/iS64EdbnRsgltXwWwsfqY9vlutFGuw7UGO+UAgvufR8xDirjrZlw1Y
        asFV75bkIN057jG6Hou24xquesAffpE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-wwDyYrSqNZWE4ZDkCUCnVg-1; Sun, 26 Mar 2023 09:13:19 -0400
X-MC-Unique: wwDyYrSqNZWE4ZDkCUCnVg-1
Received: by mail-qt1-f199.google.com with SMTP id i24-20020ac84f58000000b003bfe3358691so4188241qtw.21
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679836399;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDmH+gmU6zt3mD2nO7zm/sbyoPAN9cTAbp6KyhpDGG0=;
        b=Mk/kUUkw3cvBYfeJbK9VC8p8JeN7kZjV5fm2djJmRmDDNRIjdEMjxaGbodHYNwHeGV
         KBiY960qOrSaZZa8euALkNZ8kh4UrnNAJXj5rDg6TjmcAb0LeqFNsqQz02+kPJS6cw5q
         0VOdq2OC5K5UoT5BpqRRhlYg6EEC5AebSQ/9uqMDtsOo8YUt+rgapYDf1/dgojFpXts0
         ajcoWWf5/SR9Nj4z/nUdYl8x+X0k8AJi9Axr9LgHDuCjFmmyGoqddedH/IYHG5DTkirX
         1YqAXITYsD1IAgBDFMXRWlocfdE9KSuS5SDB8T5kkzgj6dW7DhJCKLiSWue0FqnKbWJ4
         nISQ==
X-Gm-Message-State: AAQBX9fRxiV+LL42yT6q0LL+Ao8SXSyUVPPUMfwHEucZX1MWQNSv6ZnG
        beJf1czJuY5jS943mVUfVR28G6MiniA7mZzc04f9exh5j+mG+OSAXXs0XzwzncvjGokGoAvQ82m
        EqCq9OtocTG3wjm3rnzeOnu5A
X-Received: by 2002:a05:6214:5298:b0:574:8ef8:89d1 with SMTP id kj24-20020a056214529800b005748ef889d1mr14088084qvb.5.1679836399164;
        Sun, 26 Mar 2023 06:13:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350YGMIRnpMhkJ0DNPjZQOKnhKTlK+sAN401/0FukvSY0TT97gcoNhnlOu64nMTLVx/tksR/V/A==
X-Received: by 2002:a05:6214:5298:b0:574:8ef8:89d1 with SMTP id kj24-20020a056214529800b005748ef889d1mr14088053qvb.5.1679836398910;
        Sun, 26 Mar 2023 06:13:18 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m2-20020a0cee42000000b005dd8b93459dsm2181105qvs.53.2023.03.26.06.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 06:13:18 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: remove unused pHalData variable
To:     Greg KH <gregkh@linuxfoundation.org>, Nam Cao <namcaov@gmail.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        artur.bujdoso@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230326122321.1352337-1-trix@redhat.com>
 <ZCA+vIjUFHZFUFPC@nam-dell> <ZCBArurFCc7Pae+T@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8a2746a0-57e0-621b-7db9-2719554d050b@redhat.com>
Date:   Sun, 26 Mar 2023 06:13:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZCBArurFCc7Pae+T@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/23 5:55 AM, Greg KH wrote:
> On Sun, Mar 26, 2023 at 02:46:52PM +0200, Nam Cao wrote:
>> On Sun, Mar 26, 2023 at 08:23:21AM -0400, Tom Rix wrote:
>>> clang with W=1 reports
>>> drivers/staging/rtl8723bs/hal/hal_btcoex.c:1182:23: error: variable
>>>    'pHalData' set but not used [-Werror,-Wunused-but-set-variable]
>>>          struct hal_com_data *pHalData;
>>>                               ^
>>> This variable is not used so remove it.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   drivers/staging/rtl8723bs/hal/hal_btcoex.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
>>> index e36f8c369a04..0cb2adcc1f78 100644
>>> --- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
>>> +++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
>>> @@ -1179,10 +1179,6 @@ bool hal_btcoex_IsBtDisabled(struct adapter *padapter)
>>>   
>>>   void hal_btcoex_SetChipType(struct adapter *padapter, u8 chipType)
>>>   {
>>> -	struct hal_com_data *pHalData;
>>> -
>>> -
>>> -	pHalData = GET_HAL_DATA(padapter);
>>>   }
>> If this function doesn't do anything, does it not make more sense to
>> just remove this function entirely?
> This function is already removed in linux-next, so it doesn't matter :)

My patch is against linux-next from tag next-20230324

Tom

>
> thanks,
>
> greg k-h
>

