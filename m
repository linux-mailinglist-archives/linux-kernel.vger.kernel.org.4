Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F386B2B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCIQms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCIQmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE801689E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678379442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z4raW7JwK9AMYLNaG7Amr5oIsub3jCwJbX6vi87O+9M=;
        b=KaakZY4VpoWDhsdqpd7rTaZarb3vF9Rz8YG+l18Chclhb127Bq9vWsC4eCq7UWd99ndK4u
        1qg8DBJiKF6CtibCaXIK1EXWVtq7dj+v+DRef9RJZDwgAPNlNZiOZ4V5MVid0oMN+sCxWH
        pzaValVcWempkOuvrp408X6EBkgGB7E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-s7_6Hll4MpiTDwDveH9lOQ-1; Thu, 09 Mar 2023 11:30:40 -0500
X-MC-Unique: s7_6Hll4MpiTDwDveH9lOQ-1
Received: by mail-qk1-f197.google.com with SMTP id ou5-20020a05620a620500b007423e532628so1477576qkn.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 08:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678379440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4raW7JwK9AMYLNaG7Amr5oIsub3jCwJbX6vi87O+9M=;
        b=6Msb3lmuzGBEbUKcBHwr+PCBz1Cp0GxaKsClWf7VbjLJOuEmqRNZHwGDXvy2aAh4LU
         9QmvfyYHQ/RD4kR1xwUP1BGpHaIQ34AaNEXGCJhfv0Tvnjvx47GfuWBLSH6/NSwT3Ixg
         yhOSgqewj03wuR4Jru4n+asDbhBaLtzLNhmpepKz2reT41hqilEZ2DgSXdYznAZ0LI9d
         FszIJzTNP5pfpP1X2Tl9vcXHbKkI9ynbNYOVyZT+Wt4Ek3w6l+EWuD3vAiYwAi5ynord
         iJCMixRM2gkiu0TCzwiCUCKHG/WSI5CtsI7uA83QJO6ouAe0gL7hnkUVSGxT08nkM9Ea
         NlZw==
X-Gm-Message-State: AO0yUKVGcdIUm65hpwLRTK0nqGyZmrX9K9h15I3wdnjncDmwXK8VikS5
        kpfVgjL+8v0V2jRRgogT6VMxQkS15A0GtfhAsgUSb/Q7NkwLmzGw8XMhoqFvfj7+bLmjBZ5R5Mh
        yc3UHW2AibOQ4e1quTcjAS9KR
X-Received: by 2002:a05:622a:d4:b0:3bf:dc57:5034 with SMTP id p20-20020a05622a00d400b003bfdc575034mr9196016qtw.29.1678379440307;
        Thu, 09 Mar 2023 08:30:40 -0800 (PST)
X-Google-Smtp-Source: AK7set9F/7Lif+W8Grh5U9Rl6sCN3eyoUaSPb2LI2vQ/RFVdDMCaeHv1X/pGMvmo6/ilZGbAAqWACw==
X-Received: by 2002:a05:622a:d4:b0:3bf:dc57:5034 with SMTP id p20-20020a05622a00d400b003bfdc575034mr9195975qtw.29.1678379439938;
        Thu, 09 Mar 2023 08:30:39 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id u37-20020a05622a19a500b003bd0e7ff466sm14142374qtc.7.2023.03.09.08.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 08:30:39 -0800 (PST)
Date:   Thu, 9 Mar 2023 17:30:34 +0100
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
Subject: Re: [RFC PATCH v3 4/4] test/vsock: copy to user failure test
Message-ID: <20230309163034.bznx6pywv5a45egw@sgarzare-redhat>
References: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
 <5d726a68-8530-3e90-202c-ba21996db60f@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d726a68-8530-3e90-202c-ba21996db60f@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:14:48PM +0300, Arseniy Krasnov wrote:
>This adds SOCK_STREAM and SOCK_SEQPACKET tests for invalid buffer case.
>It tries to read data to NULL buffer (data already presents in socket's
>queue), then uses valid buffer. For SOCK_STREAM second read must return
>data, because skbuff is not dropped, but for SOCK_SEQPACKET skbuff will
>be dropped by kernel, and 'recv()' will return EAGAIN.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 118 +++++++++++++++++++++++++++++++
> 1 file changed, 118 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 67e9f9df3a8c..3de10dbb50f5 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -860,6 +860,114 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define INV_BUF_TEST_DATA_LEN 512
>+
>+static void test_inv_buf_client(const struct test_opts *opts, bool stream)
>+{
>+	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
>+	ssize_t ret;
>+	int fd;
>+
>+	if (stream)
>+		fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	else
>+		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENDDONE");
>+
>+	/* Use invalid buffer here. */
>+	ret = recv(fd, NULL, sizeof(data), 0);
>+	if (ret != -1) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != ENOMEM) {
>+		fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	ret = recv(fd, data, sizeof(data), MSG_DONTWAIT);
>+
>+	if (stream) {
>+		/* For SOCK_STREAM we must continue reading. */
>+		if (ret != sizeof(data)) {
>+			fprintf(stderr, "expected recv(2) success, got %zi\n", ret);
>+			exit(EXIT_FAILURE);
>+		}
>+		/* Don't check errno in case of success. */
>+	} else {
>+		/* For SOCK_SEQPACKET socket's queue must be empty. */
>+		if (ret != -1) {
>+			fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		if (errno != EAGAIN) {
>+			fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
>+	control_writeln("DONE");
>+
>+	close(fd);
>+}
>+
>+static void test_inv_buf_server(const struct test_opts *opts, bool stream)
>+{
>+	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
>+	ssize_t res;
>+	int fd;
>+
>+	if (stream)
>+		fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	else
>+		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	res = send(fd, data, sizeof(data), 0);
>+	if (res != sizeof(data)) {
>+		fprintf(stderr, "unexpected send(2) result %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SENDDONE");
>+
>+	control_expectln("DONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_inv_buf_client(const struct test_opts *opts)
>+{
>+	test_inv_buf_client(opts, true);
>+}
>+
>+static void test_stream_inv_buf_server(const struct test_opts *opts)
>+{
>+	test_inv_buf_server(opts, true);
>+}
>+
>+static void test_seqpacket_inv_buf_client(const struct test_opts *opts)
>+{
>+	test_inv_buf_client(opts, false);
>+}
>+
>+static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
>+{
>+	test_inv_buf_server(opts, false);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -920,6 +1028,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_bigmsg_client,
> 		.run_server = test_seqpacket_bigmsg_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM test invalid buffer",
>+		.run_client = test_stream_inv_buf_client,
>+		.run_server = test_stream_inv_buf_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET test invalid buffer",
>+		.run_client = test_seqpacket_inv_buf_client,
>+		.run_server = test_seqpacket_inv_buf_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

