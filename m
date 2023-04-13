Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3E6E0E05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDMNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDMNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D756A42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681391154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wSVcYYxYpVN5DF7FLqIuRd52scPCmKkAnh64SyS2hM=;
        b=ds6qASWYJq82RM16MwwWrSEV2oMQ1MffwuTiHPqDUWvVCZ5nx1HMD2Kpfrz1HTY7aYlwLd
        B0A6XXZ20tyKP5yw4wUKDtiKuefdp/Eyd+6ZhfwvelTEaWKvINTkYfXE3RvZQJnE3SHuUR
        tiRBMrFFqcWbKBEOlgElvDSeZ2iq+m4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-4hBr1V99Nc-apSJvZIMxTQ-1; Thu, 13 Apr 2023 09:05:52 -0400
X-MC-Unique: 4hBr1V99Nc-apSJvZIMxTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED09485C6E3;
        Thu, 13 Apr 2023 13:05:51 +0000 (UTC)
Received: from [10.39.208.7] (unknown [10.39.208.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91A8C7D283;
        Thu, 13 Apr 2023 13:05:49 +0000 (UTC)
Message-ID: <12865759-344a-9111-0ceb-6a31ac510426@redhat.com>
Date:   Thu, 13 Apr 2023 15:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next V2 0/2] virtio-net: don't busy poll for cvq
 command
Content-Language: en-US
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        david.marchand@redhat.com
References: <20230413064027.13267-1-jasowang@redhat.com>
 <f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.com>
In-Reply-To: <f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/23 15:02, Maxime Coquelin wrote:
> Hi Jason,
> 
> On 4/13/23 08:40, Jason Wang wrote:
>> Hi all:
>>
>> The code used to busy poll for cvq command which turns out to have
>> several side effects:
>>
>> 1) infinite poll for buggy devices
>> 2) bad interaction with scheduler
>>
>> So this series tries to use sleep instead of busy polling. In this
>> version, I take a step back: the hardening part is not implemented and
>> leave for future investigation. We use to aggree to use interruptible
>> sleep but it doesn't work for a general workqueue.
>>
>> Please review.
> 
> Thanks for working on this.
> My DPDK VDUSE RFC missed to set the interrupt, as Xuan Zhou highlighted
> it makes the vdpa dev add/del commands to freeze:
> [<0>] device_del+0x37/0x3d0
> [<0>] device_unregister+0x13/0x60
> [<0>] unregister_virtio_device+0x11/0x20
> [<0>] device_release_driver_internal+0x193/0x200
> [<0>] bus_remove_device+0xbf/0x130
> [<0>] device_del+0x174/0x3d0
> [<0>] device_unregister+0x13/0x60
> [<0>] vdpa_nl_cmd_dev_del_set_doit+0x66/0xe0 [vdpa]
> [<0>] genl_family_rcv_msg_doit.isra.0+0xb8/0x100
> [<0>] genl_rcv_msg+0x151/0x290
> [<0>] netlink_rcv_skb+0x54/0x100
> [<0>] genl_rcv+0x24/0x40
> [<0>] netlink_unicast+0x217/0x340
> [<0>] netlink_sendmsg+0x23e/0x4a0
> [<0>] sock_sendmsg+0x8f/0xa0
> [<0>] __sys_sendto+0xfc/0x170
> [<0>] __x64_sys_sendto+0x20/0x30
> [<0>] do_syscall_64+0x59/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Once fixed on DPDK side (you can use my vduse_v1 branch [0] for
> testing), it works fine:
> 
> Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> For the potential missing interrupt with non-compliant devices, I guess
> it could be handled with the hardening work as same thing could happen
> if the VDUSE application crashed for example.
> 
> Regards,
> Maxime
> 
> [0]:

Better with the link...

[0]: https://gitlab.com/mcoquelin/dpdk-next-virtio/-/commits/vduse_v1/

>> Thanks
>>
>> Changes since V1:
>> - use RTNL to synchronize rx mode worker
>> - use completion for simplicity
>> - don't try to harden CVQ command
>>
>> Changes since RFC:
>>
>> - switch to use BAD_RING in virtio_break_device()
>> - check virtqueue_is_broken() after being woken up
>> - use more_used() instead of virtqueue_get_buf() to allow caller to
>>    get buffers afterwards
>>    - break the virtio-net device when timeout
>>    - get buffer manually since the virtio core check more_used() instead
>>
>> Jason Wang (2):
>>    virtio-net: convert rx mode setting to use workqueue
>>    virtio-net: sleep instead of busy waiting for cvq command
>>
>>   drivers/net/virtio_net.c | 76 ++++++++++++++++++++++++++++++++++------
>>   1 file changed, 66 insertions(+), 10 deletions(-)
>>

