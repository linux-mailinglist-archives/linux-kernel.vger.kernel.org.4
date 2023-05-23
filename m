Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337370D9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjEWJ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjEWJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE9120
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684835747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YZVEtAbMGXAYdoIkesND/UzUOTQcJuA574999NK3d8=;
        b=SF5DYx7rvcuLwpmmrg6H5yCEEwBZBR0c3Tjpjh0N9GVd6kwxtay9eCL682mOOV8JO3U/CO
        dhwxy69w3b39U/ARNP/fb4wEvmoKvhX/QkMAlUkYSE0hwFsPho0R8CRtvY9qek0U/G/Qef
        4B8R9tfX15BGlB74mWgEqBfr2RWg7UM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-PwzWb3yzP_6_3Os4WVgB6Q-1; Tue, 23 May 2023 05:55:46 -0400
X-MC-Unique: PwzWb3yzP_6_3Os4WVgB6Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so26212135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835745; x=1687427745;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YZVEtAbMGXAYdoIkesND/UzUOTQcJuA574999NK3d8=;
        b=gTZPBTnn7f+VZ5H55ELhX7ZDjXU/gCWSEewpJlBn7nIGM65rqdUxuL4OYvynF3LhtO
         cqIUjqTLCsEuB7vjzz+2UuaBMNHOBgC66i+1+/md5NYiuh37ZxjbgRLO2VW90Zj8wQYF
         utmIQEBvDgohPJUFy99lZos0dkMxgOFglOA4+vbo39s0EG8qSNuDvrTyjU1dTlXNe7Oi
         Kg0XG9NWQZ03o4lzHCP9yOC8Cr+Crb8QL/v5T0SgJFe9AqGG8odYQ0zRhyd4KsZagMxh
         6g2DJOqYZYea8ikw9fGvhKD7e0G3HQiUhc45Y7PmXUQaUv6U1JAvk6t1TrtuQJpmDO05
         YaGA==
X-Gm-Message-State: AC+VfDwwcLAtycyaVCGGJcgr61ZZXmQTUT9VIVAoNptFzYPcmav33hfQ
        X6gmNt+36XOK86zMxh1+6Jel9qO+VhbEdWcR6UlaZBQCyyKyN4ipRwCnffAx6oSAYtycLhqJUoT
        X8sVpjGkwzKKLBZ4n2g8F4qsH
X-Received: by 2002:a05:600c:28c8:b0:3f4:2452:9666 with SMTP id h8-20020a05600c28c800b003f424529666mr7987549wmd.40.1684835745332;
        Tue, 23 May 2023 02:55:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jiTVu/IhpqGDiYtn4owqhZUiBNGdKgOHblGxYFQ5Svb4v2MhESPjS2wI1nralmUIeeX1u8Q==
X-Received: by 2002:a05:600c:28c8:b0:3f4:2452:9666 with SMTP id h8-20020a05600c28c800b003f424529666mr7987535wmd.40.1684835745019;
        Tue, 23 May 2023 02:55:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c22c800b003f4289b18a7sm11244609wmg.5.2023.05.23.02.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:55:44 -0700 (PDT)
Message-ID: <4a38e04a-df69-5c5d-5631-152b662db7a7@redhat.com>
Date:   Tue, 23 May 2023 11:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 3/6] ksm: add ksm zero pages for each process
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305221842587200002@zte.com.cn>
 <20230522105305.4126-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522105305.4126-1-yang.yang29@zte.com.cn>
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

On 22.05.23 12:53, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> As the number of ksm zero pages is not included in ksm_merging_pages per
> process when enabling use_zero_pages, it's unclear of how many actual
> pages are merged by KSM. To let users accurately estimate their memory
> demands when unsharing KSM zero-pages, it's necessary to show KSM zero-
> pages per process. In addition, it help users to know the actual KSM
> profit because KSM-placed zero pages are also benefit from KSM.
> 
> since unsharing zero pages placed by KSM accurately is achieved, then
> tracking empty pages merging and unmerging is not a difficult thing any
> longer.
> 
> Since we already have /proc/<pid>/ksm_stat, just add the information of
> 'ksm_zero_pages' in it.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> ---


LGTM. [inlining inc_ksm_zero_pages() and avoiding explicit 
dec_ksm_zero_pages() as noted on patch #2 ]

-- 
Thanks,

David / dhildenb

