Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2215A6C0F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCTKt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCTKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DEA25BB4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679309078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/zfm/iMBqjihSZrFF9A/S4gBRsOTN99Y8OwQCdHpx4=;
        b=VxmvtzQbBAEQcjdZTKbISqnq8vFLpcjmMu/7Xtx5ZkMHPMI3/fRRMfDPULPun1nRj3G6ce
        PRe4Z3Kj1Efy3uOAs72Q/pP2+MGilMHTcCi4jcvwrK7QsF5oe/i04XyUHgIGJ0jIV9BdCQ
        Oj9aPDgxI0XBmWxdywAvPqdpQN+IbY8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-BqEfC6oQMjmgPdraA7atiQ-1; Mon, 20 Mar 2023 06:41:24 -0400
X-MC-Unique: BqEfC6oQMjmgPdraA7atiQ-1
Received: by mail-wm1-f71.google.com with SMTP id v8-20020a05600c470800b003ed3b575374so5316803wmo.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308883;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/zfm/iMBqjihSZrFF9A/S4gBRsOTN99Y8OwQCdHpx4=;
        b=ggJ+vWHcEEq6UhnZV8iETGPOuSBaurDJJa4mKOoQIsKJuchROwcfXxILOjrG9axQ7l
         1RGijC+5mwXJ0C8AWUSTHaCSqPk9xzsQRgRjjJpvTWp2phgvwnvX9i2H0r143DIkEQbA
         tf5akbcx1sXxaXqyYT0AKRLxKIH6nlqCEsW63JQOv3HJAVzTvfV2xYsXLsgj5orLAnlo
         J3YDCZEXOmg2CkzIAZSTrST7m9SbHykr0BXC9Rs19/AJh2rD/AfLiOej9WwSBljC+DFN
         gz1N4JZ92kTZ6yQ/BiIFzulKOpFWr1y4I+lp8IZz5dpdIf19J7VepJEpJ0f76cVdxAnf
         xkXw==
X-Gm-Message-State: AO0yUKXL1WnItzUGgHBMgOkGYcBcyUl6lHuSCX2IoxtbmfjqEchSNXUA
        6X5nVg7i/dmGp9xRC0mM0bX9Mdp+M9RgMwWg+/6Gr8kZsBFl7euofExkvO8XTJ7oKrmPAnQHAI7
        QxLm5r8mp6bpfpF9YuF3SOx0Q
X-Received: by 2002:a7b:ce03:0:b0:3ed:5a7d:fcfe with SMTP id m3-20020a7bce03000000b003ed5a7dfcfemr12841653wmc.3.1679308883702;
        Mon, 20 Mar 2023 03:41:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set8VZjkq7GCgobpz8BUvT0F46hv0XS185gY9bV0RE1/Uo0GRuPBNbY0rUOAkJA7byaVeIEmCUA==
X-Received: by 2002:a7b:ce03:0:b0:3ed:5a7d:fcfe with SMTP id m3-20020a7bce03000000b003ed5a7dfcfemr12841637wmc.3.1679308883377;
        Mon, 20 Mar 2023 03:41:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b003e1202744f2sm16423888wmo.31.2023.03.20.03.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:41:22 -0700 (PDT)
Message-ID: <078af8b0-4f4f-41f0-40d8-2beba34d0e76@redhat.com>
Date:   Mon, 20 Mar 2023 11:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 14/15] mm: move vmalloc_init() declaration to
 mm/internal.h
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-15-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-15-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 23:00, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> vmalloc_init() is called only from mm_core_init(), there is no need to
> declare it in include/linux/vmalloc.h
> 
> Move vmalloc_init() declaration to mm/internal.h
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

