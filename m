Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB9699106
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBPKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBPKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16715FD9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676542834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9d2F3j0rYGNO9oHzYnL7gUMrLwfVFcsHDqpyr29XsFY=;
        b=ekGQ/spVmcRAczmkr3no5y8IiDO69i7bKVr6cbPtIaJEiUS4CvFwQdQpj3CxaeY7bh2qwh
        sZT7RSMxvCiofkZZJfGQzh44K7b5zn1u2ZhoZ9p4lpsrDKjBOGu6DJQQGg7jo58rkc7xim
        ip67+QhGr6Tr6lxnNP1fm4aDadsWEmk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-sXlW34CtMmaqkVG5QGc2FQ-1; Thu, 16 Feb 2023 05:20:33 -0500
X-MC-Unique: sXlW34CtMmaqkVG5QGc2FQ-1
Received: by mail-qk1-f198.google.com with SMTP id j10-20020a05620a288a00b0070630ecfd9bso888671qkp.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d2F3j0rYGNO9oHzYnL7gUMrLwfVFcsHDqpyr29XsFY=;
        b=cGvbK3/syy+NxR2VaqYAA2PtQjKUczw/74ODgbVfiBxxz6lwEa0Zx+PfhQ+aAHKLd+
         xKW4SrXfciU9wzuGLHGR/9nEL2eg8ezWQqdmBhAEYzEEZdELAomN7RAAeY2vstExf9M7
         YfeVPz08xel+mp10lnWfpeW818Y8RiOtHDPL6lAjXUB9Z9eDlExFw6XAmc2F+xJ/PLGV
         7VeqIAUEntOWpZFKWm2T+OkLpHcWaE2U8v5J8R8gBlLtKbv/oXZMY/Q37MLhxAZPvkcT
         L0vN7w3XzauVB60n1g5EjLIK1dMLK4lmGkppu7U278OAfNnypcuehzRyGLec3+aopdjb
         jOng==
X-Gm-Message-State: AO0yUKWV96Mi5oAP3/oh9ZImmxOYSp8/ayyvZT2Pc1fTuyhQxgtuAmsr
        nD3cMLO7nCFgP+o9f9ftwcsy9glCrhgPN/ALQlqfwjBkKnVBtpjdf/+Pu47dyAq7ovI7Vj06hco
        rIbT+pcz/YnpXkxa1melJEREz
X-Received: by 2002:a05:622a:174d:b0:3ab:a047:58ee with SMTP id l13-20020a05622a174d00b003aba04758eemr9376173qtk.25.1676542832975;
        Thu, 16 Feb 2023 02:20:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8WG516tWCWUltiUeGBZdvhUmS/AHWTqFHc3ZJxdL6RnhQL67hG28I/A0hEUzhvBPMCOVbEhw==
X-Received: by 2002:a05:622a:174d:b0:3ab:a047:58ee with SMTP id l13-20020a05622a174d00b003aba04758eemr9376145qtk.25.1676542832685;
        Thu, 16 Feb 2023 02:20:32 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it. [82.57.51.167])
        by smtp.gmail.com with ESMTPSA id a14-20020aed278e000000b003b8238114d9sm986954qtd.12.2023.02.16.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:20:32 -0800 (PST)
Date:   Thu, 16 Feb 2023 11:20:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jakub@cloudflare.com, hdanton@sina.com, cong.wang@bytedance.com
Subject: Re: [PATCH RFC net-next v2 0/3] vsock: add support for sockmap
Message-ID: <20230216102023.jplhourjlvupeazy@sgarzare-redhat>
References: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bobby,
sorry for my late reply, but I have been offline these days.
I came back a few days ago and had to work off some accumulated work :-)

On Mon, Jan 30, 2023 at 08:35:11PM -0800, Bobby Eshleman wrote:
>Add support for sockmap to vsock.
>
>We're testing usage of vsock as a way to redirect guest-local UDS requests to
>the host and this patch series greatly improves the performance of such a
>setup.
>
>Compared to copying packets via userspace, this improves throughput by 121% in
>basic testing.
>
>Tested as follows.
>
>Setup: guest unix dgram sender -> guest vsock redirector -> host vsock server
>Threads: 1
>Payload: 64k
>No sockmap:
>- 76.3 MB/s
>- The guest vsock redirector was
>  "socat VSOCK-CONNECT:2:1234 UNIX-RECV:/path/to/sock"
>Using sockmap (this patch):
>- 168.8 MB/s (+121%)
>- The guest redirector was a simple sockmap echo server,
>  redirecting unix ingress to vsock 2:1234 egress.
>- Same sender and server programs
>
>*Note: these numbers are from RFC v1
>
>Only the virtio transport has been tested. The loopback transport was used in
>writing bpf/selftests, but not thoroughly tested otherwise.
>
>This series requires the skb patch.
>
>Changes in v2:
>- vsock/bpf: rename vsock_dgram_* -> vsock_*
>- vsock/bpf: change sk_psock_{get,put} and {lock,release}_sock() order to
>	     minimize slock hold time
>- vsock/bpf: use "new style" wait
>- vsock/bpf: fix bug in wait log
>- vsock/bpf: add check that recvmsg sk_type is one dgram, seqpacket, or stream.
>	     Return error if not one of the three.
>- virtio/vsock: comment __skb_recv_datagram() usage
>- virtio/vsock: do not init copied in read_skb()
>- vsock/bpf: add ifdef guard around struct proto in dgram_recvmsg()
>- selftests/bpf: add vsock loopback config for aarch64
>- selftests/bpf: add vsock loopback config for s390x
>- selftests/bpf: remove vsock device from vmtest.sh qemu machine
>- selftests/bpf: remove CONFIG_VIRTIO_VSOCKETS=y from config.x86_64
>- vsock/bpf: move transport-related (e.g., if (!vsk->transport)) checks out of
>	     fast path

The series looks in a good shape.
I left some small comments on the first patch, but I think the next
version could be without RFC, so we can receive some feedbacks from
net/bpf maintainers.

Great job!

Thanks,
Stefano

