Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6D6DDFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjDKPdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:33:06 -0400
X-Greylist: delayed 74038 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 08:33:05 PDT
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B0B1997;
        Tue, 11 Apr 2023 08:33:05 -0700 (PDT)
Received: from [10.36.2.154] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 5CBF126235F;
        Tue, 11 Apr 2023 17:33:03 +0200 (CEST)
Message-ID: <ca17f815-5779-d37c-e3f8-2a6c2983fe45@selasky.org>
Date:   Tue, 11 Apr 2023 17:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org>
 <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org>
 <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
 <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org>
 <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
 <1d50d25c-e64b-01f4-029f-8b40b46848fd@selasky.org>
 <CANiq72mbM+WBcvj1TwU2u9kLz=EucLhLR-a5nzZEDa7VJ0s2_A@mail.gmail.com>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <CANiq72mbM+WBcvj1TwU2u9kLz=EucLhLR-a5nzZEDa7VJ0s2_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 16:19, Miguel Ojeda wrote:
> On Tue, Apr 11, 2023 at 3:15 PM Hans Petter Selasky <hps@selasky.org> wrote:
>>
>> If you cannot build a new toolchain without a new kernel.
> 

Hi,

> Why not?

To me it is very simple:

Look at this:

-#define FE_GET_PROPERTY                   _IOR('o', 83, struct 
dtv_properties)
+#define FE_GET_PROPERTY                   _IOW('o', 83, struct 
dtv_properties)
+#define FE_GET_PROPERTY_OLD       _IOR('o', 83, struct dtv_properties)

The FE_GET_PROPERTY IOCTL definition is incorrectly specified as reading 
data. While it is actually writing data. When will this be fixed in 
Linux - I think never. That's just the way both Linux and GIT works, 
unfortunately, though that's another discussion. You can put stuff in, 
but you can't easily get stuff out, without it having consequences.

Similarly rustc may depend on an incorrectly specified ioctl() 
definition, also via other libraries and static linking, that just have 
to stay incorrectly defined, because it was initially incorrectly defined.

Daniel, please explain why the few lines of chunk above (and there are 
some more) cannot be upstreamed into Linux?

> 
>> Then you are stuck forever to build a new toolchain and kernel? Do you
>> agree?
> 
> No, I don't agree, because I don't understand why you cannot build the
> new toolchain in the old kernel, or use a pre-built toolchain for that
> matter (whether built by you or by somebody else).
> 
>> Or you can say, someone else needs to deal with it, but then you have a
>> single point of failure.
> 
> No, you could build your own toolchain and save it somewhere, if you
> don't want to rely on a build from somebody else.

I'm trying to explain something difficult. And I'm OK that you neither 
understand nor agree about my viewpoint. See my replies above.

--HPS
