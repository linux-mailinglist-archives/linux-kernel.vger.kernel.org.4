Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424826E0C56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDMLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDMLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05D4220
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681384746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XuDaODPg28/lbKls3iVZv9/j3tAy7pEuJB1+NArX0sI=;
        b=BMHy6mnjcXbL3NGCq/5qM3p4v9RH90UHNCpIE/pI1zOvDSf+C2rwcqvOK/MLJPq3HE/8oE
        qMlRDIrYEJf4S7qecyGiVNC9QgIFV3JwgN67YVmx/Z9pR/QfP7AabZDSfhGMQltsQ2ThX6
        GbJ9n2euOfqeyxXqXEy+0LN/taM96P4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-yWnYA_8XNf-g_j_j6hhcGg-1; Thu, 13 Apr 2023 07:19:05 -0400
X-MC-Unique: yWnYA_8XNf-g_j_j6hhcGg-1
Received: by mail-wr1-f70.google.com with SMTP id j6-20020adfa546000000b002d58b4b7698so2510699wrb.19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384744; x=1683976744;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuDaODPg28/lbKls3iVZv9/j3tAy7pEuJB1+NArX0sI=;
        b=R1Fmwy53RuAFVINsKBNVrtBibzg6W+sbeVz9ZsXe7D1RvCeSjucs5NIqnEthPc6BW3
         7W2/jYYxBLMx2Cjd7t41uH8CxgxWJY50QpbyndDpLQ1mMi8szukIG+KfqExU4ZLMCIxl
         uZtO0ByNf9b6t1fG1mAPSbqR1GdDjgd0f+WTFnj/yfhYjJjV+0catEbVnJYIZPGU67s4
         +QRckSOL19HhNkOMBtKQMF0rQN9x1vNygkDDmm1fWymZEDgr94V0eh+rwol/5i5ZO92O
         OPV8uE4kwkUHlLhtzHBbBAZlksCSWi+wKbgTFugs+WXG7pfUY+ayy2jp+RqF/rdUjN70
         z9Yg==
X-Gm-Message-State: AAQBX9c4f2n+iDt7kdth99B1Ir/V2yVyXHtQetokFwV+sMK5I0YCFKq1
        7XG3yqhooy6Kc8aDQQCzc7LK6aPWK4VZC5mZtZmA+C/4eXlXURR4/meQ9IfiFBK+8ywUULd9jba
        GRJ2UU0qDdv3rBj8eXLvIIrjK
X-Received: by 2002:a7b:ca4c:0:b0:3f0:7147:2ecd with SMTP id m12-20020a7bca4c000000b003f071472ecdmr1571275wml.7.1681384744360;
        Thu, 13 Apr 2023 04:19:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350bLB2veUASI4/m+qmmFnnoaJ0DjGho2eJAioBtjyEBuvdQ48H1Q2Wt23LlVt3082GLF+6fzbQ==
X-Received: by 2002:a7b:ca4c:0:b0:3f0:7147:2ecd with SMTP id m12-20020a7bca4c000000b003f071472ecdmr1571251wml.7.1681384743997;
        Thu, 13 Apr 2023 04:19:03 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b003ee9c8cc631sm5196264wmb.23.2023.04.13.04.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:19:03 -0700 (PDT)
Message-ID: <bb42720b-dec9-a62b-50a2-422ddd6a1920@redhat.com>
Date:   Thu, 13 Apr 2023 13:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 2/3] mm: vmscan: move set_task_reclaim_state() near
 flush_reclaim_state()
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-3-yosryahmed@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413104034.1086717-3-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.23 12:40, Yosry Ahmed wrote:
> Move set_task_reclaim_state() near flush_reclaim_state() so that all
> helpers manipulating reclaim_state are in close proximity.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---

Hm, it's rather a simple helper to set the reclaim_state for a task, not 
to modify it.

No strong opinion, but I'd just leave it as it.

-- 
Thanks,

David / dhildenb

