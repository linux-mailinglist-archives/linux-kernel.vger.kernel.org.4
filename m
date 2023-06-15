Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB773165B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbjFOLUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjFOLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF62686
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686827971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xym/1KPuJqoFWHnNyHhIyr51SyseepnNY2jGfeKFh0s=;
        b=FU2Xo5n7WGQyX/ChUBN46xO7LUdMVCd9x4aqefQ7gIvnGgEygllBlr/iYI7D+/8oiqDB1/
        sXKhduv+eAzErh4sGra89c+PZ1LA/vvUqbiZlyuLzytb5iPAo+EHX7Lk0WBDCnUztJk53h
        Y1TV0XpQl6sKVmpLL30in+SCACdbWJE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-q1IuMZRLMh6B0SsowNGZNQ-1; Thu, 15 Jun 2023 07:19:24 -0400
X-MC-Unique: q1IuMZRLMh6B0SsowNGZNQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f63eed2413so5951407e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686827962; x=1689419962;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xym/1KPuJqoFWHnNyHhIyr51SyseepnNY2jGfeKFh0s=;
        b=g7KP0VKiDvr7ezSQ8YshBgEtgBSz4d2pUBtOHYDRo11SPWt7MLAK061slFNbujuaoY
         spcLQy6E05L50It1AHEfewEsIQMH9OP6yLNMHfhIHRQtSK91xwmSf7FirHxmLhago2qq
         TRqAgpqiS75MEDCgWkN9DBBBrWndxwARx1lAVWO1Kon70h57u1zs0fCOcDcf3MqgQ2k7
         d0aVJVz/qj/I+c7Mmg40fJkHVUsuGW2BbYN1lT4G3A8wkjb55p7n1w8RPKiwS1jq02SZ
         PRtuTxXX3wmKZTMLkDQC0tqDkxJGBNk8h9tMQQYlmf4jPTVsReKOS9KRJCL4N3diboXf
         VoKw==
X-Gm-Message-State: AC+VfDzI5iD9fG5TXS/EXW4qDGuffUoqDBFgBW6Sis+gCTMjv5oED9jt
        GTVrVk0Ncn9v81jFBTbD1vHG1NtohmpfvmiGk+VRryTuyZ+yUJte1DD6ZIVIp/y1xsy5Ig3ZXnv
        ZKHXRq9DMr9durOCOKduDPNXJ
X-Received: by 2002:a19:f20c:0:b0:4f6:1b45:e8aa with SMTP id q12-20020a19f20c000000b004f61b45e8aamr9235070lfh.50.1686827962645;
        Thu, 15 Jun 2023 04:19:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qWeX/amvQzhTPUWXOdoa3rXAdgKaQPfYsUdAyPa9DKINYSgNmcshdNBbidleI45XccnCzZA==
X-Received: by 2002:a19:f20c:0:b0:4f6:1b45:e8aa with SMTP id q12-20020a19f20c000000b004f61b45e8aamr9235059lfh.50.1686827962250;
        Thu, 15 Jun 2023 04:19:22 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f819faff25sm12911187wml.13.2023.06.15.04.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 04:19:21 -0700 (PDT)
Message-ID: <3f54542e-235b-8456-f13f-786d21c6c14f@redhat.com>
Date:   Thu, 15 Jun 2023 13:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
Content-Language: en-US
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com>
 <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.23 13:15, 贺中坤 wrote:
> On Thu, Jun 15, 2023 at 5:27 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> Interesting. When looking at possible ways to achieve that in a clean
>> way, my understanding was that the page might not always be accounted to
>> a memcg (e.g., simply some buffer?). Besides the swap->zram case I was
>> thinking about other fs->zram case, or just a straight read/write to the
>> zram device.
>>
>> The easiest way to see where that goes wrong I think is
>> zram_bvec_write_partial(), where we simply allocate a temporary page.
>>
>> Either I am missing something important, or this only works in some
>> special cases.
>>
>> I came to the conclusion that the only reasonable way is to assign a
>> complete zram device to a single cgroup and have all memory accounted to
>> that cgroup. Does also not solve all use cases (especially the
>> swap->zram case that might be better offjust using zswap?) but at least
>> the memory gets accounted in a more predictable way.
>>
>> Happy to learn more.
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Hi david, thanks for your reply. This should be my mistake, I didn't
> describe the
> problem clearly.
> 
> The reason for the problem is not the temporary page allocated at the beginning
> of zram_bvec_write_partial() and released at the end,but the compressed memory
> allocated by zs_malloc() in zram_write_page().
> 
> So, it may not meet the need to  assign a complete zram device to a
> single cgroup.
> we need to charge the compressed memory to the original page's memory cgroup,
> which is not charged so far.
> 

Yes, but my point is that there are cases where the pages you get are 
not charged. zram_bvec_write_partial() is just one such example that 
highlights the issue.

-- 
Cheers,

David / dhildenb

