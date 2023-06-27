Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7BD7405B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjF0Vfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjF0Vfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:35:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED05213A;
        Tue, 27 Jun 2023 14:35:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55b1238a013so584911a12.3;
        Tue, 27 Jun 2023 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687901732; x=1690493732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2+7EhmDYzz3dsEHy7Rn6SNAYgMmhl2BbDV5wUwjQK8=;
        b=IA2lH70aDaFl2XJlVOTQnIMwx86vTfNIHx/2zlLGnGxoIeJU6iSJr690/J76EnFuLh
         2V1LdJtJMax2yrC2Ejwd224xFInGkiC/vy3Y3hR+yJzX4T4kDY8X4pVvlQmxquMtEnOV
         MpeodNxuEqiSKqERAQxT5oTlnKZSUcJmj7FnqUG4utDG+UaBd6pW6I/32A0PI5XfFUK2
         rrq37uygtSLf6/wPwUcLE20RhV7OZn5XxXGpGGebynm3BiBsV57iv7TBlF0bSf4xqdqC
         eWLttRrvqazCJir5fSR73w6mu4JAZiSXeKHpU+DR3PVUoxth6bNOkrtCfctAU7viC7kD
         gAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901732; x=1690493732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2+7EhmDYzz3dsEHy7Rn6SNAYgMmhl2BbDV5wUwjQK8=;
        b=F1vdgY/soUlOFaqfcQb6XNs2p0gaW6VWtJjp1RcDgULZHrH5dcqYuBtgv8AAxN6Jr+
         ysPm7XF/1Mk5DFDUorZCT0fTtLsgTUQYZ2PFgiDb9DLl9bzUFt6T40yilMSrqQYPZSDn
         I6il8wEedsRreruAMezqICBZ2ZT74lh44MgNUWxrkclJH7UXAO0NPYkqFQ5Sv0dcwkIJ
         LQFGZ5s8cPfcjewBLc3Q7oEbz8zgtOY9XdVqGa9fnIawErw44zW2t/JHSLGisjPocH1G
         fM0uN+iFLg9wSYQDZy+yScb/i0sUgrhcxq/WKAk4kbxSYN5H33aUjaaIq4Him5cQhXQ5
         MUEQ==
X-Gm-Message-State: AC+VfDxAUjhb+dUNADtL3VsEzNJ5vneJ7icfTJaZlIJDRtOT/ok9sx3w
        PzCEbkZ9G7uGc7mbTVhZpWc=
X-Google-Smtp-Source: ACHHUZ4XdrSuq3CPHSr7GVJLtMGwzV3PBEi7M6MrqV4otgI4lHidph5ey0KmEZL2gATRlHvHBPnGcQ==
X-Received: by 2002:a17:90a:3ee4:b0:253:340d:77d8 with SMTP id k91-20020a17090a3ee400b00253340d77d8mr30883103pjc.33.1687901731785;
        Tue, 27 Jun 2023 14:35:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090abf8a00b0025e7f7b46c3sm8231098pjs.25.2023.06.27.14.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:35:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 14:35:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/81] 5.10.186-rc1 review
Message-ID: <b331ff35-e995-486b-a37e-919405cb61ff@roeck-us.net>
References: <20230626180744.453069285@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
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

On Mon, Jun 26, 2023 at 08:11:42PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.186 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 485 pass: 485 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
