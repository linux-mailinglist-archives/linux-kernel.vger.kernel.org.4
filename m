Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8B64285D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiLEMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiLEMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:23:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC8AFAC9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670242943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Fpu1oLPXixRs8SXVb53vX2+k8zH4l62xyUnVTqnhLI=;
        b=dMQDya763huKerwxVobS6BeuX5jwLh9sQmd5qcfnPClbwBVx8yBdagBmHsg+b5mbEkJNXc
        K4DK0CEW1n7hWM9c3lSrcmOh0sLluMksnVYL5Mjf2zTMy6DZ/1EjjENFcS/fODCQ66UNxt
        LzdZEWEsm413uh3xEkoGR26459G0584=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-DunJGTQ8MUu08MwnnVXqdQ-1; Mon, 05 Dec 2022 07:22:22 -0500
X-MC-Unique: DunJGTQ8MUu08MwnnVXqdQ-1
Received: by mail-wm1-f69.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so6782289wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Fpu1oLPXixRs8SXVb53vX2+k8zH4l62xyUnVTqnhLI=;
        b=TIKvqV5/hDWdSxV77Fcq6VNMcfjEAtBoBYjPyBkDzvQGQNAE8UTcWWxx6ZMGr/WDgW
         HLcxtQXDz19D/gGo1rKT4CMtsY6fNkVtkDEf/CQQ8+5QE4vcRLUtgFgy7GXZrdK3a9TC
         HBFa0PrJwEV0P/meAnBWNPmvE+AHVcmyjFi3Ggpv1HeLV+MBGVppmGq2HKC8vcZBhvzZ
         GVKja5OqEVuSTaieA+iWEzUMnR6lKJROO78VPqqaunRbEWJUwVHRXZt83DtaDbYQ0Zv1
         pnTd1OMMHboiKZlO1PXolehhhgHZ1yj/JQ1O0w8iNfuFdcSRaGpmjXiWM3C/554JOKIZ
         zsWg==
X-Gm-Message-State: ANoB5pnU6Cs9y7E2GoHoACyM2WlYoaua5p/gBU90PtoRgFkK3al9vRl3
        e3AL3UfWBKnoPBxed4K9cu0UR3K5Ta+VUgnqGjthoTd5UGQcELiLeASASvdPdlxeMWb/9vN/QsJ
        hkSFYaO8rR2DaYcVhVFWbwyDN
X-Received: by 2002:a05:6000:1b86:b0:241:9606:1123 with SMTP id r6-20020a0560001b8600b0024196061123mr45199174wru.537.1670242940834;
        Mon, 05 Dec 2022 04:22:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6lXoHQqNZ83Ji7T4v0uWQIKCS1P748eGLo9Jfj6gSuWt8L17oynW4Eb8SDldK2I9Z85TIOMg==
X-Received: by 2002:a05:6000:1b86:b0:241:9606:1123 with SMTP id r6-20020a0560001b8600b0024196061123mr45199150wru.537.1670242940594;
        Mon, 05 Dec 2022 04:22:20 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id a3-20020adffac3000000b0024245e543absm8823432wrs.88.2022.12.05.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 04:22:20 -0800 (PST)
Date:   Mon, 5 Dec 2022 13:22:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] virtio/vsock: replace virtio_vsock_pkt with sk_buff
Message-ID: <20221205122214.bky3oxipck4hsqqe@sgarzare-redhat>
References: <20221202173520.10428-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221202173520.10428-1-bobby.eshleman@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:35:18AM -0800, Bobby Eshleman wrote:
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
>Changes in v5:
>- last_skb instead of skb: last_hdr->len = cpu_to_le32(last_skb->len)

With this issue fixed, I confirm that all the tests passed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


As pointed out in v4, this is net-next material, so you should use the 
net-next tag and base the patch on the net-next tree:
https://www.kernel.org/doc/html/v6.0/process/maintainer-netdev.html#netdev-faq

I locally applied the patch on net-next and everything is fine, so maybe 
the maintainers can apply it, otherwise you should resend it with the 
right tag.
Ah, in that case I suggest you send it before the next merge window 
opens (I guess next week), because net-next closes and you'll have to 
wait for the next cycle.

Thanks,
Stefano

