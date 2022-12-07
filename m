Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5A645BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiLGN6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiLGN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:57:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2856545
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:57:55 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vv4so14224218ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6R6RPhEMnDDwr3AtfavGsulA8T0smLmthgPNwTxk7do=;
        b=rFZLKzuxSCXL0/RVKoW+2JN4Rhlu7jPPPMgyWfU8TeLIsLHk1bujos1jkakP3oAw7p
         0bemsdoifiqJFY069nVhiehDpd+hhgQPnV4RaSLdEJiEQ6Hgudm4NKoOxgoHWPoHHK8G
         PjCHChNsPqqdvW2kF1dWmNzrQSPGOq7lqcy6+rqFOdRZ3SwMQqQLDNwbSMQ9qIoaHQJo
         3dHSKfM4LAu81L+MBAw0oYiw7jaAHNuxK5AByyHBQMv9BND8lpLe76R24GF22PrRt6Uh
         MagZbcVq7S0RWa9EFh2wA7A/G2kBOtOhlV5pg0THEOpcqV/EO001P1iFCFWfrHedZ7yr
         UEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R6RPhEMnDDwr3AtfavGsulA8T0smLmthgPNwTxk7do=;
        b=uNy70SUrMHdHXF5fM/hqFsAggX3RYLcy3EBoew7UFhdGdepDqlr1XEBGjuaZZxG4g/
         OalQVY91sYe0bK68FlunbcgoBkbeAY00bdjrPUdsTA32Xd2e0FVLt4LxQnbaiS1FSLKv
         ML4C+2EQaAIHnxZ7aD497VjhpCnZIRHBV0W6oa0eVkcFVbWa5IVodR6BBKGQfVCcIsGJ
         cBUJvzn+5S1FNccfM/Clrn3NBvZZ0xHwzJmWkwhvx25ZxkNtVGnGW4fNZIow5wvrhmVG
         ZSn89RqAtvSDYg4q9ryavXLK/FqfgaDVt5d+aTDCaNkzVXVbvTArtSUxYvuagZ8hTmmP
         4cOA==
X-Gm-Message-State: ANoB5plkO3MbWJvQmFH/6Avr+TeUpar+xxC8FlMPx9KFtYaiYvJV5bgz
        Qo2BpWXphzq0rLNxI6CCQQmtcQ==
X-Google-Smtp-Source: AA0mqf4cs3jAxjVlM/djRjoy8ts1G83WugKPd01O9HoGR4w0IADcpL+ZW8XmzZBxKvAi0gGDSHR4Qg==
X-Received: by 2002:a17:906:ef1:b0:78d:260d:a6e4 with SMTP id x17-20020a1709060ef100b0078d260da6e4mr75140483eji.93.1670421474344;
        Wed, 07 Dec 2022 05:57:54 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b007b790c18264sm8500628ejb.159.2022.12.07.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:57:53 -0800 (PST)
Date:   Wed, 7 Dec 2022 14:57:52 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        macro@orcam.me.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ralf@linux-mips.org,
        jeff@garzik.org, akpm@linux-foundation.org, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH net] net: defxx: Fix missing err handling in dfx_init()
Message-ID: <Y5Cb4EMML3f0Ivdx@nanopsycho>
References: <20221207072045.604872-1-liuyongqiang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207072045.604872-1-liuyongqiang13@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Dec 07, 2022 at 08:20:45AM CET, liuyongqiang13@huawei.com wrote:
>When eisa_driver_register() or tc_register_driver() failed,
>the modprobe defxx would fail with some err log as follows:
>
> Error: Driver 'defxx' is already registered, aborting...
>
>Fix this issue by adding err hanling in dfx_init().
>
>Fixes: e89a2cfb7d7b5 ("[TC] defxx: TURBOchannel support")
>Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
