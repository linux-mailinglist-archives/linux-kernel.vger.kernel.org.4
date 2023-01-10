Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD6663B54
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjAJIir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbjAJIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328E3C38E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673339792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OA5uFXsjy9VOrtOt4v6gI0JId1gSQ8b6AXjXO1XR9p4=;
        b=MSNpQQHDq9J+7CHQGnl8US8z5dB1A9e7G5E2LYfhjsFkni5Pwfx8zzHRCcHc03auOP0Xcb
        iEhs/iE3b6WB3mQCwuoJMi4uXYxAxN4njQHE5cW31KQojtexjRfogi55hIIBz8nzjKfA72
        LNSlnztZfesUo95sGBQrx1tFmEnqdik=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-225-3-ycfwqfN2qwmm10C9fJ-A-1; Tue, 10 Jan 2023 03:36:31 -0500
X-MC-Unique: 3-ycfwqfN2qwmm10C9fJ-A-1
Received: by mail-qv1-f72.google.com with SMTP id oj9-20020a056214440900b0053233473499so1864730qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OA5uFXsjy9VOrtOt4v6gI0JId1gSQ8b6AXjXO1XR9p4=;
        b=G5mDCp4bos31MVdFXqM16kGh3i/zANIKmoFuFoDCyvnstn6F3vOWrD1btzyfHt4IS5
         R2fkupBACAzHuEdn9GcIbmFNB3RreV0inW5riCR6gwZbnmREhe1YsvulvbjuBlTNl4Oc
         w0zWyGQWRTSKJx+W8YZuyTKODxew87ii4+JyNzJo58CO8/pKjkNc7cRlab2ZkWBrfC8K
         jzHkVhVA139Z7dtcQtNIZA59hjzLTdg7bSfUY+wHtuKNvVLguhrrx8Xp5/kaAphi0ZKP
         NuLtRlSYwZ/sm7kzpItw5Se0GFePBM6HormequS15u+DJGwwzPaXcd37hmbIHvnfzOwt
         3COA==
X-Gm-Message-State: AFqh2kpC0FgCcauHPnlRuuQ3KCMZ1IikKeWXbH8GNmXD6QjrhsmHejZA
        a2BgJOlGCCNHk60e/M5SSr/TgIzcUJ69meK64o+ib7TEXrB0j+RdjP2asmPV7L3GGNxCdC1QSfv
        bsEXtDRi5KOLWA89p6aA9/IZm
X-Received: by 2002:ac8:6e87:0:b0:3a8:11f3:b81c with SMTP id c7-20020ac86e87000000b003a811f3b81cmr92473608qtv.53.1673339790901;
        Tue, 10 Jan 2023 00:36:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtHKXcGwIf1YTV+2xcYytzlbmWmXvkPsMytlZlxe1TCEXregd5S2XFcyMVIu2vtJs6MCGLTzg==
X-Received: by 2002:ac8:6e87:0:b0:3a8:11f3:b81c with SMTP id c7-20020ac86e87000000b003a811f3b81cmr92473590qtv.53.1673339790644;
        Tue, 10 Jan 2023 00:36:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-128.dyn.eolo.it. [146.241.120.128])
        by smtp.gmail.com with ESMTPSA id s24-20020ac87598000000b003a7e9db074asm5687861qtq.67.2023.01.10.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:36:30 -0800 (PST)
Message-ID: <91593e9c8a475a26a465369f6caff86ac5d662e3.camel@redhat.com>
Subject: Re: [PATCH net-next v9] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
From:   Paolo Abeni <pabeni@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Jan 2023 09:36:26 +0100
In-Reply-To: <20230107002937.899605-1-bobby.eshleman@bytedance.com>
References: <20230107002937.899605-1-bobby.eshleman@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-07 at 00:29 +0000, Bobby Eshleman wrote:
> This commit changes virtio/vsock to use sk_buff instead of
> virtio_vsock_pkt. Beyond better conforming to other net code, using
> sk_buff allows vsock to use sk_buff-dependent features in the future
> (such as sockmap) and improves throughput.
> 
> This patch introduces the following performance changes:
> 
> Tool/Config: uperf w/ 64 threads, SOCK_STREAM
> Test Runs: 5, mean of results
> Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
> 
> Test: 64KB, g2h
> Before: 21.63 Gb/s
> After: 25.59 Gb/s (+18%)
> 
> Test: 16B, g2h
> Before: 11.86 Mb/s
> After: 17.41 Mb/s (+46%)
> 
> Test: 64KB, h2g
> Before: 2.15 Gb/s
> After: 3.6 Gb/s (+67%)
> 
> Test: 16B, h2g
> Before: 14.38 Mb/s
> After: 18.43 Mb/s (+28%)
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---
> 
> Tested using vsock_test g2h and h2g.  I'm not sure if it is standard
> practice here to carry Acks and Reviews forward to future versions, but
> I'm doing that here to hopefully make life easier for maintainers.
> Please let me know if it is not standard practice.

As Jakub noted, there is no clear rule for tag passing across different
patch revisions.

Here, given the complexity of the patch and the not trivial list of
changes, I would have preferred you would have dropped my tag.

> Changes in v9:
> - check length in rx header
> - guard alloactor from small requests
> - squashed fix for v8 bug reported by syzbot:
>     syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com

It's not clear to me what/where is the fix exactly, could you please
clarify?

Thanks!

Paolo

