Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45AA714AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjE2NsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjE2NsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:48:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A59C;
        Mon, 29 May 2023 06:48:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso3137003a12.1;
        Mon, 29 May 2023 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368090; x=1687960090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbFSyfRcHjKjP7DsBh0HDWun6Z5NhHLqrv1Cu0fSBmg=;
        b=A0zcVJWZ1hYG248bC25y4nx6Z7Olu1rixcosAZpBx5A5x/Z2OOVs/rAYnHqvlKupA2
         smjqg2/W4h0qr5UVVhuFARK67LvCP8XmridfdYC73JzLGW0AeEF+C+lLBKPKSwu68JXW
         NWP/+IyuG2ZP4nrFqHhaXW+gKRywXIuW0XpUqZZvU0TjM7oovvLZtFUNkfBsxHTz7SyO
         jU8keQrs41graqzFA7kK4z1ALDKIOwZVyonHrPUp6zOROAIas9BGC6ZLMzYCTjGRxKJx
         g/NwnyN7Ops4LgwSMfbiGOPgu81QU52U9Pepf5Yr48agfTNZPf+fRISUC3pUNwB3r4Ab
         HgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368090; x=1687960090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbFSyfRcHjKjP7DsBh0HDWun6Z5NhHLqrv1Cu0fSBmg=;
        b=lzi7iNjU/zo7R/LaTg+KfAh8jWHJWTGEkBjyv5wMpvVAZ1ogCubc3jdioFKPEmLLWA
         QhtFYvleYsPl+I9ozCujIEfpYGfVEPKDw5ub5eg2y41JgSqZfi9Uo4kzDAmZqs5Hx9ZW
         QH2eWkkUIFq0/0bHpiXgpLgn/Os+2eEfKZdBgj9a530NeJEgIcYqTL22477m9F+cmuqJ
         IZ8BE6y8bb4L4flFqFInaTnolam9P1EBeLI3STCrocbN47PHeoTk47BdLXJWg14uf/47
         2I+0teJXjTClKbm0/lWa5w2s4t4hY7vB8nDegWQz3pbb6vQB4Z7/36+ByreUzaUnjA1H
         Lu0A==
X-Gm-Message-State: AC+VfDxrcuBM0q4c1dlMVe/WpAH9uP9wDIkblkGP+dOHQaoJcv5HwPyu
        4OsZErX0OhodEIOPhem30PpmUS/lpFw=
X-Google-Smtp-Source: ACHHUZ7M2hQvQWZjhae42ciJyF8vZr6ju+Cd6K5d5L7J638XOVQ8Q1Xq+jDC8WWdSuXG5wPzncCoYg==
X-Received: by 2002:a17:903:230b:b0:1b0:3ab6:5140 with SMTP id d11-20020a170903230b00b001b03ab65140mr4622115plh.4.1685368090378;
        Mon, 29 May 2023 06:48:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jb18-20020a170903259200b001ac2c3e54adsm981300plb.118.2023.05.29.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:48:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 06:48:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.19 000/132] 4.19.284-rc1 review
Message-ID: <e98d3b88-980b-4487-baf8-4685cfe62209@roeck-us.net>
References: <20230528190833.565872088@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
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

On Sun, May 28, 2023 at 08:08:59PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.284 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

Building s390:defconfig ... failed
Building s390:allnoconfig ... failed
Building s390:tinyconfig ... failed

--------------
Error log:
s390-linux-ld: drivers/base/platform.o: in function `devm_platform_ioremap_resource':
drivers/base/platform.c:97: undefined reference to `devm_ioremap_resource'
make[1]: *** [Makefile:1061: vmlinux] Error 1
make: *** [Makefile:153: sub-make] Error 2
