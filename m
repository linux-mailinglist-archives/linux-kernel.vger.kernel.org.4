Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B378869CFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBTOuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBTOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFE1C5A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676904599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14aOzXv8/LFbctYEfZwWWmrtrURJsidYi3oSxaFz0Xw=;
        b=dJjDqq9nQeGAtaGn/elYkQbmnBvbpDrw1X7OUQKTwZJiInENZvjZL7V6TNiYkReuUVKEke
        jEIs0SlRZs6jw+u9iaUVHv5n1YXXE+Dvs2XO2xRpBTw8inIndPCUmBwJr0tHyIZuvT4dPL
        cJjzlCdhSvyT2EWuuBRziSY2o+9udfc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-315-sMuYcFrLOzOxxaZrgI4i4Q-1; Mon, 20 Feb 2023 09:49:58 -0500
X-MC-Unique: sMuYcFrLOzOxxaZrgI4i4Q-1
Received: by mail-ed1-f72.google.com with SMTP id b1-20020aa7dc01000000b004ad062fee5eso1946263edu.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14aOzXv8/LFbctYEfZwWWmrtrURJsidYi3oSxaFz0Xw=;
        b=UQwQtKfZM8Gltn1jzXXoXY6XaoOwLL0GcK8o3wqmfKfO/LCQpSG3q+jTYB7nvcjbhy
         fISAovoBnhstiOrpGgFrmOqtESjbFrA+zhKDXU5zjcpfO+CybRuiJ5lhJjrFt30Tft+n
         1LAZRfeR84HwaLBXHuLEegPheF/gCznCVKzFsUXWtU49N/VH1LTAazFTD45h/45DKsfg
         G/gcqVo3qXCa1mUuNH/86Sb3BwcsnEbvqd8pR35YSgOC3P3T9Ng1QKPD9eftBH4zEXK1
         yC++opSKqRLaudtigg8TSwcD0QwfMUJVg8edkqnOMttJJXfILPrcnptbw1tTPo0HPuVl
         J8cA==
X-Gm-Message-State: AO0yUKXqy5stmv6vQlxfcBvMN4LzBcMAr+9/LO/0jOBkp6xUKbQzt2sS
        UK1FTh3XL830uq8wu/r85ASiOmDe+txn8nfE9Ylu/6bjuZSqTAdDX4B7OMPHiPK91CEf541HjBK
        fX1Hu5uaKgPhI+whMuJP6yFjF
X-Received: by 2002:a17:906:c451:b0:88b:4962:b72f with SMTP id ck17-20020a170906c45100b0088b4962b72fmr7384953ejb.20.1676904597384;
        Mon, 20 Feb 2023 06:49:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+98u/y2Cal3np2ksbwfkOOCjcq6rtCsH8aYGEsMo5bVtK+OVJWU6UbYetsNggJNxfOhh/MAw==
X-Received: by 2002:a17:906:c451:b0:88b:4962:b72f with SMTP id ck17-20020a170906c45100b0088b4962b72fmr7384942ejb.20.1676904597149;
        Mon, 20 Feb 2023 06:49:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id jr14-20020a170906a98e00b008af574fbfc2sm5934451ejb.33.2023.02.20.06.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:49:56 -0800 (PST)
Message-ID: <3bb02ec3-4d19-9135-cabc-26ed210f7396@redhat.com>
Date:   Mon, 20 Feb 2023 15:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH drm-next v2 04/16] maple_tree: add flag MT_FLAGS_LOCK_NONE
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
        corbet@lwn.net, nouveau@lists.freedesktop.org, ogabbay@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, boris.brezillon@collabora.com,
        bskeggs@redhat.com, tzimmermann@suse.de, Liam.Howlett@oracle.com,
        bagasdotme@gmail.com, christian.koenig@amd.com,
        jason@jlekstrand.net
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-5-dakr@redhat.com>
 <Y+/Xn11dfdn7SfBD@casper.infradead.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y+/Xn11dfdn7SfBD@casper.infradead.org>
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

On 2/17/23 20:38, Matthew Wilcox wrote:
> On Fri, Feb 17, 2023 at 02:44:10PM +0100, Danilo Krummrich wrote:
>> Generic components making use of the maple tree (such as the
>> DRM GPUVA Manager) delegate the responsibility of ensuring mutual
>> exclusion to their users.
>>
>> While such components could inherit the concept of an external lock,
>> some users might just serialize the access to the component and hence to
>> the internal maple tree.
>>
>> In order to allow such use cases, add a new flag MT_FLAGS_LOCK_NONE to
>> indicate not to do any internal lockdep checks.
> 
> I'm really against this change.
> 
> First, we really should check that users have their locking right.
> It's bitten us so many times when they get it wrong.

In case of the DRM GPUVA manager, some users might serialize the access 
to the GPUVA manager and hence to it's maple tree instances, e.g. 
through the drm_gpu_scheduler. In such a case ensuring to hold a lock 
would be a bit pointless and I wouldn't really know how to "sell" this 
to potential users of the GPUVA manager.

> 
> Second, having a lock allows us to defragment the slab cache.  The
> patches to do that haven't gone anywhere recently, but if we drop the
> requirement now, we'll never be able to compact ranges of memory that
> have slabs allocated to them.
> 

Not sure if I get that, do you mind explaining a bit how this would 
affect other users of the maple tree, such as my use case, the GPUVA 
manager?

