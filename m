Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743546E0C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDMLVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDMLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B4BF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681384863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSfTt/FpZ51XsXOxa366XVa7DCOmNmyBB//s/oWzTsk=;
        b=JDOOxtWbitDg6ieKXAAtF1fKPzvtcwi5u7mhzpeUSH/kuacWvPM1GRBQzKKEHtQUgTdCh3
        /WPG9Fd115PYJOCRVcneUMcynSWcYdlBKtFPlI2zJDftCkf6fEycJ/2OsLZOci3dM0Itce
        iHtzY1nRR3+avE0TUsvBOKTQN4F5QiQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-KAErT1ZVPUWgKEgd6s1j5g-1; Thu, 13 Apr 2023 07:21:02 -0400
X-MC-Unique: KAErT1ZVPUWgKEgd6s1j5g-1
Received: by mail-wm1-f72.google.com with SMTP id hg24-20020a05600c539800b003f066c0b044so10627083wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384861; x=1683976861;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSfTt/FpZ51XsXOxa366XVa7DCOmNmyBB//s/oWzTsk=;
        b=kBLXWDgTYVk4R8yxZkzxifVkElZBfjKY/ws/L4tfEOvDrhJC0Ljv4j3/a/adkTsa5Y
         8N64+8Pw31Sh58nFMIoqAQbq/pnvBZTvbqZOFaU2ZUNMbg4MAXpD1yOi5FNQhJt89lww
         hyPMiVeYLzXPwYX3bjui/I+gFVZBTnk8tnKOGLLy5tAcUNkEe5PdiLqUxYamxUL3ufov
         6m4PFSgfbFJP8yp+YykHh9bxkpedVpbQN6HCQhg43pYZaSn5uHazUDtyB8pOb5aRgON7
         pfexFbqxTw8l61KdQaTW8EUxXQXBxIYkpjwowdoO+xqKdZmpUTQ5XuI6p5fZkNSub2Vd
         /TVQ==
X-Gm-Message-State: AAQBX9csXnhKU+jPO3whvfFNoahJxc/FfoTDwLRDb4Olqv/Nj7pOLqAA
        ePNSq+HkGO0tgdYhIogC4V+of/6Olyq1wNlKK2/Ltmyo1nPIYNO/h7bdMww7Ae+hpijY5US6mlL
        cp5aoYjD0AQQXjU9hqZJVOr/B
X-Received: by 2002:a5d:4748:0:b0:2f4:bc68:3493 with SMTP id o8-20020a5d4748000000b002f4bc683493mr1179301wrs.34.1681384861481;
        Thu, 13 Apr 2023 04:21:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350aqjI6Q+vFzM2qin74WRIRynSqW3dUlzZ+lzWRnT/FaK8OWoaXuG4EWNsNhSjPY7wORElSWBA==
X-Received: by 2002:a5d:4748:0:b0:2f4:bc68:3493 with SMTP id o8-20020a5d4748000000b002f4bc683493mr1179271wrs.34.1681384861121;
        Thu, 13 Apr 2023 04:21:01 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f4-20020adff584000000b002f008477522sm1086917wro.24.2023.04.13.04.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:21:00 -0700 (PDT)
Message-ID: <b7fe839d-d914-80f7-6b96-f5f3a9d0c9b0@redhat.com>
Date:   Thu, 13 Apr 2023 13:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 3/3] mm: vmscan: refactor updating
 current->reclaim_state
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
 <20230413104034.1086717-4-yosryahmed@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413104034.1086717-4-yosryahmed@google.com>
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
> During reclaim, we keep track of pages reclaimed from other means than
> LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> which we stash a pointer to in current task_struct.
> 
> However, we keep track of more than just reclaimed slab pages through
> this. We also use it for clean file pages dropped through pruned inodes,
> and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add

Would "reclaimed_non_lru" be more expressive? Then,

mm_account_reclaimed_pages() -> mm_account_non_lru_reclaimed_pages()


Apart from that LGTM.

-- 
Thanks,

David / dhildenb

