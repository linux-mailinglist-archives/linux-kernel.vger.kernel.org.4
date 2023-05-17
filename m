Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB96705D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjEQCxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjEQCxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:53:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664F44BF;
        Tue, 16 May 2023 19:53:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6439d505274so149225b3a.0;
        Tue, 16 May 2023 19:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684291983; x=1686883983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0knSTukOUoEA/wmGwfwoC/dUcviWijr3YWx3zmFpESE=;
        b=I2qhuRSewJs18B8O4auIVlb/sAKreimAlq3iRAucDkEok4WWKA6apTvqsY9XTtXWrh
         Gxh48MzPmvUF6CZZts9tBpETwZSijWSpPFW2NtxkPXCHBazJe0t5Z4duKKZ4m3rnJoWc
         Q6U8HktZycdtl6JnMjkK6K188SnFg52UXwgbLZ7fMsJXgLYbQ3UrnAZl+eFI2LverAVi
         sTaADRiuGUgyJwjRweSx10myrgtSWIqpkvO8afpGkWYamFRKqy6m49yUfBWBzMSOslEJ
         jxJMlhmHsd74hJOqUixoeS732tsIdI+6y38W65dw42QBhigHm92CWYQ30sr5MX0vlH9g
         8JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684291983; x=1686883983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0knSTukOUoEA/wmGwfwoC/dUcviWijr3YWx3zmFpESE=;
        b=da3Fqhlc3erixUt9IIhboXzuFItvAMlU7dNHkT3nBITpumRLem5pDOQJKP1Q9AGA19
         qDPALwV42mNC7IT2gilLI65h71GHeTKIHePGJsN0zpTRmxgq1csAPX/8h5Odqb7MabEm
         gr7A+TtR8MexJaoISzogVX01dgyhwsQMYzhGBJB2zb5gdASN/uMyoGX2MQmNhcrS6ZJF
         pNEFMw3uR7EYyvlQ75AwrMmZcdsN5GOKNOxM5tkpAaGR9aUW6Exyp9NFtjIkqJjyhsdg
         uiK9L0nDoK5a8PfxQ72QYl3HcnUVysynrpWkFt6UcMr/pS1x/HPwwdEGne9VmdcYrYv0
         FW2A==
X-Gm-Message-State: AC+VfDxZn33o9jzHBEEzHY6ksd3WeGWM5osxuzRf84ylIVC7PlI5+Sxl
        rRx9ddACT8fq+A68xTRSw6g=
X-Google-Smtp-Source: ACHHUZ6a0/RxnXNMIWD1GSAs8zOBKY2SfU8HCTVG/QLyFqdcVuSI5jdpWPU+VFRkizRuPS8cqFjydQ==
X-Received: by 2002:a05:6a00:1813:b0:64b:50:240d with SMTP id y19-20020a056a00181300b0064b0050240dmr17694439pfa.5.1684291982915;
        Tue, 16 May 2023 19:53:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7838b000000b0063b6fb4522esm11077308pfm.20.2023.05.16.19.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:53:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 19:53:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
Message-ID: <233bbd74-0d89-463f-9dab-c057f8dac7ff@roeck-us.net>
References: <20230515161721.802179972@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:25:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
