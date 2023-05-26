Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC464712AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjEZQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjEZQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B7DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685119579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15hzoN1grDfhUpQizKd1JzLnEjMUd9UXGO5wVqE9Ya8=;
        b=buTYW36R81B+8NP3ZqBXB+jw6W9K9AstPJj5A4eEnLEyLUhYH8X0NGPHkGIgiervB6NCYd
        6SN2TTIaMt2dtZGirjqLkRPIiqzyfDXq9+8NsybxjHMwnqmsYNHZl6MulC8ZkSsfVxPsWn
        QWTNuL3h9nJO81i6mDm1ZrYZLraUnRg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-kCWLTbx6M6emalZSFKRk3w-1; Fri, 26 May 2023 12:46:18 -0400
X-MC-Unique: kCWLTbx6M6emalZSFKRk3w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30ac89cc4faso587035f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119577; x=1687711577;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15hzoN1grDfhUpQizKd1JzLnEjMUd9UXGO5wVqE9Ya8=;
        b=L8ARuuNhM8a3YT1ST/cs038bWYhP8Ifof27leEup3vSXTrwZyljNRXj1/TpOOr2wau
         FYss3Z2Fp6M8A/eLIA5aAO33A6BjSn964mxmv3in65J95Vh3WAoPJr1RUqSQqhT2riia
         uydjguaoY8Sd90+sPIoYSFMSoBu+HLU6ZMgJPfb3Nd6jxabQOksYEHrav0olcwKbxGie
         UocEKc5UhodRSnD5scYQ/qmylP25r0QO8XZ5gB1MSLXu77aJtE/HT/DcGXfPSJm5iC7p
         Fz2kFX8Zq0nH+BFySXxC6+D0qopbq8O4P4Smw75zVztuA7BeD/Zaduo/JwqvzF/3iSQU
         L4wg==
X-Gm-Message-State: AC+VfDyHeNIokl5vEj1ZyCL6++VrJ6yg7F8A42YwiXJh3YCjqsVmTDZb
        m4yW1fUzeC7aqnpJuwlMq6ocmwzIOBuV+GINyF4MsxbiqIG4t+0MKpn9EK90WvEZe0jJsg9/fkD
        alB9qD9xHQjXIY5tAgAPulJ2KITDgQBVs
X-Received: by 2002:a5d:6e53:0:b0:30a:3ae0:f455 with SMTP id j19-20020a5d6e53000000b0030a3ae0f455mr1989815wrz.2.1685119576893;
        Fri, 26 May 2023 09:46:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kcRipuP320lWaCy4ny+PW8DKtULjLxKrNnDpClSlTBkygY/JXSFoIljwXwyg6UTRZw+hEew==
X-Received: by 2002:a5d:6e53:0:b0:30a:3ae0:f455 with SMTP id j19-20020a5d6e53000000b0030a3ae0f455mr1989795wrz.2.1685119576490;
        Fri, 26 May 2023 09:46:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id r14-20020adfce8e000000b00307925ff35bsm5571809wrn.49.2023.05.26.09.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 09:46:16 -0700 (PDT)
Message-ID: <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
Date:   Fri, 26 May 2023 18:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
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

On 26.05.23 18:44, Matthew Wilcox wrote:
> On Fri, May 26, 2023 at 09:44:34AM -0600, Khalid Aziz wrote:
>>> Oh, I think I found it!  pin_user_pages_remote() is called by
>>> vaddr_get_pfns().  If these are the pages you're concerned about,
>>> then the efficient way to do what you want is simply to call
>>> folio_maybe_dma_pinned().  Far more efficient than the current mess
>>> of total_mapcount().
>>
>> vfio pinned pages triggered this change. Wouldn't checking refcounts against
>> mapcount provide a more generalized way of detecting non-migratable pages?
> 
> Well, you changed the comment to say that we were concerned about
> long-term pins.  If we are, than folio_maybe_dma_pinned() is how to test
> for long-term pins.  If we want to skip pages which are short-term pinned,
> then we need to not change the comment, and keep using mapcount/refcount
> differences.
> 

folio_maybe_dma_pinned() is all about FOLL_PIN, not FOLL_LONGTERM.

folio_maybe_dma_pinned() would skip migrating any page that has more 
than 1024 references. (shared libraries?)

-- 
Thanks,

David / dhildenb

