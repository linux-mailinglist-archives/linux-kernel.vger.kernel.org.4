Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC5E6F10EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbjD1EFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjD1EFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:05:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744402717;
        Thu, 27 Apr 2023 21:05:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b52ad6311so10748409b3a.2;
        Thu, 27 Apr 2023 21:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682654734; x=1685246734;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDN907CyaznRR4k8kodhgNDU+z16mOoMzStatTzaj+o=;
        b=kllEdpQ5bert43BWr7D8RdLHiVilg+1R0Y1t6YH+9cDQeEj5R2QW6izSMegjkBfofL
         BuB+H2eSAAmvwbGMIjGA4FrFvEqDewPX0HVvuYA2NslUsPjTcbb9xMhhjTwtiboTR5it
         oDNjoWPY9NLmYN8onsCoBHKIHVH9H+Y5Klk6fUEXkCzRDFTcVJx0K4h3fZsQKE64iGCt
         Y3zlyaVOXF5goDB/ksZ5BK1vb7PVuG418Q9/jMwy4EFz3LctThjAZk74gxamIk3OB1hV
         QuWjaCseN8Pn7Uz7rTP0DEa01H3ImysJ86mvE8ZyJJbnBDISFvvqVFP3t6MxFv8e21z4
         PsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682654734; x=1685246734;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDN907CyaznRR4k8kodhgNDU+z16mOoMzStatTzaj+o=;
        b=Q9REtvFzU0UECOx+UvLQW4PvvQ0bKmX8zyI7h6jiUqVSh1NLo5p0rQ7gMElXCIINpb
         hSXN1XVMwhaHdJWiWOrso5yMz3WNFx0pJzAeD0XrRn6jQfbxjoWWQJtqPvcBuhSNlZ9s
         pk9V6FfybpkQJ4RcluhNx1WExdSNBbAW1TSa3jtyFgqisliCzkgPWzwjEDVN0MVwSrwj
         EvuuRzrFl1/gBHiVnVzTozs1AJdoRi4JHYBfi43tuKd9DmoW+vCdEGQypgA4tyrWtOcT
         BGQbMeR+O0oN6B1v6hz9D5eIPUA6nMPl7zm99WkzESoFObFgrWTkKb8thw+/mONnB/cm
         gf/A==
X-Gm-Message-State: AC+VfDwsDWRuZO60d1CvVBranyQnq9k/39GuME4y0HGjvOtVYqmkA9yN
        /9VOBeTheuE3dExHUP+Uh8fAKrDh+Ow=
X-Google-Smtp-Source: ACHHUZ6p5hYapMMyXMNrOtPjMxF6eKMyWyrMZiNs6lC9QX3f4pBXBDjza3IoQlGe/aky2KrYm9IHag==
X-Received: by 2002:aa7:88c7:0:b0:63b:8cbc:bc0f with SMTP id k7-20020aa788c7000000b0063b8cbcbc0fmr5653746pff.22.1682654733775;
        Thu, 27 Apr 2023 21:05:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o76-20020a62cd4f000000b0063d6666ee4csm14000212pfg.34.2023.04.27.21.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 21:05:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dfcd56d1-102d-ace6-c8b3-8f668e5f6872@roeck-us.net>
Date:   Thu, 27 Apr 2023 21:05:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Joaquin Aramendia <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426184420.99945-1-samsagax@gmail.com>
 <720c2b48-ca48-4ee3-9158-f453e48cb012@roeck-us.net>
 <CABgtM3i+HZJDearvBK-sBrWnfqdrsuNCDYfxASC3QVsn8rAy-Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add AYANEO 2 and Geek models
In-Reply-To: <CABgtM3i+HZJDearvBK-sBrWnfqdrsuNCDYfxASC3QVsn8rAy-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 16:16, Joaquin Aramendia wrote:
> Hello Guenter and thanks for your quick review.
> 
>> Please run checkpatch --strict on your patches. Never mind, I'll apply the
>> patch anyway - I see the other entries are the same.
> I've run it before on the other patches... did something change in the
> checkpatch?
> Nevermid, After this one I may submit a patch to fix all styling in one go
> 
>> That makes me have a closer look at the code. What is the purpose of the
>> odd typecast anyway ? Why not just
>>          .driver_data = (void *)aya_neo_2,
>> and
>>          board = (enum oxp_board)dmi_entry->driver_data;
>> ?
> I don't know why but the compiler would complain with the casting from
> enum to void*.

Really ? I tried with both 32 bit and 64 bit targets, and the above worked
just fine (with W=1). I tried with gcc 10.3 as well as 11.3. What is
your compiler version, what exactly is the warning/error message you
observed, and how exactly did your code look like ?

> Found out that explicitly casting the enum literal before casting it
> to void* works and
> the compiler stopped complaining so I went with it.
> 

You are not casting the enum literal, but a pointer to it.

Guenter

> As a follow up question, since this driver has become more AYANEO than
> OXP since its inception,
>   wouldn't  it be better to change the description?
> 
> Joaquín Aramendía

