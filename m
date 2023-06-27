Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157D27405A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjF0VeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjF0Vd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:33:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AD72941;
        Tue, 27 Jun 2023 14:33:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b80b514fb7so15880675ad.0;
        Tue, 27 Jun 2023 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687901635; x=1690493635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l032ei3THBbpXbHFTtk6BrFOBjlXWcrXrnfyPyB3vBQ=;
        b=Z77Nls1HJMIAW5+Tn6vViEYrvA9hlHg9ugDlCaf+RjJnsmLa4xkVnmozjY4LsdCmpn
         yOfcpxU9+MbfFtNjRHXYD/o0Q/nu5Nzqd4hBthGTBkW0hUeKFiJgTyDpvSCvbkpfsF94
         D4YNRGsZUV4/xCHaJUw6Pxv+r0f9lHb22djLl6d+lZKq9w5WUjFfnEs+apu6ZUywY4Nd
         rVrLwQGWAgNmTKOhoHOThS2G/hZZ4aZcZDM1FerBuqyyLpv+nyFjEB/f+vt5e7IeKN8p
         VKLDkL9CEuO+I+qiE1n6TuUSvzKOAi9pzrLGiXUM5NAaziqXK5EATELV/KmOvGZx/Got
         iHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901635; x=1690493635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l032ei3THBbpXbHFTtk6BrFOBjlXWcrXrnfyPyB3vBQ=;
        b=QzlVH3T9rmTUE9zn0Dnd/AnhIVB6rD9AM9prlXbKLbUbL//yqd12Nho3yhn+AQQE7U
         j4j+LxudS3I6evon/Wl3GQ72pt5NUJyd25BF4uMUX+viMI9xlreq2i16QXeS5CZ4rgE4
         y/cLFBjBivNJB8XV94J4c6zRygTaLRQMl+s1diCRH+wQuti/WNpUzWo5LSOARhWQvzai
         zUFEbJk+33pLkxf6DHZTA5j0BxcAJ/8PCk6VwsKjgfn3ODsEm0fzHKHqgt4sssoZ6Nry
         AsKXB1hTkr5zsUXQlYgbS0ReI0+q5XtpkkHwcGwPO9TnX611OFPAWUu6BfmdTm6ym6OK
         6HEQ==
X-Gm-Message-State: AC+VfDzImgdzm97Mge4+RRdKjcfTIZaYrm9vpU5fz+eWxTOGEVYr9mN/
        odY0/jzloxhnKZtB1KJxATc=
X-Google-Smtp-Source: ACHHUZ7eMIKHXzr2r7w/oRls7XIv31Dp+9iIZUIiOXVsupTB2egnKnV3tw1oEbjR8X0QuT0Spq1CDw==
X-Received: by 2002:a17:903:2308:b0:1b8:142b:fb5a with SMTP id d8-20020a170903230800b001b8142bfb5amr4850131plh.53.1687901634743;
        Tue, 27 Jun 2023 14:33:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b001b414fae374sm6385023plb.291.2023.06.27.14.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:33:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 14:33:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/26] 4.14.320-rc1 review
Message-ID: <758158e4-a9da-40f2-bf05-2128c8bd2b8e@roeck-us.net>
References: <20230626180733.699092073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
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

On Mon, Jun 26, 2023 at 08:11:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.320 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 166 pass: 166 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
