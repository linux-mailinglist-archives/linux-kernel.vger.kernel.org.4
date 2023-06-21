Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD47378D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 03:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFUBt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 21:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFUBt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:49:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B848D1728;
        Tue, 20 Jun 2023 18:49:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6686708c986so3587753b3a.0;
        Tue, 20 Jun 2023 18:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687312196; x=1689904196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ry3IPi7RV+RVDCpY68V4pGxA3Mva/4700DA+cxVYeY=;
        b=DMtfPyZC9ppzsUwyADd328RctyjiiOW/Y3ulct79Lme8H+P6wRF6DaYZHQoPvcFF8G
         aAelELigiyrzKMV/X5osFvRssKDMC9q5qAETjTq1m96meVG9HbeXQSg2LgFB6lzxtwux
         ZgcL0QQHwfSjdoxx2tbdO5h27rUEA0Sd+mlxSURFPo+OMApafkAwuK4JkEo+BC7Bf7H0
         WTbneI5tz73t8ultanibKKTAUdWVsuMJg5TR5e6IYwGLUIdNAas/p/6NswIHMsHHYbgl
         i7Zqww8AYxsuQpk9OLEQ8WAlN6OLzLWpsfMZIz5QnOup8j85/hue5S+zEdu8BQifr68a
         VKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687312196; x=1689904196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ry3IPi7RV+RVDCpY68V4pGxA3Mva/4700DA+cxVYeY=;
        b=G1ZtxJQLkB0gDH/B9BzJURlphwwuni2SbOfeE/TDjw6MO4Wa4Ocv/GXJO7FWKjMqjR
         s9rHTBJYS22nR1pSFw//f8Z0xjR9MrrU9UtqVfyoGotMqmbP+JyiOIyB22TVaER2VBUq
         rLZZNnEDs++c8Nl8vjnIoCqIGCXDVnrvStNFngqsZJx21+9oqDapeA2mO9oq2HSmiCET
         R7IjaFJJbJ4oiniD8duEbcrbRTUD8gt3C7Msje4Hpw/WiShQfV0bd9/ODbA8dapuk++0
         mT76lgdoCNHgprgEemqDOBDuqzREr2BWKcfJq321JeTs+OZK28meEY70ShK87Mg0bFro
         Q9Og==
X-Gm-Message-State: AC+VfDzMeSEEgySoshj2kKWb6/GCtnv4V3EEdE3htr6im/Hiu+T+cWrr
        8IkHGxNyCIdgniHv/H0u1CY=
X-Google-Smtp-Source: ACHHUZ4lYT5DHLkUs+qrcxPEFUiRY53k7N/A8hiFqIl2ggCrARtXsgsjcngVw7L9xc+4eKhYk/zwuw==
X-Received: by 2002:a05:6a00:8d5:b0:666:ad0c:c0f4 with SMTP id s21-20020a056a0008d500b00666ad0cc0f4mr19095048pfu.23.1687312196099;
        Tue, 20 Jun 2023 18:49:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78141000000b0066875f17266sm1841555pfn.135.2023.06.20.18.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 18:49:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 18:49:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.4 00/64] 5.4.248-rc1 review
Message-ID: <ba1c3460-e06f-4884-9ec9-e990629622db@roeck-us.net>
References: <20230619102132.808972458@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 12:29:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 450 pass: 450 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
