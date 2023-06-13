Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106572EFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbjFMXKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbjFMXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:10:16 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731E19A7;
        Tue, 13 Jun 2023 16:10:15 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b2bdca0884so4238095a34.2;
        Tue, 13 Jun 2023 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697814; x=1689289814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThnGwJYxeqSNiOkoq76JlK5vhrFTF2bvs99eMiOK5Io=;
        b=B9tiGOL+/EfAowWlHC+ACMZd+O9ywfA4a1GLTVboS+3h2KicdVCCUibWxsnM/Yrh+5
         nbCVJqWEEikC6lZgKM8nzGYeQ2FoF3YrRaoFJCjaAT0Ra6CsdUHXh/jsvreEf89jJ1Nj
         MRh7077roodC9MvP6lL+QktRQi9o80ZcVoF46zfoFT+0uC9akbJsVlrEvjJe4RfcTqYu
         ONyOjlQ7/FE8CEp45Waz4h8/unBzxkJqQX6HnX8zdU6nSUtGS4LOZ2byKp7FQ0SFTU+2
         y1cPH7pGXWNaXT42WpWZh3aVvAaR25rCHQ0QOEtH2dWmRiJN/LoSt5i7misMWfpgrYrv
         Y7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697814; x=1689289814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThnGwJYxeqSNiOkoq76JlK5vhrFTF2bvs99eMiOK5Io=;
        b=KIX2yA9kJHe+ICiYL8RS12N+zE+g+DTHwz4jE+TZwYjAWz3kB3tb0dkpDflYl4TE/y
         0t9KasxFSH4u5gCMfAknK17tEbOyVzlzW8VFeGOkWGVc2tVkq7PvYVn+D05nE2ylJNwU
         DCocVqY0O/cTKFZ2lXSfxy8zk0xrwE7IT5Yrc9F3pHW90NsWRcW07OX611+cX8beznbW
         QQmdCvMXIHk8v3CHaWmR3i5G7C3ot6s1c08U14aVPdZ2HBe9Sk1lMgclXeF0hLJVe+g8
         UUw9m3IfH9ud0Z943RlA9XV/k5jvVPp9/ZQh/EmwhH8/NEkG/LLg/Jy/sOW/gk57nIJT
         G3JA==
X-Gm-Message-State: AC+VfDweOYO0cNf8bFA+skG7GsVdju/WgYB1jklPaizVtzoSEAobnDgC
        Bk12OPakPZ1462+4JHMgki+n2pnd1UY=
X-Google-Smtp-Source: ACHHUZ7yIK/lLhQ7hs5c+Ty0225YPV+i0YckVvHxyToPhsUOcH/k/CR66uX9UTZXQR+HXaDYSlld0w==
X-Received: by 2002:a05:6359:59d:b0:129:d242:f782 with SMTP id ee29-20020a056359059d00b00129d242f782mr7547135rwb.0.1686697814375;
        Tue, 13 Jun 2023 16:10:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k67-20020a632446000000b005439aaf0301sm9815843pgk.64.2023.06.13.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:10:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jun 2023 16:10:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
Message-ID: <3519fdde-069c-4473-b5ae-bd3a58d323dc@roeck-us.net>
References: <20230612101702.085813286@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
