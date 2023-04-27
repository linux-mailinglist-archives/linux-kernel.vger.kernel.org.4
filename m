Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A854B6F070C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbjD0OMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbjD0OMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:12:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEE54C37;
        Thu, 27 Apr 2023 07:12:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64115eef620so5226433b3a.1;
        Thu, 27 Apr 2023 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682604762; x=1685196762;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=c9pWafJdGs9XhHSjXJtv5YiQxlqlIFTZBpbtKAwDdxk=;
        b=Av+lNUajxjSv8UgxbnVRhGfFQOAHb/COccIZjuLSdikQkwF+nvWnzi+wvy8GDo09tz
         t+8XH44U1+25d2cXzrsrpRO5ZbQ6qrkgYSWE2bgiRb3uGgBsy1TD0Eb9s/a7UcJW4wIY
         04CzU90dWtjoDoyo/cX0ruKtIZwx6kdtAA4fhHgdvmGO8E1LKDKtQlmSNGClM255u3I5
         zHpSnqVXb2wy6soIHAqwz4sRDnSOtl8C+P/EQFsLr9CT84WB7gOu3/NUVmu9Xt8emVne
         WgFN2ClYxiFK10Rpd+cdPG/bLY748kn4PeXAeksl+R/BRL/TcW1p54EZG76SnrbHslrX
         wSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604762; x=1685196762;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9pWafJdGs9XhHSjXJtv5YiQxlqlIFTZBpbtKAwDdxk=;
        b=ZDHgGOiYwb8tWowwUXLAOOuKLP+cA4/rTJHGHoWXFks05xjp5ol+Ncxt94KuOYnEiq
         Cakefsy+rXY2NxGc2jRtBIr5ulZpmpMJoHfblaosF3fWREKGCdkQXZT5eLyW0+h/InKq
         W+cqdDXeNmmt41L/EAVRyxmdtiO8kEBS8tJ3sWxBmIf+dCIb0bfkGow5tj4b03P9xSB6
         DZj4Kt0uXfkvUIDyMROyz3rm9L4/8FKnSOz//rdsvWkNB/bGjdYna9Cz6WqzfD9fzRHa
         rLHGzNNGPILWRPAbMJNS+RNxtMwnerHoBmM5G6yjMAMg/V9HfhLb/tln99O1/8Hyu9Vb
         uQYQ==
X-Gm-Message-State: AC+VfDwqZBYv0reeX/v/J95VzAL1yAlIulwCI2Djd2ZC1ooS+2yyBN8C
        tLnmQ9+Zyg4O0QEsYQWP0/CIU4tLKGY=
X-Google-Smtp-Source: ACHHUZ7iZXc8EIBQRmObMHVapK4Qag9lL7UzrHVy/qkUv4+LaXWJz9k3iC0D9apl6kRLD5Foi6QZIw==
X-Received: by 2002:a05:6a00:179f:b0:63c:56f5:5053 with SMTP id s31-20020a056a00179f00b0063c56f55053mr8262985pfg.13.1682604761985;
        Thu, 27 Apr 2023 07:12:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i64-20020a62c143000000b0063d328a690fsm13188926pfg.25.2023.04.27.07.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 07:12:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a6dd47dd-6dfc-787b-43ed-edda0cc0e51f@roeck-us.net>
Date:   Thu, 27 Apr 2023 07:12:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: watchdog: pcwd driver updates (was: No subject)
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230427133350.31064-1-oneukum@suse.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230427133350.31064-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Oliver,

On 4/27/23 06:33, Oliver Neukum wrote:
> This fixes some long standing deficiencies in error handling,
> several race conditions and disconnect handling.
> Finally a cleanup as we now can get the device easily
> from the interface.
> 

This series is a no-go. If you want to improve the driver, please
convert it to use the watchdog subsystem API.

Please note that the subject of your patches should start with
"watchdog: pcwd:"

Thanks,
Guenter

