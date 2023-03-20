Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D696C0F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCTKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCTKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393624BEF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZ0AxV1VG3KdfSZkp/T15ZdSHC7gyLYAQev+yJsxfl0=;
        b=drAq3Qo+MjuGg3W/nVAIywIVGwV5W1uoQpfSn4gbXpiFZMMt8cGNEcYfWb2lDPfIRof5gQ
        YFpTp0LvUdczKJV6aCc9efZ5VszyhtrPtH2TWbkxrGt6IoRPnk2RG+owa9d9Hgptp8VIBn
        EVDLVp8Yj6d2PVG8aXVg9EDZzEGqpP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-YKuakWCnORaiFhs1yRqPXg-1; Mon, 20 Mar 2023 06:36:36 -0400
X-MC-Unique: YKuakWCnORaiFhs1yRqPXg-1
Received: by mail-wm1-f70.google.com with SMTP id j16-20020a05600c1c1000b003edfa11fa91so745222wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308595;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZ0AxV1VG3KdfSZkp/T15ZdSHC7gyLYAQev+yJsxfl0=;
        b=p/PWr0lxUBwGQnoo00S/OJcrlZ06tZZMGpYy9re00R08vjIbPn3ojn62ovdjMDe+nc
         JlYGzHTIKP9aNvetQzI5SYXsVfoLXK5re62i6u2YAeA2FZ9uSM4UH/BAmFdvW+lmBuhu
         FbkN2WAGQ0+OG84qqorTVSHJAekX5qCqoMK5OlP0oLYXinakiuRAlNQcM67x5jBs7+Hv
         ouBR7EC8/ku6qAt4f1a0aJiDRAo0k7+XPR3CCTsfADGxYw4voSGiqhTCz+CsUhp5dDk+
         YG0zmFqXZeUxubcftQcMjbkMmdEAseO51Z0xefo3RmsrRmf1NOmhEsCN0w1z21+Ml6v2
         DThw==
X-Gm-Message-State: AO0yUKXzNtcxPsEK6GkXdtJ5oNQvioD5Lm6zXkspWHIfPGsAPvoBTMN/
        BMxzjXDTOG8CVewlqO8QdSrGZ84IwFg2xN6I3ydTfYsBs4nogwBzTwmnEeTMjgI1xVXbK6V8vxw
        R19uSC7D2oJQjfa+SAtnOqwT1
X-Received: by 2002:a05:600c:c8c:b0:3ee:598:7a9b with SMTP id fj12-20020a05600c0c8c00b003ee05987a9bmr1138798wmb.11.1679308595615;
        Mon, 20 Mar 2023 03:36:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set/wJFKOO9oISw4hm5jxAAqcxKIdueA+KhnptjzCqGrBZFputxwfG1iHZ4b5QpZIESamS40dDQ==
X-Received: by 2002:a05:600c:c8c:b0:3ee:598:7a9b with SMTP id fj12-20020a05600c0c8c00b003ee05987a9bmr1138783wmb.11.1679308595351;
        Mon, 20 Mar 2023 03:36:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c1d1600b003ee17ff73d3sm230544wms.46.2023.03.20.03.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:36:34 -0700 (PDT)
Message-ID: <c65f4959-2e1a-6031-2d4e-5797ef229aaf@redhat.com>
Date:   Mon, 20 Mar 2023 11:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/15] init,mm: move mm_init() to mm/mm_init.c and rename
 it to mm_core_init()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-9-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-9-rppt@kernel.org>
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
> Make mm_init() a part of mm/ codebase. mm_core_init() better describes
> what the function does and does not clash with mm_init() in kernel/fork.c
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

