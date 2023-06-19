Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4C735DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjFSTss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjFSTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:48:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B99610F2;
        Mon, 19 Jun 2023 12:48:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so1297480b3a.3;
        Mon, 19 Jun 2023 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687204105; x=1689796105;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E7KkfLpi3l6gCUuNlm+7kZCAQ12I62eGTlh/1JYDgMY=;
        b=IDpUDVdVuxOhfgsGCa2B27RISf9xOIuosHH069kBR36yOsr6kZ0Db2MzKtL+Z3b8G2
         D2lxaycZJPA6JBfOpWlTj9F3OEC8+vmreysHOl+57ne/myVjLvWigfn/OPUni6Bvi+iM
         8QufmddbKS6PdDsOYgzV06dVJlbz9Ndck0DmUXT2/aNJIc4MiKnxmVtkZKfR/oJLHf4N
         msWbGYedFvA1M3BDB3ZjVjuXdThzXE4jkmq2FCU8qdd+ejXWPe8khp+8DpZpi3utpfa8
         HJyvCJRn3xw68xlWXAhuQxWjKUqj9MqbG8ykeGSrhpqNpA3IWwzZMOjxziJBc0B0/Ilc
         MSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204105; x=1689796105;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7KkfLpi3l6gCUuNlm+7kZCAQ12I62eGTlh/1JYDgMY=;
        b=YzKMe2qt6pFnITVUiRP5ArokqgV2IGBoAeuNWURBS4FItZwIk1wSQhxpAOAAYM9K5+
         PPHFdKcjNrNSfh7k6jqPd9QeqM6pp4PbUytl5EgOHYnWbkBR8HjtbURguai418ND6F3b
         jjOu7aRO8g/3/oHTw23RApPJsdlLw/jxieMKGRnSKMq3Fyyp8FSyzY7kNtqjq8lI9ga9
         acTjyhZAqk2L+8a6r+sCpQG6KXpZexfI9Ic+NmA26S4XQvWMJm0lUcd9KrA1kqgfM0fy
         ErjEK7cEO9bJ+4CslkiWt8NyFHzVNfntkogO890kMc0PbsxbXztjpoCeZRXYQ4xbkLlF
         lIrg==
X-Gm-Message-State: AC+VfDyleXqNU6Kf2eaqARA47cFKgS6lZ0WQ8vXEtFgC1dlpR1XK88u+
        HuglXSVrvTMQYXlHKhmkGG9fXE7S05E=
X-Google-Smtp-Source: ACHHUZ6BQl8FLKmwAS00w0vVlb2sKbE3jUFW3qQxqWnAmoJ03YXTPomCVRUCVBlstmyclKOuqSp2Bg==
X-Received: by 2002:a05:6a00:15cc:b0:666:5f59:cfe8 with SMTP id o12-20020a056a0015cc00b006665f59cfe8mr1984688pfu.34.1687204104736;
        Mon, 19 Jun 2023 12:48:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78818000000b00640f588b36dsm68430pfo.8.2023.06.19.12.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 12:48:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <99f95783-176a-c227-6a75-1c6e05a8020e@roeck-us.net>
Date:   Mon, 19 Jun 2023 12:48:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Baskaran Kannan <Baski.Kannan@amd.com>, babu.moger@amd.com,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619165413.806450-1-Baski.Kannan@amd.com>
 <4585ec62-b7bb-9f2a-eee0-07032648e55a@roeck-us.net>
 <012ea369-52ec-4a7a-ec66-812690d430ad@amd.com>
 <598247ee-3ff8-8413-274a-7d313c2af324@roeck-us.net>
 <a8107f7d-3163-4f03-9f17-82e1a93d8e91@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <a8107f7d-3163-4f03-9f17-82e1a93d8e91@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 11:53, Limonciello, Mario wrote:
[ ,,, ]

> So Pinnacle Ridge and Summit Ridge (Zen/Zen+) have model_id_str values of 'B1' and 'B2'.
> I think we should be able to detect those and only avoid showing the negative values when:
> 
> * Family 17h
> * Model > 0x00
> * Model <= 0x0f
> * Model ID str B1 or B2
> 

Threadripper 1950X model string is "AMD Ryzen Threadripper 1950X 16-Core Processor".
Not sure where B1 or B2 is seen, but it is not in the model string.

Guenter

