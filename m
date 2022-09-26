Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E65E9C40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiIZImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiIZIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702A3687E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664181747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miZ9cp9EXHlLfuDKQdDnuTtw2KJ7fxB/IhGn8Pmq+FA=;
        b=Gu1aEjbPKkowahjFjNNthTUz/H1LHkoDt8/igb1ZJ/gwuAcW5OSreTDfURHFGLatluUiqN
        6/RDfaGo+enmVGqL1ZimxJ5CEToavOGuBUECCv592s9I3Kuyjax6zZrqW8pOcqrG6sZq5D
        /tG90EFpy98WgnlH1Q2k0gRkA1Gw8X0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-FrmP7ewQMLqLfaD_CdHrwQ-1; Mon, 26 Sep 2022 04:42:26 -0400
X-MC-Unique: FrmP7ewQMLqLfaD_CdHrwQ-1
Received: by mail-wr1-f70.google.com with SMTP id d9-20020adfa349000000b0022ad6fb2845so931828wrb.17
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=miZ9cp9EXHlLfuDKQdDnuTtw2KJ7fxB/IhGn8Pmq+FA=;
        b=Cn/hWWjrknrJTd+1qVkf/Y8fVCfWzyTF/RwMDpwWQE/3lgBhWbNwdTIZ8WvvbX6HgS
         v2ty3d9T8wVwErI6sZVVGknerg9kNQ0M8q7sXWUbq9zkool5VhqtIKY82Z1sF/GDSrTs
         EMw8p2sbwNKztK/EhSxhCBoSZSezYn08KtYSItiuoFzbNicUqnZooKFVqPot4beAND3B
         3KoZDK7sQ/2I/lDdBetAgsyQisBdta5p3RI9x4G8/VV25dUZLqVRbe7AeKncpkTyAtFn
         d/wXy87OB5ddsv9ZREOZ9Ybae4u2XkT42u81U1CDM0WVjlX0UtKLWps7dIpIGpoWF8dz
         Wyzg==
X-Gm-Message-State: ACrzQf3O0c0lGZo3AzhELdRIvTSm1khsAF+2mGARAZZwPXvuLlGWicG7
        XLj+gHXBtkgdNxepcZhU4wivWoXxGF5ajY4WgcITqxmlX65XbLYztFDVR09DwkbjnpDUHGvPWth
        JWeROBhemde59sFD3ud5xRx+C
X-Received: by 2002:a05:6000:184e:b0:228:bc3a:8e35 with SMTP id c14-20020a056000184e00b00228bc3a8e35mr12563562wri.443.1664181745046;
        Mon, 26 Sep 2022 01:42:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5+IrAJ28k+vH8MMXMHBNesDpckEZ7dORdCHL7kBkAE1tVVdTyByWNsrXuA1sL2YLjlUBFhGw==
X-Received: by 2002:a05:6000:184e:b0:228:bc3a:8e35 with SMTP id c14-20020a056000184e00b00228bc3a8e35mr12563555wri.443.1664181744824;
        Mon, 26 Sep 2022 01:42:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d468b000000b00228d8420f57sm13638417wrq.95.2022.09.26.01.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:42:24 -0700 (PDT)
Message-ID: <1a69af58-b9d2-6319-9db7-f92428b87612@redhat.com>
Date:   Mon, 26 Sep 2022 10:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] mm: fix misuse of update_mmu_cache() in
 do_anonymous_page()
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        chris@zankel.net, jcmvbkbc@gmail.com, maobibo@loongson.cn
References: <20220924053239.91661-1-zhengqi.arch@bytedance.com>
 <3A09E40A-E2C5-4C6F-8550-DD0E17B7DAB9@linux.dev>
 <48590f80-fc58-bf67-5acf-082880a607b2@redhat.com>
 <e1a6007d-24f2-5153-5382-f66391cbd0cb@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e1a6007d-24f2-5153-5382-f66391cbd0cb@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.22 10:41, Qi Zheng wrote:
> 
> 
> On 2022/9/26 16:32, David Hildenbrand wrote:
>> On 25.09.22 03:43, Muchun Song wrote:
>>>
>>>
>>>> On Sep 24, 2022, at 13:32, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>>
>>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>>> if PTE entry exists") said, we should update local TLB only on the
>>>> second thread. So fix the misuse of update_mmu_cache() by using
>>>> update_mmu_tlb() in the do_anonymous_page().
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> The change looks good to me. However, I am not sure what is the
>>> user-visible
>>> effect to xtensa users. So Cc xtensa’s maintainer and the author of
>>> 7df676974359
>>> to double check this.
>>
>> And if there is one, do we have a fixes tag?
> 
> IIUC, there's only a performance difference here, so maybe there's no
> need to add the fixes tag?

Maybe be careful with the usage of "fix" in subject/description then and 
point that out in the description :)

-- 
Thanks,

David / dhildenb

