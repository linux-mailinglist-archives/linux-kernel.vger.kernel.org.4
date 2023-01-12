Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA06679DE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbjALPwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjALPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:51:41 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752A544CC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:40:29 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id b127so1216299iof.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWWhNrT9Ke8XYLb8r5IaUaBZVoV2XiZfmbvzfAwI4iI=;
        b=MngxITgLNyxn404MzBRbCEydZQMQNE26YYFbOcQHjBoQKLBkKHwvuE2F9SXy21IW/h
         fLACLURN+6ruZuqgdfFZwtYuI9OjIt1wAYBcAsKevWgM3+v6CEXVDEGqN1MJNldRuvBd
         ZqFMzx0zww2t3oYm9MN3upHhbqM/L/MXTcAhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWWhNrT9Ke8XYLb8r5IaUaBZVoV2XiZfmbvzfAwI4iI=;
        b=ljttjSI1MjZK6tbVrtDP9PTZ499nJ2/xxebk2y1h92Xro6g+vO3lTASuuMjKrzQXzr
         VMqa4iBdUYE8Ks3IobhXqxp2YQv1/45UGjLyt9c6dqIYZsUDXrTJWgBtLi/ckkC8JYiC
         GL6ka9H+P9Qeg0PyfmSuMBp5RwoXgS1XyUtXv17dUFcb75Af/Ja7AnT+50IGJM1CgmFm
         MCv64Iq7DpvBYixbmEMjzZ7TUpuFQnzDC77kqxhEUjo06koTQeYo5xO2gMAWw+3sZ/SO
         V7+33I0WeQpHKqwBURWfOYJeqbc5MqR37achqamqP0y5Bo92xBp3UoIuPwdFl83pPJwI
         I9DQ==
X-Gm-Message-State: AFqh2kocUrDS93U3LsLqNJUECNVoEnlYp+AAPtVnEAZfUN+/4Cxa4LBJ
        Cqu0kYz8OHbLHWBawMsl/NXlCA==
X-Google-Smtp-Source: AMrXdXtNICG3twcmAi6A90HH0BbzD1t6DeiNY72gWA6aRASJLdYd6Md5XZfl8hHzTQHbQJtgx5J3zQ==
X-Received: by 2002:a5e:9408:0:b0:704:69fd:280 with SMTP id q8-20020a5e9408000000b0070469fd0280mr966631ioj.2.1673538028493;
        Thu, 12 Jan 2023 07:40:28 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r10-20020a92d44a000000b0030314a7f039sm4776849ilm.10.2023.01.12.07.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:40:27 -0800 (PST)
Message-ID: <db42f90b-dec3-1e2b-c973-b4dc76cd4830@linuxfoundation.org>
Date:   Thu, 12 Jan 2023 08:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_kernel_BUG=c2=a0at_mm/usercopy=2ec_when_using_usbip?=
Content-Language: en-US
To:     =?UTF-8?B?U29zdGjDqG5lIEd1w6lkb24=?= <sosthene@nitrokey.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robin Krahl <robin@nitrokey.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <aa686f98-c9a3-6225-18e8-7ca57678ce4a@nitrokey.com>
 <4c9a5640-9ebf-db87-fcb0-b076b615e4e4@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4c9a5640-9ebf-db87-fcb0-b076b615e4e4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 08:13, Shuah Khan wrote:
> On 1/12/23 01:40, Sosthène Guédon wrote:
>> Hi!
>>
>> I have stumbled upon a bug that is triggered reliably by using usbip.
>>
>> We are using usbip to test our firmware. usbip attach works, but once `opgpcard-tools` interacts with the firmware through pcscd, a kernel bug happens.
>> Then usbip stops working, and `lsusb` as well as other tools interacting with usb devices hang.
>> The symptoms are similar to https://bugzilla.kernel.org/show_bug.cgi?id=215487 but the kernel bug is not the same (see attached dmesg logs).
>>
>> The bug can be reproduced on arch (Linux archlinux 6.1.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 07 Jan 2023 15:10:07 +0000 x86_64 GNU/Linux
>> ) and debian (Linux nitropc 5.10.0-19-amd64 #1 SMP Debian 5.10.149-2 (2022-10-21) x86_64 GNU/Linux), though the reproduction is not minimal.
>>
>> To reproduce the bug on Arch Linux, with the packages rust, pcsclite, and openpgp-card-tools installed:
>>
>> - Compile and run the usbip runner from this PR: https://github.com/Nitrokey/nitrokey-3-firmware/pull/149 (`cd nitrokey-3-firmware/runners/usbip && cargo run --features alpha`)
>> - Run `usbip attach -r localhost -b 1-1`
>> - Run `pcscd`
>> - Run `opgpcard status`
>>
>> The bug should happen.
>>
> 
> Thank you for reporting the problem. I will take a look and
> get back to you with possible fix. Will you be able to test
> fixes?
> 

Please send me complete dmesg and your kernel config.

thanks,
-- Shuah

