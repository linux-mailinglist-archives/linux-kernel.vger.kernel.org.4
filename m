Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6717200F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjFBLz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjFBLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57FD10E4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685706774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0e2kTAxpyGwta5efoRPZW8NlgUhggCRfdYJlDSsPPM=;
        b=D2NhS6SjxNoEba4Lony02Z+5hiptapoPbw0xvqlZZs2ldX3BWO/jIuVp8lzCed7duj9dJo
        gAsbc2HiYOSkE4vg0haf56iEuApHLKbYBiRiYH0HlKbhMa8JPS0wJ7jtHfOPyMuCMrse5Q
        bNt1ZSa+efGaBzvNceN6ldWTi/cokSM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-1uaGn3RFNZ-GBcQvtPfXLw-1; Fri, 02 Jun 2023 07:49:36 -0400
X-MC-Unique: 1uaGn3RFNZ-GBcQvtPfXLw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ec790b902bso1468178e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685706575; x=1688298575;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0e2kTAxpyGwta5efoRPZW8NlgUhggCRfdYJlDSsPPM=;
        b=fvDQp5w/v+KlSmuwETHWMWG2eVJdsZFdyZFLc+tft6IohSzmJfJBYFSmoube7DlJmr
         kIusTu88MqABVoSiPLS1OI3XGp6Q7dzxsBj0gpbbLAaay1Sf+XrUASzo/Od208Mkbb7v
         zCRNFIuFPVNTTEANCwn4q8ECkNCVM38DQBk8nym/nTepmf4FFfUstVL/jbdIotSOHkCX
         fTynhodOGil1nuU0llrmfvZClx4fc5JZpq10C55RjFN2tKa7id+XCrrUII2Nv36afQ0t
         0AfhayYk097qfT+3jo2AO7V3ByslW1J0lUVSFWbEAfoderUaLEQ3wOGuYdSQSGy0vwPq
         PG6g==
X-Gm-Message-State: AC+VfDyJRZ/4Yp182WWqLZBrBYUelYB0I5y8qN5Lx8NJAefljRTqZZJL
        SCesXYBON/kFgCBO6HVB8dy9f4W8PcM5Qp/HQJ+b9aRtf6Cp52Aj4D9fVpTU+1dQh1CaTZID5qD
        1B5iGT1xiQsD5OeAsl8U2Sp+Pa/tB6rJH
X-Received: by 2002:a19:7604:0:b0:4f4:b0a1:9956 with SMTP id c4-20020a197604000000b004f4b0a19956mr1694574lff.7.1685706575032;
        Fri, 02 Jun 2023 04:49:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UDcvqzZHCN0YTEHj0DYZvzDW42Cakdi3UEqOx90b/vvVFEBzWpYs9X3BjgHRw9tY6/bgiVg==
X-Received: by 2002:a19:7604:0:b0:4f4:b0a1:9956 with SMTP id c4-20020a197604000000b004f4b0a19956mr1694564lff.7.1685706574694;
        Fri, 02 Jun 2023 04:49:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6786000000b003078cd719ffsm1468096wru.95.2023.06.02.04.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 04:49:34 -0700 (PDT)
Message-ID: <f125f0db-30fe-5452-4669-3e48f7856569@redhat.com>
Date:   Fri, 2 Jun 2023 13:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] mm/memory_hotplug: remove reset_node_managed_pages()
 in hotadd_init_pgdat()
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     osalvador@suse.de, rppt@kernel.org, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230601162626.1030-1-haifeng.xu@shopee.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601162626.1030-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 18:26, Haifeng Xu wrote:
> managed pages has already been set to 0 in free_area_init_core_hotplug(),

"via zone_init_internals() on each zone"

> so it's pointless to reset again.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>   mm/memory_hotplug.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..65e385f34679 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1210,7 +1210,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>   	 * online_pages() and offline_pages().
>   	 * TODO: should be in free_area_init_core_hotplug?
>   	 */
> -	reset_node_managed_pages(pgdat);
>   	reset_node_present_pages(pgdat);
>   
>   	return pgdat;

With that, reset_node_managed_pages() no longer needs to be exposed 
outside of mm/memblock.c

Can you unexport that function as well?

-- 
Thanks,

David / dhildenb

