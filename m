Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254DF6F4B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEBUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEBUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:51:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08419BE;
        Tue,  2 May 2023 13:51:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aae5c2423dso35500655ad.3;
        Tue, 02 May 2023 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683060712; x=1685652712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3o1/gGfAuM1GgmlkdkXFFdhfCcUzmKygNLMFJFzDzk=;
        b=RRgWhWnSHeshZj2YLkMZ0tddZTgKwe+pqjGtIDLYMZrYbNxwQG5Q6ovkEHFTA+3YJs
         X93v3qf0mQpHSRE7t2X5E9WwSad/4jQNLaI9X834EAg1WRmiJORx35g+9Fi6G5tXl31F
         PklwEVgm7vHTn+NFR8ndwl8XbNlzbINxOFAwqfOH/EMuP+1/BQtfwdqSLOa5uKSuf7xL
         xa7gaHO6zBXATWF5DWH+3hkAqitFcVBFQWstTtw/oNFs0zqpTL6A7OBzMcSEo5b2GFVl
         em5bsTMO93QN9QRgs1bkv4ZQeF0DCGcD5hZv+7FFEJp/1M6wLHpgzJ5o6247/Ba/bqKo
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683060712; x=1685652712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3o1/gGfAuM1GgmlkdkXFFdhfCcUzmKygNLMFJFzDzk=;
        b=FrvhpjPnpLhokNCi+Hs/dL/yZlefx1pD0CSgy3+o5326xwTdqFpOH1fEb6uuie0Fo0
         eqwseAZcnKT1Xxr/3fsb0zprteeUuYR/bdEyScSdb70IZxNCA+RTxlNtp97E9TECsfN9
         CBlZE4HeaYZcxq3mlXJUQhNDh0lCeXt0gcs8xjVDffT2maeS8oeFXE3EWY7rIOrsRmj2
         q9WJaa3fKGU8XFwl1wnAaopZ7Wh9BKNkXNx8AyDV1zFtZ3M1q5G2HRqcQTslya0/EsLs
         Rl4Bl0g6Or7rmnArHuATWSJdGMwZhCPBCvAi28QcNZvHxBpaMP5141mY5UmDNdcCPiRI
         UJCQ==
X-Gm-Message-State: AC+VfDwQmqW4MkakB8Gb6PxIpRqqEYetiibtHFNSJk8tM+OJYs153UlN
        mDnQ3IuDWaoNhl2SmA/YuWM=
X-Google-Smtp-Source: ACHHUZ6u7jjyF8dsPzHmxLaowBUYNXThg4DzZuIZQ4+Z1iyATJWzoHLB4mLLHKx+g3SHU5Vlsf1Xnw==
X-Received: by 2002:a17:903:11cf:b0:1a9:95fa:1fa8 with SMTP id q15-20020a17090311cf00b001a995fa1fa8mr22748295plh.41.1683060711925;
        Tue, 02 May 2023 13:51:51 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6edf:1ae0:55be:72db])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090282cc00b001ab0278a788sm2914973plz.65.2023.05.02.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:51:51 -0700 (PDT)
Date:   Tue, 2 May 2023 13:51:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 3/6] dt-bindings: input: cypress,tt21000 - fix
 interrupt type in dts example
Message-ID: <ZFF35BpA7xf0OBF/@google.com>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-4-mweigand@mweigand.net>
 <ZFBYIZc5zKs6dpHF@google.com>
 <5aaba4d1-f7e2-9d30-5f15-0713f9fc6a8c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aaba4d1-f7e2-9d30-5f15-0713f9fc6a8c@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 04:23:54PM +0200, Maximilian Weigand wrote:
> Hi,
> 
> On 02.05.23 02:24, Dmitry Torokhov wrote:
> > On Mon, May 01, 2023 at 01:30:07PM +0200, Maximilian Weigand wrote:
> >> Triggering the interrupt of the IRQ_TYPE_LEVEL_LOW type can lead to
> >> probing issues with the device for the current driver (encountered on
> >> the Pine64 PineNote). Basically the interrupt would be triggered before
> >> certain commands were sent to the device, leading to a race between the
> >> device responding fast enough and the irq handler fetching a data frame
> >> from it. Actually all devices currently using the driver already use a
> >> falling edge trigger.
> > 
> > I'd prefer we adjusted the driver to handle level interrupts properly.
> 
> Ok, I will have a look at that. Just to be clear: The driver should work
> only with level interrupts, or should it optimally support both level
> and falling edge triggers?

Optimally a driver would work well with both.

Thanks.

-- 
Dmitry
