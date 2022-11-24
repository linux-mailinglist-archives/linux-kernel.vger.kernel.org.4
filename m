Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B457637C63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKXPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKXPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982812E215
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669302013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BAjfPV4xt1OtlG9wsm8F4N47NjOLXIg1wmr/fWW5B8o=;
        b=Yq6WfAiuuEn1m94nf7XKK1+I7phj5jJsJM9CoX3+2yqDEDOMk37dLT/WPjEyPjKc5YAijs
        +R7faPcPo887CQxjrn4a2rUH7dr9ykEppMzxJsiwvgxO4Ge8eLh/ySst1Oa6AHFuBX2gB9
        a1hbs11aTk9HKTStba7/yoj0SM6JN0o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-qsahOXrcOUe2oypNxTARLg-1; Thu, 24 Nov 2022 10:00:11 -0500
X-MC-Unique: qsahOXrcOUe2oypNxTARLg-1
Received: by mail-wr1-f72.google.com with SMTP id v14-20020adf8b4e000000b0024174021277so472971wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAjfPV4xt1OtlG9wsm8F4N47NjOLXIg1wmr/fWW5B8o=;
        b=yB+nc1ub00dxQBJmSMJs9pDQja9pzfk7TIaxYaKZGHOSHvt/qWnXj9TjE1WLRU0I3p
         TVrR1PSE8oBARuTBiW0kIcu2s+OzcTCNnL5ZbgCv0E1kHqt6dK0gytmA68oLFIViw5Nw
         BmbkImmIqHwZ6UJusF+94Kw3N6zfKP+3xcBSizxnfStqYg8YMs1JE/G68+KR9ioJhiLD
         yG+qu0JbM+tCmas33bEDbr5lWIA9mree+tDFEQBb6AYaaWSrHZ+9F67l22KHxlcoz1cW
         vGKX5wzmRTOlvqTV0kjrUE1QfJXYiLBu6+b31yHt1RPXelsBxDiSX/JU8SiQznnxYjdV
         vrDQ==
X-Gm-Message-State: ANoB5pksiDjXG0i7Es/NDhnvGTni6Zm/yAx+ooASyrWzrzaxfPnflg6I
        22DHxQCeOzUMILHxNVVQnd3Mx+q3jpW1laX9MqaNkgYReoYDqPLWzEX3m+mWXGU3Fmqg85WVtnj
        6ja4WHZKiep4vpgYPUkF9KQD4
X-Received: by 2002:a5d:4d4c:0:b0:236:55eb:a25a with SMTP id a12-20020a5d4d4c000000b0023655eba25amr20765355wru.55.1669302010703;
        Thu, 24 Nov 2022 07:00:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5sZbbTxNTiJwbBNeC7KFcse58SdLkR/Xx9k6PAPDIUZFhtBjhA7/8RRgSdQ+ARtA68UUkFVw==
X-Received: by 2002:a5d:4d4c:0:b0:236:55eb:a25a with SMTP id a12-20020a5d4d4c000000b0023655eba25amr20765337wru.55.1669302010429;
        Thu, 24 Nov 2022 07:00:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id hg27-20020a05600c539b00b003a3170a7af9sm2156923wmb.4.2022.11.24.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 07:00:09 -0800 (PST)
Date:   Thu, 24 Nov 2022 16:00:05 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] virtio/vsock: replace virtio_vsock_pkt with sk_buff
Message-ID: <20221124150005.vchk6ieoacrcu2gb@sgarzare-redhat>
References: <20221124060750.48223-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221124060750.48223-1-bobby.eshleman@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a net-next material, please remember to use net-next tag:
https://www.kernel.org/doc/html/v6.0/process/maintainer-netdev.html#netdev-faq

On Wed, Nov 23, 2022 at 10:07:49PM -0800, Bobby Eshleman wrote:
>This commit changes virtio/vsock to use sk_buff instead of
>virtio_vsock_pkt. Beyond better conforming to other net code, using
>sk_buff allows vsock to use sk_buff-dependent features in the future
>(such as sockmap) and improves throughput.
>
>This patch introduces the following performance changes:
>
>Tool/Config: uperf w/ 64 threads, SOCK_STREAM
>Test Runs: 5, mean of results
>Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
>
>Test: 64KB, g2h
>Before: 21.63 Gb/s
>After: 25.59 Gb/s (+18%)
>
>Test: 16B, g2h
>Before: 11.86 Mb/s
>After: 17.41 Mb/s (+46%)
>
>Test: 64KB, h2g
>Before: 2.15 Gb/s
>After: 3.6 Gb/s (+67%)
>
>Test: 16B, h2g
>Before: 14.38 Mb/s
>After: 18.43 Mb/s (+28%)
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---

The patch LGTM. I run several tests (iperf3, vsock_test,
vsock_diag_test, vhost-user-vsock, tcpdump) and IMO we are okay.

I found the following problems that I would like to report:

- vhost-user-vsock [1] is failing, but it is not an issue of this patch,
   but a spec violation in the rust-vmm/vm-virtio/virtio-vsock crate as I
   reported here [2]. We will fix it there, this patch is fine, indeed
   trying a guest with the new layout (1 descriptor for both header and
   data) with vhost-vsock in Linux 6.0, everything works perfectly.

- the new "SOCK_SEQPACKET msg bounds" [3] reworked by Arseniy fails
   intermittently with this patch.

   Using the tests currently in the kernel tree everything is fine, so
   I don't understand if it's a problem in the new test or in this
   patch. I've looked at the code again and don't seem to see any
   criticisms.

   @Arseniy @Bobby can you take a look?

   I'll try to take a closer look too, and before I give my R-b I'd like
   to make sure it's a problem in the test and not in this patch.

   This is what I have (some times, not always) with both host and guest
   with this patch and the series of [3] applied:

   host$ ./vsock_test --control-host=192.168.133.3 --control-port=12345 \
                      --mode=client --peer-cid=4
   Control socket connected to 192.168.133.3:12345.
   0 - SOCK_STREAM connection reset...ok
   1 - SOCK_STREAM bind only...ok
   2 - SOCK_STREAM client close...ok
   3 - SOCK_STREAM server close...ok
   4 - SOCK_STREAM multiple connections...ok
   5 - SOCK_STREAM MSG_PEEK...ok
   6 - SOCK_SEQPACKET msg bounds...ok
   7 - SOCK_SEQPACKET MSG_TRUNC flag...recv: Connection reset by peer

   guest$ ./vsock_test --control-port=12345 --mode=server --peer-cid=2
   Control socket listening on 0.0.0.0:12345
   Control socket connection accepted...
   0 - SOCK_STREAM connection reset...ok
   1 - SOCK_STREAM bind only...ok
   2 - SOCK_STREAM client close...ok
   3 - SOCK_STREAM server close...ok
   4 - SOCK_STREAM multiple connections...ok
   5 - SOCK_STREAM MSG_PEEK...ok
   6 - SOCK_SEQPACKET msg bounds...Message bounds broken

Thanks,
Stefano

[1] https://github.com/rust-vmm/vhost-device/tree/main/crates/vsock
[2] https://github.com/rust-vmm/vm-virtio/issues/204
[3] https://lore.kernel.org/lkml/c991dffd-1dbc-e1d1-b682-a3c71f6ce51c@sberdevices.ru/

