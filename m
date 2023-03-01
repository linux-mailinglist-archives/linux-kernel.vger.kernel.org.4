Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1E6A68DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCAI1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCAI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3597936FEC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677659179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/oAv3ZT1NMDfBA1YiEiITC5gnW/pXSuUfY745CxpBJU=;
        b=QCaHx2EarnB24hwiYKVN90kL5zd39RCJoQ6AlpCti4dc2hwbmH9YEuePXmy3H12BYCc11g
        Z2kXJn8vG6lbYFXpsSjkVbyHir9Ck2ZF/Y4Y8U/hs3l2yoJ3BYdfvxnr/DrO2BybDmJ5h5
        z3pg0goBX9TiL6wqsnwejUTHcVdpZIs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-CeX32jlfMT6mMYlbn-ci0w-1; Wed, 01 Mar 2023 03:26:18 -0500
X-MC-Unique: CeX32jlfMT6mMYlbn-ci0w-1
Received: by mail-wr1-f70.google.com with SMTP id 15-20020a056000156f00b002ca79db6d42so2103785wrz.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oAv3ZT1NMDfBA1YiEiITC5gnW/pXSuUfY745CxpBJU=;
        b=I0XhhSUm647d065mlPJ9rb5kfN0W9V2Gg+nN/imRusPZ6LYGCZOJjM4JVZ1xRWoj4v
         TrirmVEg+K0cMpPTabFc1EBAU8OADKUDe2dnkOo1wJkT/Dg8ktWtU6IFVHzv8vh9Spuz
         Qouc1jK97m7QgjXzP5AXxTXUWYAWgdXx+5E3FYjF77z5b/5n3W29ioNZ15U9of1Z9ncZ
         2P0P2f/4mZ7lRlzF9olL7KikN8kmoLsPPSM2bN0ASfdSmEQ/2oem8WRYCJQlO4mMc9Rz
         v1OKOaVZyX+mjn5h1OUMeKcElZyd8DyzkJLuIv3BoOJf5qIQUdZyRAGfhJCduiqPQUAf
         opww==
X-Gm-Message-State: AO0yUKVwpQo0LYJwEY0aOpEJMSlxw7cXd7baCHo0PASoshmkIzUiXuC/
        xwj5I4K8xIFn3KD0gLkz1PKHH64UzyPf82QSkRRwpKWXYXuRuhpat6uCQq9ogY/JZYBWWU/ztlR
        2CjH6fNc0QEP1O4OOdwTSPsVL
X-Received: by 2002:a05:600c:331a:b0:3eb:2b88:4e02 with SMTP id q26-20020a05600c331a00b003eb2b884e02mr4751563wmp.16.1677659177221;
        Wed, 01 Mar 2023 00:26:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9/F44ZyZ5VrGYqX5VPdUR0W2BC2TitglAmZx8Zlfz0CjoFZEgN9uaiIBXZnxoMycpbMFs8HA==
X-Received: by 2002:a05:600c:331a:b0:3eb:2b88:4e02 with SMTP id q26-20020a05600c331a00b003eb2b884e02mr4751540wmp.16.1677659176886;
        Wed, 01 Mar 2023 00:26:16 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003dc4480df80sm19719174wmq.34.2023.03.01.00.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 00:26:16 -0800 (PST)
Message-ID: <98791b0f-0c00-0d0d-4831-3c36fce55888@redhat.com>
Date:   Wed, 1 Mar 2023 09:26:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] mm/mmap: remove unnecessary vp->vma check in
 vma_prepare
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, error27@gmail.com, willy@infradead.org,
        Liam.Howlett@oracle.com, jgg@ziepe.ca, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20230301022720.1380780-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230301022720.1380780-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.23 03:27, Suren Baghdasaryan wrote:
> vp->vma in vma_prepare() is always non-NULL, therefore checking it is
> not necessary. Remove the extra check.
> 
> Fixes: e8f071350ea5 ("mm/mmap: write-lock VMAs in vma_prepare before modifying them")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>

It would be great to mention that this simply silences a smatch warning. 
Otherwise, one might be mislead that this commit fixes an actual BUG ;)

> Link: https://lore.kernel.org/r/202302281802.J93Nma7q-lkp@intel.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Fix cleanly apply over mm-unstable, SHA in "Fixes" is from that tree.
> 
>   mm/mmap.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0cd3714c2182..0759d53b470c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -505,8 +505,7 @@ static inline void init_vma_prep(struct vma_prepare *vp,
>    */
>   static inline void vma_prepare(struct vma_prepare *vp)
>   {
> -	if (vp->vma)
> -		vma_start_write(vp->vma);
> +	vma_start_write(vp->vma);
>   	if (vp->adj_next)
>   		vma_start_write(vp->adj_next);
>   	/* vp->insert is always a newly created VMA, no need for locking */

Yes, that looks correct.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

