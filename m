Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A069623AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKJETG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKJETD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:19:03 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465B18353;
        Wed,  9 Nov 2022 20:19:02 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 130so624213pgc.5;
        Wed, 09 Nov 2022 20:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vI+BbdTspMedL1PIKTxIlxg5i5FOr9/mbNi3wUwy048=;
        b=CHVL/MN01rzFGwWdgDzCFScorFJlhAbYmR6Pjqpaq5FeCwMgaDXH+l7N8O5P4yX4Mm
         rAo4Cw1i1gAmtcuSTJC2J9ZqKFecwJLfOGGqiW/dx1gg4hej+7VhcVHXl4AY7PpdAxk5
         DJh+c16hPOWN6oZCDh709h6PIxjNCFJzrkwSfjfZEJTvujmJ4OUy26WLyQkzHt7diF/S
         v4dCZGoVYgCXYHzLOGeo6holF17F1i4vTfgKZw+TZkSsJ+HzKSNCx8xLEOm1s/AqLqYY
         YCqcN1QTelUgNFDMSMzgl0VBPPFPBlbUtTTrSntVarjsBIdwChx1KTboUhDYf923p8YA
         9XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vI+BbdTspMedL1PIKTxIlxg5i5FOr9/mbNi3wUwy048=;
        b=f/HbuhrquTLai2upmyoHzqhuRZb6NTxLOXkGlG9vJ/GeIWPqGGbuUwEAszG0VrlYop
         Ld76/Pbicpvap113KjopFQuMLhsU+V1B4hFt/rrhCnbV4WZShTy2KgO7AAW4RJZ7+FkD
         yuzCRwhTqOtgd6jdUbM2RB2Gqo7jwfy9bqNVwqaY+7szIbWkQoyELKX3mjcW3+JAURdm
         YPstkOL7OM005hZ2KcJr+Fb6U+mj/cZfkII7d7j0ZNM+A4+2ra8Dn9SQX1Jc05yWxtXj
         o3DSKBMiecCjIPT0ZXQazhQr2GAQUagqmW7pHFJvMkdxOE0PAGjzrxvS0nUAFbxduetk
         S7Cg==
X-Gm-Message-State: ACrzQf0bs9FWmkjsYvruLw5WfrjstofO/d/D8xnPWLKI8vC9ePWFGs7V
        zj3qzp9G7xR5GIb67N6IKJE=
X-Google-Smtp-Source: AMsMyM4apZRgTURnPH5Yuo/aptcggbvO6/JRovadyl38Ik/g6vm9uaZLZiycz7HmSMLsRgkyvpWeQw==
X-Received: by 2002:aa7:9389:0:b0:55f:6a0d:741d with SMTP id t9-20020aa79389000000b0055f6a0d741dmr1765218pfe.39.1668053941534;
        Wed, 09 Nov 2022 20:19:01 -0800 (PST)
Received: from [192.168.108.223] ([159.226.94.108])
        by smtp.gmail.com with ESMTPSA id y123-20020a623281000000b0056bb4dc8164sm9052053pfy.193.2022.11.09.20.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 20:19:00 -0800 (PST)
Message-ID: <ffda7120-c2aa-d093-a2a5-f5d169c7651e@gmail.com>
Date:   Thu, 10 Nov 2022 12:18:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] module: Fix NULL vs IS_ERR checking for
 module_get_next_page
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110025834.1624394-1-linmq006@gmail.com>
 <Y2x5a1YVbvmqrK9O@bombadil.infradead.org>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <Y2x5a1YVbvmqrK9O@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2022/11/10 12:09, Luis Chamberlain wrote:
> On Thu, Nov 10, 2022 at 06:58:34AM +0400, Miaoqian Lin wrote:
>> The module_get_next_page() function return error pointers on error
>> instead of NULL.
>> Use IS_ERR() to check the return value to fix this.
>>
>> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
> Thanks queued up. How did you find out? Just code inspection? I see
> chances are low of this triggering, but just curious how you found it.
I found this by static analysis, specifically, I obtained functions that return error pointers and

inspected whether their callers followed the correct specification.

>   Luis
