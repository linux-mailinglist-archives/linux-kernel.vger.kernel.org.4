Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBAA705D82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjEQCxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjEQCxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:53:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18D84220;
        Tue, 16 May 2023 19:53:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae50da739dso1637215ad.1;
        Tue, 16 May 2023 19:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684292025; x=1686884025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aBQ4mEPzfDLNAurJE9vtcKaHJGJ5KAIeFlJrI9UDdc=;
        b=RAd73w2dvXNMAvwPEY+hWFGpMdqe4GcTKRo22aAkZdmmALMSOTSl0JjOZlV9wLyb5p
         EVFFv7ko6XFkHr1xHLeglzU9bAIN3BAQMCttieyvIt+c89C27tQt/U1SdgofPwe3zXPb
         l4Ox0cOxQk/RheKz+KBFZqxIXZXp+GPheFbci7lmDxtZDhpk+szhShjciCAoFBIyD6Cu
         RJAEQNJ+DDgsb6lq0xZt9FsGjnRAaTRrWmcWZ3nxWlno7Bt0yvsIpTA/EasrH4tg3jQX
         LpbLD1kvG/U6RwE8OyCmRG5elMGaerkOnMGUCjRJS0GEH6uUqtQXzc7MuZlyf+oHJcso
         mRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292025; x=1686884025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aBQ4mEPzfDLNAurJE9vtcKaHJGJ5KAIeFlJrI9UDdc=;
        b=EkS38WN+Wi0AcsoyQlmZ+dB0YpjJHeTLJooIrkzQUZvSQ2fbxq+e28bY8SaGP2lKve
         1IP+wMMmEYgfKhbrWpV32uQ95i9yzgNuRxbWiOzMgPGb995MrE3wRw8yvASJoY/EMLEx
         0APtJTboRzOgzkf36VmEjvWsv41OSyUhENnjUgbVdcPoLEG5u3sjc6J3tgXC8Qrd82Z3
         1P3qyhKHdAvBD0LPy3pwKpjzHrAgsxTHe8fs6o0rqSgyedUF16KW3xCzXNCCHiGa0MOi
         aTx3dhyKUkFGeJwkqpaf3rCfwNulLPgMtk6WgWJhEwvAQ7JLcHrDEse5lm3t15eEypr6
         F43g==
X-Gm-Message-State: AC+VfDzOwxLXQa2ja4L6qcwBU0oEAurzvD5F56Aqlw/IkxaohJOcwrfX
        Rw2lECeX/fK3uwLegumS9tI=
X-Google-Smtp-Source: ACHHUZ6MbQ6GboXNdJq7qJOCzsUz2Ls1xiZzpsrPFtoeiLb9StBJQmBSNgiQ7qJhPOtLyP3y7aeT5A==
X-Received: by 2002:a17:902:da84:b0:1ac:a28e:4b29 with SMTP id j4-20020a170902da8400b001aca28e4b29mr37702565plx.26.1684292025292;
        Tue, 16 May 2023 19:53:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b001a217a7a11csm13183659pll.131.2023.05.16.19.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:53:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 19:53:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Message-ID: <2b1e9ab4-b416-436f-9437-bce488f300bb@roeck-us.net>
References: <20230515161722.610123835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:23:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.3 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
