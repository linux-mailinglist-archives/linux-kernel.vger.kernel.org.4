Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823276A1BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBXMNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBXMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:12:59 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBEF19686;
        Fri, 24 Feb 2023 04:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lMkQbXYIvElBugu5cxf5zhoj0h7ckwIM5nbeXE9onRM=; b=EficBCbipgvSiu1PZL4IAP/bIN
        2kym6zJFt+S3sQs9fb+2xvvwyTyhcQpd7KNY+xxmqUth4L6B0Q3wpYuQ9Nvrhn4mpXm6fxCmxZ4x+
        qarjUhvLQq0cuBhHtQVYzuZ5u3JK5Q61x7mX62Aqvlmw74ROzOi3gdZPBX2CLiuLpBpTlXz65Y8HO
        Rws0WmHsg+slJHGILwXf/Ay9OJqy+9CaKeHzF/7qrtzFGQEYx4T2dL6rGQ1b+3+tPmvhJlXfAUiaw
        tWuqERTOO9QSGCQUGhM3EdkPcI7t7akaPgj9l6bNUwWq12end0/SkF4chgljzS6MgKCxh4Yx6KsFq
        vSMBjFcg==;
Received: from 189-68-200-53.dsl.telesp.net.br ([189.68.200.53] helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pVWwS-00DXbT-1m; Fri, 24 Feb 2023 13:12:48 +0100
Message-ID: <cadf9320-366c-da33-5fb4-30575533b04e@igalia.com>
Date:   Fri, 24 Feb 2023 09:12:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] kbuild: modinst: Enable multithread xz compression
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-dev@igalia.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <20230223001607.95523-1-andrealmeid@igalia.com>
 <CAK7LNAQbzWQs3WzsdyLsCyFD_2Kgz8sqjqk+nFXkEXQFrYobRA@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAK7LNAQbzWQs3WzsdyLsCyFD_2Kgz8sqjqk+nFXkEXQFrYobRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Em 24/02/2023 02:38, Masahiro Yamada escreveu:
> On Thu, Feb 23, 2023 at 9:17 AM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> As it's done for zstd compression, enable multithread compression for
>> xz to speed up module installation.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>
>> On my setup xz is a bottleneck during module installation. Here are the
>> numbers to install it in a local directory, before and after this patch:
>>
>> $ time make INSTALL_MOD_PATH=/home/tonyk/codes/.kernel_deploy/ modules_install -j16
>> Executed in  100.08 secs
>>
>> $ time make INSTALL_MOD_PATH=/home/tonyk/codes/.kernel_deploy/ modules_install -j16
>> Executed in   28.60 secs
> 
> 
> Heh, this is an interesting benchmark.
> 
> Without this patch, you ran 16 processes of 'xz' in parallel
> since you gave -j16.
> 
> You created multi-threads in each xz process, then you got 3x faster.
> What made it happen?
> 
> 

During the modules installation in my setup, the build system would 
spend most of it's time compressing big modules (such as the 350M 
amdgpu.ko) in a single thread, with 15 idles threads. Enabling 
multithread allowed amdgpu to be compressed really fast.

The real performance improvement during modules compression is not 
compressing as many small modules as possible in parallel, but 
compressing the big ones in multithread, that proved to be the 
bottleneck in my setup.

 > How many threads can your system run?

$ nproc
16

> 
> I did not get such an improvement in my testing.
> In my machine $(nproc) is 24.
> 
> 
> [Without this patch]
> 
> $ time make INSTALL_MOD_PATH=/tmp/inst1  modules_install -j$(nproc)
> 
> real 0m33.965s
> user 10m6.118s
> sys 0m37.231s
> 
> [With this patch]
> 
> $ time make INSTALL_MOD_PATH=/tmp/inst1  modules_install -j$(nproc)
> 
> real 0m32.568s
> user 10m4.472s
> sys 0m39.132s
> 
> 

I can see that my patch did not introduce performance regressions to 
your setup, at least.

> 
> Given that GNU Make provides the parallel execution environment,
> you can control the number of processes of 'xz'.
> 
> There is no point in forcing multi-threading, which the user
> did not ask or ever want.
> 
> 

Should we drop -T0 from zstd then? Is currently forcing multi-threading.

> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
>> ---
>>   scripts/Makefile.modinst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
>> index 4815a8e32227..28dcc523d2ee 100644
>> --- a/scripts/Makefile.modinst
>> +++ b/scripts/Makefile.modinst
>> @@ -99,7 +99,7 @@ endif
>>   quiet_cmd_gzip = GZIP    $@
>>         cmd_gzip = $(KGZIP) -n -f $<
>>   quiet_cmd_xz = XZ      $@
>> -      cmd_xz = $(XZ) --lzma2=dict=2MiB -f $<
>> +      cmd_xz = $(XZ) --lzma2=dict=2MiB -f -T0 $<
>>   quiet_cmd_zstd = ZSTD    $@
>>         cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
>>
>> --
>> 2.39.2
>>
> 
> 

Thanks,
André Almeida
