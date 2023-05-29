Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E202714AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjE2Nt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjE2Nt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:49:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250BC8E;
        Mon, 29 May 2023 06:49:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2566e60cc5aso1191132a91.3;
        Mon, 29 May 2023 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368195; x=1687960195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+4Cgyc6oSSWl1ErU2o6gFZDIghOcHo1W8MEXv6d9x8=;
        b=csz0WLWKWQpnzZvSiWQIVkc00Mq8vYNnjH/IstORzeXRwMJKarPVWIXv3rz6m7qyYl
         8sOA0/u8VPzK8ug/fltFYWIiq2cN9NmITlsP/MmPP5Dd2699tBlowvfeN4CycJFqDTQC
         sC+8VOrk9eNYkfhN57djkEFTdnmfuMroczcRMZY0gWuDkn7vlZP4Q5S28m/ckYra197E
         lP9KBSwXAlhfCnQPAOOgYk7ozl81p6rR+nBirjHz3UjiXXrn2Cy/6cUluxCtoDZ+njg5
         mJBUme8UVyfuAclk9Z1dIAoLMA4fvbmWsFUmo6014e6rYESSXIpPaFufCHKtQBDe69PI
         5fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368195; x=1687960195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+4Cgyc6oSSWl1ErU2o6gFZDIghOcHo1W8MEXv6d9x8=;
        b=Z8K2/DY6oCFLmXbDgqRLHX2lnYqq0WNYbPmRjy+R+fwP8lst+dWQkjHZcSonRQR1D1
         BMwdYr2fXPJAjrr7hAPtrmclCGRpsjFJUMweOaOvHmZaM09VRDV6bb/EgJtxllSBrfze
         Juu8v/0Dg4vJKwhpmKWAJRzAiKV8AwYgk3UHa54raZXt0CiG79OnX5zFTbqPwr1E1NKd
         pNipPR4vddjmbYNENKFr4K7/+ps5wmJxn8sk4b8u8wvNj+/uijwt6exQd58RQhFZTgRC
         94C4a//c3BL8PEHCIkJSAJtqFRfU6qWw//sF10ebDg95oKGj+EWSt/UbdDNL7KXs1I5V
         mD0w==
X-Gm-Message-State: AC+VfDyez+OvFCl28lrlNmsUjundW6lFg5/QhSSSRhD/HTZVt/9wi3sw
        FXM1qa9ueiq3ic4P6Lov0wi8UyuJdV8=
X-Google-Smtp-Source: ACHHUZ4DpBtncFch/J/DxqgBVhKF+YYoGLUaLXMgmWdIfbwSgMihsIYo/Q2TI7H/UwcA+jd2HiZAFQ==
X-Received: by 2002:a17:90a:2f81:b0:256:468b:fb50 with SMTP id t1-20020a17090a2f8100b00256468bfb50mr7754110pjd.47.1685368195554;
        Mon, 29 May 2023 06:49:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id oa13-20020a17090b1bcd00b002467717fa60sm7212726pjb.16.2023.05.29.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:49:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 06:49:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.19 000/132] 4.19.284-rc1 review
Message-ID: <468bc707-0814-4d83-9087-74768d98203a@roeck-us.net>
References: <20230528190833.565872088@linuxfoundation.org>
 <e98d3b88-980b-4487-baf8-4685cfe62209@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e98d3b88-980b-4487-baf8-4685cfe62209@roeck-us.net>
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

On Mon, May 29, 2023 at 06:48:10AM -0700, Guenter Roeck wrote:
> On Sun, May 28, 2023 at 08:08:59PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.284 release.
> > There are 132 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Building s390:defconfig ... failed
> Building s390:allnoconfig ... failed
> Building s390:tinyconfig ... failed
> 
> --------------
> Error log:
> s390-linux-ld: drivers/base/platform.o: in function `devm_platform_ioremap_resource':
> drivers/base/platform.c:97: undefined reference to `devm_ioremap_resource'
> make[1]: *** [Makefile:1061: vmlinux] Error 1
> make: *** [Makefile:153: sub-make] Error 2

This also affects um:defconfig.

Guenter
