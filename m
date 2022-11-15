Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEFE629DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiKOPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKOPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:41:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C882C107;
        Tue, 15 Nov 2022 07:41:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so36924206ejb.13;
        Tue, 15 Nov 2022 07:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bgyx5FfCpiGgQkICCBasflGAYvOLt2ZvMDvdN9h5OQ=;
        b=YPy0jGV2NnpPdLWarfkmqQiLGAMYsnG0ygimx0w5tdmAQDIGMX52b54QzAvbtgeDiD
         ByY6RU3k6JMMwVHeulZwSvDouoAZPqbwaIvYtIf7DMiuL+54IaALMQYqs+jyHktA4WRV
         Cy3t+ugC3eip+2sfab2I07JvtKtF7IrkdTdvdwVPqgmKDxTkrJMAzuAudaYOVRvQSNzp
         3PcVmzUqBNjNqSsl+fLcQYP/ju48fCraRqkdCNHW/M6p6Naf/+JINVTqRBgStsys8zP2
         pJNfUWlylJLUBh0M2kd4x8pEM4Fvz8j3wJpAJTaMGos2ugqDQYe6k6xjE5043k2E7yMx
         huWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bgyx5FfCpiGgQkICCBasflGAYvOLt2ZvMDvdN9h5OQ=;
        b=ltTnXMi2K1E1osNtDqk/3lYLqDWuBu8rJeL1F4SOlWIc8Ppre8E1I+Buqtv4kQRckH
         UehOMov21WbVkOwjSV18WH8jbhhrJlxf4/I9is5c5yPakj+q8cK0LkAZt+VAHCqsJvrg
         dPb5zWMeu6Vs9VJf6jgwbXkXFLcjAnD5hNnmEThjEmhA/XMtqBwpD5GiCnmy7WyRJj/w
         tHD4u2no7XjzWnkPyZEe3rsmg+wFqVOPhXI/DmsblxJnV1M4c6BTs1wx4PsBEbNVF/Eh
         cwcIkU1tBdSkMLuF/PztXgE/Uy4uhwya0jflTEyUicURYCwHTyFmozRWSvhciWiDnuJf
         zmAg==
X-Gm-Message-State: ANoB5pmPiC7EUGebxfLSZqyy6MZoEH5IPOBbGQtbgGzVCV6ncZZ00Jhn
        Ds4c5vDQCHZkDigforJwNcU=
X-Google-Smtp-Source: AA0mqf58bxDLOArQwPpPWdOxsW/qtXOohBgTC6D1UAzGOUo4e99h7025IKUvXv+mFfk/lrzAYyB7EQ==
X-Received: by 2002:a17:906:a884:b0:778:d81d:b1f0 with SMTP id ha4-20020a170906a88400b00778d81db1f0mr14013602ejb.731.1668526905950;
        Tue, 15 Nov 2022 07:41:45 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id 20-20020a170906329400b0079dbf06d558sm5574656ejw.184.2022.11.15.07.41.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:41:45 -0800 (PST)
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Fix battery
 identification
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        philipp@uvos.xyz, Pavel Machek <pavel@ucw.cz>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
 <715a60b5-2f3c-caf7-2b24-61ec92bda9be@gmail.com>
 <Y3OY/l2ZBX+WbRR4@atomide.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <90314373-de30-019a-dc0c-f5cab57a48c6@gmail.com>
Date:   Tue, 15 Nov 2022 17:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <Y3OY/l2ZBX+WbRR4@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15.11.22 г. 15:49 ч., Tony Lindgren wrote:
> Hi,
> 
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221110 16:40]:
>> On 10.11.22 г. 18:05 ч., Sebastian Reichel wrote:
>>> Why do we care?
>>>
>> Because if we know the battery is genuine (or at least pretends to be :) ),
>> then we can read battery parameters from nvram, see patch 3/3. This will
>> allow us to charge HV LiPo batteries to 4.35V, using the full capacity.
> 
> Let's not enable charge voltages above 4.2V automatically at all unless
> the user chooses to set a higher charge voltage via sysfs manually.
> 
> We have had reports of bloated batteries if left connected to the charger
> at higher voltage than 4.2V. This seems to happen after connected for some
> weeks or months. AFAIK this happens both with Android and mainline kernel
> at higher voltages.
> 

Not that I sent such patch yet, but still, thinking about it, we should 
be able to easily prevent such damage by not restarting the charging 
after battery is full and voltage has dropped by 50mV or so. There can 
be a threshold (lets say 4.25 or 4.2) above which charging shall not be 
re-enabled unless the user reconnects the charger. Even if default stays 
4.2 and it is the user that has enabled 4.35. Just an idea.

> For more information, please see commit d4ee021c410f ("power: supply:
> cpcap-charger: Limit voltage to 4.2V for battery").
> 
> No objections for using the NVRAM to detect the battery max voltages
> though. That is as long as the default charge voltage does not go above
> 4.2V.

Patch 3/3 does just that - reads battery design parameters from NVRAM.

Regards,
Ivo

> 
> Regards,
> 
> Tony
> 
