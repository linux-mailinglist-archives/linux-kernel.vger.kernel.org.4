Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855B37047EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjEPIfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjEPIf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:35:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE3BA;
        Tue, 16 May 2023 01:35:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96649b412easo1813729466b.0;
        Tue, 16 May 2023 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684226127; x=1686818127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8e4NHYJl0ojx/fa43Z8pAIL3TomPVIv+YLhEdD0YsE=;
        b=MIvVQBlSFw6cKp8JrUYDItCgBnwdr++cjK8DsRaCR3avEUKQ5+59oc8fk2bJ+t0jmf
         rvMV/pTTcBwK9MyFjCUNPmLqRsMU4ttaFEZVMm9SADp+7XrPGRXHerKFfPoFEwbz04nc
         QnKmdJCjeCB32/OGwZC5RGoUxh9cYQt8vlVqYFfLfL3bYi50lCZbMG9tbL37hzEPoIZj
         63tq32DQDu8ArbxUYd6uEF5j9nSPj8eoYVxfG0GV8FlBLiJ7N/B6njnStgwNxwjh/0e/
         AX1GxxILtsC6cN3lm9iqVwoOevKFN4tdyeZZWdK4Q2d7PlnUxSzANEQbR7C6pW+fomOi
         tcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684226127; x=1686818127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8e4NHYJl0ojx/fa43Z8pAIL3TomPVIv+YLhEdD0YsE=;
        b=Yjw3zKQw5O0+dwE1CfT5jRGA52nezaGEyMDj1hBWHRDu6CDNQAyy8Z8cjRBeqLu0Mp
         D3rCIrb32FOGWBTSXtCaGk7yXz97uEEZCv/c6adOxlAUHrQSeiMuZ0FweyMLVLopDFDx
         n+WHKPOjh9kupCxM/eSdcpUL7CbHl/H+hudc7nFHohTimxEcdU7QaaMupPech1xl4U6J
         j2Y7Q4SFLJ9+tdOEfpipRDclfOws04RGrV50gL6ekpQ2+VFUuGhfNSPZo1zwLKGCzBY+
         KRIDXeG28Ku7zQTFGVenkJtM4efV/mPjh6d3VHp38Qls/n2wZj1ImMB69H8xXYCMtv5k
         XJlA==
X-Gm-Message-State: AC+VfDwE/CDrTwJoWbZIAsG3/AgoEIM1aW2r5Q4psBuzIC91JGYXbT9n
        30b1jltBP99dWBaKsJrEE60=
X-Google-Smtp-Source: ACHHUZ770YWb+27ocY0i/HufgaFXPBUzmRTEQY6c6vHTnhLHiM0YjdJifL5YooavC4/oGYDzNSv03Q==
X-Received: by 2002:a17:906:6a24:b0:96a:2b5a:f013 with SMTP id qw36-20020a1709066a2400b0096a2b5af013mr20490261ejc.62.1684226126482;
        Tue, 16 May 2023 01:35:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ib8-20020a1709072c6800b0094f67ea6598sm10659250ejc.193.2023.05.16.01.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:35:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 6B030BE2DE0; Tue, 16 May 2023 10:35:24 +0200 (CEST)
Date:   Tue, 16 May 2023 10:35:24 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
Message-ID: <ZGNATKe3U0oXHICX@eldamar.lan>
References: <20230515161736.775969473@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, May 15, 2023 at 06:24:11PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

The build fails here with:

sound/soc/intel/boards/sof_sdw.c:187:6: error: ‘RT711_JD2_100K’ undeclared here (not in a function)
  187 |      RT711_JD2_100K),
      |      ^~~~~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:286: sound/soc/intel/boards/sof_sdw.o] Error 1
make[6]: *** [scripts/Makefile.build:503: sound/soc/intel/boards] Error 2
make[5]: *** [scripts/Makefile.build:503: sound/soc/intel] Error 2
make[4]: *** [scripts/Makefile.build:503: sound/soc] Error 2
make[3]: *** [Makefile:1828: sound] Error 2

I did mention it in
https://lore.kernel.org/stable/ZFuHEML1r5Xd6S7g@eldamar.lan/ as well but I
guess it felt trough the cracks back then.

Regards,
Salvatore
