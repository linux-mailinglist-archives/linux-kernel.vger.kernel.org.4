Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84436C11EC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCTMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCTMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A23586
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679315401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfqpIgX4fLbKXurM7Kf6KLvRPea8XVgc4JZHuTZ7PDI=;
        b=IjZjM1rNhK1hO09WlozQhM77o2l6FU/iKrPS26vqZR1J45b00bpoiBB1ZjAZ33ruwhtp18
        JG3OYHw/uPrTri0sQBdw43CLnl3NW8bu3BH/Z90d0IBXmfOai4DIPIITM4ZbeT0qzqcCr6
        hcwcwXv/nSwOCDordS7ywm3OFUrVPC0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-TMQGZwPCNlqO170_gpieNQ-1; Mon, 20 Mar 2023 08:29:55 -0400
X-MC-Unique: TMQGZwPCNlqO170_gpieNQ-1
Received: by mail-qv1-f70.google.com with SMTP id c15-20020a056214070f00b005bb308e7c12so4816425qvz.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679315394;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfqpIgX4fLbKXurM7Kf6KLvRPea8XVgc4JZHuTZ7PDI=;
        b=U3fbMAZneW0g/lAfTXk0Wkln8s9T2hdgdD7VMxqkc5LsJBsPHgBFB2CfavmdXlhRgw
         g+4ZN9U2Cwk6HPAYYgW8frCX2x09V2w2xP+fqiDfk+UzhAoI2PGRj5hC0JPOG0sb0s8R
         8NysM0UEq4IKp4P/GOT8FhmG6/ZdOTmkT6lQacJBJxfpNoXw4cS0KqDKQiYfrITbltlN
         GenDUcNajMxStfSBOeDOzueagvhZOjr6UqcpRV9Uo7hJhbjGIjzGK0z2F6tfAyq62gMO
         ywkqK2MOa4ONqWpk7ZO7yU5i3kTZW1CpuaAb5hvgNmaXAb7E68xvmhQfUT79LCeINJCd
         eDww==
X-Gm-Message-State: AO0yUKXyIndI0Fuo2k0Eu4gSLHGhwNwfFpsQVMHs4ep/RqVaMdnSCYmR
        47TBvGNkqsZ6Szah6dLdAdNuPMKbVla/MCL3IocvgkM+O50jjhgqvDnrn5lxUjor/CRokKfUYMA
        W3M2/QZ+AEr82kQePS8SfS0d3rVxpXAWM
X-Received: by 2002:ac8:578e:0:b0:3bf:d0b1:433d with SMTP id v14-20020ac8578e000000b003bfd0b1433dmr27832936qta.60.1679315394714;
        Mon, 20 Mar 2023 05:29:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Xkg5GXCW1nwGbZIqz+rPOxATrxz/ugD6phHqlEFjOnuUqwxEdyf/hjO4XymAepfNWlKckOA==
X-Received: by 2002:ac8:578e:0:b0:3bf:d0b1:433d with SMTP id v14-20020ac8578e000000b003bfd0b1433dmr27832914qta.60.1679315394487;
        Mon, 20 Mar 2023 05:29:54 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r19-20020ac85213000000b003b643951117sm6511664qtn.38.2023.03.20.05.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:29:54 -0700 (PDT)
Subject: Re: [PATCH] net: cxgb3: remove unused fl_to_qset function
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230319172433.1708161-1-trix@redhat.com>
 <20230319174525.kwhlxme7gh45b3un@soft-dev3-1>
From:   Tom Rix <trix@redhat.com>
Message-ID: <21aad6c8-8abe-79e0-eb47-d03e964419a2@redhat.com>
Date:   Mon, 20 Mar 2023 05:29:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230319174525.kwhlxme7gh45b3un@soft-dev3-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/23 10:45 AM, Horatiu Vultur wrote:
> The 03/19/2023 13:24, Tom Rix wrote:
>
> Hi Tom,
>
>> clang with W=1 reports
>> drivers/net/ethernet/chelsio/cxgb3/sge.c:169:32: error: unused function
>>    'fl_to_qset' [-Werror,-Wunused-function]
>> static inline struct sge_qset *fl_to_qset(const struct sge_fl *q, int qidx)
>>                                 ^
>> This function is not used, so remove it.
> Don't forget to mention in the subject which tree is targeting this
> patch.

This and all my similar fixes/cleanup are against -next.

What prefix would you like to see ?

Tom

> Other than that looks OK.
>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/net/ethernet/chelsio/cxgb3/sge.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
>> index 62dfbdd33365..efa7f401529e 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
>> @@ -166,11 +166,6 @@ static u8 flit_desc_map[] = {
>>   #endif
>>   };
>>
>> -static inline struct sge_qset *fl_to_qset(const struct sge_fl *q, int qidx)
>> -{
>> -       return container_of(q, struct sge_qset, fl[qidx]);
>> -}
>> -
>>   static inline struct sge_qset *rspq_to_qset(const struct sge_rspq *q)
>>   {
>>          return container_of(q, struct sge_qset, rspq);
>> --
>> 2.27.0
>>

