Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EDD651EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiLTKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLTKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D27BE3D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671532547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xIE948N+OVyD9RxTPjKQ11q6Fjch6dgm41Al2E4iz0=;
        b=hErDz/vIIXmxX6pXfMRZRf6yr1oVt7xtf1J8SvGy+bXyrsyf91yufTNNcXqLXsQGeMuPRE
        I+q5JjJTkXBt8eeSyzjx+5dIs9ccDJqRRehP2e8TjW42Keb+rcqaiOL0NQx9P+c/6zOehH
        p0lKpdU0V8EmVBUnVPG+BnuQMqsZ5JQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-QSEUWu0gO1ysYUMcpYrDZQ-1; Tue, 20 Dec 2022 05:35:45 -0500
X-MC-Unique: QSEUWu0gO1ysYUMcpYrDZQ-1
Received: by mail-wm1-f69.google.com with SMTP id i132-20020a1c3b8a000000b003d0f49bc21bso7862466wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xIE948N+OVyD9RxTPjKQ11q6Fjch6dgm41Al2E4iz0=;
        b=5ED0wIXnZYbCCtjmJ/Q7C59OPaUnQIYSbC9fotgqUtB5BdoNDN/GSJRDkchfvS2aAN
         zt3QMYhXeqfan1QAWhNwELOjl3FZqRGVcG10vpMTBkIPEaMzF9IpEvGr8I6b5L4BIw7O
         6boL3LxGRb663VR7rzAHvi07il7Wu1zdn2zhJmlaISThgByPMmoxNeJTjFBY9nfVdpM+
         cRUuCuTV2gFxSbIQhVHSaKEQZwh8aJQL8T7YMLu91LWbszCnZaVuk7yfJQj+0SYyNW6s
         4Ps7F1dFdmqc88keln5iENO7Me+ylDGTBnve7ZAYAXTV8iTIBppWnWAGvWYbJT+Ifomv
         gmZg==
X-Gm-Message-State: AFqh2kp1oGRg7ureJukXnV81z2KSPIljg5Ki5DAgdbwxpIdh9Dyr+zGf
        SCqDuiZzB3dVgLGZFuiTybkVtDZnOOQZr/5fI7jUnPP2OAG33Rrm9D6AKdFg9Leui+Xe2YLdd0K
        lPZDaAFagqybFqFokPsU24pd+
X-Received: by 2002:a05:600c:3b08:b0:3d3:4a47:52e9 with SMTP id m8-20020a05600c3b0800b003d34a4752e9mr8998383wms.15.1671532544034;
        Tue, 20 Dec 2022 02:35:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXswZvLV6vC3rUs9MMkLlnmeQY6d+pmClDori0caDrXbfFSl7htQYg5vZB4m7wOx5HQXfo1nIg==
X-Received: by 2002:a05:600c:3b08:b0:3d3:4a47:52e9 with SMTP id m8-20020a05600c3b0800b003d34a4752e9mr8998362wms.15.1671532543832;
        Tue, 20 Dec 2022 02:35:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b003d23928b654sm21773342wmf.11.2022.12.20.02.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:35:43 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:35:38 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v5 4/4] test/vsock: vsock_perf utility
Message-ID: <20221220103538.msrgcwsolmzoc2r4@sgarzare-redhat>
References: <e04f749e-f1a7-9a1d-8213-c633ffcc0a69@sberdevices.ru>
 <d92184cd-e79b-80ae-4f89-92dfd43d1e92@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d92184cd-e79b-80ae-4f89-92dfd43d1e92@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:23:46AM +0000, Arseniy Krasnov wrote:
>This adds utility to check vsock rx/tx performance.
>
>Usage as sender:
>./vsock_perf --sender <cid> --port <port> --bytes <bytes to send>
>Usage as receiver:
>./vsock_perf --port <port> --rcvlowat <SO_RCVLOWAT>
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/Makefile     |   3 +-
> tools/testing/vsock/README       |  34 +++
> tools/testing/vsock/vsock_perf.c | 441 +++++++++++++++++++++++++++++++
> 3 files changed, 477 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/vsock/vsock_perf.c
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index f8293c6910c9..43a254f0e14d 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -1,8 +1,9 @@
> # SPDX-License-Identifier: GPL-2.0-only
>-all: test
>+all: test vsock_perf
> test: vsock_test vsock_diag_test
> vsock_test: vsock_test.o timeout.o control.o util.o
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>+vsock_perf: vsock_perf.o
>
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
>diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
>index 4d5045e7d2c3..e6f6735bba05 100644
>--- a/tools/testing/vsock/README
>+++ b/tools/testing/vsock/README
>@@ -35,3 +35,37 @@ Invoke test binaries in both directions as follows:
>                        --control-port=$GUEST_IP \
>                        --control-port=1234 \
>                        --peer-cid=3
>+
>+vsock_perf utility
>+-------------------
>+'vsock_perf' is a simple tool to measure vsock performance. It works in
>+sender/receiver modes: sender connect to peer at the specified port and
>+starts data transmission to the receiver. After data processing is done,
>+it prints several metrics(see below).
>+
>+Usage:
>+# run as sender
>+# connect to CID 2, port 1234, send 1G of data, tx buf size is 1M
>+./vsock_perf --sender 2 --port 1234 --bytes 1G --buf-size 1M
>+
>+Output:
>+tx performance: A Gb/s
>+
>+Output explanation:
>+A is calculated as "number of bytes to send" / "time in tx loop"
>+
>+# run as receiver
>+# listen port 1234, rx buf size is 1M, socket buf size is 1G, SO_RCVLOWAT is 64K
>+./vsock_perf --port 1234 --buf-size 1M --vsk-size 1G --rcvlowat 64K
>+
>+Output:
>+rx performance: A Gb/s
>+total in 'read()': B sec
>+POLLIN wakeups: C
>+average in 'read()': D ns
>+
>+Output explanation:
>+A is calculated as "number of received bytes" / "time in rx loop".
>+B is time, spent in 'read()' system call(excluding 'poll()')
>+C is number of 'poll()' wake ups with POLLIN bit set.
>+D is B / C, e.g. average amount of time, spent in single 'read()'.

Since now we prints Gbits/s I think we should update the previous lines.
But the rest looks good to me. So with the updated README:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

