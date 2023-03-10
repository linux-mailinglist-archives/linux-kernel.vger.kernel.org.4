Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980496B3E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCJLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCJLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:40:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0865110B1D3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678448408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJwQlAakOokhmQO5hlNSSM0QAOQ7URuACK/mNX+Ecvw=;
        b=OJ3Xfx63shEv/qq3wxCdzzUsdGMHfbUcVOOnZUnehEZ7cdTFzJb5k2KeX/c0hSVKBAviWu
        CA/aNygzLvN+9l7wiZZrB8GaAwC5biRKefIJf2kqZmFktX+djGIc/52icv7//MYA6mBPK0
        q/Xv0V2Ll18HySAAWdGoeLBNpX+/0q4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499--6xhv_7fNzSAO-24HfY-eQ-1; Fri, 10 Mar 2023 06:40:05 -0500
X-MC-Unique: -6xhv_7fNzSAO-24HfY-eQ-1
Received: by mail-wm1-f70.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so1702506wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678448404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJwQlAakOokhmQO5hlNSSM0QAOQ7URuACK/mNX+Ecvw=;
        b=Otr7LeYu189sJ2ltkgmFJaokMYQekFT1rnOvfVKUFC6FGVYa9bYxC1H9+qdCRql6ZV
         Ejbc+w0Y9OGnkZ3F0PN4EUCTj3JJiPGXneuTOfUp4xNJWPxDTfR8Q4xI44pvdvqH+Lwm
         MqYxxaLqTxLuCea9AJrUAWbHpWgsgp5nZukjrCHnVf5nufMfaD+PWD67TJ6JHPKjLFqo
         ppiw5UDYi7Rq7hW1lRzw+yy/wiagtrh5fdTRInduOTwSCDYmG7YYqg2sRkUKWbeBDJh6
         wdHbOdyt0jtOL6/ELTLnWDXevrYv1M+LS5sCyJIoHUvmL5qii2w1ATvVEYHOXR/erYMM
         eZyA==
X-Gm-Message-State: AO0yUKUsrDLgqZ7WY/oh/hMitDywN8ZVLIncB/+A2nuRb+H371UxirHy
        JoPd48NGFWMnkbYEH8SBp5D9lIHw4ZKXHMZ8PwojDhBv1bww/VjTT3nH6bqdyzXuRPXKvd9X/ie
        sVX+Q8d17sjfrI8z5H2jFwc9t
X-Received: by 2002:adf:ef10:0:b0:2ca:3576:756d with SMTP id e16-20020adfef10000000b002ca3576756dmr17441598wro.50.1678448404005;
        Fri, 10 Mar 2023 03:40:04 -0800 (PST)
X-Google-Smtp-Source: AK7set+RNKqlJyQI+1SQ507spnOBqv3bWEPOICTIm+RgBVN6rKvCG9ALHkeDNEO4/C58wDmMpo7bIA==
X-Received: by 2002:adf:ef10:0:b0:2ca:3576:756d with SMTP id e16-20020adfef10000000b002ca3576756dmr17441579wro.50.1678448403714;
        Fri, 10 Mar 2023 03:40:03 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6244000000b002c707b336c9sm2065136wrv.36.2023.03.10.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 03:40:03 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:40:00 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 0/4] several updates to virtio/vsock
Message-ID: <20230310114000.6ptwpryulbvcqf5m@sgarzare-redhat>
References: <1804d100-1652-d463-8627-da93cb61144e@sberdevices.ru>
 <20230310090937.s55af2fx56zn4ewu@sgarzare-redhat>
 <15b9df26-bdc1-e139-8df7-62f966c719ed@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15b9df26-bdc1-e139-8df7-62f966c719ed@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:42:13PM +0300, Arseniy Krasnov wrote:
>
>
>On 10.03.2023 12:09, Stefano Garzarella wrote:
>> Hi Arseniy,
>>
>> On Thu, Mar 09, 2023 at 11:24:42PM +0300, Arseniy Krasnov wrote:
>>> Hello,
>>>
>>> this patchset evolved from previous v2 version (see link below). It does
>>> several updates to virtio/vsock:
>>> 1) Changes 'virtio_transport_inc/dec_rx_pkt()' interface. Now instead of
>>> � using skbuff state ('head' and 'data' pointers) to update 'fwd_cnt'
>>> � and 'rx_bytes', integer value is passed as an input argument. This
>>> � makes code more simple, because in this case we don't need to update
>>> � skbuff state before calling 'virtio_transport_inc/dec_rx_pkt()'. In
>>> � more common words - we don't need to change skbuff state to update
>>> � 'rx_bytes' and 'fwd_cnt' correctly.
>>> 2) For SOCK_STREAM, when copying data to user fails, current skbuff is
>>> � not dropped. Next read attempt will use same skbuff and last offset.
>>> � Instead of 'skb_dequeue()', 'skb_peek()' + '__skb_unlink()' are used.
>>> � This behaviour was implemented before skbuff support.
>>> 3) For SOCK_SEQPACKET it removes unneeded 'skb_pull()' call, because for
>>> � this type of socket each skbuff is used only once: after removing it
>>> � from socket's queue, it will be freed anyway.
>>
>> thanks for the fixes, I would wait a few days to see if there are any
>> comments and then I think you can send it on net without RFC.
>>
>> @Bobby if you can take a look, your ack would be appreciated :-)
>Ok, thanks for review. I'll wait for several days and also wait until
>net-next will be opened. Then i'll resend this patchset with net-next

Since they are fixes, they should go with the net tree, not net-next.

Cheers,
Stefano

