Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C31C624427
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiKJOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiKJOVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:21:54 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB61C19C19;
        Thu, 10 Nov 2022 06:21:52 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l127so1937163oia.8;
        Thu, 10 Nov 2022 06:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0l0HkGStvh8ekqBVw6XOHFtjJQ25u2aSlRE478jryI=;
        b=TQYDbPO/olvXM/iSV5CJ6so73UsFpCcZOAGE8qruh/KqC785Ci1ZGZ/RF8JKHNQdtF
         lyCHvSUvMThbMRiMKz1jA7wD2q9doBbm3D6qDC64/cCkG6xikNOaGrW4fE7icucOaIN+
         pT6fEPvBD/6/imVt9ngYFZO30wtmjldaMQlfJVpQAIpP83oxsVuxIKrMDPWe0lRg2zLP
         uTA+W5p2ltVYHJgQLG2kfscdwW+wkqVBhxu2kjjl+vehFUikJHKAm5OQMuyAYQ1bOdi5
         2Rp0xsaPhF9EiNnuUC3fFuL9CZ8WoY3o4k1uJAHY0tXTAIik1MAtzWLSnKeF64GjbWtI
         Dulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0l0HkGStvh8ekqBVw6XOHFtjJQ25u2aSlRE478jryI=;
        b=Nzgy1gCH8Ty+RCyEkrcrDZ0ZO+RiHxuPJYJ4M7M5snd0zm+7KY8HwqjDCLGPSsOwze
         jcPG9153Ekjj88aL7+g+Kw0qYnRuxtFY4wH8jiM+HPU/3q+5WcJKIVPEjzekz+ibFzOE
         rXjyDdac0uTj3lEN7KMrruGBXQRQnOEwe2hB9srqBnSh6/ipaYTCTjnRA0aNyFLHr0j/
         Tln1MDI1LbjKAEzVV4PYWTR9x+C2bC2Y3/1EvXra2CfpMphTNr0+cvuBLVXGzf4vfNOo
         +/BdyBo+LQdUi7nWb2z5dK4M5umIIJNaUX32dcWJlVQPdtijhzne69c1j3iDSyPBGvZS
         tqUA==
X-Gm-Message-State: ACrzQf3QXYTUIqxb/G54ioTtOQnAcPA5G90j95q/gMHrLrBu3g4v6tSc
        0HkbkKz1H+YV81hEqoK/ncNEtmfYmBk=
X-Google-Smtp-Source: AMsMyM4zTRSB8BVNrdlESTGTrSnL6fD7B6/3tGYgHsP1HJVe+eJaoJcH/WGk5G67Culh9KjGUyumFw==
X-Received: by 2002:a05:6808:1507:b0:35a:5eed:f5ce with SMTP id u7-20020a056808150700b0035a5eedf5cemr17161066oiw.108.1668090112131;
        Thu, 10 Nov 2022 06:21:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870470e00b0012d939eb0bfsm7564424oaq.34.2022.11.10.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:21:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Nov 2022 06:21:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] thermal/core: Protect hwmon accesses to thermal
 operations with thermal zone mutex
Message-ID: <20221110142149.GC2404288@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
 <20221017130910.2307118-7-linux@roeck-us.net>
 <CAJZ5v0hMbzEdLecy_OWquOqdauBc1nsN7Q9mPkt2tOU4nEpHVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hMbzEdLecy_OWquOqdauBc1nsN7Q9mPkt2tOU4nEpHVw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:19:13PM +0100, Rafael J. Wysocki wrote:
> On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
[ ... ]
> 
> And I wouldn't change the code below (the ternary operator is out of
> fashion in particular).
> 

I tried to introduce some consistency; the ternary operator is used
in some of the existing thermal code. Guess I went the wrong direction.
Never mind; I don't have a strong opinion either way.
I updated the series patches to no longer use ternary operators in
updated code, but I left existing code alone (changing that should not
be part of this patch set anyway).

Thanks,
Guenter
