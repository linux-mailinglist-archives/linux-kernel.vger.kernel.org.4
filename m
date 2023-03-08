Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F56B0C76
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCHPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjCHPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D424CA26
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678288745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqMveydNu6XNejp+shWEpKdVrYy02V5i0PEhRKX7Rrc=;
        b=VkMeXOqlFoEL/A4jESsdAc73MCRlfYFwwHDiLVcJGsLLH6rDvRwPKGzfB5sBAqrJ7Lw0a5
        qL145PaJXmyR/lDwB2s0PRILDAjWmTRZXj7xsbGKTXe6wq/9L+SNAxzjWklBLIBFB5ubu+
        xJoLBg8sn+JoKfwDsNe1na8LK7m4Xfs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-WdbQPSoPOz6fjPl_uYc9ZA-1; Wed, 08 Mar 2023 10:18:58 -0500
X-MC-Unique: WdbQPSoPOz6fjPl_uYc9ZA-1
Received: by mail-wr1-f71.google.com with SMTP id l14-20020a5d526e000000b002cd851d79b2so2939521wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288737;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqMveydNu6XNejp+shWEpKdVrYy02V5i0PEhRKX7Rrc=;
        b=Hsw0WKwE9Lx6U5L1qswEkqoikL7QTn7coxPoiAexQv6cy3iYj3U83hFy8YrJ2eKlBY
         utn1OUbt1tBwPGVBlIrqfoYEEBzEGPazNQlio3nvcwnCmYkOQ7KvIZGYVmvKGMrnSjw2
         OVwIwzrmu5R7IBHATCWiiU/Zxg5pLacRlCWmsa5+dQ2X6RTzQu69JGK2yAVCjoLOXua0
         4/x/mi6jJ/CJ82c8uMtK98ntmIFIeSFyHDH5GKYNhZXAhKV8LmAqnOQDYQPDb3hv0yik
         h79R+lDt6FORx823ukysS4lwNuQXamcV+VNgR8X9x2BGz7Nz6I3ND8rYTqsgVOpolYvL
         C3ng==
X-Gm-Message-State: AO0yUKXhfi/2KeDqLT+DmhBiPLfNml6RiCDPVTNDgUEHGCBqd/l+dNBX
        qpNEo5ErTdlw5VCKz38NdTWWRn5yF6dG1Ka5U4SJvd04Dh9ccQUmgwvoJ2wOPNXkZvFopfnek2U
        Mp7GdE4ar5sg7a1Z8JF9lND91
X-Received: by 2002:a5d:4ac6:0:b0:2c5:4ca3:d56c with SMTP id y6-20020a5d4ac6000000b002c54ca3d56cmr16363765wrs.0.1678288737553;
        Wed, 08 Mar 2023 07:18:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+eeUD0ndDLPrfGROs+plKRbr9juDzI5L0SeuXOPDJn6wu4tn5amO/mlEW4MhS+El2M6NvXZw==
X-Received: by 2002:a5d:4ac6:0:b0:2c5:4ca3:d56c with SMTP id y6-20020a5d4ac6000000b002c54ca3d56cmr16363758wrs.0.1678288737334;
        Wed, 08 Mar 2023 07:18:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4e07000000b002c5694aef92sm15528270wrt.21.2023.03.08.07.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:18:56 -0800 (PST)
Message-ID: <59b703ac-9660-a0e5-09f7-c5b69d4f39cb@redhat.com>
Date:   Wed, 8 Mar 2023 16:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] maple_tree: export symbol mas_preallocate()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230302011035.4928-1-dakr@redhat.com>
 <20230302015242.xi3y53okc4skmonn@revolver>
 <9abef101-3a9b-0bdd-7139-ced7d5e28ebe@suse.cz>
 <da65d59e-f918-d7d5-644b-33cc51c2ba6c@redhat.com>
 <20230308144343.GA16259@lst.de>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230308144343.GA16259@lst.de>
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

On 3/8/23 15:43, Christoph Hellwig wrote:
> On Wed, Mar 08, 2023 at 03:34:29PM +0100, Danilo Krummrich wrote:
>> On 3/8/23 11:59, Vlastimil Babka wrote:
>>> On 3/2/23 02:52, Liam R. Howlett wrote:
>>>> Thanks for the patch.  This should indeed be exported.
>>>>
>>>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>>
>>> What uses it? Don't we export only things used by in-kernel modules?
>>
>> mas_preallocate() is part of the maple tree's 'Advanced API'. All other
>> functions of this API are exported already.
>>
>> More specifically, e.g. mas_store_prealloc() is exported which doesn't make
>> a lot of sense without mas_preallocate() being available too.
>>
>> I don't think it is used outside of mm yet, but as a generic tree
>> implementation maple tree is pretty likely to be used in code built as
>> module, e.g. drivers.
> 
> If anyone wants to use they can add the export as needed.
> 

Valid perception, though personally I wouldn't share it in this specific 
case.

Anyway, it's just that all other functions of the 'Advanced API' are 
exported already without them having other users than mm either, e.g. 
mas_store_prealloc() can't be used without mas_preallocate(), hence 
exporting one, but not the other doesn't really make sense.

Consistency wise I think we should either also export mas_preallocate() 
or don't export the other ones either.

