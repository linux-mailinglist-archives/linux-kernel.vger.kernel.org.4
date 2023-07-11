Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A074F525
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGKQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGKQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:27:26 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB24CA;
        Tue, 11 Jul 2023 09:27:25 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b06777596cso5085271fac.2;
        Tue, 11 Jul 2023 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689092845; x=1691684845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oljS3CL+A9NlQFaPM8t1XUxGkq5OOWrkjTs5IXV2lUY=;
        b=AC9SHZY7OqY2h6kRrnt94oFO6cvpIzP/1SdJ12umUwa91WhJK8Vwig9/387HPtHja8
         UwTq8lGvCofB7HACCWP7TOb7Cgh9D0UCVh2FgWDdXASLosEJdIMfRutFXA1zl7xlBxOi
         ndzY3LHfeqpM5isEWbRVhVaHO8teQcSMFqFb1ABOeOHMYi3JEFkVi29sm/JrJ5OL44Wo
         CfpiIZOyL867EI5TFSZK6paBOj87XWzZfW1Fa11sXHSG2AHYXA8xwWdScSfJ/5MT7qr2
         l3kL49DxGtu7E7S3oaKvIObmKGZhVSFoX49cZdiTtemXujU9WzVbtLZjJsKjY1giqzyP
         pPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092845; x=1691684845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oljS3CL+A9NlQFaPM8t1XUxGkq5OOWrkjTs5IXV2lUY=;
        b=Ijsj6X47N/IXaIlnF0IK2xutmuF38/wCigm8gBB35N+UyvMivUtsYbVV4woF4RO82o
         Mbr0OfS3gtlUqLWU/FRKRfUwvAVl2uIoboK+O7/DBqIaOZ4+hz4xZCgQIZFplKS/CuQF
         dEXuqFzvScYtzFHx8Kgpj6yXn7vGfWWxt1vle3/tYgNgCpe+85Xet8pC4T5olSA28igf
         /h+0U8ajXubPeVIhCGgVe+M7xpPKdDs/IM04PxBFz2/0aasLR1gTVU3pWHM6hKtIXnCo
         6OqoxHrQaQ9AAbjfVIVxVi+RaiArHQsstsoNexmEl+0wd2+55T65NfJ1/Dlov1fMTj/I
         pZ1Q==
X-Gm-Message-State: ABy/qLZFUmW1h7JDztHNEWzR1Ph8bi3NLpqBoYRhcySq+5Hg3aLi+Yay
        Xys0HudCDt2SBhotl+L7KpI=
X-Google-Smtp-Source: APBJJlHNVeZOBOzJuy/jYVc5k/hN6t75kg0q2tbRSr6JY3djdH+35anpSWDOWPN9mLD3cuPNzd4TEg==
X-Received: by 2002:a05:6870:73c8:b0:1ad:4c06:15c with SMTP id a8-20020a05687073c800b001ad4c06015cmr15690310oan.18.1689092844838;
        Tue, 11 Jul 2023 09:27:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a188-20020a0df1c5000000b0056d4b5cde00sm646581ywf.118.2023.07.11.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:27:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 11 Jul 2023 09:27:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.3 000/424] 6.3.13-rc4 review
Message-ID: <ab657651-92f8-47fe-a8a0-099b76481743@roeck-us.net>
References: <20230710142227.965586663@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710142227.965586663@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:23:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 424 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jul 2023 14:21:05 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
