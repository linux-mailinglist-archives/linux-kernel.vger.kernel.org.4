Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6216990D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBPKNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBPKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAC518C6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676542347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLm8OV5SZ3K17LU2/PE/CsDcErtwY0pKaR4xgAdsEhE=;
        b=ODAbm4nmeSd4KT7Sbw6UCb064h/3NCJu3dtxBCzFlhd5KHWKgNdxon4n2ADSHNbaCzMJ0p
        MsA3RyCo3+m451yPjRiCelprOpTBjDTpKl9cP2Z5Bw+4B6AyKlsdWqz0YdvjVd6RTpYlrx
        dFi8+5QMnOMoVRMeZcrdsk3Men5T/VI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-o66YhWYMMkC1F6jS90nzuQ-1; Thu, 16 Feb 2023 05:12:26 -0500
X-MC-Unique: o66YhWYMMkC1F6jS90nzuQ-1
Received: by mail-qv1-f70.google.com with SMTP id r10-20020a0562140c8a00b0056ed45f262dso818990qvr.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLm8OV5SZ3K17LU2/PE/CsDcErtwY0pKaR4xgAdsEhE=;
        b=rnynDF9bTD/PuSrbqcSREodCln+OoDlH639wiKBHHDzzfbXm/qUJvZnhK6fAlDN8iq
         oyT9mH3ayD7BGypkj/JQAyM71tjbus0CjjnwcIU86GZRprDK0K//hua1Rj5f7/p2Q+3x
         IioxCa7a2MlIVvEYApqgHhRMMx8GWQnwIoygr2JHRjO+rK7cYgJBRva3CdrIIq9ED8Z/
         mP3u8HYk9V03gEzj8chO0ClRDL9PpC0Wd11rU1iplYcyY8xizaajkt9tCibY1cwtFh9+
         hW7kylg3avHoaWo+S+FibhS+dKd1mPpOTmfZ9P2btY3sxjBAeqScy+9l1dCLf3Dcx3mV
         7qYg==
X-Gm-Message-State: AO0yUKWuqMBB6vN4QzokyWQIjRjorGwW9gxkpJs84ullDB6Vhvu1noxs
        cuWHjbmQA2IdOFEbj/oElTOZ0jOTX4zeOfv4q0BN3wBab2EGiHkpiDR8jZFDsvFJvxvQ9zDHY0t
        prrSHQvJNNyNofFliSivIBgG1
X-Received: by 2002:a05:622a:4d4:b0:3b8:6b96:de6d with SMTP id q20-20020a05622a04d400b003b86b96de6dmr8781699qtx.18.1676542343688;
        Thu, 16 Feb 2023 02:12:23 -0800 (PST)
X-Google-Smtp-Source: AK7set/zE2Vo8IFiM5bi4CYFWFwpnz4WpLl7uD3E3+3LHHuXvGxuiCHVQXEZwLa/M9o96TnD3MRZ3w==
X-Received: by 2002:a05:622a:4d4:b0:3b8:6b96:de6d with SMTP id q20-20020a05622a04d400b003b86b96de6dmr8781680qtx.18.1676542343413;
        Thu, 16 Feb 2023 02:12:23 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it. [82.57.51.167])
        by smtp.gmail.com with ESMTPSA id o14-20020ac8554e000000b003b9e1d3a502sm453519qtr.54.2023.02.16.02.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:12:23 -0800 (PST)
Date:   Thu, 16 Feb 2023 11:12:14 +0100
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
Subject: Re: [PATCH RFC net-next v2 2/3] selftests/bpf: add vsock to vmtest.sh
Message-ID: <20230216101214.eor4myzdsvihjww3@sgarzare-redhat>
References: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
 <20230118-support-vsock-sockmap-connectible-v2-2-58ffafde0965@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v2-2-58ffafde0965@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 08:35:13PM -0800, Bobby Eshleman wrote:
>Add vsock loopback to the test kernel.
>
>This allows sockmap for vsock to be tested.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> tools/testing/selftests/bpf/config.aarch64 | 2 ++
> tools/testing/selftests/bpf/config.s390x   | 3 +++
> tools/testing/selftests/bpf/config.x86_64  | 3 +++
> 3 files changed, 8 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
>index 1f0437644186..253821494884 100644
>--- a/tools/testing/selftests/bpf/config.aarch64
>+++ b/tools/testing/selftests/bpf/config.aarch64
>@@ -176,6 +176,8 @@ CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> CONFIG_VIRTIO_MMIO=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_VLAN_8021Q=y
> CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_XFRM_USER=y
>diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
>index d49f6170e7bd..2ba92167be35 100644
>--- a/tools/testing/selftests/bpf/config.s390x
>+++ b/tools/testing/selftests/bpf/config.s390x
>@@ -140,5 +140,8 @@ CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_VLAN_8021Q=y
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_XFRM_USER=y
>diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
>index dd97d61d325c..b650b2e617b8 100644
>--- a/tools/testing/selftests/bpf/config.x86_64
>+++ b/tools/testing/selftests/bpf/config.x86_64
>@@ -234,7 +234,10 @@ CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_VLAN_8021Q=y
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_MSR=y
>
>-- 
>2.35.1
>

