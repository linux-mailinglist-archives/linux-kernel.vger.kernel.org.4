Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069F688FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjBCGsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBCGsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:48:31 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F6726B9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:48:23 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id k6so4428735vsk.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 22:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOZM23/1S7CSy+q5eLPYC0k+K4EbQYTOVhbDtucSWfM=;
        b=LiP66aSOWqDz/lsmy3FBtArCy252DrCVwRjht+3hFGLHIkDLRMIyomYfBZAYIoXqBs
         xIUYGAErxGzzf9DMiwBtyfLsIBSWZqHJLhNFpUg54R2e6xFEiyVltZyM/x620nbV+LkE
         /pH20N3QvW2bMMkz03uWkzZPcOUJ0TOATiTYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOZM23/1S7CSy+q5eLPYC0k+K4EbQYTOVhbDtucSWfM=;
        b=mIRLgKOIw7x2Kkl10qsRquevaodiqmj2koxTJBHxREuS9FjzPFLroY/0vXYKNP/l6/
         cW3MUx0Ga34GDM60JodZCg8I/3UE8SIQduYPbreBkdoW4XFs/uL6lGgbpFWrSN03v9GE
         pMX+G9k0ltk6f4e47xD9ODJIg/dJUfH+dnAn38zfy9qW0h7BK8R8EmCV0aQjGUbijO5I
         vLJImmOgCOXm6LqV0rb3uxxT5xLci2zq5ga9LG96/095sLaakh3kPzdh40ic7bhYvHii
         YxEMOb2QYuclsxX/jl5v9xUeRlmRFA7P69DWpe+8MtVTwOop9VZJHI00f694VhFjR5Nv
         wCIQ==
X-Gm-Message-State: AO0yUKV2dh18/ko++nHzC5mWf29egjPmxD5Hl0FXD2aMDka1UW/sue/K
        wY2kIYnr7h7Vhenn7+O5JhUbVVgbIyoAe5LfJxRkJg==
X-Google-Smtp-Source: AK7set8EbtIiJP5eoXyubQfcVDaNwVo8erq5xWSisdXu007fPae2bmld9wOxBu+g1ovX9YXJEqaHQ5n31c2NLBL8a1w=
X-Received: by 2002:a67:d21a:0:b0:3ed:2cd6:deed with SMTP id
 y26-20020a67d21a000000b003ed2cd6deedmr1757642vsi.65.1675406902737; Thu, 02
 Feb 2023 22:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20230119124848.26364-1-Garmin.Chang@mediatek.com> <20230119124848.26364-6-Garmin.Chang@mediatek.com>
In-Reply-To: <20230119124848.26364-6-Garmin.Chang@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 3 Feb 2023 14:48:11 +0800
Message-ID: <CAGXv+5GFuog-E-1o2qYKFkvC0XnDvYU_fA+BxvaFLGv=_Y=JkQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/19] clk: mediatek: Add MT8188 infrastructure clock support
To:     "Garmin.Chang" <Garmin.Chang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 8:51 PM Garmin.Chang <Garmin.Chang@mediatek.com> wrote:
>
> Add MT8188 infrastructure clock controller which provides
> clock gate control for basic IP like pwm, uart, spi and so on.
>
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
