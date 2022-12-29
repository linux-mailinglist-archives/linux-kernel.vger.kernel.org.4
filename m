Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0E659064
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiL2Sae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiL2Sa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:30:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBBC16488
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672338444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ncz/JzRiNhIzkJdS+Qxx5N7DoIcWvm3kfeKHRY93eqg=;
        b=Z7VHiCaqsesVwB+oXV58/FuIz66fJiYbOPok+KccpFE6WC9mFMbGNdpTCd/1o9yzRMMUhR
        vOe5JSrLBHkIn7i3gEHUOsURXtHZ75yKKYkt672eSvC+ZGbzLfLaDonm21pompgOelTfku
        H3JflRIVx+MWUUF7qNmb3Qr3Cu8LMKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-DffOF79pOZOyvGlfMf2FSQ-1; Thu, 29 Dec 2022 13:27:23 -0500
X-MC-Unique: DffOF79pOZOyvGlfMf2FSQ-1
Received: by mail-wm1-f71.google.com with SMTP id m8-20020a05600c3b0800b003d96bdce12fso8377127wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ncz/JzRiNhIzkJdS+Qxx5N7DoIcWvm3kfeKHRY93eqg=;
        b=N5WDi+qwPvjwQmhYU3yFYxcFDVhmncF6ii7gO7Vo+Alg6sBthsc2AmEQpJPjqvRM9o
         LkSERdgM46dJLsfizS/6+Tg8qfvGUiP/ymJwpEar9lLzzw0iESQWyaeyzFxgFVriwv7n
         Ltzmuc4ac5GXOusnd32d8759X9EO4V/YBCiprrlnXL9K+x+/F07IaEN3Vxa0dD3mAqR0
         YOUfvxoHRPQ3fwnib05QjlnYBKFcsvVu6bCeR/PInxjWioO5LmNF+wM+7aaentD0caaZ
         IHiIiaNzhZVo8XNhk/ZVisJdWD0lBBcISStwOK5qQ077XWaIqlh/5ZBKAc6/Z9E/Bygs
         Ratw==
X-Gm-Message-State: AFqh2kroRqr0GqM9Ua0s3kLaCzFvW2h9cKN0wEEU9PMU/fXYZ3xH7T4s
        a997Q11s7Ytw9BzFutB7BbgVjAlda5FWFjEEQSd5wbRB3bNq9hT6uHsKeC4L9nhKTgcN9qkeqBk
        AFZqobjNAjQpADNOWdl9cmJHz
X-Received: by 2002:a05:600c:34c2:b0:3cf:7397:c768 with SMTP id d2-20020a05600c34c200b003cf7397c768mr20815947wmq.30.1672338441682;
        Thu, 29 Dec 2022 10:27:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsCc4gewdGeIbLXPGQ/OrYxNRihTGtBQpf+uuO+YOr1Ab2iTKmz/boWaAqV5T2Mf4PPK2R80w==
X-Received: by 2002:a05:600c:34c2:b0:3cf:7397:c768 with SMTP id d2-20020a05600c34c200b003cf7397c768mr20815935wmq.30.1672338441496;
        Thu, 29 Dec 2022 10:27:21 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b003d978f8f255sm22278897wmq.27.2022.12.29.10.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 10:27:21 -0800 (PST)
Message-ID: <257b19f7-89ce-39cd-a403-b5a03d92c7bf@redhat.com>
Date:   Thu, 29 Dec 2022 19:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mfd: rk808: re-add rk808-clkout to RK818
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228140708.26431-1-tom@tom-fitzhenry.me.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221228140708.26431-1-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tom,

On 12/28/22 15:07, Tom Fitzhenry wrote:
> Fixes RK818 (e.g. on Pinephone Pro) to register its clock, without which
> dependent devices (e.g. wifi/BT, via sdio-wifi-pwrseq) fail to probe.
> 
> This line was removed in commit 3633daacea2e
> ("mfd: rk808: Permit having multiple PMIC instances"), but only from RK818.
> 

Maybe add a Fixes: 3633daacea2e ("mfd: rk808: Permit having multiple PMIC instances") ?

> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

