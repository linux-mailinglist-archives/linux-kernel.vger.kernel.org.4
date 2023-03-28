Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181026CBB30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjC1JiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjC1JiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C390B72A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679996221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWP56QTwI0j5S4y9OZwMMK69ElYFfc3hdgO7pVbXfvc=;
        b=co6Wx04JyeN3Z7iAWKKO8khq4oDDkO2EQ3NbRZ9fxpbBZs/m/tcDcgFeoZkSmKAwBrHKVD
        FLGPnoErjqwjkcUFPS7TYaUTPaQpSfjkTO3P5Lmtyaxf9y/G+0UT8Op6NzkUqcue1ypnN+
        94grvgxrL+bOf1WVLlO5lsI2mq2W8aA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-QaL9G5XlMHWPAsho_r0PUQ-1; Tue, 28 Mar 2023 05:30:57 -0400
X-MC-Unique: QaL9G5XlMHWPAsho_r0PUQ-1
Received: by mail-qk1-f198.google.com with SMTP id z187-20020a3765c4000000b007468706dfb7so5295919qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWP56QTwI0j5S4y9OZwMMK69ElYFfc3hdgO7pVbXfvc=;
        b=SB1ehNTjadJULTl906Yhx2LMp404CQc97BsZ9bfxE0olUR4ByNFn+mY64Z2QFC24iT
         dJKcC2QvvfTwPzsskKYmZOLNtxMiuPwp15DyuNdJSDWeK9sKThkWa4j/r+Bie62B1SG4
         xRmgJP4/zmWuIBrivjx+oHMkTmeELqiCBE7sG1+0CbmqOvPAOO1/wyWCnZjWtNXdiM/g
         vZq+1zGgWCOecUGoaR92J8qRECKLpI+ZgBtJOpdIcFmL4ZEunchZOjNiR0fqUvyh36yp
         PE7N74bplzRJ5h+kUV9p3G92406xkdLZjJ2VUqpXnnm460ero8AHxw0tH3Acb8/vz25K
         l76g==
X-Gm-Message-State: AAQBX9eeWVh144YunLPkNJESs3S3VDzgzJ4Y00JUQkDSTWDpNZkQUIyD
        mZwYDYPflK5zvhAHIi2Sh6nBj+Ui6/6gkwuTVlZLG0kwoBwm7LvhUEkjqO/8CWYBlL2YkH9IMLj
        3+9n/3HHMTjDSczvzfr8k2U9r
X-Received: by 2002:a05:6214:f67:b0:5a9:d6dd:271e with SMTP id iy7-20020a0562140f6700b005a9d6dd271emr28333794qvb.18.1679995856866;
        Tue, 28 Mar 2023 02:30:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZwIE40bSx1WKsFgqe2PCHGzCXvqVs53jO1BzC3wYrOuhs7M2wOyYY3HNPlwUdzzs+Ntl0tyQ==
X-Received: by 2002:a05:6214:f67:b0:5a9:d6dd:271e with SMTP id iy7-20020a0562140f6700b005a9d6dd271emr28333776qvb.18.1679995856610;
        Tue, 28 Mar 2023 02:30:56 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id cy2-20020a05621418c200b005deeeba2aa2sm1892696qvb.43.2023.03.28.02.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:30:56 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:30:51 +0200
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
Subject: Re: [RFC PATCH v2 3/3] test/vsock: new skbuff appending test
Message-ID: <fgtpnj6zgti2ed2xcwwfetv5lnie7onph3inqm6y3mrisaumtw@y47xhizbyf7m>
References: <728181e9-6b35-0092-3d01-3d7aff4521b6@sberdevices.ru>
 <776a30e8-3cd5-35ba-5187-63c9b83eaa44@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <776a30e8-3cd5-35ba-5187-63c9b83eaa44@sberdevices.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 01:10:16AM +0300, Arseniy Krasnov wrote:
>This adds test which checks case when data of newly received skbuff is
>appended to the last skbuff in the socket's queue. It looks like simple
>test with 'send()' and 'recv()', but internally it triggers logic which
>appends one received skbuff to another. Test checks that this feature
>works correctly.
>
>This test is actual only for virtio transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 90 ++++++++++++++++++++++++++++++++
> 1 file changed, 90 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 3de10dbb50f5..12b97c92fbb2 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -968,6 +968,91 @@ static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
> 	test_inv_buf_server(opts, false);
> }
>
>+#define HELLO_STR "HELLO"
>+#define WORLD_STR "WORLD"
>+
>+static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
>+{
>+	ssize_t res;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Send first skbuff. */
>+	res = send(fd, HELLO_STR, strlen(HELLO_STR), 0);
>+	if (res != strlen(HELLO_STR)) {
>+		fprintf(stderr, "unexpected send(2) result %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SEND0");
>+	/* Peer reads part of first skbuff. */
>+	control_expectln("REPLY0");
>+
>+	/* Send second skbuff, it will be appended to the first. */
>+	res = send(fd, WORLD_STR, strlen(WORLD_STR), 0);
>+	if (res != strlen(WORLD_STR)) {
>+		fprintf(stderr, "unexpected send(2) result %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SEND1");
>+	/* Peer reads merged skbuff packet. */
>+	control_expectln("REPLY1");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[64];
>+	ssize_t res;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SEND0");
>+
>+	/* Read skbuff partially. */
>+	res = recv(fd, buf, 2, 0);
>+	if (res != 2) {
>+		fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("REPLY0");
>+	control_expectln("SEND1");
>+
>+	res = recv(fd, buf + 2, sizeof(buf) - 2, 0);
>+	if (res != 8) {
>+		fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	res = recv(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT);
>+	if (res != -1) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
>+		fprintf(stderr, "pattern mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("REPLY1");
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1038,6 +1123,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_inv_buf_client,
> 		.run_server = test_seqpacket_inv_buf_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM virtio skb merge",
>+		.run_client = test_stream_virtio_skb_merge_client,
>+		.run_server = test_stream_virtio_skb_merge_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

