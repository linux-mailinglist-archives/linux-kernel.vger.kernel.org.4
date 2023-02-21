Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6B69E5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjBUROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjBUROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E77A276
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676999608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yPp4giTefdhMbNYiavZiH2cm1Lod+7F0kuDYxzrSTg=;
        b=NeijGzuJtNC0ZIV9fuMs2qvqXyXPKpFQKRZGoULNNJ0BaQsHYuBSkMF0jysNRshCFKixPX
        WgVRq5n4+REYFJW9EW3/emAjtA5PUBiMEDZzsN6N1J/cx6Sb570YY0405nqwPU3MYpXR/L
        n05Jn5ZpU6U1kyXznAuOw5rFsFYkhQQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-142-j1_-vkezOquDanEaRbFKRQ-1; Tue, 21 Feb 2023 12:13:27 -0500
X-MC-Unique: j1_-vkezOquDanEaRbFKRQ-1
Received: by mail-pg1-f197.google.com with SMTP id 10-20020a63030a000000b004fb64e929f2so1804410pgd.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yPp4giTefdhMbNYiavZiH2cm1Lod+7F0kuDYxzrSTg=;
        b=4NDj64KegSbPLMez+kdZEKi5vMFMrwpzysQNs7uyVPva6m5EgD4ZQbDaF0RkXu3qWX
         SKkTDbqr/lBiA8CwJ8Cjkf2S1YDuYOcVK0lZaKhJ5rpA4FvFOjAf5aPkkq6ACnXgtygk
         6iX/jLvqfIUpwlTJ7rk1XQbQXfjkibpdzplTh/+cVRAM7QI4NDL8S+H2n2sP7TdydBnX
         MMN4S+oRWOFf1mh4mxe8vPxhX/WVHKVvv/txt9zfR+aBJ1LJ8F8kq+HHVu2Wj/85xSRl
         pfwxJ9JJH+PbXTw6vj/3cGJ8c6wDQKUlw/u/MCS/87j8zAGoQilCDQTJ0T8oy8nKGim3
         IZBA==
X-Gm-Message-State: AO0yUKXt3VygMqvkH8Ne8Do3Qiac24tX2yY6zhK9j5zYhMshuVJrDNLm
        QXz5yzOihRPYfFEt1MRlTt9lOIT0YhXUaSgkT+HOffuahWMUEz7gJLw8Npp7dS4krBoD2VTfL9b
        2S/AWUNPTAQzKSHJr85lHhM4D
X-Received: by 2002:a17:902:8b85:b0:19a:b74a:7f7e with SMTP id ay5-20020a1709028b8500b0019ab74a7f7emr5874049plb.28.1676999606334;
        Tue, 21 Feb 2023 09:13:26 -0800 (PST)
X-Google-Smtp-Source: AK7set+RtL9IAIPXYJCcn8MrIbfJVmPzlVV8mepNgQVRI7RPXIX1+E4Kx9H9UE8S/26bkU9BkRgtWw==
X-Received: by 2002:a17:902:8b85:b0:19a:b74a:7f7e with SMTP id ay5-20020a1709028b8500b0019ab74a7f7emr5874025plb.28.1676999606000;
        Tue, 21 Feb 2023 09:13:26 -0800 (PST)
Received: from ?IPV6:2601:1c0:4680:5870:8add:adee:83ef:b4f3? ([2601:1c0:4680:5870:8add:adee:83ef:b4f3])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b0019abb539cddsm10112124plp.10.2023.02.21.09.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:13:25 -0800 (PST)
Message-ID: <65ab5cb1-2dbe-e853-48ea-d1df87706cf0@redhat.com>
Date:   Tue, 21 Feb 2023 09:13:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx>
From:   Josh Stone <jistone@redhat.com>
In-Reply-To: <87v8jvnqq4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 4:32 AM, Thomas Gleixner wrote:
> Now the problem is that 'Instant' in it's specification is bound to
> CLOCK_MONOTONIC and there is no way to express CLOCK_BOOTTIME, but
> that's a shortcoming of the spec which ignores CLOCK_BOOTTIME
> completely. IOW, that's also a problem for user space.

That's not exactly *specified* -- it's meant to be opaque time. It is
documented that this currently uses clock_gettime monotonic on unix
targets, but "Disclaimer: These system calls might change over time."
CLOCK_MONOTONIC isn't even consistent across unix targets whether that
counts suspended time. It's been debated if we should switch to
CLOCK_BOOTTIME on Linux, but for now we're sticking to monotonic:

https://github.com/rust-lang/rust/pull/88714

But as others mentioned, this is in the std crate which isn't used by
the kernel. You could absolutely define your own with more specificity,
like kernel::time::BootTime, and copy an API similar to Instant's.

