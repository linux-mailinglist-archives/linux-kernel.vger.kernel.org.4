Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029EE6C6AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjCWOTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCWOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8A9EDA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679581096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmOQUOtAqacRyOXsSm85w+5nwuG+5y33vZI5QHs5gnc=;
        b=WfDroiEAY/MdQwjMu9VZ8OpLohbDiZZxOXxORJLvXbOm19sYS4HJUYEnNaJQj9i0Fu+oF9
        b7l6CyLwDf22MEN/q6p35VfjPwyb1pkSaScRq1GEmn3tlpSGCaFxmFiOqn7BuYUqqkq6cg
        M7FzDTkn0yius8XLExAMQCqQkI2Gv0A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-nGtjhohZPc6xNUlaqjK6WQ-1; Thu, 23 Mar 2023 10:18:14 -0400
X-MC-Unique: nGtjhohZPc6xNUlaqjK6WQ-1
Received: by mail-qv1-f72.google.com with SMTP id a15-20020a0562140c2f00b005ad28a23cffso10735987qvd.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581093;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmOQUOtAqacRyOXsSm85w+5nwuG+5y33vZI5QHs5gnc=;
        b=rqoD+B0BhZck8IvrTW1uK/13ci4MeBhNyH6xA4M1/fxfNc72x+0b8z/PHfwixz+5Xy
         u2wvm0jBOdGEW8bOqDp/8PpEczcQL4c6BM6xK+x5r14rxUR4BuVEvw95Qkb6ijt1Mu6G
         cHS/6hZvTgKiQPQBhcKtYB64scNpSnSfVHgw+ziPWdFCxLK6ohtdADIVxJPaBLXzzbNM
         hqwY24tzszY3d18RN9M0BzGuPujMv4DO+3LRifxyLyWdztpyOBPGY4CbsZQ+nrXH11TX
         PcXT2TGT0jjemclYxSoDINnvzcOnYhL+iHs6ZqR2bLnJ2bKL2F0nquhfnnpYpWQHIsjq
         1h3Q==
X-Gm-Message-State: AO0yUKXqQ0SHTmpxqRNBKSh9d1PXIuu5fBwCc7UtiOyfXop73hN9PbK2
        esRQDxN45ex1unXYT9SogKEiwRhNxusuFejZ9x4N82pyD/1OZfFgIO0en7HVbtzJoMoxyumg/6W
        sfDb7J7UxNpBlflJEZyYgeAN5
X-Received: by 2002:ac8:5845:0:b0:3bf:abd5:f1ef with SMTP id h5-20020ac85845000000b003bfabd5f1efmr11961141qth.7.1679581093096;
        Thu, 23 Mar 2023 07:18:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set8+oxS4bzeF5lRLgX7lO++tpFXfO+fw1zDuVOc/fpqog2+KS85aPH3xR/dKuzfXWCYb7jmdzA==
X-Received: by 2002:ac8:5845:0:b0:3bf:abd5:f1ef with SMTP id h5-20020ac85845000000b003bfabd5f1efmr11961109qth.7.1679581092868;
        Thu, 23 Mar 2023 07:18:12 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b00745c2b29091sm5993338qkp.93.2023.03.23.07.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:18:12 -0700 (PDT)
Subject: Re: [PATCH] ath10k: remove unused ath10k_get_ring_byte function
To:     Simon Horman <simon.horman@corigine.com>
Cc:     kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230322122855.2570417-1-trix@redhat.com>
 <ZBtnbgeW9T75ZXfv@corigine.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0b9f9c45-7e88-deda-46a6-8c7961878b83@redhat.com>
Date:   Thu, 23 Mar 2023 07:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZBtnbgeW9T75ZXfv@corigine.com>
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


On 3/22/23 1:40 PM, Simon Horman wrote:
> On Wed, Mar 22, 2023 at 08:28:55AM -0400, Tom Rix wrote:
>> clang with W=1 reports
>> drivers/net/wireless/ath/ath10k/ce.c:88:1: error:
>>    unused function 'ath10k_get_ring_byte' [-Werror,-Wunused-function]
>> ath10k_get_ring_byte(unsigned int offset,
>> ^
>> This function is not used so remove it.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Hi Tom,
>
> this looks good. But this patch applied, and with clang 11.0.2,
> make CC=clang W=1 tells me:
>
> drivers/net/wireless/ath/ath10k/ce.c:80:19: error: unused function 'shadow_dst_wr_ind_addr' [-Werror,-Wunused-function]
> static inline u32 shadow_dst_wr_ind_addr(struct ath10k *ar,
>                    ^
> drivers/net/wireless/ath/ath10k/ce.c:434:20: error: unused function 'ath10k_ce_error_intr_enable' [-Werror,-Wunused-function]
> static inline void ath10k_ce_error_intr_enable(struct ath10k *ar,
>                     ^
> Perhaps those functions should be removed too?

I believe these were removed with

c3ab8c9a296 ("wifi: ath10k: Remove the unused function 
shadow_dst_wr_ind_addr() and ath10k_ce_error_intr_enable()")

Tom

>
>> ---
>>   drivers/net/wireless/ath/ath10k/ce.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
>> index b656cfc03648..c27b8204718a 100644
>> --- a/drivers/net/wireless/ath/ath10k/ce.c
>> +++ b/drivers/net/wireless/ath/ath10k/ce.c
>> @@ -84,13 +84,6 @@ ath10k_set_ring_byte(unsigned int offset,
>>   	return ((offset << addr_map->lsb) & addr_map->mask);
>>   }
>>   
>> -static inline unsigned int
>> -ath10k_get_ring_byte(unsigned int offset,
>> -		     struct ath10k_hw_ce_regs_addr_map *addr_map)
>> -{
>> -	return ((offset & addr_map->mask) >> (addr_map->lsb));
>> -}
>> -
>>   static inline u32 ath10k_ce_read32(struct ath10k *ar, u32 offset)
>>   {
>>   	struct ath10k_ce *ce = ath10k_ce_priv(ar);
>> -- 
>> 2.27.0
>>

