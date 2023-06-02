Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA22720C00
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjFBWgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjFBWgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:36:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC741A2;
        Fri,  2 Jun 2023 15:36:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38e04d1b2b4so2121968b6e.3;
        Fri, 02 Jun 2023 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685745375; x=1688337375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=of674XRvlx3/FzSHdFSRdMppyBXBB7Firiv2U8wT/bU=;
        b=cYOr6LStbQ3rQIrtdbTdHjzgR5m6u66Bo5p+KO8lEDSsdK8HUE0hUIuzQhYafkDwix
         xPzTdY14ks52OKikb5o2jLwC48FeqNWi1t/OK84cHM+EcKQLvrtlqZVRaj+5LuJoFdQu
         72uoCT0nbZlxTA6co0a9D6H+nB2Jdu4BEsoxCz8DBJzk2FZzN4RTHtP+hxo1Xhe1pjBm
         hfTHp4S4rxZ5uzvR0FY+BXZoAzdHEJHh8mjm1naOlRZ0day1BL9FwysO+cefR0O6JRNO
         1KsBRF91rqOg9a/CFBEXzkiwarjUl0FNrnp8vy1eZD1xo2bmcqH2ZpUzaAw76bhITfJD
         xPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685745375; x=1688337375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=of674XRvlx3/FzSHdFSRdMppyBXBB7Firiv2U8wT/bU=;
        b=iM6Lw3LD2Yj3fAvH8rDUUqJyaxngzgTZeotSD3c2DMJxY1Uq0GOe/Pd1KBVUMtVyeN
         xflWM6jRg0m508SAeJwOB0Fb/0DKFzrwPn6K+4HrHb1U0RUme3/BEVd1bb4s5txFMMKJ
         jy8OaQ1s5nZVI4OGWKigACUId5MWvGau7aTA8fOeW1qz+hOeU8YrlTQMpGqodweGBNTo
         yUiEuzEriqFeda05ox8EYmizd5Q8LOd+g4m1Y/1464KZeQjxhWvUPaVx2jxbWe6c5jEM
         +qW/3rD65j7NPEq5gd6SVU0HAJPLadBSRjKF7CvaKex776nyrj+wt7fd7xSV8XuKp2jp
         SRKg==
X-Gm-Message-State: AC+VfDwVGTrPzv8+aaN3aAdNS/q6/0/N5X6Xqcb/TiNNe61DqbkePdTC
        IoRX+poQwl/w1rPTqZ0yyok=
X-Google-Smtp-Source: ACHHUZ7lSmvU5fH9/0RO8nspGwMqr/NGHrSuB7aPRrWM4oGtYd3eyKrAsG/6f17WVxdltdL/VQJFYA==
X-Received: by 2002:a05:6808:8c5:b0:398:59fe:6ee3 with SMTP id k5-20020a05680808c500b0039859fe6ee3mr1106424oij.54.1685745375577;
        Fri, 02 Jun 2023 15:36:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001a2104d706fsm1835249plb.225.2023.06.02.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:36:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jun 2023 15:36:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
Message-ID: <f3c90f5e-696f-4458-9fef-ff82f5d41e1c@roeck-us.net>
References: <20230601131938.702671708@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
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

On Thu, Jun 01, 2023 at 02:20:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
