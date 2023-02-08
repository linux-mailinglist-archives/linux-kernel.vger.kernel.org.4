Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7909B68F745
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBHSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjBHSlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:41:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADDF13D78
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:40:59 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g13so15542317ple.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vScWvp/d/ozadghDwSfm3Gk65WbH936w/mqDt9205Qg=;
        b=mlm0snFmkK/mocn6K/lz9IRq8FtpwlhW6dqLlq+kstL00rWUBkse6deR80FKo7M2sI
         EtTcbyfxm8XQRS78OevJvYIb8WadY62gDjKNr9Zx3obtxH3DWDi9omz4IQDPPWJowKPG
         bzz5/QcSxiLG6SrKf9CtckVzfeSy2yPfLXPe/rutbCsL4Er/5tbYfkxS+eGyri+uA4yf
         CATV386bbeQQZWKqnNYkgn28RZ1PeFKJZ4ceaI53YiQ2C4mDVWD3EkA1QIlCUG9JEV1s
         VzuEN2RaL0laqkQV1GP6B0afJw5Ostx3XoOcnUHRJg1X4Zn7TxxHHX/OftnLMpq2BcgT
         HV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vScWvp/d/ozadghDwSfm3Gk65WbH936w/mqDt9205Qg=;
        b=wRDYQH4hIgYKMjn5RU9FL850BvBnMJ/nAh3oLAx90xY3p+7odLse0tm/SW2uAgyLLl
         /jtJzhoorA7/2KcSv/3nMSNNtOXG7xlfqbDAINKe4zrw8M4mllNLJ5z0sok0c2dpty1q
         3vnyqofsAnksvgpZe/gCb1y6y6x1x/fKSxY3TsXFbCUssb+JezLXYnddePZ08WKhL6MO
         TttYPlQS74J6Ux0tuD2YrpfwznJXUR15eL4VjJTSSIBVp7DVvXMN/UaVo9xK49m2k9aT
         Z/j1sj3pqpuJFS2I2V/gbQ2q3duNqupfA0RYLs8IEWxbuXYL2VmuAMJbvJf37f2XTVch
         bqmw==
X-Gm-Message-State: AO0yUKVzTTc9M09/8bT5xOswK/yrK50l3NWw/hLuHQ4hQquMlqihMRMN
        aIQIVRRCJzCFx3GIKkVD1kassP4YXrzvjQ==
X-Google-Smtp-Source: AK7set9Di9u7lExJjp+4e48o30DuEVXmHUmhkVXNgT/jErcWaoOpUpbzfz2tBZ+ehDmVwnbfG3oiAw==
X-Received: by 2002:a17:902:d04a:b0:199:482f:d4a1 with SMTP id l10-20020a170902d04a00b00199482fd4a1mr2189566pll.33.1675881659326;
        Wed, 08 Feb 2023 10:40:59 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t15-20020a63b24f000000b004fab2ba60adsm8016822pgo.81.2023.02.08.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:40:58 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com, ye.xingchen@zte.com.cn
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: brcmstb_gisb: =?iso-8859-1?Q?Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresou?= =?us-ascii?Q?rce=28=29?=
Date:   Wed,  8 Feb 2023 10:40:57 -0800
Message-Id: <20230208184057.863743-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202302081537158530029@zte.com.cn>
References: <202302081537158530029@zte.com.cn>
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

On Wed, 8 Feb 2023 15:37:15 +0800 (CST), <ye.xingchen@zte.com.cn> wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
