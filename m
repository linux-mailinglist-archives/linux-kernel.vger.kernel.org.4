Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6563C6ABF21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCFMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCFMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:08:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B572227D43
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678104469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I0ekj7n7BGA/ETtY6sbgYM92CAukII9oGd0VLpZBNPM=;
        b=E/MaTkEMxDslUr2+yBFtp7APjx5Atj6Z+ZLrxEYQQ1ZXP2+IkG9o8Gcos8JE1mLF1Swr8Y
        oRZ7vzkfkFsKEfjE/1WGhUtRSwevgiUNZ7pDdXg2jNchcPM7qBMePcIPQIYNanBVEfAA6j
        Zs/saW44vArQlYnl+ce8/3JRYO2O2v8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Gdij4IW9O5ifmkHPFJPYuA-1; Mon, 06 Mar 2023 07:07:47 -0500
X-MC-Unique: Gdij4IW9O5ifmkHPFJPYuA-1
Received: by mail-qt1-f200.google.com with SMTP id k13-20020ac8074d000000b003bfd04a3cbcso5043353qth.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 04:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678104467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0ekj7n7BGA/ETtY6sbgYM92CAukII9oGd0VLpZBNPM=;
        b=UkPg6VhDPQUq62OQ3VqCQWLDY6weckzOg6TYufRqlDHr3/XqMg9wThRSpc7HilxkkB
         KoMyI4T03QSO8XVhern9P/z1uHkbQLEzvaDHfsuFNq6qLBRwx0j2ASe75z9ZvylQH8BS
         QusL1bDR/nKf/sW2Nt5IMYCfQcq9CsLLniRLhgsasPOi8QD75WOL09r+lV8lwX0lsi+u
         FeeQkMjDc/fdj+MViFL6cjcg062WQ8xPYKOUyrZtisC7TWwumezoQW+qCEUfYjqaBYAO
         vrk1W8NZYSz7AmLv1+jwxgdMlwGVe3o8ruDrpN+y8W3y7hj1gxL+JDrkfpJTcMFyWHX/
         Kn+A==
X-Gm-Message-State: AO0yUKWLUvPDS7sWFeg8R6s+C6/GU+SlmPbf4eHx0vMRfoHqO8sOu9O3
        g/980byhVP20Zue4WePwLkOyhGzYd4NRgwWl1jv1XYOMn/jOhA/CjMHZaMpoabdSdCbz4ByQriJ
        r0BETgzF+97/nmVzP/qEMWh9d
X-Received: by 2002:ac8:5846:0:b0:3b8:5f26:e81f with SMTP id h6-20020ac85846000000b003b85f26e81fmr17766940qth.26.1678104467256;
        Mon, 06 Mar 2023 04:07:47 -0800 (PST)
X-Google-Smtp-Source: AK7set+V96PPHCzW88GO7gnogT8Tq/LXjyFpkqulWQDOc7ELP578FLhsQX2W1rCp9GrjRWDk+JnlEg==
X-Received: by 2002:ac8:5846:0:b0:3b8:5f26:e81f with SMTP id h6-20020ac85846000000b003b85f26e81fmr17766898qth.26.1678104466945;
        Mon, 06 Mar 2023 04:07:46 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id 5-20020ac85605000000b003b0766cd169sm7496344qtr.2.2023.03.06.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 04:07:46 -0800 (PST)
Date:   Mon, 6 Mar 2023 13:07:42 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 3/4] virtio/vsock: free skb on data copy failure
Message-ID: <20230306120742.v6ss4w22ku7pe45a@sgarzare-redhat>
References: <a7ab414b-5e41-c7b6-250b-e8401f335859@sberdevices.ru>
 <ef98aad4-f86d-fe60-9a35-792363a78a68@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ef98aad4-f86d-fe60-9a35-792363a78a68@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:08:38PM +0300, Arseniy Krasnov wrote:
>This fixes two things in case when 'memcpy_to_msg()' fails:
>1) Update credit parameters of the socket, like this skbuff was
>   copied to user successfully. This is needed because when skbuff was
>   received it's length was used to update 'rx_bytes', thus when we drop
>   skbuff here, we must account rest of it's data in 'rx_bytes'.
>2) Free skbuff which was removed from socket's queue.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 30b0539990ba..ffb1af4f2b52 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -379,8 +379,12 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 		spin_unlock_bh(&vvs->rx_lock);
>
> 		err = memcpy_to_msg(msg, skb->data, bytes);
>-		if (err)
>+		if (err) {
>+			skb_pull(skb, skb->len);
>+			virtio_transport_dec_rx_pkt(vvs, skb);
>+			consume_skb(skb);

I'm not sure it's the right thing to do, if we fail to copy the content
into the user's buffer, I think we should queue it again.

In fact, before commit 71dc9ec9ac7d ("virtio/vsock: replace
virtio_vsock_pkt with sk_buff"), we used to remove the packet from the
rx_queue, only if memcpy_to_msg() was successful.

Maybe it is better to do as we did before and use skb_peek() at the
beginning of the loop and __skb_unlink() when skb->len == 0.

Thanks,
Stefano

> 			goto out;
>+		}
>
> 		spin_lock_bh(&vvs->rx_lock);
>
>-- 
>2.25.1
>

