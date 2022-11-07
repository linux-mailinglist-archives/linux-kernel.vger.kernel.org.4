Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA7620379
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiKGXMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiKGXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:54 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6724BF2;
        Mon,  7 Nov 2022 15:11:53 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13b23e29e36so14438538fac.8;
        Mon, 07 Nov 2022 15:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsY32S3Ci2xQSLvyGjHjsxCXhkDvmP8cF1HLMu57Vb8=;
        b=CgSj+1WwbPpZhIVVZgNW9nrkptDgRV/GzCWx20zQzgiDHSDFWJOO8YWrBYrqqarYSk
         LdnuGo41PU2SgNI+k4/WV1xluxkDRiujnft1nmxQiXc/sxSOCNMzB0bU/lyRfucXL7Mv
         kmqP4/RAQqNtMMWb+1y8PD1w8tXPdd42+tY464u+enbRjShWveV4sPL+QWmbenEhIslG
         kSJYQubsTLxBBoUHLQ6QqeF3tngiuVyNVSY1vIGxoxHr6XgImsojhjkDU7XnsYqYYlPJ
         rDSYL37exOjQmIZuCECMLq8z+5x9drE8xATwkM2sza0IoWt7MYcw+0M/EEw3/68MaK5y
         Auuw==
X-Gm-Message-State: ACrzQf0arPMJqQ+VaYxwaAmzW77QoBMz6k8NHw+hJdWcM/8TCoqLBkUu
        HPCizLcIOgz1jTNC87o2+A==
X-Google-Smtp-Source: AMsMyM7nXVwMcu5ISDcRp634syLg/5x3kTrKGqWMfvQM7YOn46opCf+Bo3bZ5zc/ZQ7ccM5Zb/iR6g==
X-Received: by 2002:a05:6870:58a4:b0:11c:9b6d:f066 with SMTP id be36-20020a05687058a400b0011c9b6df066mr31211751oab.155.1667862712788;
        Mon, 07 Nov 2022 15:11:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i13-20020a056870890d00b0013b09a56d59sm3774129oao.27.2022.11.07.15.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:52 -0800 (PST)
Received: (nullmailer pid 1834437 invoked by uid 1000);
        Mon, 07 Nov 2022 23:11:52 -0000
Date:   Mon, 7 Nov 2022 17:11:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        David Heidelberg <david@ixit.cz>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vidya Sagar <vidyas@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/23] Update cache properties for arm64 DTS
Message-ID: <20221107231152.GB1779129-robh@kernel.org>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107155825.1644604-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:56:53PM +0100, Pierre Gondois wrote:
> v2:
> - Update/Add patches for missed cache properties requiring to be
>   updated for the following platforns: bcm, amazon, arm, exynos,
>   freescale, marvell, mediatek, nvidia, socinext, tesla, ti.
>   Missed cache properties were detected using Rob Herring's branch:
>   https://github.com/robherring/dt-schema/tree/cache-rework
> - v1 of exynos, tesla were merged.
> - Updated wrong reference in commit message.
> - Added received Rb/Acked-by.
> 
> Align arm64 DTS to the DeviceTree specification v0.3 regarding
> cache properties. The patch-set mainly adds 'cache-level' or
> 'cache' compatibility properties.
> For one qcom DTS, level 1 cache nodes are removed as they should
> be in the cpu nodes.
> 
> On another node, it seems that the 'cache-unified' is under-used.
> cache-unified:
>   If present, specifies the cache has a unified or-
>   ganization. If not present, specifies that the
>   cache has a Harvard architecture with separate
>   caches for instructions and data.
> Only a few l2 cache nodes have this property, and in the absence
> of [|d|i]-cache-size properties (or other), the cache is assumed to be
> split.
> 
> The l2 cache of the Rockchip RK3308 platform is thus assumed to be
> split:
> l2: l2-cache {
> 	compatible = "cache";
> 	cache-level = <2>;
> };
> when the platform datasheet advertises a unified cache.
> 
> No modification/check was made to correct that due to the lack of
> cache information for most platforms.

I suppose in theory a split L2 is possible, but I think in practice that 
doesn't exist. The Arm ARM allows for such a thing, but this[1] says L2 
caches are unified. IMO, we should just define level 2+ is unified in 
the schema and we can relax that if ever needed. I've updated the cache 
schema branch[2] with that requirement.

Rob

[1] https://developer.arm.com/documentation/den0024/a/Caches/Cache-terminology
[2] https://github.com/robherring/dt-schema/tree/cache-rework
