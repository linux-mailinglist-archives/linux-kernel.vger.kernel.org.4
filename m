Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DB6F22D2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjD2EKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjD2EKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:10:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797852D4A;
        Fri, 28 Apr 2023 21:10:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso582297b3a.0;
        Fri, 28 Apr 2023 21:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682741411; x=1685333411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjvvpGcIfO9/6mwyUZ95vKLipkSeEdsdP/+UUpT4GIo=;
        b=a+NtvOhsHC7mJJxkkpLs46QmV+56Hu0N3ksL8ctjHJmEF2j/cXPpztiDFHdoEk8T+z
         IIaS0wyJ57b/aPAD3TBxyzf2pTlVw2qD699BZrtDtolKCqHyHbhIGuHinTf//It14BXn
         G1Ql0qm7C2cxfJjU0Z0KCDyNETZe9pv2zn1uhbB7QENUmA3y8rQ444sz/Lx2S5mGGltk
         FWrbDpGiKGDtRNbxL6x6oqWPpfOW3oiy/I/OtUbw58vKrAeEbMDBda6fCBWhqnmRCoD6
         FBfQRc+sjUR59yBIT0OBBbgCvsnBnaFH2D8YnZO/n9A/cTsQh6FAYlpf/mZjSSJcHvvs
         8ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682741411; x=1685333411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjvvpGcIfO9/6mwyUZ95vKLipkSeEdsdP/+UUpT4GIo=;
        b=d6p1hBG4yG3DqxmS2ak/N+Dh6CIrDZOpXWu1ZlAZhr101skkpuoaPQsHjvVw3GYxb4
         0ppNL/QTeSX91domIIx6bAu6biYAi+XfgxsXGiQToGxsZ9+rGSIDtKFimOxaAKl9wV+Q
         ppih7iBcExL004p21gW6obyKIDyeRKyfPTAyLgk+mwiPfXe+X62Jnujp68r176OyRWDj
         ziBbl2YRwJYguTwnDNWQo/7K7zCY4Pr0PRifQDs4yqsDKbKjQYEE+xW/fx3cokLzgr+E
         YZCbJ/qrEFNLp8Ia0eQe3ZV0CNy/crZl7jiBBXEpVEUHa/nB7ALz7JwxjHZZV0aiUJd6
         NIqg==
X-Gm-Message-State: AC+VfDyvgT334QRTdNZuPH9VtlUUb2QXfwUAzBuKwq3lLxkzAgF1bXJz
        TbCZy8tFw4HZMzrBISOuE8k=
X-Google-Smtp-Source: ACHHUZ4uTBVDNMCrbDaI+hYI9X/r5lZTnpaCGyGxZyBeAFx3mUwPIccx6mCH5rvZjuI1aD9Hs5SMSQ==
X-Received: by 2002:a05:6a00:cd3:b0:63b:6d60:9a02 with SMTP id b19-20020a056a000cd300b0063b6d609a02mr10854773pfv.34.1682741410883;
        Fri, 28 Apr 2023 21:10:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b00636c4bd7c8bsm15785546pfe.43.2023.04.28.21.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 21:10:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Apr 2023 21:10:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 00/15] 6.2.14-rc1 review
Message-ID: <35bdf66d-0615-4d2d-a9fc-a4d226c5b54e@roeck-us.net>
References: <20230428112040.137898986@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
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

On Fri, Apr 28, 2023 at 01:27:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
