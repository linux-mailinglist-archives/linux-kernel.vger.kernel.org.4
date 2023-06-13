Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865772EFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjFMXIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFMXId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:08:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E94E6F;
        Tue, 13 Jun 2023 16:08:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25c134dc52aso740587a91.1;
        Tue, 13 Jun 2023 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697712; x=1689289712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AINuLYyd7cKrlzuDExWPH4P62HSz9yrUj99uIR37smI=;
        b=sAkxAzgHD5WhF5gjfUAj4P6ez4e9hjGXWDkDaFFQ8eIwqj2IbAsyWWyecLR5k9m/LY
         NfZ1xXdyKcat+B+UUObmyAc0ZMuib6noEdUh3US+c2nVrQYeUA8OPr1VBSZ4vjwrXvBu
         yUW7BS337oP50pG6cDsdnHdJnmBbKgWbCOF0R7ySs6dvSz+8qHWD1fdtPKPySqA4vmSG
         U2V8gocMKrsUoOgiI8fxvL9v3GjBSnYMkdeK3NVPiJfnMEPOJKsE/VY16DpHevUVw1Ng
         V7hIQusTKBqV0J7+kDurNJJt6Bwd5p539YGdmO5jIi6wswlKmf2rztvxgG16bPXiJxFQ
         q+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697712; x=1689289712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AINuLYyd7cKrlzuDExWPH4P62HSz9yrUj99uIR37smI=;
        b=aVGZ86PNFCjF8aORK2Qgj1zK7CyddG9QNtSl/giK+3eJWU5okDF/raqrHv2oax5vW3
         w2aB71IIz/1mwOWewuLIXHeslgTxy7yIDsn/Lcgi/43/Mb82kwKqyIT3i9AUq1dH5E2V
         zUfLGMzdi/Rvk0MMmRjhv9TBAQmo4F71vakGIOLiY5ezhJhBTAJmrG0jXjK8jAL4wHgT
         eBMM6m3UGOrdUZiTjeeNC6rDZOpnSFTgJFZot3AmpQa8xZGBC3D/W+8G7Bw433XB0d6c
         xPSo4CQm0yiCMPGLviwREZLS4wZcWD+dzKdRX+bV3aoet2DcA0C4HRS7jN3flhGBG2RA
         ktAw==
X-Gm-Message-State: AC+VfDwiwe4ZwbU74Ch30aiquqZwDEyBsKLCwvOpo9HRds9gC37jv5+0
        SJ6Tkew457SkOv9MeTv6oz4=
X-Google-Smtp-Source: ACHHUZ6o71fxvbwXQPFnYGzICrJGfpJoazuyDv4nfphEJ+bTpdjGfIrO8KNYLSNCn9Te7WAtxehm2w==
X-Received: by 2002:a17:903:2449:b0:1b4:9dd5:b2c6 with SMTP id l9-20020a170903244900b001b49dd5b2c6mr1257914pls.65.1686697712232;
        Tue, 13 Jun 2023 16:08:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm5426673plb.86.2023.06.13.16.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:08:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jun 2023 16:08:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.14 00/21] 4.14.318-rc1 review
Message-ID: <472fc325-18d9-4214-829c-8cb2f8b916da@roeck-us.net>
References: <20230612101651.048240731@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.318 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 166 pass: 166 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
