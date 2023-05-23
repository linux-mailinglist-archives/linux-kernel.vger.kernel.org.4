Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7497270D6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjEWIIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjEWIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A143AE77
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684829166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/I/wqsAUZDwVaD1e7Awdsb6/q2Rvw3zvRXvMlz6NW0=;
        b=Y1wPTmEHdDuqJcR894gJGUz9g7ViCy5yrPih7RpbmcyKrAwh1oYJGefDY4HPT63IbUyf/m
        Wnk5dcTjmZz4LIUXJfwXGF5ZR9VE0JGZZ747chok3cH1H/R8GDry1PAMRfZeBaczH3aVdg
        JddTIBPlA/nViNwZ+XDSg1KP6Anisus=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-ZPjnPHSNODaJrOUkx0WvWw-1; Tue, 23 May 2023 03:59:56 -0400
X-MC-Unique: ZPjnPHSNODaJrOUkx0WvWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30a5d4e5731so1068946f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828795; x=1687420795;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/I/wqsAUZDwVaD1e7Awdsb6/q2Rvw3zvRXvMlz6NW0=;
        b=UHWyXsjQqfJFdc6pZv5u/gjGU02qUDegIj0iWnn0C9LP42QH75ddh40oS5IlJxrjVD
         b85wDejXMR7m0bLikgeFrCoTALDvGpx6EaFBsmlzUWU4xxw7e2JVar1j16f3//u0rk1/
         Eos93LQtaFjIE0DmGvwyerzTzLPW27MoqYQNzI/GqL643z6iBkU6rxHoBZEuQD8NA/yj
         hqfodXMUu6NtXbAQv80KTY5VJlgTQxBhtTH7DEydw2F52D9qBSfgd4RuIyKYJHR9bWHC
         N3fCZJ5mkAKsUmUjFaDy1GGq2zQxt+YSoP/yy8redaOy+PR3oK/F0xd5jZYzvil67VPU
         vHhg==
X-Gm-Message-State: AC+VfDw8ouhioXr6rrrZxpXvksX1sBEPMEbYkKaq3vtK6w2lb8ifI7wg
        TgalZGOU9vQvE7ibcsER3kOlPQBYni2YLkQXk5+8bZ1tAKxxhaqYUUU8waDMq26/igUtaRYw1zi
        gNxGEyKseQI31VZHc/UybYmjw
X-Received: by 2002:adf:e401:0:b0:309:4176:702 with SMTP id g1-20020adfe401000000b0030941760702mr9786032wrm.37.1684828795459;
        Tue, 23 May 2023 00:59:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63Bb25pawnjsloN5gp3/r6DIpPxmC+hDZy27hfHmyipn66Vb2ESk2diwsR0KgQ5gEy6CPgrA==
X-Received: by 2002:adf:e401:0:b0:309:4176:702 with SMTP id g1-20020adfe401000000b0030941760702mr9786013wrm.37.1684828795083;
        Tue, 23 May 2023 00:59:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d414a000000b00304ae802f02sm10148229wrq.66.2023.05.23.00.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:59:54 -0700 (PDT)
Message-ID: <e0bdc23d-b2f3-4c36-c658-b5d914555cb7@redhat.com>
Date:   Tue, 23 May 2023 09:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V2 4/5] swap: remove get/put_swap_device() in
 __swap_duplicate()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
References: <20230522070905.16773-1-ying.huang@intel.com>
 <20230522070905.16773-5-ying.huang@intel.com>
 <9cbd93e0-721a-01c2-14dd-87f89363a830@redhat.com>
 <87o7mbyifo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87o7mbyifo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.23 02:56, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 22.05.23 09:09, Huang Ying wrote:
>>> __swap_duplicate() is called by
>>> - swap_shmem_alloc(): the page lock of the swap cache is held.
>>
>> page lock of the swap cache? Did you really mean to say that or am I
>> confused?
>>
>> "Page lock of the page that is in the swap cache?"
> 
> Sorry for my poor English. Or make it shorter?
> 
> "the folio in the swap cache is locked"

Much clearer, thanks.

-- 
Thanks,

David / dhildenb

