Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2340F63ECD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiLAJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLAJqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2C89AED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669887956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jFiCUY0VXNcy859wsO8NBTioywcuSZZtPBsENMWnSA=;
        b=Ef+3veNnnylOe0CXr1djbs6ZINvFCuH4CxtbVhiLjc6xNOPemiOh+/AyMghx30kZGJ8X6n
        R1qTe69f+eYbuFQQtdHiv7yPnT29NiF6/HjJMCOPiCBVwT3XTJl9nZByJoY3RWLQVcH7Mu
        a8ytjrHLRWWQo2Agf+e8bm3u2XTI/Sg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-j4pjFFitMPSOAF7zlDRSZA-1; Thu, 01 Dec 2022 04:45:55 -0500
X-MC-Unique: j4pjFFitMPSOAF7zlDRSZA-1
Received: by mail-wm1-f69.google.com with SMTP id f18-20020a7bcd12000000b003d077f0e3e5so470969wmj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jFiCUY0VXNcy859wsO8NBTioywcuSZZtPBsENMWnSA=;
        b=oYSYNF6mKNNOTtmTvrgEcM/DpYUfzLEygXfbJDngxRUgMRd5e6Cf8y/zp/8/hUG02L
         Y3HLjdNXec8D6ZDZgbvQUuMMglDY6Apf33DjKlxB7+Hj1FI/nUFYoEUNfIJFuhBc/NdL
         s9OAsXaRGx6dsOLU/f0v38XF9Wr2GPdwloxpbxFYZHb7m9Zkad7sxqcH6xq2q5Q7H632
         9TFTtUTKoOkKXvTH94kzSqsBB/U7V63lPPY9Z1ru+5hfxlb8PDaG01FMXSjq5A79tnca
         2eIGlPXDMIF+iEJ231hT3XwtxfQ36tZrwtFM0E/NCTEG2yMbe8/CodDM83Zd8Ie49amJ
         66LQ==
X-Gm-Message-State: ANoB5pn8FwMiVwTyJgFvQvC2jLy3SDxElu2g9H3oDHmI7zvLv1cZZ3NZ
        wzOqRaD8ujVuiFsv+oASS/t3pcEWs1rAP00VJzA3wGIlIXaBm7c6yr0PwYBUMFUXUR/g9Y3qsKY
        KfXLJmQYG4F8qb/1KjE6ituDo
X-Received: by 2002:a5d:5709:0:b0:241:d71c:5dde with SMTP id a9-20020a5d5709000000b00241d71c5ddemr32282800wrv.678.1669887954217;
        Thu, 01 Dec 2022 01:45:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5nW23nrN+fFkGvbidJKQkIpQeOg7U4YOPGmwbwBTJo0vjWdvoPfPZAVrz0Zpx4X0wkQ8bdVg==
X-Received: by 2002:a5d:5709:0:b0:241:d71c:5dde with SMTP id a9-20020a5d5709000000b00241d71c5ddemr32282770wrv.678.1669887953965;
        Thu, 01 Dec 2022 01:45:53 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id jb17-20020a05600c54f100b003d070272f25sm4660834wmb.8.2022.12.01.01.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:45:53 -0800 (PST)
Date:   Thu, 1 Dec 2022 10:45:41 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v2 5/6] test/vsock: add big message test
Message-ID: <20221201094541.gj7zthelbeqhsp63@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <2634ad7f-b462-5c69-8aa1-2f200a6beb20@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2634ad7f-b462-5c69-8aa1-2f200a6beb20@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:13:06PM +0000, Arseniy Krasnov wrote:
>This adds test for sending message, bigger than peer's buffer size.
>For SOCK_SEQPACKET socket it must fail, as this type of socket has
>message size limit.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 69 ++++++++++++++++++++++++++++++++
> 1 file changed, 69 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 12ef0cca6f93..a8e43424fb32 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -569,6 +569,70 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>+{
>+	unsigned long sock_buf_size;
>+	ssize_t send_size;
>+	socklen_t len;
>+	void *data;
>+	int fd;
>+
>+	len = sizeof(sock_buf_size);
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (getsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &sock_buf_size, &len)) {
>+		perror("getsockopt");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	sock_buf_size++;
>+
>+	data = malloc(sock_buf_size);
>+	if (!data) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	send_size = send(fd, data, sock_buf_size, 0);
>+	if (send_size != -1) {
>+		fprintf(stderr, "expected 'send(2)' failure, got %zi\n",
>+			send_size);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != EMSGSIZE) {
>+		fprintf(stderr, "expected EMSGSIZE in 'errno', got %i\n",
>+			errno);
>+		exit(EXIT_FAILURE);
>+	}

We should make sure that this is true for all transports, but since now 
only virtio-vsock supports it, we should be okay.

>+
>+	control_writeln("CLISENT");
>+
>+	free(data);
>+	close(fd);
>+}
>+
>+static void test_seqpacket_bigmsg_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("CLISENT");
>+
>+	close(fd);
>+}
>+
> #define BUF_PATTERN_1 'a'
> #define BUF_PATTERN_2 'b'
>
>@@ -851,6 +915,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_poll_rcvlowat_client,
> 		.run_server = test_stream_poll_rcvlowat_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET big message",
>+		.run_client = test_seqpacket_bigmsg_client,
>+		.run_server = test_seqpacket_bigmsg_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

