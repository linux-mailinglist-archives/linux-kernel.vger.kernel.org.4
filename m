Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE16131DB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJaIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A2B0F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667205822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0cVx55tetrN0slfUGsIN9YfNlhQLUs9MTDiVMp3ty/0=;
        b=hwhlJb3t8YEGTriavJJ2Fx4WyqvFhF02RIOHycggR/d0yNC7KjDVRmIvFvc8K4CiCIje4t
        nG2vHF1kqgHdO63YSyoczSCVkVRehlevMsk00M+Kxadb0ahgigDP3rr8bCn5raWxu0c90K
        ArclCS9AQZ4uI2tnbvwIPiM4e82Z4CE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-287-jxa-VrrZPiqenOuFez9mPg-1; Mon, 31 Oct 2022 04:43:33 -0400
X-MC-Unique: jxa-VrrZPiqenOuFez9mPg-1
Received: by mail-ed1-f70.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso7434587edc.21
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cVx55tetrN0slfUGsIN9YfNlhQLUs9MTDiVMp3ty/0=;
        b=hJYfANTns31DIFtxhIvTHmQKo5RFhYp917N7LNEi5wHbf7su/Pj1XHEixpngf5SJR1
         M5BPyKSMSs+qO6xdoiy1aWt4+vBH8Iyfkc3rbNLS+wy+v393oM2nIHLUiSw8odqy3r4Z
         xRFaAYptwx/LQxhx3HE6j+iB5e2N6ygu08TOhGm8mZ/hFaPTuJA4FyCtwpToanEsYOaw
         55r784rW04v1wrVU4lgOjBeFyPCoU+18Mh49bEv0SOyUOJza02Ho4jnHRmfbIzApIrsk
         F83Di3dHVD3FgRQx84bIzBy/a8P1x7YrIm4vya3vm3XrlTwGCtktmTuhMuA5MBnP6JKJ
         JNOA==
X-Gm-Message-State: ACrzQf3qZtvPuXbg3Xi34ldFb09HAqeXUKSv9dgYeJvP648EetPZCU7b
        4TcTnXL8ArqyesPlHejJb7Bx13Wsw8rrKzmP9D56yAaDRi6SePToexE4LEbxO2dTj69W7o2liGg
        Bpdb42x/K9gp/3HPQrEIG8gXb
X-Received: by 2002:a17:907:9609:b0:7ad:d7de:6090 with SMTP id gb9-20020a170907960900b007add7de6090mr2357875ejc.705.1667205812193;
        Mon, 31 Oct 2022 01:43:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78kesRA+qFkC4xT0N1dTMkPq+EZe+uIxAjrrmBRYnA8hqY50buMcYsM3zFLwBQ3G0S2t+fkg==
X-Received: by 2002:a17:907:9609:b0:7ad:d7de:6090 with SMTP id gb9-20020a170907960900b007add7de6090mr2357859ejc.705.1667205811954;
        Mon, 31 Oct 2022 01:43:31 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7c2d8000000b0044dbecdcd29sm2914807edp.12.2022.10.31.01.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 01:43:31 -0700 (PDT)
Date:   Mon, 31 Oct 2022 09:43:27 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, arseny.krasnov@kaspersky.com,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, stephen@networkplumber.org,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Message-ID: <20221031084327.63vikvodhs7aowhe@sgarzare-redhat>
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-3-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221028205646.28084-3-decui@microsoft.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:56:46PM -0700, Dexuan Cui wrote:
>Currently vsock_connectible_has_data() may miss a wakeup operation
>between vsock_connectible_has_data() == 0 and the prepare_to_wait().
>
>Fix the race by adding the process to the wait qeuue before checking

s/qeuue/queue

>vsock_connectible_has_data().
>
>Fixes: b3f7fd54881b ("af_vsock: separate wait data loop")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/af_vsock.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d258fd43092e..03a6b5bc6ba7 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1905,8 +1905,11 @@ static int vsock_connectible_wait_data(struct sock *sk,
> 	err = 0;
> 	transport = vsk->transport;
>
>-	while ((data = vsock_connectible_has_data(vsk)) == 0) {
>+	while (1) {
> 		prepare_to_wait(sk_sleep(sk), wait, TASK_INTERRUPTIBLE);
>+		data = vsock_connectible_has_data(vsk);
>+		if (data != 0)
>+			break;
>
> 		if (sk->sk_err != 0 ||
> 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>@@ -1937,6 +1940,8 @@ static int vsock_connectible_wait_data(struct sock *sk,
> 			err = -EAGAIN;
> 			break;
> 		}
>+
>+		finish_wait(sk_sleep(sk), wait);

Since we are going to call again prepare_to_wait() on top of the loop, 
is finish_wait() call here really needed?

What about following what we do in vsock_accept and vsock_connect?

     prepare_to_wait()

     while (condition) {
         ...
         prepare_to_wait();
     }

     finish_wait()

I find it a little more readable, but your solution is fine too.

Thanks,
Stefano

