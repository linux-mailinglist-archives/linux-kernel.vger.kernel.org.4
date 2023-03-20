Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A061D6C0F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCTKpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCTKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48789199E9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJguxbCJYBtj4CFOHRDKkjtpLbwvo1pCuTkJH1ikJVM=;
        b=crKGov1Nbgr7fKKrkdYtWC/Ss8hE/jeVXh0mDuIRO6ApQjYmNgfoJGYBgRV1bCJWyrN5Sw
        p44xQ9DYOCQViecFviOawvvVYlqKGVANBNTZ9874nWmp+ycqVvgXliqzO5sWr/ZSVM9Qeo
        cDAzMFPyjvYHn3J6Jt6sSn7FaP1FBPc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-BZCLVytnOZmWtJOP85Xb8A-1; Mon, 20 Mar 2023 06:40:58 -0400
X-MC-Unique: BZCLVytnOZmWtJOP85Xb8A-1
Received: by mail-wm1-f69.google.com with SMTP id o42-20020a05600c512a00b003ed26fa6ebdso4234538wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308857;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJguxbCJYBtj4CFOHRDKkjtpLbwvo1pCuTkJH1ikJVM=;
        b=4TN5lbafpgUC+el2JnKaPBdc6jAnR0gQfN6qeDPrX8TG3ysWxs6TBAXChZspPNutQt
         5HxEe+doS4tYZPpIiuQoUd2b4l7BHFGpqmI0yltxX/CTSyN2zU4ujlvKn/TwkfGapFXV
         k4PW5ZQhPWEWD/zlUWwRfHViZG2PU7+HglWDcWYllfTFUjPxFrgDc3I0wglZRJRB1mxh
         Yl2RoXjWmqaERrdC6ry1k9wDFPnpfdOQ63d+R2IbNsmM3O05jJO0hTCQmbxJ18+2P1LF
         ua3JGxdCAUgqmwMc0PznitEXdg/T/sIzZSCt2LJldE5lND4Bkz950ip7QgF5EbzK0q9+
         3pEA==
X-Gm-Message-State: AO0yUKWqcwCbRyb+Bl08c+WxuMmCM5BkJ8BrYM0mKxMCbgq33iRrH5kZ
        w1SSyiJh0JMTUeNV94QwYOpypEWBB6VedJK2H+q8sl1+JsOH7tC5KY3uV7JInnOlbzUSF9zw7Io
        TTpzp68TS8gyxNgm/QSIl+aXS
X-Received: by 2002:a1c:750a:0:b0:3ee:392:39e3 with SMTP id o10-20020a1c750a000000b003ee039239e3mr1321304wmc.30.1679308856965;
        Mon, 20 Mar 2023 03:40:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set+OTIiIktUe11EIou7C0lzkEJJROa0OtRp3yUuYILIQu/flQFGe1MwG4Rz3QJZ4IPl6vg4+tA==
X-Received: by 2002:a1c:750a:0:b0:3ee:392:39e3 with SMTP id o10-20020a1c750a000000b003ee039239e3mr1321298wmc.30.1679308856790;
        Mon, 20 Mar 2023 03:40:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id y13-20020a1c4b0d000000b003ed551b139csm10108565wma.36.2023.03.20.03.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:40:56 -0700 (PDT)
Message-ID: <56495339-fe3a-97a0-bc98-ade387adeab3@redhat.com>
Date:   Mon, 20 Mar 2023 11:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/15] mm: move kmem_cache_init() declaration to mm/slab.h
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-14-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-14-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 23:00, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> kmem_cache_init() is called only from mm_core_init(), there is no need
> to declare it in include/linux/slab.h
> 
> Move kmem_cache_init() declaration to mm/slab.h
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

