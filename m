Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9229A6DC81F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjDJPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:01:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BF4ED3;
        Mon, 10 Apr 2023 08:01:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso3254958pjt.4;
        Mon, 10 Apr 2023 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681138876; x=1683730876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D/gheyaCTp4V2rB10c4zOvu9Oo7rvG6c7rSlnCnrhsM=;
        b=AoIgJLUa3lJgR4pR1dCSqC/X1z+doWpyDjIOIrQWFfYK32IKPjTfyv54o+LqUx36tE
         zEhARCNCOb9nMheGkGhASK+lbJf/FA5fv6q1sxbccydJjZ/1SSjQgKihpEbmZ/UTKbsL
         1rK1uSvNQRKq+LElzETzZZ4wxaRGDaB65f35Imm6F9ijjfsPolgUPyOe57R9uRy4Z/zu
         lVjHGQ2kXd7EuSwn83PmzmsXUt4a+JEZYxLye5hIi64HtyOhVfnLynDfNDx8DGpC9gs5
         4v9r/t6EUe6NSWZtrOuVTgQV7KIItRNmjYWKbwbCFYXVAa3+RtmzORT90cwpFji5c0Wz
         Am4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681138876; x=1683730876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/gheyaCTp4V2rB10c4zOvu9Oo7rvG6c7rSlnCnrhsM=;
        b=60SZAnkfukdWZ6Ee9S4+YD6DLoNgzRfCo/GLFmqDdpZrYzjF4RP2D9+Z3zQV+YmO3T
         YGKLttWLqS1nLvBDkG27C4kNuBmUQ0t0FadHCUE7Vgt4ooadqPVplb9jZtpLfiEPy4Py
         tmwMldfWdOBJLzVhyqnLj4SGX5eyIxIuKfOr0aoOmAXhs6x2m3TYBkOY1Bqz/bWBJi/G
         cQUQCeW1z9EXDAUpM/chirghTB74QZt+ZhBbqJnaudxodEAyf9go/xbTJY1DBUTwI/LM
         748PB9bHwsOZU1d/KEImBhIYFnP8Ll4tfnoqXzMUrxa5TuK3npoSI99/Jd2/ok0ZLiED
         Pfww==
X-Gm-Message-State: AAQBX9d7jUbnCmqH6pPwlyQ2nThTDp2TAWcRIsucJx/lW2DBqCX3l1BF
        vhFIk7gEdIgoaDnAKPon3wI=
X-Google-Smtp-Source: AKy350Y9XKZgt5cHBZpkiyzzMdjkE3jeC/Na9/l9cPQdfSolpcWiFr8jW0VR/iJ0T9OdgIyVWQ64Ug==
X-Received: by 2002:a17:902:bf41:b0:1a1:a800:96a7 with SMTP id u1-20020a170902bf4100b001a1a80096a7mr12955497pls.8.1681138875948;
        Mon, 10 Apr 2023 08:01:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001a52974700dsm4386082pld.174.2023.04.10.08.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:01:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd4497b6-32a4-3135-fc62-fafb9fb76d26@roeck-us.net>
Date:   Mon, 10 Apr 2023 08:01:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Remove support
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fred Eckert <Frede@cmslaser.com>
References: <20230410143101.182563-1-william.gray@linaro.org>
 <7b0fbd06-73d0-7fa9-3f03-e788f1df4631@roeck-us.net> <ZDQifl7EB33dh/eu@fedora>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZDQifl7EB33dh/eu@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 07:51, William Breathitt Gray wrote:
> On Mon, Apr 10, 2023 at 07:43:37AM -0700, Guenter Roeck wrote:
>> On 4/10/23 07:31, William Breathitt Gray wrote:
>>> The current maintainer no longer has access to the device for testing,
>>> the original user of this driver indicates that they have moved on to
>>> another device, and the manufacturer WINSYSTEMS does not appear
>>> interested in taking over support for this code.
>>>
>>> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>>
>> A bit harsh, maybe. Just mark it as orphan for the time being.
>>
>> I see there are other Winsystems drivers. What are you going to do
>> with those ?
>>
>> Guenter
> 
> Oops, I didn't mean for that commit message to sound so harsh but merely
> log some brief reasons for the support removal for posterity. However, I
> adjust this to orphan status rather than dropping; what is the process
> to mark a driver as orphaned?
> 

I didn't refer to the description when saying "harsh" (the description was fine),
I meant to say that removing the driver would be a bit harsh. There might still
be some (unknown) users, after all.

Just submit a patch removing yourself as driver maintainer and mark its
status as "Orphan", with the same explanation.

Thanks,
Guenter

> As for the other Winsystems drivers, I'm still able to test those so I
> can continue maintainance of those -- although I'm always open if
> WINSYSTEMS would like to join as a supporter, or a user co-maintainer
> comes along. ;-)
> 
> William Breathitt Gray

