Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE977728C64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbjFIA1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjFIA1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:27:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C89A2115;
        Thu,  8 Jun 2023 17:27:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso265954a12.3;
        Thu, 08 Jun 2023 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686270433; x=1688862433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmy9FcdmN1zPqlfENuWgahekfDgTqHicAiRcTJtdOa8=;
        b=NCZegwuVytmKIOCDaPZbP8Xsh5WGytrzeVhQNJnS+CE3G8tFm/W0OgCLkKW4e3ZGic
         2MzXJDUbskcnzur/ciKjqGQE+FkFTTEcra2Hbx+tVO5AVmV6+Dl5QphvvEaA6Ib6FBKl
         EdF73q9OrrocQZGOfXQhWN0OscPJkKOCRNh8aRAGqzHH+gkOlrqg6+i0gAaWVYs/QTw5
         W/sAbU096hfeyLwE/ah/V4m94LI/GB28v506z1xktMgKuHjVdZEst4CRxKToASFtgCmz
         7ByqvovEyUoPBnjT7s2x+QJCdOWGlceUIvmpQJj9WMSMn/Ullhg0DjjvN/oQEOcmVOps
         IOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686270433; x=1688862433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmy9FcdmN1zPqlfENuWgahekfDgTqHicAiRcTJtdOa8=;
        b=P+LgdUBBLVvPP/3N9FUqnLml4nrPvbWoV5iY+y8Bl9jGrknXv1q2xuNrITgaf18H1I
         fRatz/uMpVDwxauW0LkURLLvtxMjTNWJ3xqBw3ZflLsQqOME+JrvTa+5pbu3qwfW217q
         xTrW0Efbt1nqNM3nCViXDJSZBp7Vy2PIOjcTURfIfOdvJjY0R9bfrKlHscd2u/9WS+UH
         n6QSeNDXyDNejQYzslvAaFat0fEigVsYXKOwV4y77V9M3IOKMFKcDiSegqAC+aJ92Snc
         1iVYdzTDCCJAqnxicvf1APu6GXk0wpoUUKwRca0CvTC/ZwV5v0H5I7QQRmdH6saehTas
         CX5A==
X-Gm-Message-State: AC+VfDyGukmp0wSBfzAwdSPNvTuZkwgCOMpNJdU0bZLdEIu9MPZJHwQK
        J+rVTAa99U1nxZdvH6H4VdI=
X-Google-Smtp-Source: ACHHUZ4AwbFXZv+fsc3bKfjNUcmKpuV2pVpcNBYeF/Xf+Ol+7+aY/NMjzx7e2ENQXbktJRDch0fuow==
X-Received: by 2002:a05:6a20:8695:b0:106:c9b7:c93d with SMTP id k21-20020a056a20869500b00106c9b7c93dmr6899603pze.19.1686270433373;
        Thu, 08 Jun 2023 17:27:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j17-20020a62e911000000b0065379c6d549sm1554078pfh.215.2023.06.08.17.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:27:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Jun 2023 17:27:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.4 00/99] 5.4.246-rc1 review
Message-ID: <f2893b27-d040-49c5-afc3-030842f0502b@roeck-us.net>
References: <20230607200900.195572674@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
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

On Wed, Jun 07, 2023 at 10:15:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
