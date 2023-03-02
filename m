Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832356A83EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCBOC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCBOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37330EB5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677765697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X853Jg3cnR4uj49XXzsgp4yTPwwc+lfJj/lENOT9FE0=;
        b=R3ZEhrJA5qzzCI7KBqpkCsba2bAhFfanbjDNEZ0qQxnPZgKZK0sbbrEVd9kYFaoe9QnDJk
        q+5QLxdE0TmgWFuBW6iWFRCOa8tTPuvYx31KLm+9gR0Wa4Ncl0GV7rbJB6gJx7vT73ros5
        bY3xdZ6AnfaiVyxNbs+jhFrBMLMWfgI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-WmV29igcOtiEn5Ya6kX2XQ-1; Thu, 02 Mar 2023 09:01:30 -0500
X-MC-Unique: WmV29igcOtiEn5Ya6kX2XQ-1
Received: by mail-wm1-f71.google.com with SMTP id r7-20020a05600c35c700b003eb3f2c4fb4so1123196wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X853Jg3cnR4uj49XXzsgp4yTPwwc+lfJj/lENOT9FE0=;
        b=PPcUUBdY8UuY/UPjp/QXyq9iau/VaF4SEDhn0P6dSD4Gbis6FDxL+B5zFW+AbqAJ5D
         NsMfYdjBBicMT2e1ToQoOZDwvnp/zkeG0FF9/v6Jur+LZ/qlBVULp72Vf0czZT+iJ0MU
         W8LjA/F9F8syoaRsaHJooyPnmHVYj3Evc5rJ5vP1t8lj0xKBMZ5SObpvNdQgAtWOan0t
         B90Vzzu0LAUj9wB2Fv9bX2MHCgEsu9AruWRH5/BuTioqx4qanbCXkghaQReiZZ/BFGHB
         HI07jkr5SiEUluebGe6OTgqmLYRy0XLAvXttAbnpvqDEiidQoRar6LHRxMc6ABtqm+Ls
         mrNA==
X-Gm-Message-State: AO0yUKWFTsSemrqckUda3IZDhbn7n+XlqVX2C3jN5EAgrdGVI3qq5Zns
        4IRjRPByKeJ24z4Eo4mNpMtAlDx35NBqvvi139BqGbURmeYjSlAB5STCOMZv3CYLqCyBhqxCZA/
        gDvIe4bJGLmeu81JhuBBFX1hk
X-Received: by 2002:a5d:6ac4:0:b0:2c7:1d70:561 with SMTP id u4-20020a5d6ac4000000b002c71d700561mr7379550wrw.45.1677765688802;
        Thu, 02 Mar 2023 06:01:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/2Wx2szV1QS3+CwX3F47nzraKBbC+iHmfJSmogaJrsx8GaNXcHjv+xuPmWHssxbfzuGkG4FA==
X-Received: by 2002:a5d:6ac4:0:b0:2c7:1d70:561 with SMTP id u4-20020a5d6ac4000000b002c71d700561mr7379525wrw.45.1677765688446;
        Thu, 02 Mar 2023 06:01:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b002c54c9bd71fsm15760107wro.93.2023.03.02.06.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 06:01:27 -0800 (PST)
Message-ID: <982c1623-ac28-2743-d6a3-4faf42f72d47@redhat.com>
Date:   Thu, 2 Mar 2023 15:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n> <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n> <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
 <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com> <Y/9tA2EVglOJ0Ap1@x1n>
 <fc95fd2c-d661-926c-3bdb-8709cb49de3b@collabora.com>
 <8783f47e-76ea-cd24-e373-f2156884cd05@redhat.com> <ZACrOWKWdVYO/EAI@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZACrOWKWdVYO/EAI@x1n>
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

On 02.03.23 14:57, Peter Xu wrote:
> On Thu, Mar 02, 2023 at 10:37:44AM +0100, David Hildenbrand wrote:
>> Especially for such large sparse VMAs, the current way of allocating
>> pagetables to place markers/zeropages is far from optimal.
> 
> IMHO that's not a generic workload.  As mentioned in the reply there, I
> would suggest we go with simple then we have space to optimize it in the
> future if necessary, because the API will be the same.
> 

I disagree with "generic workload", we use sparse mmaps all over the 
place, and when blindly used by e.g., CRIU, we'll simply end up wasting 
memory and time.

But I already agreed that this optimization that is a separate thing to 
implement.

-- 
Thanks,

David / dhildenb

