Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408A073F62D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjF0Hy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0HyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACF1BEC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687852419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaGOS9wkr6YWqK+5U8u6i1zG6qs2tTQ6/raZM0kVnbg=;
        b=PVMeg2JjMSS/0gDrLzGu7irndygCB4no2Q9fo5gnZODr2MdLy9NkYzUyhyNXHh4iLYuTjY
        CwPkvTampREq+NY9Y4GLc8M8bXHmFbyQJ+lR7K4hjI3UK990U1oEatJMZaZx6+soe2m1PY
        mhCmjv7s2Pud51edmhYcV14o0U8Hnnw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-gcoOdVY8Oou2sCXvPLeo8w-1; Tue, 27 Jun 2023 03:53:34 -0400
X-MC-Unique: gcoOdVY8Oou2sCXvPLeo8w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a356c74e0so224792966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852413; x=1690444413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaGOS9wkr6YWqK+5U8u6i1zG6qs2tTQ6/raZM0kVnbg=;
        b=A4FY26Ru8dp8bhkvsTcC7uKjSaL4dn4sbOwtDEbQhnriqF0cXkFYDXzzh83kHu363g
         roR/N7Lmbz1x9wvI8YrHXjoVFl4rrlerk+OPeGC3vcK6xlHhgSUsSA3SCzenUcg5umEA
         69e4mn5VlttwKWuwohzXheP8FwlBK3ot7w3o9U4GdHsbX32qvoY6eVqQcWQR4gOBEmzL
         gDaugcXwV8bfQiBe3lO4oKZw0s/EM3WyCtCzkCYWXKGhFm9HTTwHglohOrjejls0YgZ3
         VVCK76f9PTdKUYYw5WgJ013HChxBMXavZH4PWbJSHK7KfCfMLgbQfcUUzGuf/q9sYYuD
         8N5Q==
X-Gm-Message-State: AC+VfDyldapoj194GF5lAis6gPWelKhv68GxKDlF5dtRFqtfZbAlRc+Y
        Kut1DdR2WohhD6XRGBiiTSeQRLBnC8sr6+7MSoPVuAbQ0EbqRkjfkjHKwFObkPXKHJYYtfuj/5E
        pEbxm+URiLxAEnVHvkRWg4Kog
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id o15-20020a170906974f00b0098921e46c6emr15445247ejy.53.1687852413617;
        Tue, 27 Jun 2023 00:53:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iZHQ4sT71AvDVVWRhT6FBmJw3cWaMNmCzSmG2L5gutVyEA42mOg+6M3+BcIvlFY1BUoU07A==
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id o15-20020a170906974f00b0098921e46c6emr15445236ejy.53.1687852413286;
        Tue, 27 Jun 2023 00:53:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id r21-20020a1709067fd500b00988781076e2sm4235786ejs.78.2023.06.27.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:53:32 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:53:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 06/17] vsock: check error queue to set EPOLLERR
Message-ID: <pnbag2axu2uy7w2wrgiljutr3hifo3rltvkkc46wlrmhwzqr5b@pgaqr2m3iwof>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-7-AVKrasnov@sberdevices.ru>
 <rg3qxgiqqi5ltt4jcf3k5tcnynh2so5ascvrte4gywcfffusv4@qjz3tkumeq7g>
 <94a133e5-a180-a9b5-91cb-c0ca44af35ea@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a133e5-a180-a9b5-91cb-c0ca44af35ea@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 07:44:25AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:04, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:28PM +0300, Arseniy Krasnov wrote:
>>> If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>>> reader of error queue won't detect data in it using EPOLLERR bit.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This patch looks like it can go even without this series.
>>
>> Is it a fix? Should we add a fixes tag?
>
>Yes, it is fix and I can exclude it from this set to reduce number
>of patches, but there is no reproducer for this without MSG_ZEROCOPY
>support - at this moment this feature is the only user of error queue
>for AF_VSOCK.

Okay, so it's fine to keep it here, but please mention in the comment 
that without MSG_ZEROCOPY it can't be reproduced.

That way we know that we don't have to backport into the stable 
branches.

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>> Thanks,
>> Stefano
>>
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index efb8a0937a13..45fd20c4ed50 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1030,7 +1030,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
>>>     poll_wait(file, sk_sleep(sk), wait);
>>>     mask = 0;
>>>
>>> -    if (sk->sk_err)
>>> +    if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
>>>         /* Signify that there has been an error on this socket. */
>>>         mask |= EPOLLERR;
>>>
>>> -- 
>>> 2.25.1
>>>
>>
>

