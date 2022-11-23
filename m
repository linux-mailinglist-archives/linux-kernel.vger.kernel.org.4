Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154CA636357
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiKWPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbiKWPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:23:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F09764A07
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669216928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAQ+WUBilLvtBfWw+OuxYtN3auR7ZBxIQdmmFViSJCU=;
        b=XQ4zh5vJn4kX6WkkgoZwvhmjP748S6BsAZel1G00opQiMHKJ8XNXrhKEwkrXUCWGE6tpt4
        eQya7MKwK0NlK1foLmvVW5bD6zj1wWmaXnQulqjiosfD0nCz9xdqkvwrfOqTT0s3cJw8qJ
        7MgZYyiDh2x2ED1WJlJ+44EAcuJKneo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-N9Yd3yz-NtioDe3telSw5Q-1; Wed, 23 Nov 2022 10:22:07 -0500
X-MC-Unique: N9Yd3yz-NtioDe3telSw5Q-1
Received: by mail-qv1-f72.google.com with SMTP id d8-20020a0cfe88000000b004bb65193fdcso16672931qvs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAQ+WUBilLvtBfWw+OuxYtN3auR7ZBxIQdmmFViSJCU=;
        b=anLuCP13rYKbRILmzX1Px9IXC34Ela6p6spc1uUCCo8YKelpjRssffiaVTNt/osak1
         JvlIvrZzxVnMe1tpr2HYKPAmGIWhhzPp+fsXI7dQwAXiNV35pitz5LOZGnQm+71HsiCQ
         xRBfXgvVSiek6/pTpriFGHNKLlc0ilTmbTtA+APVhzUaNE9c5jkL2QZSJwzdLOWQjQYs
         0XzLaqBzC0Lcw4BlUJL4d1W/8lDaHwg7Vz+NjQi+UUsLwg2dozej4Mc/qbOB1Rn8Qrxw
         tQ7AxNUJuiSYt3p3Wp21XjTRaArOW3KAu4WZaO+gwoIqqf3C5OU/8ZKIac/Q9mCy6T8c
         Tm0g==
X-Gm-Message-State: ANoB5plY9VFzhCEjpWiHJ7wYNwUjk3aWCihg2GnjqciADCrnhcZUBdaZ
        PBDZ1gR+2LP4m3awZOy2Utgq+dBoBTb8+1yTHfV8Frtp6B8pvcxL4H2c/I5gfz6PCszgo6lTNLe
        +R8SCijHkx1o5pLLXLv7LMXPd
X-Received: by 2002:a05:622a:4c15:b0:398:8048:6f75 with SMTP id ey21-20020a05622a4c1500b0039880486f75mr10367988qtb.316.1669216926651;
        Wed, 23 Nov 2022 07:22:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4sD3+Iedq4yhwBmBg6QKG+ew06sbvutG4uKTF/wuyFU4KECi/G/prQEwmsbfcWmBDXde195w==
X-Received: by 2002:a05:622a:4c15:b0:398:8048:6f75 with SMTP id ey21-20020a05622a4c1500b0039880486f75mr10367963qtb.316.1669216926356;
        Wed, 23 Nov 2022 07:22:06 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id m20-20020a05620a24d400b006b949afa980sm12666193qkn.56.2022.11.23.07.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:22:05 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:21:59 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Bobby Eshleman <bobby.eshleman@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        kernel <kernel@sberdevices.ru>,
        Krasnov Arseniy <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v1 2/3] test/vsock: add big message test
Message-ID: <20221123152159.xbqhsslrhh4ymbnn@sgarzare-redhat>
References: <ba294dff-812a-bfc2-a43c-286f99aee0b8@sberdevices.ru>
 <f0510949-cc97-7a01-5fc8-f7e855b80515@sberdevices.ru>
 <20221121145248.cmscv5vg3fir543x@sgarzare-redhat>
 <ff71c2d3-9f61-d649-7ae5-cd012eada10d@sberdevices.ru>
 <749f147b-6112-2e6f-1ebe-05ba2e8a8727@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <749f147b-6112-2e6f-1ebe-05ba2e8a8727@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:40:39PM +0000, Arseniy Krasnov wrote:
>On 21.11.2022 19:50, Arseniy Krasnov wrote:
>> On 21.11.2022 17:52, Stefano Garzarella wrote:
>>> On Tue, Nov 15, 2022 at 08:52:35PM +0000, Arseniy Krasnov wrote:
>>>> This adds test for sending message, bigger than peer's buffer size.
>>>> For SOCK_SEQPACKET socket it must fail, as this type of socket has
>>>> message size limit.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>> tools/testing/vsock/vsock_test.c | 62 ++++++++++++++++++++++++++++++++
>>>> 1 file changed, 62 insertions(+)
>>>>
>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>> index 107c11165887..bb4e8657f1d6 100644
>>>> --- a/tools/testing/vsock/vsock_test.c
>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>> @@ -560,6 +560,63 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
>>>>     close(fd);
>>>> }
>>>>
>>>> +static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>>>> +{
>>>> +    unsigned long sock_buf_size;
>>>> +    ssize_t send_size;
>>>> +    socklen_t len;
>>>> +    void *data;
>>>> +    int fd;
>>>> +
>>>> +    len = sizeof(sock_buf_size);
>>>> +
>>>> +    fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>>>
>>> Not for this patch, but someday we should add a macro for this port and maybe even make it configurable :-)
>>>
>>>> +    if (fd < 0) {
>>>> +        perror("connect");
>>>> +        exit(EXIT_FAILURE);
>>>> +    }
>>>> +
>>>> +    if (getsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>>> +               &sock_buf_size, &len)) {
>>>> +        perror("getsockopt");
>>>> +        exit(EXIT_FAILURE);
>>>> +    }
>>>> +
>>>> +    sock_buf_size++;
>>>> +
>>>> +    data = malloc(sock_buf_size);
>>>> +    if (!data) {
>>>> +        perror("malloc");
>>>> +        exit(EXIT_FAILURE);
>>>> +    }
>>>> +
>>>> +    send_size = send(fd, data, sock_buf_size, 0);
>>>> +    if (send_size != -1) {
>>>
>>> Can we check also `errno`?
>>> IIUC it should contains EMSGSIZE.
>Hm, seems current implementation is a little bit broken and returns ENOMEM, because any negative value, returned by
>transport callback is always replaced to ENOMEM. I think i need this patch from Bobby:
>https://lore.kernel.org/lkml/d81818b868216c774613dd03641fcfe63cc55a45.1660362668.git.bobby.eshleman@bytedance.com/
>May be i can include it to this patchset also fixing review comments(of course keeping Bobby as author). Or more
>simple way is to check ENOMEM instead of EMSGSIZE in this test(simple, but a little bit dumb i think).

Maybe in this patch you can start checking ENOMEM (with a TODO comment),
and then Bobby can change it when sending his patch.

Or you can repost it (I'm not sure if we should keep the legacy behavior 
for other transports or it was an error, but better to discuss it on 
that patch). However, I think we should merge that patch.

@Bobby, what do you think?

Thanks,
Stefano

