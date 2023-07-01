Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E10744641
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGAD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGAD2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:28:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6821749D5;
        Fri, 30 Jun 2023 20:04:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262e839647eso1732260a91.2;
        Fri, 30 Jun 2023 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688180650; x=1690772650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRrHr6UEiq56x6SWgCHurtfSPLy20rMaAzy+jSm0CKc=;
        b=Q/2Jk3RYSEs7/AXtd3InR4THAXhAwr+L3mP+y6X2gcmIQOrDO0CVWyOf9zXSkncWx3
         vokrPejb0TZOCN9XtuOoqJfDWJxJHnAPEMGeU0ygwTwPw2uGSoDqdQ+PJ6BV9UDX8QwG
         j1gy6UnEgduP8C5F3drb9nsm9zFi4gTVkvzW16tO6LsPP6t+mOXLwFELZzhU4X4p7CBI
         xS2yNyR1cxdezTF9UVCviNCX5NM6jrV6x1jp3lcDHv3/Zdy8c8AzHbY4O+WIEfabqspw
         YHj2qpOFfDLOds1npq+7njOU9RjYBD6pZ4TOU8n1lk9jWyWMpinSIeAhs0DxudO5WOKr
         vaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688180650; x=1690772650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRrHr6UEiq56x6SWgCHurtfSPLy20rMaAzy+jSm0CKc=;
        b=j9J1pde/HvWBIxqzmljgnEVnJ3OicBfSbEWTRp+elIK+pX0GVkqm1m9KexNceiWd/P
         fpSoqrsKmMf/v+9OIeKnuZrSDtHb/UTV+lJ8/GL8d5PF8Rx8T5EiRkfnttcAz77+3S+n
         CzJJn0XlNllR2qTqTP1W3uMBNfIex0JfClXoqNV5ZCzekxK1qx/SgnVb9bO0i2Nz9JTY
         ewzZQvrg++ZTsvyOLCyElFl6LScf8t5JHlMjnmUhZzhS8XU0EeycDIsLsbo+4nHRNtcy
         Myut2mCtLdslmJF5uP+BOhmNSegSS72+k9B7nxuZAH63751CmXbHVlCBd9tgaGdLAxZV
         ymCQ==
X-Gm-Message-State: ABy/qLbCfnGeI/GSlvNUGyPW7/roN50PqiUAxLlhipKV/M5icNjwTiEN
        FHDu1ba+on0tq4VJN8WnI9sLGh0QZ0s=
X-Google-Smtp-Source: APBJJlFqB8Bf8VkiGpreAMOsX6QylwofUfVYvcXRfj1zAgibD2LC/YRQP1Vgyp9B+2sNdd1Ge36MYQ==
X-Received: by 2002:a17:902:e5c1:b0:1b2:a63:95aa with SMTP id u1-20020a170902e5c100b001b20a6395aamr4572712plf.54.1688179953021;
        Fri, 30 Jun 2023 19:52:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id az12-20020a170902a58c00b001b0034557afsm11370517plb.15.2023.06.30.19.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 19:52:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Jun 2023 19:52:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/31] 6.4.1-rc3 review
Message-ID: <eb3f2352-98c8-4d33-beea-d2d88dbe3371@roeck-us.net>
References: <20230630072101.040486316@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630072101.040486316@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:33:31AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.1 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:20:45 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 520 pass: 519 fail: 1
Failed tests:
	xtensa:de212:kc705-nommu:nommu_kc705_defconfig

Guenter
