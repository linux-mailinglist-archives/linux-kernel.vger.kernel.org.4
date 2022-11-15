Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E888E62959E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiKOKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiKOKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:19:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EDE11A0A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:18:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so9920496wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y0jhQ5wWDkw9YieqTPmmqrGIOhq9gcBh4/aIkZ5lXzM=;
        b=57noagd9/+GLWjNU9l6zkY9huepwbD69VwGHB+sQGnTHr1xZHyfKABbg4l4A4KRW5k
         ruJ0W7plLAqEVfC09oNuWRQrNTDypUejVAyHQIkLAnJCp74Khfg64VJUWos7+NcX6iLa
         gnpsgeEnzLVmexr7TFZoqkPbevxOTsmvfyDZNkQcpy4hgkvg6yV4FixJKueRVN9ew+RH
         k3JhIE9cHIfqpGyzVApsoLHiZyKF1/AROnnTIWkNvB+JDtHB2g6fC+7RSqNn6EbGLU0t
         E+q80oRh3vJmfeGrdASC8eTGBIOumDLS/VfT5BhurOOvdpPDzwq/M/wQqZKiRX2G3SeS
         M+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0jhQ5wWDkw9YieqTPmmqrGIOhq9gcBh4/aIkZ5lXzM=;
        b=Ha4P2/NEHy6HRFwb08mZnX07sSXJVQNDbFhFUAepUwSVq4hpOWgDBOq16/Zh60u2IG
         l5OGydP6ZszInaStnpe7MDXJ542DYOk2plOMpw5HMB+4beAVKOLNimGELk7ZGdCkvG84
         MwSAOAAsTeB6Y9nVJ9FCoiPj9BhUnl/icD+m/Nb5QwSjRIfrTG9d8rHb4beY3MngZKY5
         RfZWcO/Elx7Kc4MA4tKrzQMH6djn+yFQT5q85CMA2JSS6CdfLemccMaAUk34vtatYxVg
         5+HXd88MjKU2ytZUzTLGnhBrBJAM2Uv7DGcSDsnnCuqSSurcG15XVRNgRMkimDIMfTNS
         p/OA==
X-Gm-Message-State: ANoB5plin51DFxYKpl1PJz79nQI98MmFTcWwbjjLS9oGHBkT+47/Xmmv
        vl88eqIgo7hBlJ0ZrttT6qRh1Q==
X-Google-Smtp-Source: AA0mqf4ITJ/zq/QXos6q8t7wiTwkyykTspLsX8kURJcVbV6wRrgRL+pLuPL1gqJw44YPrazacqtxSw==
X-Received: by 2002:a05:600c:314a:b0:3cf:7dc1:f432 with SMTP id h10-20020a05600c314a00b003cf7dc1f432mr791063wmo.148.1668507536327;
        Tue, 15 Nov 2022 02:18:56 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id f7-20020adfe907000000b0023677081f3asm11717345wrm.42.2022.11.15.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:18:55 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:18:50 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     andrew@lunn.ch, calvin.johnson@oss.nxp.com, davem@davemloft.net,
        edumazet@google.com, hkallweit1@gmail.com,
        jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, lgirdwood@gmail.com, linux@armlinux.org.uk,
        pabeni@redhat.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 1/3] regulator: Add of_regulator_bulk_get_all
Message-ID: <Y3NnirK0bN71IgCo@Red>
References: <20221115073603.3425396-1-clabbe@baylibre.com>
 <20221115073603.3425396-2-clabbe@baylibre.com>
 <Y3Nj4pA2+WRFvSNd@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3Nj4pA2+WRFvSNd@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Nov 15, 2022 at 10:03:14AM +0000, Mark Brown a écrit :
> On Tue, Nov 15, 2022 at 07:36:01AM +0000, Corentin Labbe wrote:
> 
> > It work exactly like regulator_bulk_get() but instead of working on a
> > provided list of names, it seek all consumers properties matching
> > xxx-supply.
> 
> What's the use case - why would a device not know which supplies
> it requires?  This just looks like an invitation to badly written
> consumers TBH.

Hello

The device know which supply it have, but I found only this way to made all maintainers happy.
See https://lore.kernel.org/netdev/0518eef1-75a6-fbfe-96d8-bb1fc4e5178a@linaro.org/t/#m7a2e012f4c7c7058478811929774ab2af9bfcbf6

Regards
