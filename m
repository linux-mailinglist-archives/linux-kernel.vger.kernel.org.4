Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F16F22DC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjD2ELk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjD2ELf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:11:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D72D4A;
        Fri, 28 Apr 2023 21:11:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b35789313so522839b3a.3;
        Fri, 28 Apr 2023 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682741494; x=1685333494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uM5ip230fvATVmYJPL2FSyjUbKLn9DaZqVGs1xpi0Rg=;
        b=BksPkaF0efR76Dr9Ie6iPQrdx6ISDdtWMBi5Qcr3Xs7zU9kIMwI9ZJAoD0FYdFLA1F
         ph0KzvWRdsKX2slYiUOEYV4tU5FSBnAuz7cNvqFNgUFT2nr/cxrx4aX+YwkoPfjRJjYW
         GdBiP5NfpdTjG2jjBLyzl47iIP8S8b/OWNLawck76Dl1HrgHPejZKYJiw5Dh99PV3W/9
         At/wDAyA37RQq/qInywo4VgUI/ADMJ/4aj1QnyGvXNJAsm3/nhMdl3SHK/aCYlkC1WJB
         +JXUhc3tRQSG6p7JHFl0nMHQ0k6ai9Q7IIWz2MojUjUrTyLz9VFxKehZTrEkbylOHzIo
         zyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682741494; x=1685333494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uM5ip230fvATVmYJPL2FSyjUbKLn9DaZqVGs1xpi0Rg=;
        b=EDcFW2wcyf69GJgUpp40hIURmQWVqEd0ax3+ouBqRJQM9k6H8NZ4qA/iu64WP9kkrS
         hBcifFY1v7BeCOZO2ioCv6nZXZUPvIK19D3lurfzBW0R/+8wCdWWBAQMaaUE2+cc1jYf
         IuvyY+Cpjv1zpkFBjbLAYQEi+pVy8lTI5H6iRr75XBX49+CXxdnOBIcZUcEHIqQbGUas
         dm6s7+tycPd6nQ8qC8/gLTcD05C0Agbsze86EQZJjDHyx+8r6GbWk6GWbLI8ishyKtlb
         U9G5BcpDXCuGRL9C9bFsUzNsP2F0mtzag7NHuUSHGGfKWBFQmxroiOV7vl3RqPxAFawP
         s5iw==
X-Gm-Message-State: AC+VfDxLPHfMKfbZcfnewp/9iMR5N/dY1KP/DhoXxwj8a+NNeIK+cyFc
        fSIX+riemN644/Kiqna01/M=
X-Google-Smtp-Source: ACHHUZ6Inn8+YKKAvslaBaLlFpQcEWOiDz02qwGoOVyKUKvhXSxgQY01DkkgjizxtNS9NVfSncl3QQ==
X-Received: by 2002:a05:6a00:10c4:b0:638:edbc:74ca with SMTP id d4-20020a056a0010c400b00638edbc74camr10250690pfu.0.1682741493979;
        Fri, 28 Apr 2023 21:11:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b0063b7c42a070sm15944038pfn.68.2023.04.28.21.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 21:11:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Apr 2023 21:11:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
Message-ID: <d85a23c6-8146-4f80-af05-c1b5abc907f1@roeck-us.net>
References: <20230428112040.063291126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
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

On Fri, Apr 28, 2023 at 01:27:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
