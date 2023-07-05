Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34051748936
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjGEQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjGEQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:28:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798ED1988;
        Wed,  5 Jul 2023 09:28:08 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c5ce57836b8so2361739276.1;
        Wed, 05 Jul 2023 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688574487; x=1691166487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkxMlZkzxcysGkTdihnDiCidqfVsFE06UkOpIAnvMdc=;
        b=lAq0ZB1eGH5dJe58j9ci2XXr6ef1D7OEnFG/jNK/W1/C+bvNZK619vhRQFzS9hk614
         pbtSlTih9e/sznVefJrdZp5nRYYYu/2B6gutDBOLQfuENvZa/3mWHtOWoqoVNpTJBYZB
         jB/R3MJrHft4HgdmFTa1nLYKczPbka02i8VkRHvMaO1v8oexVFM5DvLSumDVXUA8TKvI
         wHeqrsfNVL3VFInfvC8FTJqocO4UaE2ao8xIzuFWEzq8uhMslmOaKkB1Y4H6v8rVpBn2
         FfDCrjWrNSjcUe9URURoBjFfCKMXtPBXVJlw2gNkZbrXRyJxQwzJnqdEqa446MCnLl95
         +0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574487; x=1691166487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkxMlZkzxcysGkTdihnDiCidqfVsFE06UkOpIAnvMdc=;
        b=ND77YIAM/AE1eBllgdR3clBYY4eLONONcm2buAlIIljnwAfY++7D7iR173neUVOwpW
         2mRwahoBlLuIl986d1k5+o7OrrC0REBw/RIN6e8+WuJZyNcjYwgSdJkD08AcE5leFmkY
         PcUyrj569iPujXxTlLe8VxrrGgEjuT4/p3d8YLVOBK1uW5rxsJmqORxUYFZkbc4oGttO
         wBB7wTtKzcHTEY96EAGV8hJoeYhw+OfeveTtBJtT8oaK9MrS+oKLd6EQqMX+zpaAa+m5
         si8/njWp9K2Y+YX7eQ6oOkqdA8FDkzUdvvAtOZg5Q1fbMqHL/aL+/fbV93Wjs9GAu7RG
         3Bvw==
X-Gm-Message-State: ABy/qLZBDmY3hgL+o6qif5NAWZYBoGJ911jgDcrdGjqDztqOQt5URShp
        b2rDt8Fe9nOhSfgF8qVbF2k=
X-Google-Smtp-Source: APBJJlGLYHnbvn6/Hhhn0iphucwrngQ/E9k2ghdR3X2ehjg4bTn+GtbLH/9FHSJ/C1pfaUL/dT8GsQ==
X-Received: by 2002:a5b:14c:0:b0:c62:fded:6559 with SMTP id c12-20020a5b014c000000b00c62fded6559mr1869676ybp.5.1688574487594;
        Wed, 05 Jul 2023 09:28:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r17-20020a258451000000b00bb0a8342723sm5138047ybm.50.2023.07.05.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:28:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Jul 2023 09:28:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/17] 5.15.120-rc2 review
Message-ID: <8d6e9db9-22dd-48f3-ac3c-9d4aff8459d8@roeck-us.net>
References: <20230704084610.981452877@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704084610.981452877@linuxfoundation.org>
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

On Tue, Jul 04, 2023 at 09:48:47AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.120 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
