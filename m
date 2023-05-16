Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CE1704919
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjEPJY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjEPJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:24:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF03E52;
        Tue, 16 May 2023 02:23:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965fc25f009so2271745266b.3;
        Tue, 16 May 2023 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684229011; x=1686821011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaoa0fYi/eKZjvnkX5ryATxZDZXTxrAGQl4PfS6nayQ=;
        b=AY1yaVFDAZwnTdB13XBpeSp6XnyvdT+IIofbTHrTN14ibXDaqCyJcw/8vApM34/hvf
         F5+e6TbEQePGty8IssRPlKC90TltqPRfD6WHtHkcebiQM0hQL5whQhy56OWP1k6lRwOp
         10KMgTwr2wfQFSka28FEdkprIdlZxUMEYCJQsXEfWzfvXo+dL1epTUsO7++UXup/+oha
         x6mKCDb3w4xy+l5D8t3HWmsGyvjl1kGrXj89iMwoej1QComy69UwfChcHdoXfJpR5NP6
         Mn5tJwnNAD9LRDsLoTmsbSC3sNqI7lO4gqqAJUBoVzgYAOZ8fnwPmgb2x6C+GtV28X8b
         f+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684229011; x=1686821011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaoa0fYi/eKZjvnkX5ryATxZDZXTxrAGQl4PfS6nayQ=;
        b=J/TT6Pa4ReBAfWwW2Gxw3xLGXS9qYHQvJeWFbci1YOyd4eA7AEUbY236qI9aA9eOf+
         8wMUmrvoxri3kXALYY0xdrQKchaThwpU9PBv8TNVSktTdF0SRTlsHuz34bq+NuusE2G3
         3asCFaV02ctvVtp81/LEeV0f8Gqq0FevpVnSkmRPlUl/2sqin6HC7arqkyjQigzUObz0
         UOgmT9wqekTDBo1D9hDH8/gdd/t3uvNEgGPy28B1NIA7l20bSLlI85h9nbTwUpIQZAA3
         ysUQahxKbsWPglPszJj9LCtsKe7eSm1stUSMgj0GWsqUFIAiQhnXQtfCSdBMATFogF8/
         zqNw==
X-Gm-Message-State: AC+VfDwzWTh/1/7gNkG7jYuPk8kLTYiJ3c0mEU/yzw8zBX71/kaikvVG
        IYlavDXvuQ6q1e1MacpPzZglKqxEMm4=
X-Google-Smtp-Source: ACHHUZ5UmGPABv6aBli65iKjKR1PNtrcM+N9BOKW/B9/gd9mSjf+GAaxcp4MBDgKIVkPhrFEt+SpzQ==
X-Received: by 2002:a1c:7507:0:b0:3f1:9acf:8682 with SMTP id o7-20020a1c7507000000b003f19acf8682mr23295633wmc.17.1684228323628;
        Tue, 16 May 2023 02:12:03 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id d8-20020a1c7308000000b003f1751016desm1601921wmb.28.2023.05.16.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:12:03 -0700 (PDT)
Date:   Tue, 16 May 2023 10:12:01 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.4 000/282] 5.4.243-rc1 review
Message-ID: <ZGNI4Q0K6HyU13eM@debian>
References: <20230515161722.146344674@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, May 15, 2023 at 06:26:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.243 release.
> There are 282 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 65 configs -> no failure
arm: 106 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/3528


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
