Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0EA69CF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjBTOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjBTOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203D9EF1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676903899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZooPx0J4FahhlqcFr0VVGzJP8CK2Lifinz64+tcHuxs=;
        b=FmJjSnvqrAMUAk5uUlffMYY+ktnL01a+8f4LUF1L5BIAVg7Bof9WsKyvE4xXY7U7oH+1tW
        PeQ8CeyKXZPhdWs2FZXqBBUg77gZaNulD4u3dTeZr1gAAb0Uwsz4mnz+DvZMdyysGZ6jP3
        /L+3MLXK8MUHg5fNcQPVUf/ZsWqmSlE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-7szl6ezvPNir14LTUYX3nA-1; Mon, 20 Feb 2023 09:38:17 -0500
X-MC-Unique: 7szl6ezvPNir14LTUYX3nA-1
Received: by mail-ed1-f69.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so2015369edh.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZooPx0J4FahhlqcFr0VVGzJP8CK2Lifinz64+tcHuxs=;
        b=eIfPGCbR4e2VHmewRTH091cBP+BnivTwB1HH+Knsu/X7QckPQLmi7YuxzkQ5noeJ4Z
         gEghqcmblfyc7TjD/f/Pf4GI1I+oEbdf6yD0aY6VyNaft+VdhVaPksm+FGtiF1SQkr+P
         6iB5WnelEzR/hXDJ3sWszQqoQ7jzSl/+SauoslH2/1kwyvfiNcMWF/z+319CtMkhxEva
         jMgaEAAGb8cPMNSZ+jyp52VyfQxCpn2p59hJmWQzJQeuZOcVVL11M50bOlRSszZMtfvu
         BehBxBpXeDPiDQLtuAyn1U15nF2E5mBCiQ3knOxQOJdQ9sOJXS6Ct9cR414R9612f6qT
         jYsA==
X-Gm-Message-State: AO0yUKW1kKUVZJ9uzwR2oKGZcdxcbJerkK6gPSBkjVXkO/nEXbMPCvGB
        E9SC3CqKdEUqGkILuo0az5sio27PdRpfdZbOZGTnJGV4j7ZylceduuE5BsCzbIfyEbuSjRcJmEP
        hq3I1UaOuCjcCG1IJICX9gR8q
X-Received: by 2002:a17:907:c10:b0:87b:da74:d272 with SMTP id ga16-20020a1709070c1000b0087bda74d272mr11177677ejc.45.1676903896717;
        Mon, 20 Feb 2023 06:38:16 -0800 (PST)
X-Google-Smtp-Source: AK7set890fgad0EenmfhXcAtdl+hYlW2r/ANHXfflzV6RWOHKEQ6317uyFhrXsZ5SSZOJN3kSOCx5Q==
X-Received: by 2002:a17:907:c10:b0:87b:da74:d272 with SMTP id ga16-20020a1709070c1000b0087bda74d272mr11177652ejc.45.1676903896465;
        Mon, 20 Feb 2023 06:38:16 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id kj8-20020a170907764800b008c0b8dd4cbdsm3118420ejc.112.2023.02.20.06.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:38:15 -0800 (PST)
Message-ID: <e4244345-962d-1175-6ee3-a55083389437@redhat.com>
Date:   Mon, 20 Feb 2023 14:48:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH drm-next v2 03/16] maple_tree: split up MA_STATE() macro
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        jason@jlekstrand.net, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-4-dakr@redhat.com>
 <Y+/ZW/8WXzrkQnUT@casper.infradead.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y+/ZW/8WXzrkQnUT@casper.infradead.org>
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

On 2/17/23 20:45, Matthew Wilcox wrote:
> On Fri, Feb 17, 2023 at 02:44:09PM +0100, Danilo Krummrich wrote:
>> \#define SAMPLE_ITER(name, __mgr) \
>> 	struct sample_iter name = { \
>> 		.mas = __MA_STATE(&(__mgr)->mt, 0, 0),
> 
> This is usually called MA_STATE_INIT()

Yep, that's better.

> 
>> #define sample_iter_for_each_range(it__, start__, end__) \
>> 	for ((it__).mas.index = start__, (it__).entry = mas_find(&(it__).mas, end__ - 1); \
>> 	     (it__).entry; (it__).entry = mas_find(&(it__).mas, end__ - 1))
> 
> This is a bad iterator design.  It's usually best to do this:
> 
> 	struct sample *sample;
> 	SAMPLE_ITERATOR(si, min);
> 
> 	sample_iter_for_each(&si, sample, max) {
> 		frob(mgr, sample);
> 	}
> 


The reason why I don't set index (and max) within SAMPLE_ITER() is that 
the range to iterate might not yet be known at that time, so I thought 
it could just be set in sample_iter_for_each_range().

However, I see that this might prevail users to assume that it's safe to 
iterate a range based on the same iterator instance multiple times 
though. Instead users should maybe move the tree walk to another 
function once the range is known.

The reason for the payload structure to be part of the iterator is that 
I have two maple trees in the GPUVA manager and hence two different 
payload types. Within the iterator structure they're just within a union 
allowing me to implement the tree walk macro just once rather than twice.

Anyway, I feel like your approach looks cleaner, hence I'll change it.

> I don't mind splitting apart MA_STATE_INIT from MA_STATE, and if you
> do that, we can also use it in VMA_ITERATOR.
> 

