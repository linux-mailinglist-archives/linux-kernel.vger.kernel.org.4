Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4052C6FCEF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEIUAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEIUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:00:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0153C0D;
        Tue,  9 May 2023 13:00:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6438d95f447so4421559b3a.3;
        Tue, 09 May 2023 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683662418; x=1686254418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKKLAFyTiJU1GoBQgK70evF0DF5IZgIk1ne0+KMszP4=;
        b=NGRA+5knmlP+GE4YkAOjgBOfSo3q+WTkUeDaOzjGZEkGESrM1cZppswykv1VK/TSkC
         wGpDhAwZzLAIamlZyoaL82gojJQubWXhjmi93UpjYVFScF1M6hZyWig3Vm0Cl1dNrFdU
         iONuzABrWOoOa0Gs1JsLXtY1dsjFoBKtVPx7wErZr3B9nepKJ6/A0gcUMA38Vd63Vd8M
         D0cG3CO1NuS114dMsxsuEeALkQqSMP3INv0KBAyT4Xo6NBpjyGqFqqG34g2PA6z6iYi5
         Dg851LL26Ku9fFI4Qhp2bKfO6eLodWR2BRgJSu3g5W9SbvCDWU++J9gkUaOqO8aNlmcd
         yM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683662418; x=1686254418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKKLAFyTiJU1GoBQgK70evF0DF5IZgIk1ne0+KMszP4=;
        b=DDrDVePAZjR4FO9sBmh6/xWBkBulF2ghxe+tF0hpxY3whE8i2YwoHnwqe0es+Bl/n3
         05f1TMumKkOqfV0vJvhHis+3Rfxya8EQVJEIeAngrzbzDiflJz4A9E2TcuOlpwuIZnUx
         gk7sUNwsgvMFCxwiJdsY95VRLmXNMrxLEQbYOJPr/KfCutXjT6RuWREyQywPiEjb5AVf
         heIR1kU9mx8sSPRnqvVJSnDzm32D6y88rsOSUNnUzYIco42YcZJwhiW0lGkldeOYOmmC
         bhXMzMs/SFf8vaWALibrD7odZ4t795uPOHXedtYk8Sme9AXm2+N75+T2CVG/akqdgMF1
         l6Pg==
X-Gm-Message-State: AC+VfDxig0V2ettPaPckUx4xKT35Z5vwxY6/X38ABzmnAb8d8nubHADF
        B6H/le4SSYuebJNj6fbF7CM=
X-Google-Smtp-Source: ACHHUZ78WwXLcgQG9GilCWGtRMvh3SkxYYobB2xWTmaO/k8z3A50U90Dx+SiHD/iaqexy0v/EJvm1Q==
X-Received: by 2002:a05:6a00:2344:b0:643:b68b:dd08 with SMTP id j4-20020a056a00234400b00643b68bdd08mr17639679pfj.30.1683662417927;
        Tue, 09 May 2023 13:00:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b0063b8a30b571sm2155625pfd.9.2023.05.09.13.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:00:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 May 2023 13:00:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <73d76fe5-81c6-464c-8926-e10a1b9ddffb@roeck-us.net>
References: <20230509030705.399628514@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
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

On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
