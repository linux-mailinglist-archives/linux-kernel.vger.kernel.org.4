Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096966FDA00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjEJIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbjEJIwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:52:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E1171E;
        Wed, 10 May 2023 01:51:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f475366514so3732995e9.2;
        Wed, 10 May 2023 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708702; x=1686300702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBAQkABlotf3PtL7UuZ32vX557RAQRNFDyqEv9QHB24=;
        b=o9Nnu6hBs5qkRk6u1eGyHO1dEJpEipCw75/my7SJ5m8jGmfUL4+qvdde0MhtOF+CFb
         0wgzxLrcqZDCH8FTrlYyYntgERHJfHr/N3E0JdnPjHwfhXrBX+VhNR0zWWqJkp05GTTc
         oTyvzGuFYMJ31EAqPA4+tqLrM4O036aq7P3PfdHVPzMf2D2glK51vzglUf4QAa/osb9X
         wJF1LSLPpUpyB2Z4eJwDoPnCxlhZsbKNA1+U3cgu1yAyXx2l+lUdAsC+HOUmvrC38itU
         dPet/tZxHwdn70+BOMxJHqSoetl5Vs/Acp41ZIeewHe2rSAf5pcSuU3e5VT7wO2vhofb
         3yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708702; x=1686300702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBAQkABlotf3PtL7UuZ32vX557RAQRNFDyqEv9QHB24=;
        b=OtuiJaANBrVk5wjuvFW3yeF7luMxzKFseuhBCsxFhFSBgPR14PTsDIjZfoITWuaNun
         b5aHTJsJY0aVviD0bQ1zPxjuPJiSe1ShOatUGj1LZ+ercDp/KP0NutAIcMUqdU29m4xK
         ytPWaWa98QwIxea4mRQCdPYkCmSrSymThfM4+wTeOAzSWu0YruBVIJsqhIRpbqlcdK0/
         h8vdpua7OMyFnLr1iemCWHpcIBOKqtILYHydTSFXRKYaLHx4TaZ6JjlagCTyoxBs70c6
         kRoeTiCQ1JlPpBhkDDTtPff+2MebBeAHo1nex6KmI3uqE0cs9+bgXvkek3NvMVigbhT4
         ampg==
X-Gm-Message-State: AC+VfDzq/3L0beqqT89zS7WYp2DlYVtLmR9HenqyYBqiQETZn9JgEYAz
        6KekpzT79bHtmgl1S7sqJzM=
X-Google-Smtp-Source: ACHHUZ4scNMNQ3ruGjJkawvo9rbTfPPl0+LvDkkmxs+BSuEdIohp6UmgT4Lkd1FhqsqAxT9yzCKBcg==
X-Received: by 2002:a05:6000:1362:b0:306:2a42:d23b with SMTP id q2-20020a056000136200b003062a42d23bmr12594532wrz.6.1683708702057;
        Wed, 10 May 2023 01:51:42 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f188f608b9sm22063694wmf.8.2023.05.10.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:51:41 -0700 (PDT)
Date:   Wed, 10 May 2023 09:51:40 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <ZFtbHMFe6ThVMfiO@debian>
References: <20230509030611.521807993@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030611.521807993@linuxfoundation.org>
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

On Tue, May 09, 2023 at 05:26:15AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 370 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.2.1 20230501):
mips: 62 configs -> no failure
arm: 99 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/3488
[2]. https://openqa.qa.codethink.co.uk/tests/3489

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
