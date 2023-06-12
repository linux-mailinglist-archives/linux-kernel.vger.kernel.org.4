Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16E72BCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFLJkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjFLJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0824B6A78
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686562167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iReHIMAZAtyCInAwiq0CyUCdXzchDTiz4sX/MsNC/gA=;
        b=WG5lpebp+ymnLWpaso4FyCaLH9WEFav/nnTHGKfDW51pT2eWRjb7L/O886bZXqVw+Ia82h
        mIv5iomrIwRL5wPes2iQeJD4/ngC0OVHfWnUK18AfZ3XMGReYLq/ej9Srg0rF2WFyXRBxf
        V1gB4dPxUG221LWRNY3nuWmCA9Le5tQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-I0pGH866MC2oO2E5hRiQ9A-1; Mon, 12 Jun 2023 05:29:21 -0400
X-MC-Unique: I0pGH866MC2oO2E5hRiQ9A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso1440871f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562160; x=1689154160;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iReHIMAZAtyCInAwiq0CyUCdXzchDTiz4sX/MsNC/gA=;
        b=QLhhRua3rMqqBZmJyZjuLcpFLIVJho7Ye2A6mD03+LgHq8NdfHWcPWh38w2p3n/XR3
         gKa7GjTovaczerPo2jNiFvWrmXE24UFWaBrW6ll+u5bOqKgs2AmwePb108sGzRwF+hBY
         GN+zRsR5x9dBH+5wPfKEwCNzazIOvUzuCxNMCFIGPFhDCjZvMjAGlFRecTNN8RmDAcxS
         fCIZwga9xnf5yFut5inONkfhUVlFhwYDCQMrLcMmlyM/tRAQvmVPIBYenpOKqwj0gxQB
         vTvzQFyJl8xP0xSRnliDFBXif2fFTDSBSqhdqHBrL4khkA0+eLzQEO1q/yt6sihxHHM2
         ZlgQ==
X-Gm-Message-State: AC+VfDwlrNP3kci9oPmX8HO6ocRrDpxyAHejcumVlCRoYvDIkf8wjaxQ
        pApkTSjjvHbDWCy45qBxb6ME4ZQ/X3sB1Wo0HCvZnYu/Q9IG1oRHupQX/1EVUJ8IojmsuOQ84Ot
        vTw0TuxCzVMTWIAuzVmmaVhIO
X-Received: by 2002:adf:fa47:0:b0:306:28fa:16a7 with SMTP id y7-20020adffa47000000b0030628fa16a7mr3877146wrr.43.1686562159983;
        Mon, 12 Jun 2023 02:29:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ymL7eMoBzrZVIw9zyKn16eAmdcUuV2d5dBdGAUn9giMji0K0KxPsy92u/6kiAU75YUdsH/A==
X-Received: by 2002:adf:fa47:0:b0:306:28fa:16a7 with SMTP id y7-20020adffa47000000b0030628fa16a7mr3877133wrr.43.1686562159634;
        Mon, 12 Jun 2023 02:29:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm12007654wrf.72.2023.06.12.02.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:29:19 -0700 (PDT)
Message-ID: <a562bae0-d779-620a-98bc-6102468aecae@redhat.com>
Date:   Mon, 12 Jun 2023 11:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv5] mm: skip CMA pages when they are not available
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
References: <1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20230609153519.ff01046ef0faff00a74bd5b0@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230609153519.ff01046ef0faff00a74bd5b0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10.06.23 00:35, Andrew Morton wrote:
> On Wed, 31 May 2023 10:51:01 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
> 
>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>
>> This patch fixes unproductive reclaiming of CMA pages by skipping them when they
>> are not available for current context. It is arise from bellowing OOM issue, which
>> caused by large proportion of MIGRATE_CMA pages among free pages.
>>
>> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=(null),cpuset=foreground,mems_allowed=0
>> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB 0*2048kB 0*4096kB = 35848kB
>> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024kB 0*2048kB 0*4096kB = 3236kB
>> ...
>> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
>> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64, buffer size: 64, default order: 0, min order: 0
>> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free: 0
>>
> 
> We saw plenty of feedback for earlier versions, but now silence.  Does
> this mean we're all OK with v5?

The logic kind-of makes sense to me (but the kswapd special-casing 
already shows that it might be a bit fragile for future use), but I did 
not yet figure out if this actually fixes something or is a pure 
performance improvement.

As we phrased it in the comment "It is waste of effort", but in the 
patch description "This patch fixes unproductive reclaiming" + a scary 
dmesg.

Am I correct that this is a pure performance optimization (and the issue 
revealed itself in that OOM report), or does this actually *fix* something?

If it's a performance improvement, it would be good to show that it is 
an actual improvement worth the churn ...

-- 
Cheers,

David / dhildenb

