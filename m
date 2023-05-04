Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C56F6F98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjEDQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjEDQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:10:01 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30C5B9B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:10:00 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-760dff4b701so4483539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683216600; x=1685808600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1uT9aPMfbt5S8TjfS2OMEfFbn0uM/p5n+XCA9cHmk=;
        b=Vdpc0IWMfa1eUSWOs8j2JeGzRr3ID9DOuBhgRytriJqsD3eT02KuwfgwA8Wl7B/0Mq
         pzrdX43h2ZKcpts8VNG19znzYbM4h9vGlDtZS5Q3APIUOMFXFcU+9LzusHFR9dP4JmAK
         l1Ni4f2xw+RwmZArNZmMy4bxrD9qM6Xc2QbLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683216600; x=1685808600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1uT9aPMfbt5S8TjfS2OMEfFbn0uM/p5n+XCA9cHmk=;
        b=E+fmY+57knhgRdXG91PsDPhrZuB62iuYVmx7O3Fogd0WtdWquoT0ugYUpjV/RwLiDT
         q4Zgwho6ubO1wr/LubYg7v3n9OEPgOZyimGu6Y8jftMPLWhfXvRmFoDbXfBSdMZAUmSI
         sppX5TTyBesrECNoJzsQ+Bz6GTAACwDkK0SW3bS613SYd24g8L1a/TKY40IkzstBmyWR
         5vodP9cJ4xXaMIwKA6f89OrgS7XQysfDSWihiTzwVKaXqB8yahOYyq0SC4BUNfubHRm9
         BeFqlGOK9Zdmd0WrXgNgoMq1IWzZWEnETtvjIio26GqvIJJBA9CU2z49fR/JXcaECs7f
         aNjg==
X-Gm-Message-State: AC+VfDzn0h3gPdl56zncXpXrZ2YusYqO1B9PwpmpEuHWNii8GsLAe0cG
        Js+E0vGFfsyulCz4mqizaHVQdg==
X-Google-Smtp-Source: ACHHUZ54nJy38M2vJQfXUwq4b4ACr25rS1LW3vySiieWVzVOIIgAwjN/+Q5/lLexUVUUwM3Nx0yF2Q==
X-Received: by 2002:a05:6e02:1312:b0:32c:a864:6eb3 with SMTP id g18-20020a056e02131200b0032ca8646eb3mr5295378ilr.1.1683216599632;
        Thu, 04 May 2023 09:09:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m16-20020a92c530000000b00331a4945ec1sm229641ili.42.2023.05.04.09.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:09:59 -0700 (PDT)
Message-ID: <f6f55e7e-4fff-7be0-9e88-b9980f20339b@linuxfoundation.org>
Date:   Thu, 4 May 2023 10:09:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpupower: Make TSC read per CPU for Mperf monitor
Content-Language: en-US
To:     Thomas Renninger <trenn@suse.de>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Wyes Karny <wyes.karny@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        gautham.shenoy@amd.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20230504062544.601566-1-wyes.karny@amd.com>
 <4480921.LvFx2qVVIh@work.fritz.box>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4480921.LvFx2qVVIh@work.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 00:47, Thomas Renninger wrote:
> On Donnerstag, 4. Mai 2023 08:25:44 CEST Wyes Karny wrote:
>> This technique improves C0 percentage calculation in Mperf monitor.
> 

Like it. Thanks for finding and fixing it.

> I very much like this patch.
> Would be nice to see it queued up if Shuah is ok with it.
> 
> Thanks for this one!
> 
>       Thomas
> 
> 

Thank Thomas for the review. I will queue this up to send after
the merge window closes.

thanks,
-- Shuah

