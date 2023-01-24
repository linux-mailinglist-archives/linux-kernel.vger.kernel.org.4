Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E86791CB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjAXHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjAXHU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1B11158
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674544778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7q3iqRUHEdMbAtpmNI/eVbLbK/lHpmY+A3ZIsty8k9o=;
        b=LlTe2KNQMvklWNjmXA8cFquCIlDGX52rfRAReceQ6HiQlKpIO45EcDWRbQIVZSC+d8PwFw
        kZI3cLAdIwV9sEdwqOYsZlyOte5445BD8Ubt4qmnbgMjZYWAZv6xUHmWjX9lMsHLOxCIpS
        hbS6JzeY5NVDD6aZ74ssfEmK4+AzCAM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-i0wpv2poPVaHAmgNHu3I3g-1; Tue, 24 Jan 2023 02:19:36 -0500
X-MC-Unique: i0wpv2poPVaHAmgNHu3I3g-1
Received: by mail-qv1-f71.google.com with SMTP id c10-20020a05621401ea00b004c72d0e92bcso7161994qvu.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q3iqRUHEdMbAtpmNI/eVbLbK/lHpmY+A3ZIsty8k9o=;
        b=phkADdwBc98soLxRocyLKGY4fGwgq4NtHloflhUgPK2gylEg8JdqVCmHntt44qseAW
         2MbhCC3QmI+ryvU48EfNPe9hJrd4w3Y+zD0JN3hIiA8ZguT9wK4PJjvz9YiQdAikSSsk
         ZQY+6qVJhlojl6O19THIdC60LSHD3wLZmZO5yiXNackE+a5WzFu3QjTkrk5fFUq+S0pK
         3NVA1v6+IZCc3J78qelYeSg+kH5IVpoTI/KCefGFVbUo/Cye6T1sophXlOSV/Bhzu4JY
         6f0Xj0amdw9WOrHMjPjhzkSktidrqvrCAZRmbUIkSbVjTYJiJjd9WlwmpNaqvIwpCp9H
         RzCQ==
X-Gm-Message-State: AFqh2kqK4sxfDTbaDBeSdnrp4wMyQSzBY4dKO2pgaXSW6FWWjGocWVnZ
        UjL/iZJQjK5MmExta/gu9sHiz1RYxmELUzS8TVeKeFA/RoVeRDyHlMcDuDqCDQ9z9nIwFGUhP6q
        TDAfCig0N2S94uhT0zsNzkagy
X-Received: by 2002:a05:622a:4897:b0:3ab:a3d9:c5c8 with SMTP id fc23-20020a05622a489700b003aba3d9c5c8mr45612918qtb.3.1674544775623;
        Mon, 23 Jan 2023 23:19:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuN2ZdpfTVek/pkskSHS//zZArD9nCjkHIXPrwJoZbwBa9jqTPDSAuz+JqMDr1JkvokbWw8uA==
X-Received: by 2002:a05:622a:4897:b0:3ab:a3d9:c5c8 with SMTP id fc23-20020a05622a489700b003aba3d9c5c8mr45612897qtb.3.1674544775412;
        Mon, 23 Jan 2023 23:19:35 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
        by smtp.gmail.com with ESMTPSA id 72-20020a37074b000000b00706c1fc62desm909030qkh.112.2023.01.23.23.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:19:34 -0800 (PST)
Message-ID: <3ff50750-de59-dc2b-01a9-1a453e49e26e@redhat.com>
Date:   Tue, 24 Jan 2023 08:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/4] virtio_net: notify MAC address change on device
 initialization
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, Eli Cohen <elic@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Cindy Lu <lulu@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
References: <20230122100526.2302556-1-lvivier@redhat.com>
 <20230122100526.2302556-2-lvivier@redhat.com>
 <07a24753-767b-4e1e-2bcf-21ec04bc044a@nvidia.com>
 <20230123193114.56aaec3a@kernel.org>
From:   Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230123193114.56aaec3a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 04:31, Jakub Kicinski wrote:
> On Sun, 22 Jan 2023 15:47:08 +0200 Eli Cohen wrote:
>>> @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>    	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>>>    		 dev->name, max_queue_pairs);
>>>    
>>> +	/* a random MAC address has been assigned, notify the device */
>>> +	if (dev->addr_assign_type == NET_ADDR_RANDOM &&
>> Maybe it's better to not count on addr_assign_type and use a local
>> variable to indicate that virtnet_probe assigned random MAC.
> 
> +1, FWIW
> 
v2 sent, but I rely on virtio_has_feature(vdev, VIRTIO_NET_F_MAC) to know if the MAC 
address is provided by the device or not:

https://lore.kernel.org/lkml/20230123120022.2364889-2-lvivier@redhat.com/T/#me9211516e12771001e0346818255c9fb48a2bf4a

Thanks,
Laurent

