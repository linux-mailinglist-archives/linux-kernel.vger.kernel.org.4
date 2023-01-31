Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE35682FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjAaOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjAaOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:52:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7C4EE2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675176722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOqTMgwgFTLYyDST2XEK1yQ+7SKszENyNjo2hw2IN88=;
        b=Q1nEMn0Y1DNDb/EaxnoUIDAokhmZRde/yWOK9WJuwFfd0dVEb84ty0EWnMFLYNDgzn+ZRc
        uFyhGCkSnAI2PCusX0T9SB/2P4/UeqMWyUOyIiTj+DG68OOnauym/zIwBsff1U/XxMvfwl
        iVfWrZFFJ5e1GyCQx7tw8t1bFH+pAkw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-PyZbDY7qPPW7kMz8jNGHtw-1; Tue, 31 Jan 2023 09:52:01 -0500
X-MC-Unique: PyZbDY7qPPW7kMz8jNGHtw-1
Received: by mail-qt1-f199.google.com with SMTP id hf20-20020a05622a609400b003abcad051d2so6625898qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOqTMgwgFTLYyDST2XEK1yQ+7SKszENyNjo2hw2IN88=;
        b=njU3WFONgnUiS6MWJJ3wxKYRy0iT7nB/cfTs8seMyGQk7t3LPMYk5G5lHPi0KQCe6v
         Y+H3xCCevvWS9EneLhM86MHF/bI9a/1Mdmy7m5VHRBstwEBP5sgwIkNq6XgvjyRVEQKZ
         hHJWZm2h2o4kuvtnpbCcIMCFtto+JmluYMyub+mBQ1w/uKUWiPanBVKWEYUqW4Q6TkcD
         ZUxT8oaKHmAJ83sGUtD+G69orQliTf6aei/DCTHJJmIlgDXfcOfv0BtiN/XhSBMg8SLj
         khrQjGOkANqODq+zH9eMYQFQ93lFJp/2WbYcD/D1nsgn0JxOOGIxEmb4hcZXFcot0xBY
         ZzxQ==
X-Gm-Message-State: AO0yUKU0RKNeGU6eK9aSHwotBmCjokcrTkdyUJtCk3SdXep6F82K3+/z
        V/2ibbFLS9teXzMQBNPN/DmFXZwjLvceNuptLA0IsxjjW7D5bAzCqUc2eZi4tf+fJUdU8BXycPV
        irzN4Nph1lDVzRq3FuPZWQ53t
X-Received: by 2002:a0c:c484:0:b0:537:7e81:73ec with SMTP id u4-20020a0cc484000000b005377e8173ecmr10071881qvi.3.1675176720030;
        Tue, 31 Jan 2023 06:52:00 -0800 (PST)
X-Google-Smtp-Source: AK7set8HW6qDSNpYNC8KxyvMb7ghZ+XieLE/yKQnmq9r6WIhBSPEiSyaun4EPhHbIQjbm7qVnbMZvw==
X-Received: by 2002:a0c:c484:0:b0:537:7e81:73ec with SMTP id u4-20020a0cc484000000b005377e8173ecmr10071856qvi.3.1675176719754;
        Tue, 31 Jan 2023 06:51:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id v1-20020ae9e301000000b007062139ecb3sm4513909qkf.95.2023.01.31.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:51:59 -0800 (PST)
Message-ID: <d9ca623d01274889913001ce92f686652fa8fea8.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] selftests: net: udpgso_bench_tx: Cater for
 pending datagrams zerocopy benchmarking
From:   Paolo Abeni <pabeni@redhat.com>
To:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Jan 2023 15:51:55 +0100
In-Reply-To: <20230131130412.432549-4-andrei.gherzan@canonical.com>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
         <20230131130412.432549-4-andrei.gherzan@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-31 at 13:04 +0000, Andrei Gherzan wrote:
> The test tool can check that the zerocopy number of completions value is
> valid taking into consideration the number of datagram send calls. This c=
an
> catch the system into a state where the datagrams are still in the system
> (for example in a qdisk, waiting for the network interface to return a
> completion notification, etc).
>=20
> This change adds a retry logic of computing the number of completions up =
to
> a configurable (via CLI) timeout (default: 2 seconds).
>=20
> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> ---
>  tools/testing/selftests/net/udpgso_bench_tx.c | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testin=
g/selftests/net/udpgso_bench_tx.c
> index b47b5c32039f..5a29b5f24023 100644
> --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> @@ -62,6 +62,7 @@ static int	cfg_payload_len	=3D (1472 * 42);
>  static int	cfg_port	=3D 8000;
>  static int	cfg_runtime_ms	=3D -1;
>  static bool	cfg_poll;
> +static int	cfg_poll_loop_timeout_ms =3D 2000;
>  static bool	cfg_segment;
>  static bool	cfg_sendmmsg;
>  static bool	cfg_tcp;
> @@ -235,16 +236,17 @@ static void flush_errqueue_recv(int fd)
>  	}
>  }
> =20
> -static void flush_errqueue(int fd, const bool do_poll)
> +static void flush_errqueue(int fd, const bool do_poll,
> +		unsigned long poll_timeout, const bool poll_err)
>  {
>  	if (do_poll) {
>  		struct pollfd fds =3D {0};
>  		int ret;
> =20
>  		fds.fd =3D fd;
> -		ret =3D poll(&fds, 1, 500);
> +		ret =3D poll(&fds, 1, poll_timeout);
>  		if (ret =3D=3D 0) {
> -			if (cfg_verbose)
> +			if ((cfg_verbose) && (poll_err))
>  				fprintf(stderr, "poll timeout\n");
>  		} else if (ret < 0) {
>  			error(1, errno, "poll");
> @@ -254,6 +256,22 @@ static void flush_errqueue(int fd, const bool do_pol=
l)
>  	flush_errqueue_recv(fd);
>  }
> =20
> +static void flush_errqueue_retry(int fd, const bool do_poll, unsigned lo=
ng num_sends)
> +{
> +	unsigned long tnow, tstop;
> +	bool first_try =3D true;
> +
> +	tnow =3D gettimeofday_ms();
> +	tstop =3D tnow + cfg_poll_loop_timeout_ms;
> +	do {
> +		flush_errqueue(fd, do_poll, tstop - tnow, first_try);
> +		first_try =3D false;
> +		if (!do_poll)
> +			usleep(1000);  // a throttling delay if polling is enabled

Even if the kernel codying style is not very strictly enforced for
self-tests, please avoid c++ style comments.

More importantly, as Willem noded, this function is always called with
do_poll =3D=3D true. You should drop such argument and the related branch
above.

> +		tnow =3D gettimeofday_ms();
> +	} while ((stat_zcopies !=3D num_sends) && (tnow < tstop));
> +}
> +
>  static int send_tcp(int fd, char *data)
>  {
>  	int ret, done =3D 0, count =3D 0;
> @@ -413,8 +431,9 @@ static int send_udp_segment(int fd, char *data)
> =20
>  static void usage(const char *filepath)
>  {
> -	error(1, 0, "Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [=
-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
> -		    filepath);
> +	error(1, 0,
> +			"Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [-L secs] [=
-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
> +			filepath);

Please avoid introducing unnecessary white-space changes (no reason to
move the usage text on a new line)

Cheers,

Paolo

