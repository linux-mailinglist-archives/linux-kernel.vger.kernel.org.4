Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87113608452
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJVEjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJVEjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:39:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1B1AF1D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:39:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b12so12840994edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lL9hWr+hhuL8sq+3nMErhUNcsb9i2w8SB2V2+Hb7wEw=;
        b=ZLho6sIk+j0kfjgtZxqEK2p28HrY5vrMe91vgeNfh5s5m4qf7eJpcgLeDQImWXDTNH
         zC1fFw8sYXed0XV5AxnPzhINrEhWLGiEsOt1pE06kFi5hdTUTY2NZXKJKSN+UZMwpge1
         ixABtIILYnHCuCD3J9luQlW7C2DT7UDpd6bOhvAQzySlco7TX/rU4YRoCShCW/uUmmgS
         BgNAAuBWjXenyV+YeZH6DjS6wVkxPBVoJ0/r0QLXqwAerGYgKXBmQCJKtvUKm+A7VNfh
         tE0j2uRd8htLViU1jMHZi6rloo8gZRdbiMYHdnQE+JJLZYqa2NRRGNHn0l5rDLxYYMeP
         mAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lL9hWr+hhuL8sq+3nMErhUNcsb9i2w8SB2V2+Hb7wEw=;
        b=g7PAOM8TLqhEL/vj34Z9WPOJwDhQyg8YpQvhv5D6FzAfvfmDVlEOz5er9EIRRpUfe8
         B+RnRqzEEs2tABKmqOg4TKttkZxr7WWVaCDkDam2bbLsA0pWKulsAx2TvAoTHt+cX7UE
         elX97TS/sHk+lxz490Su79gkYCYiFJ7pWJ2aOt5igVM9y2g7EDn6pHy8BZHJV6GC9vge
         VU1HP0segJw6Gv4pRZJNSz4rZFAHAHFo20M9QFMTjr81xw0rvaj1MaYSrLEsgPs47Jgv
         UyZ3ayzYJFXdE5mhLMZGfg1/HbTqOp0ycxNOhlTLj2AckqS4kkWhCGM6kVmeMjoRJqth
         2Mww==
X-Gm-Message-State: ACrzQf2GYUu7QhqqBrmqzRFRZt+qZTqSa29KNATjFUmb9Kq7raG7JEk1
        WZxb3ngNVwJvepnajqx1Rz4=
X-Google-Smtp-Source: AMsMyM4PsORIRCyLJ8A29cUas8Gx48zduVojhz94DRmXgbvA+4aJsQqbYWhLzWMc7i2sDpfdATtQbA==
X-Received: by 2002:a17:906:cc0f:b0:7a0:b91c:855f with SMTP id ml15-20020a170906cc0f00b007a0b91c855fmr1434880ejb.26.1666413580897;
        Fri, 21 Oct 2022 21:39:40 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a47:f906:12eb:e934:9c2e? (p200300c78f3e6a47f90612ebe9349c2e.dip0.t-ipconnect.de. [2003:c7:8f3e:6a47:f906:12eb:e934:9c2e])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906311700b00771cb506149sm12511561ejx.59.2022.10.21.21.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 21:39:40 -0700 (PDT)
Message-ID: <5bb36c2c-c0a8-905d-3e6d-f42cd8e9f9c7@gmail.com>
Date:   Sat, 22 Oct 2022 06:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/6] staging: vt6655: refactor long lines of code in
 s_vGenerateTxParameter
Content-Language: en-US
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <cover.1666347511.git.tanjubrunostar0@gmail.com>
 <03dd39114b1e5c029cd8022245403a079ff03ae7.1666347511.git.tanjubrunostar0@gmail.com>
 <02a45afb-f81d-639c-1cc6-6376e31351a6@gmail.com>
 <CAHJEyKW4QZHf_wjaR1bGs8vtb6Gu-inJ4oxcFkPPnAKEAd5-9w@mail.gmail.com>
 <CAHJEyKUGJ+E13-oLTHr4PS6za==gyCPWm6siGZaasUw6dJxGmQ@mail.gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CAHJEyKUGJ+E13-oLTHr4PS6za==gyCPWm6siGZaasUw6dJxGmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 20:14, Tanju Brunostar wrote:
>>> Error during compiliation in next line
>>>
>>>> +                     struct vnt_rrv_time_ab *buf = pvRrvT
>>>> +                             ime;
>>> make: Entering directory '/home/kernel/Documents/git/kernels/staging'
>>>     CC [M]  drivers/staging/vt6655/rxtx.o
>>> drivers/staging/vt6655/rxtx.c: In function ‘s_vGenerateTxParameter’:
>>> drivers/staging/vt6655/rxtx.c:1014:34: error: ‘pvRrvT’ undeclared (first
>>> use in this function)
>>>    1014 |    struct vnt_rrv_time_ab *buf = pvRrvT
>>>         |                                  ^~~~~~
>>> drivers/staging/vt6655/rxtx.c:1014:34: note: each undeclared identifier
>>> is reported only once for each function it appears in
>>> drivers/staging/vt6655/rxtx.c:1015:5: error: expected ‘,’ or ‘;’ before
>>> ‘ime’
>>>    1015 |     ime;
>>>         |     ^~~
>>> make[1]: *** [scripts/Makefile.build:250: drivers/staging/vt6655/rxtx.o]
>>> Error 1
>>> make: *** [Makefile:1992: drivers/staging/vt6655] Error 2
>>> make: Leaving directory '/home/kernel/Documents/git/kernels/staging'
>>>
>> This error occured on the first version of this patch. I corrected it,
>> compiled the code and the error was gone before I sent this version.
>> please check again. You may have seen this error on the first version
>> and not this one.
>> thanks
>>
>> Tanju
> On the first patch, this error was detected by the kernel bot. This
> time around, the kernel bot did not detect it, meaning it was fixed.

Please check the outbox of your email account and have a look. This is 
the v2 Patch and it contains this two lines:
 >>>> +                     struct vnt_rrv_time_ab *buf = pvRrvT
 >>>> +                             ime;
which do not compile.

Bye Philipp
