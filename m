Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749AA6FC18B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjEIIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:17:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9295D1BDA
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:17:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3063891d61aso5238659f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1683620246; x=1686212246;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yhDzJE0LOnWCfYyCn9a+XejfJlcvkoK8/XB5X1vX00A=;
        b=dV2nHVEFBw92Cz8RsvRh8ZoZ4xEgyeUcXn331OpSx1IbVJld66/YaV+i1F4DmV2+Ug
         JSrvJLyrQZrkppbhVhhYkXVOnHBWLIUlVghfOXzLMNpZuu8+IQOMJeLTGPT8yz/mwh3c
         BaaR4GYAQ3/5/vZn+bQFgsB/KzzgF2FaC7fwgsv/Cd7H32w4omdpL+16bNWKFFlzBq7Z
         8u2mQJM6bg+lkNMyeoZM8Dt0XmzKJhDEaeUf2XWE5neeO5NISNlNUXFLGrcNJTVn0l9a
         Q3Z8ipyzLMMlq2VpfFleB0JUz/GhhzVfcTcSwJKNdRXqn9EkKdw/nGyzQfBPYwc1ArhD
         Rm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620246; x=1686212246;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhDzJE0LOnWCfYyCn9a+XejfJlcvkoK8/XB5X1vX00A=;
        b=GDVVoO/brYRKUs3axWisDsg7pJAyjSEJg0oudhUNCwU9VSavuYYRG7N49CYBthb3tm
         aS5R2pz2FSDqLlNo0qJdwVNVuRj4rJb9aHI6vI9KG41FANjwwLAL2TMW1IFakH5+/jei
         5o6HCKS0kTFP+9/xpmju15mFRZFSnOs2e4KYpNNDMlj00oeNnkt7rd+b3LiapFi/d6LB
         4N5P7/UlKcyXigXKgQo94E+Xa80hsCC5mWHa3/DUq5BBC6e6pmWJPtpk88Qm9oXldDVX
         /oPmYVxzTGdsaWe7JNf5y6uqlePe5JemI59EOs3IKRC2yQxVvWjyYi68vC3CXT5RZJ6g
         n8Uw==
X-Gm-Message-State: AC+VfDyoQ/RI2v1M2+FjD5tPKoJgkZEWB2iYc89nsIY4zJ7B9tTe3c3A
        8O0UKn+RIsAHRSdDpp15cz3XagIx/lgDUAbk+Lw=
X-Google-Smtp-Source: ACHHUZ6hOpmIRtNG2LiaDEfDiVZPUFbso2iZvpPKkvTR3dWH0QLg1k9VZHIUNR/0TEvN/xQhyiXi1Q==
X-Received: by 2002:adf:f183:0:b0:2fe:f2d1:dcab with SMTP id h3-20020adff183000000b002fef2d1dcabmr8953210wro.58.1683620245963;
        Tue, 09 May 2023 01:17:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:60c6:b628:2847:4133? ([2a01:e0a:b41:c160:60c6:b628:2847:4133])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bc8d0000000b003f17e79d74asm19067988wml.7.2023.05.09.01.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 01:17:25 -0700 (PDT)
Message-ID: <3f15c555-a33d-9be1-2889-78627d37bedf@6wind.com>
Date:   Tue, 9 May 2023 10:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Content-Language: en-US
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <172df925-48ae-bc25-81fc-a2d6b39b8739@6wind.com>
Organization: 6WIND
In-Reply-To: <172df925-48ae-bc25-81fc-a2d6b39b8739@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/05/2023 à 10:09, Nicolas Dichtel a écrit :
> Le 06/05/2023 à 00:37, Mike Christie a écrit :
> [snip]
>> (Nicolas, I confirmed it fixes the 'ps a' case, but couldn't replicate the 'ps'
>> case. If you could test the ps only case or give me info on what /usr/bin/example
>> was doing I can replicate and test here):
> With you patch:
> $ ps a
>   PID TTY      STAT   TIME COMMAND
>   191 ttyS0    Ss     0:00 /bin/sh -li
>  1255 ttyS0    SLl    0:53 /usr/bin/example
>  1742 ttyS0    R+     0:00 ps a
> $ ps
>   PID TTY          TIME CMD
>   191 ttyS0    00:00:00 sh
>  1743 ttyS0    00:00:00 ps
Sorry, this is wrong, here is the right screenshot:
$ ps
    PID TTY          TIME CMD
    538 ttyS0    00:00:00 login
    573 ttyS0    00:00:00 bash
   8282 ttyS0    00:00:04 example:2
   8825 ttyS0    00:00:00 ps
$ ps a
    PID TTY      STAT   TIME COMMAND
    538 ttyS0    Ss     0:00 /bin/login -p --
    540 tty1     Ss+    0:00 /sbin/agetty -o -p -- \u --noclear tty1 linux
    573 ttyS0    S      0:00 /bin/bash -li
   8282 ttyS0    RLl    0:05 /usr/bin/example
   8829 ttyS0    R+     0:00 ps a

It fixes the issue.


Thank you,
Nicolas
