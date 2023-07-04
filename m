Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6F7478A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGDTXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGDTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6063910E0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688498559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFBR9aLLd+UbaMyLdyzrVxs4N2kaUNBTqCwcKCV+cF4=;
        b=VeHtMiFRKcTN/DX8ybjtpYwEBqu4LSR2/xDJNwV7f2R0hL+cl7quDp6XEUlTwq6RPtOow4
        GUIWh1G/dzyBmFnPLudPaYSXY8pxlXCH+EA6KT3otAepZvZ0IdmswYLsiqnOeJmhnr5ALm
        ujSKGZ8NDCYtzktqg+VjC16WeDd0cO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-bNqzE_xcOrKocHm-YoH1Eg-1; Tue, 04 Jul 2023 15:22:38 -0400
X-MC-Unique: bNqzE_xcOrKocHm-YoH1Eg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C620D800159;
        Tue,  4 Jul 2023 19:22:37 +0000 (UTC)
Received: from [10.39.208.32] (unknown [10.39.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7DDF641E;
        Tue,  4 Jul 2023 19:22:35 +0000 (UTC)
Message-ID: <1f4ac369-75f8-f65d-6f31-9c4a5a2a357f@redhat.com>
Date:   Tue, 4 Jul 2023 21:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] vduse: Temporarily disable control queue features
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20230704164045.39119-1-maxime.coquelin@redhat.com>
 <20230704164045.39119-4-maxime.coquelin@redhat.com>
 <20230704124245-mutt-send-email-mst@kernel.org>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230704124245-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/23 18:43, Michael S. Tsirkin wrote:
> On Tue, Jul 04, 2023 at 06:40:45PM +0200, Maxime Coquelin wrote:
>> Virtio-net driver control queue implementation is not safe
>> when used with VDUSE. If the VDUSE application does not
>> reply to control queue messages, it currently ends up
>> hanging the kernel thread sending this command.
>>
>> Some work is on-going to make the control queue
>> implementation robust with VDUSE. Until it is completed,
>> let's disable control virtqueue and features that depend on
>> it.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>   drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> index 1271c9796517..04367a53802b 100644
>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> @@ -1778,6 +1778,25 @@ static struct attribute *vduse_dev_attrs[] = {
>>   
>>   ATTRIBUTE_GROUPS(vduse_dev);
>>   
>> +static void vduse_dev_features_fixup(struct vduse_dev_config *config)
>> +{
>> +	if (config->device_id == VIRTIO_ID_NET) {
>> +		/*
>> +		 * Temporarily disable control virtqueue and features that
>> +		 * depend on it while CVQ is being made more robust for VDUSE.
>> +		 */
>> +		config->features &= ~((1ULL << VIRTIO_NET_F_CTRL_VQ) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_RX) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
>> +				(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
>> +				(1ULL << VIRTIO_NET_F_MQ) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
>> +				(1ULL << VIRTIO_NET_F_RSS) |
>> +				(1ULL << VIRTIO_NET_F_HASH_REPORT) |
>> +				(1ULL << VIRTIO_NET_F_NOTF_COAL));
>> +	}
>> +}
>> +
> 
> 
> This will never be exhaustive, we are adding new features.
> Please add an allowlist with just legal ones instead.

Ok, got it!
I'll post a new revision.

Thanks,
Maxime

> 
> 
>>   static int vduse_create_dev(struct vduse_dev_config *config,
>>   			    void *config_buf, u64 api_version)
>>   {
>> @@ -1793,6 +1812,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>>   	if (!dev)
>>   		goto err;
>>   
>> +	vduse_dev_features_fixup(config);
>> +
>>   	dev->api_version = api_version;
>>   	dev->device_features = config->features;
>>   	dev->device_id = config->device_id;
>> -- 
>> 2.41.0
> 

