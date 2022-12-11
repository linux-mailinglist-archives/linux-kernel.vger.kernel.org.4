Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFF64933A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 09:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLKIqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 03:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLKIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 03:46:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE494E0D5;
        Sun, 11 Dec 2022 00:46:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h12so9108748wrv.10;
        Sun, 11 Dec 2022 00:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loYSZndITAn/hN7yRh5Ae3Y1mFVGof0StIEqdn2NE4g=;
        b=n3IZwTyCIp/96PFBzgtZsDBy3cgplTkGR2Lnn67EUoddO7OVKngNHc8NFsLoqVVAml
         Q0Vwb/lU9BObcVWznTvklGqDeRHlEhzIdxPKNaAyA1lvZznPAHn0uRIqJLDtAOko0yC2
         drvkLnciG3ZKCarSp7cYaZ2CQKS6uKKjrafFO4npSFis6zcO27A0qzmj2YshICn4+Uhx
         Vk0igRPteNA3MOWk24sPV7FK+gQZ0qjnAmluew1vXtBHKC2fXmhuQmbULLM137GRXJa4
         dIarpHtk5Jx9VQoLTLNcMoz86L6gAzMpSYOoaFG1la4IevPIGjFs5H2FcxPpsV1SWvuJ
         Sz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loYSZndITAn/hN7yRh5Ae3Y1mFVGof0StIEqdn2NE4g=;
        b=Wcm2KTUmLTCTXCwDGTVsVyY3dnEx06jxfIzpZNc0mwph5ofISn8MRfHcVlY7FJPNC1
         wOw4LntpwvbWdDy+JSh0RrDBCx9/wEd0bafxroCGedLMdW6trteYtSRxAFT33jdM5SPf
         a9j6gAUwuNhxBIfu0+KABhZHaLxWgz1DRXVLaWGwozmph2G6unD/LL2euxq2Lpq6NC/j
         /y72pAOhxJFyO+FhGVlbT1vS8461ARSaV2b9Ie0BGQcMsbnosEf7hyL7oZq0w1zYwT/t
         cxoW0ym0rrA+UI1hrcHcPzFfi3i8/Lmi180+8AYbHXKiLuBJWyH0SOwyl4cWSe3zVjKS
         UnIQ==
X-Gm-Message-State: ANoB5pnohLjS90t4XUIqSU714xIYdFcOb5DBAvqH3mxpZZS8hCRpLzY+
        sX+DjDcLAohY6feb5nrsX1s=
X-Google-Smtp-Source: AA0mqf7BxA256Em2ujPBTajEXCwDwQJp0wGxTaUWZlaXzAl45b0Nimp9/Gl2nXURdkz/0LPDPXAJmw==
X-Received: by 2002:a5d:6ac5:0:b0:24d:867f:10e6 with SMTP id u5-20020a5d6ac5000000b0024d867f10e6mr2648624wrw.32.1670748395327;
        Sun, 11 Dec 2022 00:46:35 -0800 (PST)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b002425dc49024sm5703423wro.43.2022.12.11.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 00:46:34 -0800 (PST)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     olof@lixom.net
Cc:     ansuelsmth@gmail.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, saravanak@google.com, zajec5@gmail.com,
        fido_max@inbox.ru, =bigunclemax@gmail.com
Subject: Re: fw_devlink=on breaks probing devices when of_platform_populate() is used
Date:   Sun, 11 Dec 2022 11:46:31 +0300
Message-Id: <20221211084631.3942082-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Yyj7wJlqJkCwObRn@lx2k>
References: <Yyj7wJlqJkCwObRn@lx2k>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I have the same problem.
https://lore.kernel.org/all/CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com/

I think the root of the problem was the choice of 'compatible'
device tree property to marking mtd partition node as a nvmem provider. 

This property used only inside 'mtd_nvmem_add' function to setup 
'no_of_node' flag.

> config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");

This is how this flag processed by 'nvmem_register' function.

>	if (config->of_node)
>		nvmem->dev.of_node = config->of_node;
>	else if (!config->no_of_node)
>		nvmem->dev.of_node = config->dev->of_node;

Thats all, there is no such driver which compatible with 'nvmem-cells'.


So, maybe we should change the 'compatible' property to something else?
