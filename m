Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A587338B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjFPTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbjFPTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:02:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE0B5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:02:20 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AEi1qWzKoL90OAEi1qKqTz; Fri, 16 Jun 2023 21:02:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686942138;
        bh=nEdbn9EvNL9x4pbYLYVTKkeSAVLXfuwp+q07LLfbX1Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sOWE4+7HVfsNkjsMEvlZ6hpsZ+iJKdFcqrmJkZcxJ1VYvvfvHV9AQ2WEqmoK5VerS
         UeeyqjO+UWiczrsz5uYbmMTmFSzHLOo0c+PHzbd+6L3NBlQvYwhby+UNZbPXrbpcox
         wIqGEZ0uY0HaRADEg7AchAxeVlEa1EttGokpyUaFLvmFUkULJLyb2NNJUbC83DhYcL
         y7RiMiJvi6KLkRxgZPpf+GfloPG1JDuPh5pomucyEWgDrJN0Iw/4ce5z2nlRKMASN6
         E7vTl5kHqHPajKD6la6+Igfducbtun/bOgdGOA0JtixDG/YHhhi8jHHP0/DRlUsSC9
         57vwCen7w11cw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 16 Jun 2023 21:02:18 +0200
X-ME-IP: 86.243.2.178
Message-ID: <28f511f2-ffbb-2ef7-c47c-caf9f5164512@wanadoo.fr>
Date:   Fri, 16 Jun 2023 21:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] soc: sifive: Add SiFive private L2 cache support
Content-Language: fr
To:     Eric Lin <eric.lin@sifive.com>, conor@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, maz@kernel.org, chenhuacai@kernel.org,
        baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-2-eric.lin@sifive.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230616063210.19063-2-eric.lin@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2023 à 08:32, Eric Lin a écrit :
> This adds SiFive private L2 cache driver which will show
> cache config information when booting and add cpu hotplug
> callback functions.
> 
> Signed-off-by: Eric Lin <eric.lin-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Nick Hu <nick.hu-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Zong Li <zong.li-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>

[...]

> +static int __init sifive_pl2_cache_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
> +				"soc/sifive/pl2:online",
> +				      sifive_pl2_online_cpu,
> +				      sifive_pl2_offline_cpu);
> +	if (ret < 0) {
> +		pr_err("Failed to register CPU hotplug notifier %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&sifive_pl2_cache_driver);
> +	if (ret) {
> +		pr_err("Failed to register sifive_pl2_cache_driver: %d\n", ret);

Blind guess: does cpuhp_remove_state() needs to be called?

> +		return ret;
> +	}
> +
> +	sifive_pl2_pm_init();
> +
> +	return ret;

If you send a v2, return 0; would be slighly nicer here.

CJ

> +}

[...]

