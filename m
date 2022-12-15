Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0D64D7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLOIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLOIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5B20BE1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671093052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQftxKjFR81WRUC766VxI4Sfi85jP5put0rR4SH+wzs=;
        b=bvQUj6Qz8ErnJwgJOMKH+kuvMlpwRiGlb3cXN+WMeN2HSXLl+8fHJceGt7s6wdclEiFlTB
        XCtoVVgsHTAzXox3S/X3/7dMsob/yToTej+HBQF4Ga+zHsktj29zfqJucDqBCvZbsxCKHi
        AQQQBuHMsiqxINj+w8wszvqirwszpoM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-63-3_UN9IpMORWokRQtNndf9w-1; Thu, 15 Dec 2022 03:30:50 -0500
X-MC-Unique: 3_UN9IpMORWokRQtNndf9w-1
Received: by mail-ed1-f70.google.com with SMTP id j11-20020aa7c40b000000b0046b45e2ff83so11232077edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQftxKjFR81WRUC766VxI4Sfi85jP5put0rR4SH+wzs=;
        b=mvNH84FrABExyiK1rvfZMRH161IOh9tHAS/sZXdw4rWIl9gCfUmyFSvBxQyai9DGn6
         IJEv0Tv3bSjpiOZZaNWN9AkPciTsd+Tmf0N8SUYXXVFlV9AfuJguEZKg6anEh0C65oLr
         p/QT6F4xLYXWUM+5HgXfJimh5hHgjg0nxcafLbX+s/9goooa5aZFtAA8G03XPXrahW7x
         zclB5ghJnlESsRDwYxSVvgArCljGwcoHWa4VY+6Vj/8nWRLnyys72+SBR60DvnBAL6Pb
         TAZuIzLD5QCmmxGxW+EbWK9DWtO5A+MhLtRGsJ/qseBgxEOgKh9LYQFBOUUOxIQGLv3W
         ZTXQ==
X-Gm-Message-State: ANoB5pnheYLCnnlCfWoVYOn2oydFaDLvY617aJth24U5f81IiIdKKGdk
        TZyZaAK2YE1VLrnM52SezxMtzHt/yTfL6MEMXMXzSjYn/gIf+EDEthGEH2MryiQOW51jckSBJEy
        bdkNm5fQotcdylo4pQtUgvYVv
X-Received: by 2002:a05:6402:4d6:b0:45c:835c:1ecf with SMTP id n22-20020a05640204d600b0045c835c1ecfmr24078770edw.29.1671093049739;
        Thu, 15 Dec 2022 00:30:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4r/8QccpcVLtJ/LolCjiYE4eVoyO3dtVao5bKTz3iNWmsN4PhSYamWPcoMXBuegu/a2Nq8AQ==
X-Received: by 2002:a05:6402:4d6:b0:45c:835c:1ecf with SMTP id n22-20020a05640204d600b0045c835c1ecfmr24078753edw.29.1671093049553;
        Thu, 15 Dec 2022 00:30:49 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id a18-20020aa7cf12000000b0046cd3ba1336sm7267337edy.78.2022.12.15.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:30:49 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:30:45 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20221215083045.2lfplx6fhuwpau2s@sgarzare-redhat>
References: <20221213192843.421032-1-bobby.eshleman@bytedance.com>
 <4b66f91f23a3eb91c3232bc68f45bdb799217c40.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4b66f91f23a3eb91c3232bc68f45bdb799217c40.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:58:47AM +0100, Paolo Abeni wrote:
>On Tue, 2022-12-13 at 19:28 +0000, Bobby Eshleman wrote:
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 5703775af129..2a5994b029b2 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -51,8 +51,7 @@ struct vhost_vsock {
>>  	struct hlist_node hash;
>>
>>  	struct vhost_work send_pkt_work;
>> -	spinlock_t send_pkt_list_lock;
>> -	struct list_head send_pkt_list;	/* host->guest pending packets */
>> +	struct sk_buff_head send_pkt_queue; /* host->guest pending packets */
>>
>>  	atomic_t queued_replies;
>>
>> @@ -108,40 +107,33 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  	vhost_disable_notify(&vsock->dev, vq);
>>
>>  	do {
>> -		struct virtio_vsock_pkt *pkt;
>> +		struct virtio_vsock_hdr *hdr;
>> +		size_t iov_len, payload_len;
>>  		struct iov_iter iov_iter;
>> +		u32 flags_to_restore = 0;
>> +		struct sk_buff *skb;
>>  		unsigned out, in;
>>  		size_t nbytes;
>> -		size_t iov_len, payload_len;
>>  		int head;
>> -		u32 flags_to_restore = 0;
>>
>> -		spin_lock_bh(&vsock->send_pkt_list_lock);
>> -		if (list_empty(&vsock->send_pkt_list)) {
>> -			spin_unlock_bh(&vsock->send_pkt_list_lock);
>> +		spin_lock(&vsock->send_pkt_queue.lock);
>> +		skb = __skb_dequeue(&vsock->send_pkt_queue);
>> +		spin_unlock(&vsock->send_pkt_queue.lock);
>
>Here you use a plain spin_lock(), but every other lock has the _bh()
>variant. A few lines above this functions acquires a mutex, so this is
>process context (and not BH context): I guess you should use _bh()
>here, too.

Maybe we can use directly the new virtio_vsock_skb_dequeue().
IIRC we added it exactly to use the same kind of lock everywhere.

Thanks,
Stefano

