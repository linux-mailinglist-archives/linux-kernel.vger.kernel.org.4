Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD8F70F7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEXNa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjEXNaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:30:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483311D;
        Wed, 24 May 2023 06:30:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51b33c72686so228522a12.1;
        Wed, 24 May 2023 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684935021; x=1687527021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxdSCsmwEYvEk63TFK+FV5f8HceCpvSs4IoYiBfYQio=;
        b=l6YcUGKhmdo66vUmRH5M6UodbMyTVGt+YTKbm6A+BJZw5rfQ0U/73/SR2QQgZmpiCk
         X5vxkyHKsDP0qj4lzVg6jvq4C6B4dUzs0waZYjb5IqtvfJHjNDW+6oVgzxB1tn1n5lKZ
         tkIqK4mWb1fjSkSVCmTF38xEo0ME76bOD1dGYG3+vHlBfgapSb3ntnoLXiHhC4vrh0TO
         e4TQk8uTadNpaq0pZKjIHT7LGN+tklG/U2BUyUPpG5qsAHMPr0vuexAC2+KseGsMNfZC
         73HnQKhXLf+3UrJv1k+LATC795xrR08ZTkZPbZ3EcvwCkvoWS45JARmnuK5/jjcjyrjS
         IVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684935021; x=1687527021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxdSCsmwEYvEk63TFK+FV5f8HceCpvSs4IoYiBfYQio=;
        b=DnCK0hawnDBohzw212uRFzHF/bEaWKczI6h3RcqrFxRrqVyGZo52QRhryG/BncGfkl
         63ASX6sHs/WljszzA1NcELxNeJiYC9UTLXouPuNYUNAiC/QtvrvweHKDZbSaS5rlDjGT
         XuBdJI7MxE0388ItC7142WekLeutRMmhf0VDDkzybHDn8rukP6QqyqFjdz6CVitvVTsn
         CkZ7vpmEIz2Hj8sbjGqWhfX/ax+oUAQKg6puv/RDaIlThOkoi/45K3oymo2zKaT6rzFg
         6dsXubEDw+kqvn9e97C6Bo28/ONqdLaIj4MPu7Yf8/idkq4qYxaq/u9w/YnB2zo2IB1k
         zDVg==
X-Gm-Message-State: AC+VfDwGu97Ax5qsFlAVxAgX6HRz0EEaAMUafQzJi+0889WHwiryQjB+
        pJE4VfgtxuLAsAMBYYyONM0=
X-Google-Smtp-Source: ACHHUZ4qt+542VeOln/VB23JLFlOHOdjQEeOb42tzBAMXi+JMeapJekYTWSm5hljINawnVfl7liZow==
X-Received: by 2002:a17:902:d312:b0:1ad:8c8f:afb1 with SMTP id b18-20020a170902d31200b001ad8c8fafb1mr16531018plc.39.1684935020841;
        Wed, 24 May 2023 06:30:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902bf4c00b001ac7ab3e7ecsm8676734pls.210.2023.05.24.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 06:30:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 May 2023 06:30:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/363] 6.3.4-rc2 review
Message-ID: <f664e283-a724-487a-83ea-16a1f72d2de0@roeck-us.net>
References: <20230523164950.435226211@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523164950.435226211@linuxfoundation.org>
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

On Tue, May 23, 2023 at 06:01:23PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 May 2023 16:48:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
