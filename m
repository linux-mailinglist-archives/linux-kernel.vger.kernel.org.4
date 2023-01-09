Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEE662449
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbjAILgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbjAILgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163D18E2B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673264122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpEBm03GdEu7pr5mXkVVNIA5JjlbFFPvXuYilU99v3Q=;
        b=UMVHZPxPrsJCbz7JO3u87Tv4gwkNnwIiEknGK9gtjjCFpPN1G/ecdO7ol15T5ZMa067/SZ
        HaPzI7rloZdGfOy6Vg2OcK+83pTxPHVaAGT4enR1UaUqgySMcMckNPXNY4c/Xtq79jtTgF
        Ii1R7X/ySPmNegnS5knhSIoA/6Ry1s4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-u3VhgMHmMtSPRNblbXh0ZQ-1; Mon, 09 Jan 2023 06:35:21 -0500
X-MC-Unique: u3VhgMHmMtSPRNblbXh0ZQ-1
Received: by mail-pg1-f199.google.com with SMTP id g32-20020a635660000000b00478c21b8095so3545324pgm.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpEBm03GdEu7pr5mXkVVNIA5JjlbFFPvXuYilU99v3Q=;
        b=pOgkaWFLqw+UT19mMjNRkPy5kws48FIAw92rJp52oH1yqTUBrf7xbGnysDCKtePsd0
         czaqEe41kFvt3Dy3B2O9zyaW5/y9wnwjLL5/bN4nokPI2aB0BkVOWBVMQlu60w59iaPf
         xo0zY7XDBh3Hrolt53NL9YNBF/+0cXjOnUtCHztxulrzW5klscpSeWG8iqYNUNHMLGbO
         nTLFVWQElcyFcr7ISQ1TID8q0fU9jtKeXEL16KHm/qMU4VTiXVQLzYwzTU3ACU3q2Ogq
         YhO3CJ7tScQady1+4+b7UXV8vrsC1YfEmFOSpZVVI1L21dd5XSCnRSznqA80mublGQdV
         zFow==
X-Gm-Message-State: AFqh2kqmpm3K03h2EU8sR+mPc6bNowhbeSPD1kBqTqkqJsjLgeeIDa19
        SwVzVmfg80Kkbkz1DZdSJ0aSwgxUCxAOl8J+h8CMmUGOYTsTPQS46RgRoSeqYCV8Rd/usMN0y4z
        cSVFfCHISNMM6Bd8NSIZOSG4j
X-Received: by 2002:a17:903:2341:b0:192:5e53:15f3 with SMTP id c1-20020a170903234100b001925e5315f3mr86887071plh.48.1673264120072;
        Mon, 09 Jan 2023 03:35:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsPab4Pvw2BslAilX4Y9tDoSZq+7jkg+ZkEM1xBntD65o5ZDnZDYwzMUhtc4el7KFSVwOpO3A==
X-Received: by 2002:a17:903:2341:b0:192:5e53:15f3 with SMTP id c1-20020a170903234100b001925e5315f3mr86887051plh.48.1673264119792;
        Mon, 09 Jan 2023 03:35:19 -0800 (PST)
Received: from [10.72.12.50] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902c40b00b001894198d0ebsm5953735plk.24.2023.01.09.03.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 03:35:19 -0800 (PST)
Message-ID: <96a670f1-a4ae-e07a-d630-7fcfcda86917@redhat.com>
Date:   Mon, 9 Jan 2023 19:35:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] add folio_headpage() macro
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230106174028.151384-1-sj@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230106174028.151384-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I didn't see the [1/3] and [2/3] patches in my inbox, it seems you 
didn't CCed the ceph-devel@ mail list.

Thanks

On 07/01/2023 01:40, SeongJae Park wrote:
> The standard idiom for getting head page of a given folio is
> '&folio->page'.  It is efficient and safe even if the folio is NULL,
> because the offset of page field in folio is zero.  However, it makes
> the code not that easy to understand at the first glance, especially the
> NULL safety.  Also, sometimes people forget the idiom and use
> 'folio_page(folio, 0)' instead.  To make it easier to read and remember,
> add a new macro function called 'folio_headpage()' with the NULL case
> explanation.  Then, replace the 'folio_page(folio, 0)' calls with
> 'folio_headpage(folio)'.
>
>
> SeongJae Park (3):
>    include/linux/page-flags: add folio_headpage()
>    mm: use folio_headpage() instead of folio_page()
>    fs/ceph/addr: use folio_headpage() instead of folio_page()
>
>   fs/ceph/addr.c             | 2 +-
>   include/linux/page-flags.h | 8 ++++++++
>   mm/shmem.c                 | 4 ++--
>   mm/slab.c                  | 6 +++---
>   mm/slab_common.c           | 4 ++--
>   mm/slub.c                  | 4 ++--
>   6 files changed, 18 insertions(+), 10 deletions(-)
>
-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

