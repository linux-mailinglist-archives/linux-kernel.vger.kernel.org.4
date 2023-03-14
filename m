Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7986BA084
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCNUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:15:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC19192;
        Tue, 14 Mar 2023 13:15:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so7735451edb.13;
        Tue, 14 Mar 2023 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOERF+jCyt6cMLRNcuzDfYHf9edQe6iKfmTk13evlgE=;
        b=AAj+e5IIgIccY1twGYsHPNoORZcdlYW3Rx1rQW/alPuaVuGooEwW2bykJEcIYTbFGt
         OyDOEmDWuHvVGB9cCPI+DaKdclt+pSBfPRV0/zunyYa6S4bA36AT0jO63wQtE+Ihd87D
         GLW5eq4pfVTn86QBtqYQVneVgR3McQ0YWojYD+LTg0WT5Kzl327rg8J6EUSUMqaeLNPI
         y/JKNIHsDqZmeoT8u4/7Rjp+W1pzZy1sIaotANbKBGHnXRzJMA4a36FYaXszRB8a2+QL
         3YYZhyyQ1Mkhcw1d/dcKfu+ggNpjRMdN4eXPIUSOSzh44CgJfNtwTC+XYAvm9LBXKeQO
         QTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOERF+jCyt6cMLRNcuzDfYHf9edQe6iKfmTk13evlgE=;
        b=Zgali90QWzpT986sGkdjRRSsJxltPeKZvVsSnb7f92tDkKiOdnwyD22MiSGhYNBVDi
         qEbvykKVd2KCPXoN8v6Ga19tbGGIhsrB53S75iml8bXUI5Dcvx4xz9sqv5l0o4eFTxdq
         gsmfmdFdVrWOAwjRZaIG6gxNaJHw/RUU8RokxCC/iOaKcp3fJfrxPjByXD5nxCirD8p3
         QkeTK0v/P7nhd4AUXegcAlQh6UDCn4ARlEMvNvwkeBYIVp8p55CcAvT/EY1p8sB5teG1
         7e9icgeoyALanKW24e8PUeot96iIafeh+17I/N2G4Sj9jRRt29D6F6lq5pQ5cn/OJlBB
         Ea/g==
X-Gm-Message-State: AO0yUKVLyjov3snFfqMT36Le9VVz807wHcrKk16R0EBjPpb+zP9tagED
        PMKmN6cT3eGWSvlRQm7HUbg=
X-Google-Smtp-Source: AK7set/sMm0YjG7LDT1uBapw5l8BoDwtxlSY3JrUw3fv9um7gVJMKXwWuCWON77Fb1UYIhJnPAPx3w==
X-Received: by 2002:a17:907:76ea:b0:928:9add:3f20 with SMTP id kg10-20020a17090776ea00b009289add3f20mr3871873ejc.61.1678824921286;
        Tue, 14 Mar 2023 13:15:21 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id jz14-20020a17090775ee00b00926f89e2213sm1527267ejc.190.2023.03.14.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:15:20 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 07/27] iommu/sun50i: remove MODULE_LICENSE in non-modules
Date:   Tue, 14 Mar 2023 21:15:16 +0100
Message-ID: <22999869.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20230224150811.80316-8-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-8-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 24. februar 2023 ob 16:07:51 CET je Nick Alcock napisal(a):
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> ---
>  drivers/iommu/sun50i-iommu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 5b585eace3d4..63ac9d15b859 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -1077,4 +1077,3 @@ builtin_platform_driver_probe(sun50i_iommu_driver,
> sun50i_iommu_probe); MODULE_DESCRIPTION("Allwinner H6 IOMMU driver");
>  MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>  MODULE_AUTHOR("zhuxianbin <zhuxianbin@allwinnertech.com>");
> -MODULE_LICENSE("Dual BSD/GPL");

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



