Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624ED5BCAC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiISLaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiISLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006D27CC2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663587007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRGt0YZQFsB7DO1CCJixBbsmCtGTMDF3Jg3qE0OH4CE=;
        b=REdBbh7KjyunrEswWywA/vf2KCjiwtPRcMsMLX5iWzfdAJtBcEG8tE9UBh4DMZJLH+0iZH
        b874aqznUS5iWH2pkA4bzln75KBfzmZ/w2DYpS6wCQPic+DnBS8S6MrkyszxRK6pbaQbyo
        9Rn/ufIx7cX0jsCysPkZ9WUPR3TzT80=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218--mMRj663Mum5BpRonsOVrw-1; Mon, 19 Sep 2022 07:30:05 -0400
X-MC-Unique: -mMRj663Mum5BpRonsOVrw-1
Received: by mail-wr1-f70.google.com with SMTP id d9-20020adfa349000000b0022ad6fb2845so1438906wrb.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GRGt0YZQFsB7DO1CCJixBbsmCtGTMDF3Jg3qE0OH4CE=;
        b=IY+ec+uW94PTWf2nhE0ZiaVLLyalBbdyVgG4oJZ2zx4XZTV+BlD1edYZSQ0IOrXYOy
         nRPbBUijAU4aWULX+E0peR0YTFthmkEILImyBTTfO+7eSTIauuDNomQiBmihntGZExmC
         xfqlnwTylZzwfSXYmf+VhVWyKcSkeerDTwz69rji+KoO+DkIajrN6D5QLqANFrmDJoxa
         K8bFEde73wfeUDfYHiczHEjIYTHJC8uDztPSzw5Y3Wt1TOCfDi8KLmsakneBDUDTl7jI
         XbMA8TCJaZ7d00hpWNjXfyQu6FLnKQKmFSJt/COfrYdPq8Cb2VH9j/ZAMOESyOlCYv+r
         SYXw==
X-Gm-Message-State: ACrzQf2z09Sz/+FC60/MLrvJr93KChklswYUMk5OonuizUC3tiLY+RDl
        /CUQCKFCNoN8GeifkOS7kSN7UMC2xLnqm02YQwXidT7OK7Pp8O8TBVqEY5r+IhpA4JEkSltRWp+
        wOYX2vLOdRUb2rb8NVa+CBedO
X-Received: by 2002:a5d:64ee:0:b0:226:db9b:e381 with SMTP id g14-20020a5d64ee000000b00226db9be381mr10816084wri.52.1663587004739;
        Mon, 19 Sep 2022 04:30:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Z3NZexY7FmTzHbNilC2POx6FzkF/KjbrwNtaTfJXGSN8OJvHdvTT9wXuweUoGm4+UR0gGBw==
X-Received: by 2002:a5d:64ee:0:b0:226:db9b:e381 with SMTP id g14-20020a5d64ee000000b00226db9be381mr10816068wri.52.1663587004436;
        Mon, 19 Sep 2022 04:30:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003a5b6086381sm14408636wms.48.2022.09.19.04.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:30:03 -0700 (PDT)
Message-ID: <462a518c-9a54-0e84-840a-3ca641469a06@redhat.com>
Date:   Mon, 19 Sep 2022 13:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 12/16] mm/page_alloc: use helper macro SZ_1{K,M}
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        osalvador@suse.de, anshuman.khandual@arm.com
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220916072257.9639-1-linmiaohe@huawei.com>
 <20220916072257.9639-13-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220916072257.9639-13-linmiaohe@huawei.com>
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
> Use helper macro SZ_1K and SZ_1M to do the size conversion. Minor
> readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

