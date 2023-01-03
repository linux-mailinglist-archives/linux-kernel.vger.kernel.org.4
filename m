Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7665C00F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjACMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjACMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:42:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D039DE8F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:42:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs20so27195488wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plP8eaSv4p/j58ARogbeHs6r9oV97TP6BjSF7TScfhs=;
        b=nVLZVn/pHpfIFNkof47FKj8345x3SEuBJ0dDD2IVs8+YZOYhaQnhorOr52T0KwnbSy
         Nn88cQqeqzheb1OoKCicrDnTesC8lhGpkwO0IJdvAc9kotJTsI6/hkU38OkTpwMQgxxN
         umN1KL/stn/CD0DDQRSQQ7L9y61nmMVIZjF481R8Uh8emIko5edFUnENWP1IpsxgDwX9
         sVh8e6y6RiaTC9FEtm3ecuK1PsWigLBgNtRWZ4aby2XIDMFWxGTNxmjrBL9s/a6h0yb4
         4wkx+jOak2QwyUV/7EiN3hhe9lTe0ebHmuXQ9CcC5+FTgM5AwqHuf/boFS35Zk7vKcge
         i+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plP8eaSv4p/j58ARogbeHs6r9oV97TP6BjSF7TScfhs=;
        b=U6lfp0F4HInjynkxz9B+gSaTgkT7dXMfzCkOgjQ7S0VH1ENqYX4NzuAz3PIh9Zi8kB
         4prReI99+sIIteECJdc+peTgceITwD9XsPPNyr1GiNstqNWWCtfc5OgeUIwfIOWcMnmD
         O0dKM9/bMqnu8UIScU6EP0LV9UYtr08JoJEbMFPw7RAIXoA7yGkDPvtAoNy0glIQQu6Y
         tGbiLYFsXgTTcQXX3uKAfByABfdGbq8OJhUuK2+31NsBt0REc+sV/qVACKa1pTeIKfM9
         LLy98CYkEY78j5tji6ZLXnx22ZAKTECNxsPoz8w3/0xRTNNipCx5bez4nxcXwpVWpDBk
         /yJQ==
X-Gm-Message-State: AFqh2kolgkRCoAbAmwBwldjpXYBKfV6NieFrOF2+fbYha3m+DmuzF7CI
        qvargv8NnHdLM5JuGl+4E7ID5Q==
X-Google-Smtp-Source: AMrXdXubqxqgUBGU+2BN1FJDwgZTb4RacIhpp2ZQ9GQlGD9Yj0k7JNr5Y/bMceq3k0+XGegF9Y71yA==
X-Received: by 2002:adf:fb91:0:b0:27c:88f3:8cb8 with SMTP id a17-20020adffb91000000b0027c88f38cb8mr16569697wrr.25.1672749770648;
        Tue, 03 Jan 2023 04:42:50 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l17-20020a056000023100b00241fab5a296sm30914509wrz.40.2023.01.03.04.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:42:49 -0800 (PST)
Message-ID: <a1143ca2-9460-f156-58a7-66072034559c@linaro.org>
Date:   Tue, 3 Jan 2023 12:42:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: fix registration vs use race
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
References: <E1pCdoY-0044aT-A5@rmk-PC.armlinux.org.uk>
 <bad6a162-3e82-2f5e-1822-23951b61450b@linaro.org>
 <Y7QVh8/LPQ7H8ehp@shell.armlinux.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y7QVh8/LPQ7H8ehp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2023 11:46, Russell King (Oracle) wrote:
> On Tue, Jan 03, 2023 at 11:30:36AM +0000, Srinivas Kandagatla wrote:
>>
>>
>> On 03/01/2023 09:42, Russell King (Oracle) wrote:
>>> The i.MX6 CPU frequency driver sometimes fails to register at boot time
>>> due to nvmem_cell_read_u32() sporadically returning -ENOENT.
>>>
>>> This happens because there is a window where __nvmem_device_get() in
>>> of_nvmem_cell_get() is able to return the nvmem device, but as cells
>>> have been setup, nvmem_find_cell_entry_by_node() returns NULL.
>>>
>>> The occurs because the nvmem core registration code violates one of the
>>> fundamental principles of kernel programming: do not publish data
>>> structures before their setup is complete.
>>>
>>> Fix this by making nvmem core code conform with this principle.
>>>
>> how about a Fixes tag and Cc stable?
> 
> Which commit do you suggest? This error goes all the way back to the
> inception of nvmem, commit
> 
> eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> 
> but clearly its going to be a lot of effort to backport it all the
> way due to all the changes.

I understand the backport issue, On the other hand as this a real issue 
backporting to atleast stable kernels would be worth.

--srini
> 
