Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001AF6B0B54
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjCHOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjCHOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24573B4221
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678286074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTHYKj0ENiayYQrvquAcd+pJGNNUwvGn3+gkRMCFauE=;
        b=a+xkSXNMi2Hzn4kNyrbR++ZPx7tM7F8FQywVUcM/8J9VXt2R+8TwhsDBr0W+qNvql3VTJx
        77EtMyPPSLvxFkSSXeYEPslMO3aXa637t56IT9l83mmuMnxr5ikXKdDhl2pXVxw+wY3aIF
        qKa2BhVIdFnvNGugPUAfLgzdkgXbGfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-xBB5l-pNPrCdjSe29go_PA-1; Wed, 08 Mar 2023 09:34:32 -0500
X-MC-Unique: xBB5l-pNPrCdjSe29go_PA-1
Received: by mail-wm1-f72.google.com with SMTP id az39-20020a05600c602700b003e97eb80524so1029317wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286071;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTHYKj0ENiayYQrvquAcd+pJGNNUwvGn3+gkRMCFauE=;
        b=mkE5zDt2xDSxRTW4WRAGMpeCsMRflqHrh+pf2ZxlD+C73Vfxy/onUrFi9kWheskPtk
         TG0C8PvIJYocDsv4kN/GO9qhLFhSrTqeAa68oSwg9fdKEc0UHUWIHtj5WsNgNXXjv7AG
         PGcviYF72gd8Yjz0M+mxvRiJbn/k7c8ChA06+ALEkxZ9uN6wcUqVg81m8FAdk0bv4lDI
         j5OHfNzI+rwgW9FCnS9V05xuBzlPhLkf5bP0mgE2O98F4Cq1bMVcG0WYXgNtKQ3t2oLZ
         1bpWw+MF/jbNSN80Pz7E635DODWzoEwxy4UTQCY9V8AjTPhbT2fCLgpl4lbYwrUCn1vs
         24CQ==
X-Gm-Message-State: AO0yUKU87YqKhmNL2tnwEthpUC89IBJQQFlkumh90Ng0TbOlgoWIfYlM
        gkx9IvpiR1GLeiq5bt9l6Ve/6GQLXbOZm9vAUwzEanphZRuEVggVQY9kEnvNb4DCoAiTBZ6ZmSB
        ScEuCPXMs0Us+UAKF9x1EM/e2
X-Received: by 2002:a05:600c:a09:b0:3ea:c100:e974 with SMTP id z9-20020a05600c0a0900b003eac100e974mr17395233wmp.26.1678286071800;
        Wed, 08 Mar 2023 06:34:31 -0800 (PST)
X-Google-Smtp-Source: AK7set9D/blJuqN12Fj7TihHQyymDZzJYzQDkbph+1hZqLl9Hnb58NBvT8CIu72bROPuyM0oQPJdeQ==
X-Received: by 2002:a05:600c:a09:b0:3ea:c100:e974 with SMTP id z9-20020a05600c0a0900b003eac100e974mr17395225wmp.26.1678286071556;
        Wed, 08 Mar 2023 06:34:31 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c12cc00b003de2fc8214esm15563649wmd.20.2023.03.08.06.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:34:30 -0800 (PST)
Message-ID: <da65d59e-f918-d7d5-644b-33cc51c2ba6c@redhat.com>
Date:   Wed, 8 Mar 2023 15:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] maple_tree: export symbol mas_preallocate()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <20230302011035.4928-1-dakr@redhat.com>
 <20230302015242.xi3y53okc4skmonn@revolver>
 <9abef101-3a9b-0bdd-7139-ced7d5e28ebe@suse.cz>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <9abef101-3a9b-0bdd-7139-ced7d5e28ebe@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 11:59, Vlastimil Babka wrote:
> On 3/2/23 02:52, Liam R. Howlett wrote:
>> Thanks for the patch.  This should indeed be exported.
>>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> What uses it? Don't we export only things used by in-kernel modules?

mas_preallocate() is part of the maple tree's 'Advanced API'. All other 
functions of this API are exported already.

More specifically, e.g. mas_store_prealloc() is exported which doesn't 
make a lot of sense without mas_preallocate() being available too.

I don't think it is used outside of mm yet, but as a generic tree 
implementation maple tree is pretty likely to be used in code built as 
module, e.g. drivers.

> 
>> * Danilo Krummrich <dakr@redhat.com> [230301 20:10]:
>>> Fix missing EXPORT_SYMBOL_GPL() statement for mas_preallocate().
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>> ---
>>>   lib/maple_tree.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>> index 26e2045d3cda..3bfb8a6f3f6d 100644
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -5733,6 +5733,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>   	mas_reset(mas);
>>>   	return ret;
>>>   }
>>> +EXPORT_SYMBOL_GPL(mas_preallocate);
>>>   
>>>   /*
>>>    * mas_destroy() - destroy a maple state.
>>> -- 
>>> 2.39.2
>>>
>>
> 

