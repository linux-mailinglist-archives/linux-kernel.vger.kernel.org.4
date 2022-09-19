Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2E5BCAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiISL3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiISL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3191EC70
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663586948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+/Mc8w+aIXPz5w8iN1lc+Tc4tSmEaC40xw3lps1GKM=;
        b=iBq4wHjuWNpSgT9RGAFqQ9l1Y3HivgyIDou4gc0KZXf3oIhCX0ks1dFS5Uo7PCCmY6CDim
        2wqiLhSPA1PbbTSxHjmCYcPBr+j459hyRe9YaVCimf6l7K7Z4m/kLsoQCn7mL3bWIeUKlf
        +9Zj0dLxoB6KdHj9c3XTt8T4MZLmiLE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-5JMhkMMUNS-1-9FkJrZT5Q-1; Mon, 19 Sep 2022 07:29:07 -0400
X-MC-Unique: 5JMhkMMUNS-1-9FkJrZT5Q-1
Received: by mail-wm1-f69.google.com with SMTP id n7-20020a1c2707000000b003a638356355so15046353wmn.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=s+/Mc8w+aIXPz5w8iN1lc+Tc4tSmEaC40xw3lps1GKM=;
        b=wlUIEwfPYvvSIu976ahqbLAhg5BAcVxzo4CcFa8xIC1o43ntSLEsb+EZmgejhPYPo2
         1ojMvcakmMUyOtlRd/Z2WQYgyGPDIrJL/NEuaYB6xYdre4pkniNMVQAdOkajdOXxYK0h
         HHHGSZxy6gYm8PviZsKoA92DzbttdFsvfQe2Zi8r3KisxZM2WL4kvChoh6wo1LyxBErV
         Pm+fzzGpOMiO3SsOoCl84M0mm9dKZ3q02JG5hlqNwxRvUNwpCOcPXGSYmBVrch3n9haE
         ZGG856JUkpCQxfJrBW082/ipNpnEQox3pj8OgWkCEgPM38PiPnTYtokgPTdvy8bDUXOf
         fa0w==
X-Gm-Message-State: ACrzQf3UQbaUtOHDb1fyA/8xVWozG2R0YSecX0XUXqBju7VFInvjecpO
        gWcJ04svxqnpLbgAFkIGy43yOHO5frM6X4wT8Qj7ajA+gOLcSI5DHPHJzJHFguG7dXeX2Z4RLeJ
        1Fi1ZzvRLia/xcstVzT9y+Tmy
X-Received: by 2002:a05:600c:154a:b0:3b4:c9ec:41df with SMTP id f10-20020a05600c154a00b003b4c9ec41dfmr6343141wmg.109.1663586945987;
        Mon, 19 Sep 2022 04:29:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6tHZnjWz3j8PnHqbfxWuekW8WuxqAfOmQax0sp9LqrjbwLphoQoKDKMKbudkqw99jwjjL8kg==
X-Received: by 2002:a05:600c:154a:b0:3b4:c9ec:41df with SMTP id f10-20020a05600c154a00b003b4c9ec41dfmr6343123wmg.109.1663586945682;
        Mon, 19 Sep 2022 04:29:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003b33de17577sm13136490wmj.13.2022.09.19.04.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:29:05 -0700 (PDT)
Message-ID: <27ac1a9c-5f44-a25c-aa09-844debbb88f8@redhat.com>
Date:   Mon, 19 Sep 2022 13:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 08/16] mm/page_alloc: add missing is_migrate_isolate()
 check in set_page_guard()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        osalvador@suse.de, anshuman.khandual@arm.com
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220916072257.9639-1-linmiaohe@huawei.com>
 <20220916072257.9639-9-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220916072257.9639-9-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.22 09:22, Miaohe Lin wrote:
> In MIGRATE_ISOLATE case, zone freepage state shouldn't be modified as
> caller will take care of it. Add missing is_migrate_isolate() here to
> avoid possible unbalanced freepage state. This would happen if someone
> isolates the block, and then we face an MCE failure/soft-offline on a
> page within that block. __mod_zone_freepage_state() will be triggered
> via below call trace which already had been triggered back when block
> was isolated:
> 
> take_page_off_buddy
>    break_down_buddy_pages
>      set_page_guard
> 
> Fixes: 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

