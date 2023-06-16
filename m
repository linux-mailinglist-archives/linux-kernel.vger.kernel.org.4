Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB2732934
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjFPHsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjFPHso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31022D4A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686901674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXBh3WfPI9MVT50Pe8Afg210FLgWLd3bSOuVVKJkhWo=;
        b=dGmUTxle42pfzKyqiEj9rLKQSjOXTXevCBzo3oNI53TvUR3OMSXEu9Y0lSnvdIeSyzkeFL
        xVwl33KVljLawo0UKnduplTbkfD0+9gc4ElxpbD7HauOZtIyo2Wwi3JX+xsGjrrl69ktGE
        JpXJJXMgIxCxAho/amOgKAmd18621NE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-XfBdK-ZxNNqFGTG0qudQ_w-1; Fri, 16 Jun 2023 03:47:50 -0400
X-MC-Unique: XfBdK-ZxNNqFGTG0qudQ_w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f81dda24d3so6451775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901669; x=1689493669;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXBh3WfPI9MVT50Pe8Afg210FLgWLd3bSOuVVKJkhWo=;
        b=S3Che7KchoyJfZvIqydsFsb/2SyHX9FevYAIWTN16HflX9FHy/qM59QeNRNqRqW+cS
         wKLXl13dZZNvVM54yHLcXGl5sERJmsUGAO6zxwjO5dbjebz3ZgBWOQjwSBIVb/W0eQLy
         8D7bxNddlSpt0+PHjm96Am8A/UMceZSM4baMIiBYXR3WIeqASAhpX2EaDKx53KRk7kFv
         fGIubTYjQXGaUQiv1OswDphM8PJe6tP483NxsXQcLmQWWIQRlkE4vIgoIV6T42blsUK2
         Tw8dI9IFcHHW2SJ5SrnQDPjBxf+d8lSoUhu5gIG/CpAC4iKDV8kWXQpUjE8ZbpFmUkz5
         CBkw==
X-Gm-Message-State: AC+VfDzrCvYnFJtOHoqxGC5+s/AmabCW7QLDD2wUAhTewrdpFZ0lyB/T
        tp6h4qb17RqcpiFxGdJ1MQO31Z6HlY9Z3OvZk81uMnj4mnN0uXlI4FcQdJB1Toy1lTdihKXNZPX
        Rricj6VVrs1A+EFd+n5W9Fs+F
X-Received: by 2002:a1c:4b0d:0:b0:3f7:f544:4993 with SMTP id y13-20020a1c4b0d000000b003f7f5444993mr1141179wma.20.1686901669251;
        Fri, 16 Jun 2023 00:47:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55p+WG27rh5UmhzCo3TJhy6HQkGnC87778glLxQLQ6ZCU8vj9Eo1KqLOUz62TTGAYz/uhrHA==
X-Received: by 2002:a1c:4b0d:0:b0:3f7:f544:4993 with SMTP id y13-20020a1c4b0d000000b003f7f5444993mr1141163wma.20.1686901669008;
        Fri, 16 Jun 2023 00:47:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bcd0d000000b003f7ba52eeccsm1427266wmj.7.2023.06.16.00.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:47:48 -0700 (PDT)
Message-ID: <a40fe0a5-589f-0c65-ba57-9eb18cf54730@redhat.com>
Date:   Fri, 16 Jun 2023 09:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Export symbol
 mhp_supports_memmap_on_memory()
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-2-f6de9c6af2c6@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613-vv-kmem_memmap-v1-2-f6de9c6af2c6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.23 00:00, Vishal Verma wrote:
> In preparation for the dax/kmem driver, which can be built as a module,
> to use this interface, export it with EXPORT_SYMBOL_GPL().
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>   mm/memory_hotplug.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bb3845830922..92922080d3fa 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1328,6 +1328,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags)
>   		       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
>   	return false;
>   }
> +EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>   
>   /*
>    * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

