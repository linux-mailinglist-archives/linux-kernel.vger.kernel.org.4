Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B3744007
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjF3QoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3QoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:44:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3353AA7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:44:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so16178545e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google; t=1688143455; x=1690735455;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKBfccrJBTzwPsKp9F16ppy62jt1IusEq5OosFTqNhM=;
        b=L6uyS6gSmWW0LEFcLhBaGROe2QRiYaL5y2vDxaVytgFCbKcVwWTCDIKI+xSYkdawQJ
         R8XXgwEJxEFFaP50qF891/Gyfh9xxsYNXvw1gGeBXUYKSbV9m9NNW2r+yYfanocUQKVr
         VVqrtDu1iM9SsWUOUnm4fUhooVa2yUDT55ctE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143455; x=1690735455;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKBfccrJBTzwPsKp9F16ppy62jt1IusEq5OosFTqNhM=;
        b=KWu9gVhn6pMJ+XSDVdhS0Pvky0a3zL0oWUz3qumcUYNCbjlugZbfvfwSYYnXtJh+0n
         uek1Sv0Q31icdazGIVoaScm9CKGOzNfUoUnlYdM1BMkDjlQKvRjO3osQoUdn59Z06Wt9
         Wd2LPxeY6wNRDu14VLhotxSXIgKS9xgDeo/NCeH480CtcM6aaVkcd6ZjWf4+Y+uNU8Y6
         RSP9tNPZE0IQbsynlQBnaPA9R/Q7dmO9wIQ0fm8XQ5m1yk42TrJlqx8/6vnU/VYtEB3g
         ZtGltkES+xsN6JJ+Fi61gr+1EhQxzNrKWYS9BSsZ/1zmwksm1PPNKOKWOjNylOUUcoo7
         XLvw==
X-Gm-Message-State: AC+VfDz/1cGpfp+gERcDe3RSa49pCkXmEQY0f35HrqpWIGoppxZWww7a
        C7QbxsJuryCHtSckjyT0/m19TA==
X-Google-Smtp-Source: ACHHUZ4ByD+2TUO16Ne5E+K5eO4TL2k30sTEafqHWqmMmDw/d9Kd3NmTMrAYwXB8L2/yVvPuGaQGWw==
X-Received: by 2002:a1c:770b:0:b0:3fa:9538:963e with SMTP id t11-20020a1c770b000000b003fa9538963emr2410893wmi.36.1688143455489;
        Fri, 30 Jun 2023 09:44:15 -0700 (PDT)
Received: from [10.42.42.90] (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b003fbb8c7c799sm4666532wmj.30.2023.06.30.09.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:44:15 -0700 (PDT)
From:   Maxime Jayat <maxime.jayat@mobile-devices.fr>
X-Google-Original-From: Maxime Jayat <maxime.jayat@munic.io>
Message-ID: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
Date:   Fri, 30 Jun 2023 18:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Sojka <michal.sojka@cvut.cz>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dae R. Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: can: isotp: epoll breaks isotp_sendmsg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is something not clear happening with the non-blocking behavior
of ISO-TP sockets in the TX path, but more importantly, using epoll now
completely breaks isotp_sendmsg.
I believe it is related to
79e19fa79c ("can: isotp: isotp_ops: fix poll() to not report false 
EPOLLOUT events"),
but actually is probably deeper than that.

I don't completely understand what is exactly going on, so I am sharing
the problem I face:

With an ISO-TP socket in non-blocking mode, using epoll seems to make
isotp_sendmsg always return -EAGAIN.

I have a non-blocking socket + epoll version of can-utils isotpsend 
available for
testing at https://gist.github.com/MJayat/4857da43ab154e4ba644d2446b5fa46d
With this version I do the following test:

isotprecv -l -m 0x80 -s 7e8 -d 7e0 vcan0 &
echo "01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f" | strace ./isotpsend 
-l10 -s 7E0 -d 7E8 vcan0

I get:
...
15:37:02.456849 epoll_ctl(4, EPOLL_CTL_ADD, 3, 
{events=EPOLLIN|EPOLLOUT|EPOLLRDHUP, data={u32=0, u64=0}}) = 0 <0.000249>
15:37:02.457839 epoll_wait(4, [{events=EPOLLOUT, data={u32=0, u64=0}}], 
1, 2000) = 1 <0.000200>
15:37:02.458838 write(3, 
"\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f", 15) = -1 
EAGAIN (Resource temporarily unavailable) <0.000278>
15:37:02.459908 epoll_wait(4, [{events=EPOLLOUT, data={u32=0, u64=0}}], 
1, 2000) = 1 <0.000250>
15:37:02.460879 write(3, 
"\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f", 15) = -1 
EAGAIN (Resource temporarily unavailable) <0.000272>
15:37:02.461831 epoll_wait(4, [{events=EPOLLOUT, data={u32=0, u64=0}}], 
1, 2000) = 1 <0.000199>
...
impossible to write on the socket, and busy-looping.

With a change to epoll_ctl flags, now including EPOLLET, I get:
...
15:36:22.443689 epoll_ctl(4, EPOLL_CTL_ADD, 3, 
{events=EPOLLIN|EPOLLOUT|EPOLLRDHUP|EPOLLET, data={u32=0, u64=0}}) = 0 
<0.000171>
15:36:22.444514 epoll_wait(4, [{events=EPOLLOUT, data={u32=0, u64=0}}], 
1, 2000) = 1 <0.000188>
15:36:22.445413 write(3, 
"\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f", 15) = -1 
EAGAIN (Resource temporarily unavailable) <0.000175>
15:36:22.446335 epoll_wait(4, [], 1, 2000) = 0 <2.026006>
...
epoll_wait now blocks indefinitely.

By reverting 79e19fa79c, I get better results but still incorrect:
...
15:41:43.890880 epoll_ctl(4, EPOLL_CTL_ADD, 3, 
{events=EPOLLIN|EPOLLOUT|EPOLLRDHUP, data={u32=0, u64=0}}) = 0 <0.000200>
15:41:43.892011 epoll_wait(4, [{events=EPOLLOUT, data={u32=0, u64=0}}], 
1, 2000) = 1 <0.000408>
15:41:43.893148 write(3, 
"\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f", 15) = 15 
<0.000458>
15:41:43.894405 epoll_wait(4, [{events=EPOLLOUT, data={u32=0, u64=0}}], 
1, 2000) = 1 <0.000257>
15:41:43.895385 write(3, 
"\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f", 15) = 15 
<0.128429>
15:41:44.028757 epoll_wait(4, [{events=EPOLLOUT, data={u32=0, u64=0}}], 
1, 2000) = 1 <0.001886>
15:41:44.040858 write(3, 
"\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f", 15) = 15 
<0.108069>
...
It is then possible to write on the socket but the write is blocking, 
which is
not the expected behavior for a non-blocking socket.

I don't know how to solve the problem. To me, using wq_has_sleeper seems 
weird.
The implementation of isotp_poll feels weird too (calling both 
datagram_poll and
poll_wait?). But I am not sure what would be the correct implementation.

Note that this behavior is currently on all linux-stable branches. I am
currently testing on v6.1.36 but I know it is failing on v6.3 too.

My actual use-case is in Async Rust using tokio. Not using epoll is not an
option and a non-blocking socket that sometimes blocks can be terrible for
the performance of the whole application. Our embedded target runs with the
out-of-tree module on an older linux version, but my colleagues with 
up-to-date
linux stable kernels have recently been prevented from running tests on 
their
PC.

Is there someone with a good idea of how to proceed to fix this?
I'll probably keep digging but I don't think I can spend so much time on 
this,
so any help is appreciated.

Thanks,
Maxime


