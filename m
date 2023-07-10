Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222374D7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGJNbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjGJNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:31:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FCC4;
        Mon, 10 Jul 2023 06:31:36 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5703cb4bcb4so48530157b3.3;
        Mon, 10 Jul 2023 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688995896; x=1691587896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEOfSXv87Bm4Z+tbiK3JsYBP/IVkAFqD0bwLShJxCUI=;
        b=Xy1TLRv9OvYpAvq+TlWB5MDHyPR3XIJ22HXPyH3DzMJrHtBi/j8sUSjqx4l+LwkeeA
         WGK1yLdiIUQnnJrVm63U8Mfnbqn/rBoHNXA1M6qrURLlScfkMf4NCJW9AMzCra1chzrb
         8xG8lPQN1VJtAi/Xnpz6sbC1VOt1/ZftUAcwHiIy+XhvQQOKlWzKEejJkSR+BVPCZ+cd
         DHqWlUgMdSmxQXjemBX3ziIoDyHQYwPGjQuMutMqw9bT9EXGB4+Pj1fBFd69fvfA8BMZ
         Yl9BUwugHyFnGo5Fn9DJa36s+0eDC82jPJmsfpRCjjcoaxfg5cXx9brP4r0BmtEDAQTx
         xW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995896; x=1691587896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEOfSXv87Bm4Z+tbiK3JsYBP/IVkAFqD0bwLShJxCUI=;
        b=ayMk7k21QJ8NfIz47Bo8HSLaN4xdPW9CFiH43uakLr6wnJjtotp05DTfKV95hJ4T6t
         qQzedteqHgxXKmyAD6G7eCWFCShdXXsUkyavVUK3tG3XZt94FSqH+gWDdwUSmKh8TO/G
         Rnu5oe7lDTebgoSP0QRmDEoO99CA+0L5NGssW+mxsRzLHUtal0PmwAIj+uTlBqn1rDwA
         V+xPQZXg5YidXWiiEoF/E/6UM+gqYrhvAGPEUmgX3Jg5wqJmVUkFuTvTFIgcIzm/fAAN
         iizscbdMJl6ybUkNXUgDh13MqbINWd2qYYDWUdfQyw5J95Gl5soDDbs8ZFJRPb5gA+OG
         hnFg==
X-Gm-Message-State: ABy/qLYDYtLT6lspe7oMV8pwggysVdV83N2pm/SWIQ/HgVC2366BAvuh
        xE7aVpC0ohQtxw+AvM+ZSfxy+zYvCvM=
X-Google-Smtp-Source: APBJJlGzHHUhE2yTEOppAblNk2+rHZSW1OOSHERzIjvmq5DCUaz3bwMEdihmcNST+6tTZMuh5+3+aQ==
X-Received: by 2002:a81:4e85:0:b0:56d:34:893c with SMTP id c127-20020a814e85000000b0056d0034893cmr13577609ywb.4.1688995895778;
        Mon, 10 Jul 2023 06:31:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f10-20020a816a0a000000b0057a8de72338sm278404ywc.68.2023.07.10.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:31:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Jul 2023 06:31:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.3 000/426] 6.3.13-rc3 review
Message-ID: <ea9d1cf7-87e3-4191-a239-de8bd67a1786@roeck-us.net>
References: <20230710054619.475084489@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710054619.475084489@linuxfoundation.org>
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

On Mon, Jul 10, 2023 at 07:47:20AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 426 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jul 2023 05:45:32 +0000.
> Anything received after that time might be too late.
> 

Preliminary results.

Building mips:allmodconfig ... failed
--------------
Error log:
arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
ERROR: Input tree has errors, aborting (use -f to force output)

Introduced with "MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators"
which uses vcc_33v without introducing it (it was introduced with commit
c9f4b25272843).

Guenter
