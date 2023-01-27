Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85367F170
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjA0WxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjA0WxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:53:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699B8B7BF;
        Fri, 27 Jan 2023 14:52:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id cr11so2582970pfb.1;
        Fri, 27 Jan 2023 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MtAG/9KYlJY8+9SpaiWUoGAiO2xcU60MPfFMXhDuZ88=;
        b=g1EdfzO2WHuFFa0jaMoIWoASitkx7tIS4ElpBtZxweM8pO6vAibz9GnjuyAsCyRigX
         Vhc1APjEX1Oh1TNoZqiKKpZmLd0uSwHrX4/NRtp0D9CEiu53Guv6t6NlCsGAk2GFF6Ir
         7LlLmSGYEFshtRoCgZrZe8ihYdbrZPPj0WUbrei1Wg+jvumzQJ7xHW2/p4wlXIgzaRTs
         fQlN/ga34+LIljx0aPUDdkrHm36+0/4GRrQAeiCFkMQ3a3Ghveem9STpTc28jRZYGGJ7
         oJp5Ih47o/rEnCuIh9rywumUtpBhS3k1lr0R89vFVWpDfY1JSw3E1LN4WdWfqgZ6pZKy
         VDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtAG/9KYlJY8+9SpaiWUoGAiO2xcU60MPfFMXhDuZ88=;
        b=FESzg6EykMlHUc9qExAxfU+Fkb3F7gtpj/vT58Agr8FSp1Cj6c92HvvneA7kmnd6if
         VIFXYL0+0lJiPuo56xQZwmt8dvBi8zi5olL+3gVqHlqk5Q/rlepIDOvEd10uRDKoXfoJ
         WDWMQlU2JHpOlS7hSbmV5dzYbIS0snSUTOS/ekk7W+qQrZybLtEyj9McSQLTFzV/IHmq
         f9wfzyB0GSHADysmrr66jw4Zqtg7DBJ1LdnfgK6Zsov9o91Hp1CeWH+rQ5KkMBSjq5Ci
         9mHRR+KjGz/1GyhH3lvJ5Tvedohdcndj5/hDGyFjEt58Eag5TRRI6UkJYLoQvAzmI1/T
         6NQw==
X-Gm-Message-State: AO0yUKWSsGYXsjQxryVPtERCsxsSC1JWj3T6NiQriHBRRbhQIUU7FMb3
        MuF6tbtoP8BuE0scWCmlTOE=
X-Google-Smtp-Source: AK7set9oiUs6Tl3aXiXoueIGJeNfJFvQWZvXAkgJLdhxnuI/gFcFXzwg3djZi8zErXju+tLlb0607Q==
X-Received: by 2002:a05:6a00:3022:b0:592:b93b:afc0 with SMTP id ay34-20020a056a00302200b00592b93bafc0mr3360503pfb.20.1674859953568;
        Fri, 27 Jan 2023 14:52:33 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f44a:5afb:bb52:dec3])
        by smtp.gmail.com with ESMTPSA id x127-20020a623185000000b0057447bb0ddcsm3103779pfx.49.2023.01.27.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:52:32 -0800 (PST)
Date:   Fri, 27 Jan 2023 14:52:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ipaq-micro-ts - fix DEFINE_SIMPLE_DEV_PM_OPS typo
Message-ID: <Y9RVrZEuY9pAwovy@google.com>
References: <20230117164539.1631336-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117164539.1631336-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:45:33PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The previous change was not properly build tested and needs
> a trivial spelling change:
> 
> ipaq-micro-ts.c:146:8: error: type defaults to 'int' in declaration of 'DEFINE_SIMPLE_DEV_PM' [-Werror=implicit-int]
> 
> Fixes: 144ff5e03d74 ("Input: ipaq-micro-ts - use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

-- 
Dmitry
