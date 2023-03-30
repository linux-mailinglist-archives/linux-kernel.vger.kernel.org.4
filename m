Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47646CF9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC3Dui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC3Du3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:50:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBCC4EFC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:50:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso20748636pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680148223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wIVvQtQ08+FVB3HGLgmbrB6tpQAlVSF3Q+hrEVxEwI=;
        b=YMrzUH7rMqsk2Up5hh+tIWNrKWgJ09TihZq20qz7HzyjHnxggL3oUgZwjXqHSWH0QN
         tYfwNhVOf1ZS+iuj6L5kZmIggV94/BjBmC6/9IIzwMNA5fd4AEWMmIERa/DwuUFFGM6+
         Z1soQolxg+mo7ssaruZd6bEp+dgS5CPO8ljj8YTG/hwOm2EIA3OpCTmoS4iyHWJnlZeq
         W61nWDQ73daylvIQtvtxWqSFJDHSBj8+ht2yUgjQyazRvbIh3YnAEIlrGpRrq/bbL8WU
         2JCHuotqwHb9LM787UoVI46joOAKNUoMZaWkW6LHeg6SHhAyU+EaPgXrzrUwfZBPTwu+
         SeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wIVvQtQ08+FVB3HGLgmbrB6tpQAlVSF3Q+hrEVxEwI=;
        b=tCMzNT2I6nx8KrhsfFx3urBNeSHnMzS4uaoyilIgRQ7OcFq82cuWDUO4XVvIuP7LHm
         f+nMRTsn8mMBEWgtMjVrmydbl3/0EZJPV0fxXBZXq29OKykMQ+rv6Rmja2ZsE0SYmlBV
         scPRlZUdLkVdOnwLrB2aqTqlO3hY8L4olh7c3lNY/llDwIL+NvE08DNaISIXDs2+nmza
         9deG7SzGcadWlxLAaCuNjj56hnkOXy3PX9X2QMbAnWAtWlwblx+Li/i5LXb2JeUDJYi4
         Fj0g1WGWnrch0EUby7D8LtQv62G29XFeEGQDksH0YyXEtvD43mH4OIzuAs1TG7Kg7A+4
         SYNA==
X-Gm-Message-State: AAQBX9f0SBTMfldezipRBoET+693wQHzLTD2ZkM157q6HWTeExybHVGY
        nPBXzYgKxEb29R6A4fIFx0FC7w==
X-Google-Smtp-Source: AKy350aTCyMrKSx/cz5S2VoYDvkCUgu5K7A2N8Pm0iKJMr2eouVILR1PVbIXGBRLTJ279qHhz8eGQw==
X-Received: by 2002:a17:90a:31c:b0:233:f394:d83 with SMTP id 28-20020a17090a031c00b00233f3940d83mr21464512pje.48.1680148223614;
        Wed, 29 Mar 2023 20:50:23 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id cu12-20020a17090afa8c00b0023086d280c5sm2191677pjb.3.2023.03.29.20.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:50:23 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:20:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com, Nick Hainke <vincent@systemli.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 0/4] Enhance mediatek-cpufreq robustness
Message-ID: <20230330035020.3dctfdlnnk2cvxzr@vireshk-i7>
References: <20230324101130.14053-1-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324101130.14053-1-jia-wei.chang@mediatek.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-23, 18:11, jia-wei.chang wrote:
> From: "Jia-Wei Chang" <jia-wei.chang@mediatek.com>
> 
> MediaTek cpufreq driver has some reported problems required to be fixed.
> 
> Change since v1:
> - Fix error handling in patch [2/3] in a way of "Free the Last Thing
>   Style". Refine its commit message tag.
> - Remove the change for MT7622/7623 platform data in the patch [3/3].
> - Add the patch for MT7622/7623 platform data [1] in this series.
> [1]: Message ID: 20221202095227.167492-1-angelogioacchino.delregno@collabora.com/
> 
> Tested on:
> MT8186 Platform (kernel v5.15)

Applied. Thanks.

-- 
viresh
