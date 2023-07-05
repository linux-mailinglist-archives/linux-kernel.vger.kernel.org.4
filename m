Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC63748942
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGEQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGEQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:29:29 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F21171B;
        Wed,  5 Jul 2023 09:29:22 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57916e0badcso60537157b3.0;
        Wed, 05 Jul 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688574562; x=1691166562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c16g6eMzqCK0SYk6E8OGHHMajgzH6fmnjeBUQ9qrX1Q=;
        b=bPE06tzT9OGv/gvHDk6pbK/39D1ftHxybosER+o3UY6xLv6VUdQ8NcAxCnhJ8ohuZ/
         bDwms4xU0jKEljgLQaENLNB2yhwRrzh055FiiQSswtDrPhk3GKg++PWAfpWBQnINGO6e
         O7hRQfLesNM3LvU/dSJf1U2Yck2jG5Z2RWudM61+aZYcWwcsz04QWQob9RlSP7agcxzX
         QzNmsVWz0/eiuK3OTdm9/1yx+NrBBVD8KwM/nXgj+kIAov4K4rJpUU7Rc1+klb6rYfgB
         Bh4RHXBY93QnEO3XIj9v/z+pTyS7JxiqJr6VZxSX9rG8j+Yz+YhmCGU2F7Ghw0s82z2+
         BTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574562; x=1691166562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c16g6eMzqCK0SYk6E8OGHHMajgzH6fmnjeBUQ9qrX1Q=;
        b=fA1b7uRI5d8DzjTJ3m/AbXg80Pn203V6aOtzjQuRUv09rs/bF/+VissZf7Maanqz+z
         or8mlBrYzwngxLGzG0S/Q9QGBtrTjfjKBV67r5BE5+lT4BLXGWOJRt8Q8HNf1BKhSOBb
         IGZAOCdxwfe7V+z/AXfggr+QmqgCPG7qa9b0Qx7T+Wx1kGssqr7CDfFJPYHqiPIfKfFx
         4AqOyNPSluubzJM7+CLo5OmzNeW30vGitb+MJomrBqAZpDzqYZIPRIjgoGWjNBNY2wT/
         8xzqevPhPW9hgIUSwJ90WsWqhl1aGxT7rHYL5+xTXfb9+/vXLFEZ7yLFJbusnHfl3/OA
         z/Bg==
X-Gm-Message-State: ABy/qLbCPPhoib8wYROktR/AYsEt1rpAj742S56wqihVdfzaak4HICBU
        sC3CHD7G9ejpr/zomqSJ2KA=
X-Google-Smtp-Source: APBJJlF6G3bTKJh1S8L6KJXSj9demLxxrndPMJDCKh/ndYD/P7dJpc3qEHhl6Szwry9sbW0MrywlWQ==
X-Received: by 2002:a0d:e8c4:0:b0:576:d65d:2802 with SMTP id r187-20020a0de8c4000000b00576d65d2802mr15962556ywe.3.1688574561786;
        Wed, 05 Jul 2023 09:29:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2-20020a0ddd02000000b005772154dddbsm3751890ywe.24.2023.07.05.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:29:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Jul 2023 09:29:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/15] 6.4.2-rc2 review
Message-ID: <7586bad9-06f2-481b-a928-c3fa2a182887@roeck-us.net>
References: <20230704084611.900603362@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704084611.900603362@linuxfoundation.org>
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

On Tue, Jul 04, 2023 at 09:48:24AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.2 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
