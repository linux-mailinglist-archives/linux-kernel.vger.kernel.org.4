Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE59C732931
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbjFPHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243398AbjFPHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F7D1FC3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686901623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U5bYwqNSLrXJiQtrIMo72MYJh3QZB8KMtEIiq6QD74Q=;
        b=O6rHtbnxDD7a3gBxnAwDVtF7MZUo9b4EmqW8FNX9H4mC3cpbLYXIl7RBfl3z4Cz4Rr+syS
        zqfR6Ma4kIYgbTggNbc9wqIZVPDANMSG3kDtzyYMb9DnIcXeqGqPQ9xGqAyzCnO0U2BXmk
        le906kEMUy2CywyEUT04E1xTWH2qT8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-VBnlAa4ZPcy8nzJbYA9zxA-1; Fri, 16 Jun 2023 03:47:02 -0400
X-MC-Unique: VBnlAa4ZPcy8nzJbYA9zxA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso1878465e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901621; x=1689493621;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5bYwqNSLrXJiQtrIMo72MYJh3QZB8KMtEIiq6QD74Q=;
        b=GLl3GpciA706czmt1BA8QDRqWdyv68wvXT9X/pE4N1y33YOR7DEX+tjxBEpVlSbHdd
         cthCy7EDMdOOQ5YQBiwH92WHdQiqYmJ5Zj9dhl8Yzq4QwVLicE0YCuNn+46PKLkdnea0
         xElA0thAQLM7EFEaFj0xlpof7wWrPZFzlbgMayvI8muQ0GrdhlHB8BzcILpjggdQyXNX
         c4yZ5BqRtHF8rdChHsmFBG2wFmcaCU49Znovv+5sNzcI0QRYcw4SWjMJCev0guLQ8InR
         l/EadXChryl2qN546UO7z0SaVz6+IsOvYAVL3H9GwKPYdkQNrd9CetEfcBS/V0WcKKnM
         6W5g==
X-Gm-Message-State: AC+VfDx8yY48X0XI0SEbXnlyWlkiHiIA2JVs1G8pK5/Td+tHDny3/OiC
        oj0ueuABcuk1d8Z6X55QoXKizEzjLkoVorzWKiwkIBvSDcFhnV15UTHqTLcZtys9iYC37hyJNsF
        dd2OogMaYsspCLlfEMN9tUN3yZ7ztaB4A
X-Received: by 2002:a7b:cd98:0:b0:3f6:766:f76f with SMTP id y24-20020a7bcd98000000b003f60766f76fmr925949wmj.36.1686901621070;
        Fri, 16 Jun 2023 00:47:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FjFAGg0EAY/fN2yFOMKdsON/pGAcgKV47j+V2XrsGwOYGSddhs9zmuejwHx2MuQTEuN5LJg==
X-Received: by 2002:a7b:cd98:0:b0:3f6:766:f76f with SMTP id y24-20020a7bcd98000000b003f60766f76fmr925931wmj.36.1686901620728;
        Fri, 16 Jun 2023 00:47:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm1356132wmb.45.2023.06.16.00.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:47:00 -0700 (PDT)
Message-ID: <0ea4728a-8601-bf75-1921-bcde0818aac3@redhat.com>
Date:   Fri, 16 Jun 2023 09:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] mm/memory_hotplug: Allow an override for the
 memmap_on_memory param
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
 <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
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
> For memory hotplug to consider MHP_MEMMAP_ON_MEMORY behavior, the
> 'memmap_on_memory' module parameter was a hard requirement.
> 
> In preparation for the dax/kmem driver to use memmap_on_memory
> semantics, arrange for the module parameter check to be bypassed via the
> appropriate mhp_flag.
> 
> Recall that the kmem driver could contribute huge amounts of hotplugged
> memory originating from special purposes devices such as CXL memory
> expanders. In some cases memmap_on_memory may be the /only/ way this new
> memory can be hotplugged. Hence it makes sense for kmem to have a way to
> force memmap_on_memory without depending on a module param, if all the
> other conditions for it are met.

Just let the admin configure it. After all, an admin is involved in 
configuring the dax/kmem device to begin with. If add_memory() fails you 
could give a useful hint to the admin.

-- 
Cheers,

David / dhildenb

