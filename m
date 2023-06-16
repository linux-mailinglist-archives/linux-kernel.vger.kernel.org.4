Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AC3732928
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbjFPHp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245370AbjFPHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979802942
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686901495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHh80tHevfpfGpsYLMJr0xWQFhLc1pRS6PbFj4Uk1xM=;
        b=drFc/Zch9l9sUv5vXMu0WMzWJSZczsSP3P1R3fPg3u+ijB4VHi5pKJFrbUcZjxbJyepX4N
        oiJsLU3ZlNwyP7HWYh3HkL3/tGZ5h2WMZ89D+CqQM+JBcGSTE1ohHRyvJWariNWEAGLuMV
        mWON2sxe8/0IgV7SBoPIxCA8RXHwy/w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-3GFhf2fkNnWpcxHF1Omu3w-1; Fri, 16 Jun 2023 03:44:54 -0400
X-MC-Unique: 3GFhf2fkNnWpcxHF1Omu3w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f60dd5ab21so296667e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901493; x=1689493493;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHh80tHevfpfGpsYLMJr0xWQFhLc1pRS6PbFj4Uk1xM=;
        b=j6FZ9M+xPeDiZ5oDs58qnyYVy+TPfwp0biJ6TrW4ZHInnlLzGfnzMjrgPCvj3bvjLJ
         sudixBYoti739GIG9ErlRK1zinbO9vR1g7k1dZE3Wc1WfGFjthR/idOdLIHSvuPifZkh
         VY/iB6RyZQvcApbgcDW8AW2Vndyt5J3usuOxyiZ9/Zc0jmY2mijJT2arc2Dz8kxb6394
         pTqdcxJaka8+lZ2TZydt/hJB0rYTJaFDi7wP/I//qC/K3+j7lPHJT4ookgDha/xhtNh1
         1ASq9qb5yMkStEK6koHyLSSnSwVlYzB3ejoKUeAKWFH1TgZXiXou/AcQa+OAHBP8N5+H
         NkBQ==
X-Gm-Message-State: AC+VfDyQl/umVNwU/DVZuGBbIjxjj0j9IuWwQR7MPHIOj4ckEzkuVZAt
        kAiOnPwtBPdz0E//B8xMGvQlmcbNyKZoj96stUbMpVdsUe7JB0ao2cBkJxYXf8goiUB/7832nEz
        tGoGtJIF85tgiLA5znuzWYnRH9WFbkw9p
X-Received: by 2002:ac2:4d93:0:b0:4f8:4961:7610 with SMTP id g19-20020ac24d93000000b004f849617610mr755639lfe.43.1686901492815;
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4V2KwN13A0iu+AAg7e0iRwh6yMnxJrHrSMfwNZ/+rksVbEc+zvz9ZHK23cYpe/zyiH2IoeHg==
X-Received: by 2002:ac2:4d93:0:b0:4f8:4961:7610 with SMTP id g19-20020ac24d93000000b004f849617610mr755629lfe.43.1686901492450;
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002ca864b807csm22936582wro.0.2023.06.16.00.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:44:52 -0700 (PDT)
Message-ID: <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
Date:   Fri, 16 Jun 2023 09:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
In-Reply-To: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.23 00:00, Vishal Verma wrote:
> The dax/kmem driver can potentially hot-add large amounts of memory
> originating from CXL memory expanders, or NVDIMMs, or other 'device
> memories'. There is a chance there isn't enough regular system memory
> available to fit ythe memmap for this new memory. It's therefore
> desirable, if all other conditions are met, for the kmem managed memory
> to place its memmap on the newly added memory itself.
> 
> Arrange for this by first allowing for a module parameter override for
> the mhp_supports_memmap_on_memory() test using a flag, adjusting the
> only other caller of this interface in dirvers/acpi/acpi_memoryhotplug.c,
> exporting the symbol so it can be called by kmem.c, and finally changing
> the kmem driver to add_memory() in chunks of memory_block_size_bytes().

1) Why is the override a requirement here? Just let the admin configure 
it then then add conditional support for kmem.

2) I recall that there are cases where we don't want the memmap to land 
on slow memory (which online_movable would achieve). Just imagine the 
slow PMEM case. So this might need another configuration knob on the 
kmem side.


I recall some discussions on doing that chunk handling internally (so 
kmem can just perform one add_memory() and we'd split that up internally).

-- 
Cheers,

David / dhildenb

