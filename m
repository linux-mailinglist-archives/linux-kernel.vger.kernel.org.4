Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA15E64B8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiLMPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiLMPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6656122298
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670946193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ta5qJGL6TYgTS7WdcfK/NhG2rVIgkTUOeHGwN5QJWEY=;
        b=JQ6RmByxFW0d0XbO6fXrkhCIhmaIYc2c9mouZII98kriYOJq4pn4Gr1ltUL62pfZEPHsVC
        w8o7xiyhol2bAh7x/w9UbgUWgMjorKEgDTD/W05F9ZOOAMKwDuz/AKj/0uZcu8PCPP+85v
        N7BjJ+xW1okwWikpnVPUtbIGuck/w5o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-494-73r1KwVuOcO9kuVHxPzuAA-1; Tue, 13 Dec 2022 10:43:11 -0500
X-MC-Unique: 73r1KwVuOcO9kuVHxPzuAA-1
Received: by mail-wr1-f72.google.com with SMTP id m24-20020adfa3d8000000b00242168ce9d1so2982267wrb.15
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta5qJGL6TYgTS7WdcfK/NhG2rVIgkTUOeHGwN5QJWEY=;
        b=M6Dw9WjlU7slMXvgX5F0ewPgu2Kj23DYtJ/R4Ba63G0swlr1JlwviTpqTOqTD4VC17
         s5vFm3FeyueSo4lBa9e4/k22GIBj1oQkMUEfXtIhgOJ4SSz+Xjk5DxF2fGBe7E8L9Ys8
         O+LJGhA1JCDjQ/xPPPfQvWgZpO4pE6ksK+aBnGAzjIAZ9SaOwV8t1EHaIy1ybr6qVyad
         ca8Aji0DJHrbKFtiPXCxXOnGQ3LMvlALXjuYz3OeIGtg8PFPgM6ex0OnU/DstrlfOx+D
         ctqfQdjbJgnw3jA1tqC+CkrQRKMQRJf7Bl13QISWhmXOgW5G6wugmnTQZROa8G7HuG19
         GuzQ==
X-Gm-Message-State: ANoB5pnNw8dElsVsiH54occA4MNsSh2cpDNDbU2ryR5BqutR2ZZWUg03
        I9mloeATX03Kxddn7tNtkuoXOhySEf6VpCmr7bov5qd67bRK1BSp5QN3dYyBl5wkWV98Ww3Oj5q
        2WpDXSbHJJPB44LSu4McpIWVN
X-Received: by 2002:a05:6000:550:b0:242:880:20ce with SMTP id b16-20020a056000055000b00242088020cemr13771066wrf.47.1670946190491;
        Tue, 13 Dec 2022 07:43:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Fome2UWsPehy6lJdurAxcXv7sPgyHhsfgJzvy5rYv8HZ777S+ULuoF2cVj9aNlQvSN3jKBA==
X-Received: by 2002:a05:6000:550:b0:242:880:20ce with SMTP id b16-20020a056000055000b00242088020cemr13771047wrf.47.1670946190282;
        Tue, 13 Dec 2022 07:43:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d564e000000b0024165454262sm135347wrw.11.2022.12.13.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:43:09 -0800 (PST)
Date:   Tue, 13 Dec 2022 16:43:04 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20221213154304.rjrwzbv6jywkrpxq@sgarzare-redhat>
References: <20221213072549.1997724-1-bobby.eshleman@bytedance.com>
 <20221213102232.n2mc3y7ietabncax@sgarzare-redhat>
 <20221213100510-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221213100510-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:06:23AM -0500, Michael S. Tsirkin wrote:
>On Tue, Dec 13, 2022 at 11:22:32AM +0100, Stefano Garzarella wrote:
>> > +	if (len <= GOOD_COPY_LEN && !skb_queue_empty_lockless(&vvs->rx_queue)) {
>>
>> Same here.
>>
>> If there are no major changes to be made, I think the next version is the
>> final ones, though we are now in the merge window, so net-next is closed
>> [1], only RFCs can be sent [2].
>>
>> I suggest you wait until the merge window is over (two weeks usually) to
>> send the next version.
>
>Nah, you never know, could be more comments. And depending on the timing
>I might be able to merge it.

Right, in the end these changes are only to virtio-vsock transport, so 
they can go smoothly even with your tree.

@Bobby, so if you can fix the remaining small things, we can try to 
merge it :-)

Thanks,
Stefano

