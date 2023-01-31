Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69368379D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjAaUhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAaUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:37:03 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BAE564B5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:37:01 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7ECC6442FF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675197419;
        bh=SpC0u9OftDni3C4Wz/4+L32jBCRs4TtN6qhggEy7nZk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ax/jHeZVzT6ohL1cipqF4L0pwHjdrq5rtDkEJY3AROYvbIQAeOBYNIfsswPAhpGqX
         YWBNk7qLbXsoCasg6FoKqFgy8CSrprOz9ZKyg1ilMyN9/FwvRp8lY6BBogQ9vQQuin
         rn2IXGXRvJujJ0N/6UwdkzhZ444g9V3FcSastXwva9As/utlYAanF9G1L9xW1V6jeQ
         XrHRsT5VwBQ2kxaZtNkKEsgkvY10OXxIdxfCFOD0wL6FOY27F7o2s14widaDn+T0Je
         fz5p20WUIgo40C2yuEVmQJRuIDJBNjlaTBROXjnWJYkGeaZcFCA6b/phrzlacFe6fW
         sNo9//2KiD49g==
Received: by mail-wm1-f69.google.com with SMTP id iz20-20020a05600c555400b003dc53fcc88fso4057499wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpC0u9OftDni3C4Wz/4+L32jBCRs4TtN6qhggEy7nZk=;
        b=H9HfQ1sNFBWfRbqcVQGfWd9K/20jesqx0gbEkZ9pWHySeOaYaL+0fX1X9bYwLevPfz
         LJSUL1ZsPHBlH2gnFD55nAEy54I/lIXK2pmxExzJSm9ttzE30wMJaA6Adw8kjps7d0ju
         EKfuFO8dacS+fBqi8/fkYm8JlAumNKfZhqRH+FkTyEox6oav5Uhpm1ysXyb6Eouetcbd
         iOyT3enizzIxnyv1tEcNT43Mqah867zeUA1IASdeOdWG5LTI1VOhAKNhWZE/uZlSXo8V
         eYNhAtAW5QyQgOMkcspGt8v+0dRNrjO8iwoWunEbT35m125jwiYcVzaGfUMVP5gIjyJH
         5gBA==
X-Gm-Message-State: AO0yUKWW8RM7rBMncsfb+lsTVvSA8R5+xcLVKJanpblf7eAC6ZLn598L
        Wk04fXZypBZPnxaX1U/Zz7rPHt1/LbRpPwzqBK8FpKOS+ObQMErGAkaBOa6LpZjjyMKOZJvwMr7
        uOxWZfr+nS2iEpN4/G+YrTMV2vbe0jsEqyjs2wRp7jQ==
X-Received: by 2002:a05:6000:d2:b0:2bd:bed8:3b0f with SMTP id q18-20020a05600000d200b002bdbed83b0fmr281784wrx.35.1675197417651;
        Tue, 31 Jan 2023 12:36:57 -0800 (PST)
X-Google-Smtp-Source: AK7set/MHnQzhmMQgBCHhzwUOY0LQogwv4Tkp8u15vjSP+VsmpP/QWFjwVMFxcnYGYDGR6/2ZOItsA==
X-Received: by 2002:a05:6000:d2:b0:2bd:bed8:3b0f with SMTP id q18-20020a05600000d200b002bdbed83b0fmr281775wrx.35.1675197417435;
        Tue, 31 Jan 2023 12:36:57 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b002be0b1e556esm15355205wrt.59.2023.01.31.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 12:36:56 -0800 (PST)
Date:   Tue, 31 Jan 2023 20:36:55 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests: net: udpgso_bench_tx: Cater for
 pending datagrams zerocopy benchmarking
Message-ID: <Y9l75ys/ID7H7xTw@qwirkle>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
 <20230131130412.432549-4-andrei.gherzan@canonical.com>
 <d9ca623d01274889913001ce92f686652fa8fea8.camel@redhat.com>
 <Y9kvADcYZ18XFTXu@qwirkle>
 <17e062f077235b949090cba893c91f5637cc1f0e.camel@redhat.com>
 <Y9lCYT3XUgo4npox@qwirkle>
 <58cefd5871c4901a6f9c0394891637fed170bb47.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cefd5871c4901a6f9c0394891637fed170bb47.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/31 07:26PM, Paolo Abeni wrote:
> On Tue, 2023-01-31 at 16:31 +0000, Andrei Gherzan wrote:
> > On 23/01/31 05:22PM, Paolo Abeni wrote:
> > > On Tue, 2023-01-31 at 15:08 +0000, Andrei Gherzan wrote:
> > > > On 23/01/31 03:51PM, Paolo Abeni wrote:
> > > > > On Tue, 2023-01-31 at 13:04 +0000, Andrei Gherzan wrote:
> > > > > > The test tool can check that the zerocopy number of completions value is
> > > > > > valid taking into consideration the number of datagram send calls. This can
> > > > > > catch the system into a state where the datagrams are still in the system
> > > > > > (for example in a qdisk, waiting for the network interface to return a
> > > > > > completion notification, etc).
> > > > > > 
> > > > > > This change adds a retry logic of computing the number of completions up to
> > > > > > a configurable (via CLI) timeout (default: 2 seconds).
> > > > > > 
> > > > > > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > > > > > ---
> > > > > >  tools/testing/selftests/net/udpgso_bench_tx.c | 38 +++++++++++++++----
> > > > > >  1 file changed, 30 insertions(+), 8 deletions(-)
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> > > > > > index b47b5c32039f..5a29b5f24023 100644
> > > > > > --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> > > > > > +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> > > > > > @@ -62,6 +62,7 @@ static int	cfg_payload_len	= (1472 * 42);
> > > > > >  static int	cfg_port	= 8000;
> > > > > >  static int	cfg_runtime_ms	= -1;
> > > > > >  static bool	cfg_poll;
> > > > > > +static int	cfg_poll_loop_timeout_ms = 2000;
> > > > > >  static bool	cfg_segment;
> > > > > >  static bool	cfg_sendmmsg;
> > > > > >  static bool	cfg_tcp;
> > > > > > @@ -235,16 +236,17 @@ static void flush_errqueue_recv(int fd)
> > > > > >  	}
> > > > > >  }
> > > > > >  
> > > > > > -static void flush_errqueue(int fd, const bool do_poll)
> > > > > > +static void flush_errqueue(int fd, const bool do_poll,
> > > > > > +		unsigned long poll_timeout, const bool poll_err)
> > > > > >  {
> > > > > >  	if (do_poll) {
> > > > > >  		struct pollfd fds = {0};
> > > > > >  		int ret;
> > > > > >  
> > > > > >  		fds.fd = fd;
> > > > > > -		ret = poll(&fds, 1, 500);
> > > > > > +		ret = poll(&fds, 1, poll_timeout);
> > > > > >  		if (ret == 0) {
> > > > > > -			if (cfg_verbose)
> > > > > > +			if ((cfg_verbose) && (poll_err))
> > > > > >  				fprintf(stderr, "poll timeout\n");
> > > > > >  		} else if (ret < 0) {
> > > > > >  			error(1, errno, "poll");
> > > > > > @@ -254,6 +256,22 @@ static void flush_errqueue(int fd, const bool do_poll)
> > > > > >  	flush_errqueue_recv(fd);
> > > > > >  }
> > > > > >  
> > > > > > +static void flush_errqueue_retry(int fd, const bool do_poll, unsigned long num_sends)
> > > > > > +{
> > > > > > +	unsigned long tnow, tstop;
> > > > > > +	bool first_try = true;
> > > > > > +
> > > > > > +	tnow = gettimeofday_ms();
> > > > > > +	tstop = tnow + cfg_poll_loop_timeout_ms;
> > > > > > +	do {
> > > > > > +		flush_errqueue(fd, do_poll, tstop - tnow, first_try);
> > > > > > +		first_try = false;
> > > > > > +		if (!do_poll)
> > > > > > +			usleep(1000);  // a throttling delay if polling is enabled
> > > > > 
> > > > > Even if the kernel codying style is not very strictly enforced for
> > > > > self-tests, please avoid c++ style comments.
> > > > > 
> > > > > More importantly, as Willem noded, this function is always called with
> > > > > do_poll == true. You should drop such argument and the related branch
> > > > > above.
> > > > 
> > > > Agreed. I will drop.
> > > > 
> > > > > 
> > > > > > +		tnow = gettimeofday_ms();
> > > > > > +	} while ((stat_zcopies != num_sends) && (tnow < tstop));
> > > > > > +}
> > > > > > +
> > > > > >  static int send_tcp(int fd, char *data)
> > > > > >  {
> > > > > >  	int ret, done = 0, count = 0;
> > > > > > @@ -413,8 +431,9 @@ static int send_udp_segment(int fd, char *data)
> > > > > >  
> > > > > >  static void usage(const char *filepath)
> > > > > >  {
> > > > > > -	error(1, 0, "Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
> > > > > > -		    filepath);
> > > > > > +	error(1, 0,
> > > > > > +			"Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [-L secs] [-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
> > > > > > +			filepath);
> > > > > 
> > > > > Please avoid introducing unnecessary white-space changes (no reason to
> > > > > move the usage text on a new line)
> > > > 
> > > > The only reason why I've done this was to make scripts/checkpatch.pl
> > > > happy:
> > > > 
> > > > WARNING: line length of 141 exceeds 100 columns
> > > > #83: FILE: tools/testing/selftests/net/udpgso_bench_tx.c:432:
> > > > 
> > > > I can drop and ignore the warning, or maybe it would have been better to
> > > > just mention this in git message. What do you prefer?
> > > 
> > > Long lines are allowed for (kernel) messages, to make them easily grep-
> > > able.
> > > 
> > > In this specific case you can either append the new text to the message
> > > without introducing that strange indentation or even better break the
> > > usage string alike:
> > > 
> > > 	"Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [-L secs]"
> > > 	" [-L secs] [-M messagenr] [-p port] [-s sendsize] [-S gsosize]"
> > 
> > Funny I went through this too but it also fails with:
> > 
> > WARNING: quoted string split across lines
> > #84: FILE: tools/testing/selftests/net/udpgso_bench_tx.c:433
> > 
> > This is how I usually do it but it seems like it's flagged too.
> 
> I'm all for ignoring this warning in this specific context. Among other
> things it will be consistent with other existing self-tests.
> 
> Eventually the checkpatch script could be tuned (with an unrelated
> patch) to discriminate between kernel and self-tests code.

In that case I will use quoted strings split across lines in the next
version

-- 
Andrei Gherzan
