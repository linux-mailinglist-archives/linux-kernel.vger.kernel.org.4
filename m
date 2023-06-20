Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778DB736C64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjFTMxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjFTMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:53:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C41BDC;
        Tue, 20 Jun 2023 05:53:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b512309c86so30599215ad.1;
        Tue, 20 Jun 2023 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687265599; x=1689857599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36Q0E79+X6bNneD5gDA+F7nctDYtSY+gSKV0kemn51w=;
        b=fu5MEH1juzIab4htZxTF4jmfIOzev/Wk1AQDudUjvTAaxDCXu4R9fps4Ylu7yZszyA
         iWQHscc3RanknU5P7ymBj5jhwQaZbP5wC3qjs4Er1cnu9pbFi3NSl09kCxQEKx7bx3Au
         wZVOUO3KKX8TMBMHfhQcORkkZtS3IJKPMrgMxip1d8mx7NINDyP4AOojWN2X+p73VOXX
         xAjwx03F1JFmHvk69Zy2w6xIqKIJ9XttW2CY3NKiTXdWzzYJgbLfiCKCDD0436XRfAww
         RJF7VkaVtboMWgjkI5+N4+d87+NBJHVF6XgD4yUPm7f0PSLN+dETpsZxc5e2Xya8STC+
         elvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687265599; x=1689857599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36Q0E79+X6bNneD5gDA+F7nctDYtSY+gSKV0kemn51w=;
        b=RJW8638y9T47saABuGTXnqcaRu10C32NWxSg0CI0WdeDthOapbQRA4FLVdlpq+YIae
         2wkg4IJPcTq3VLLz+jwN3esIB6wgLEyosGRgR9SPhyuWEgYJfw5OIIa6f1P/fvkYPUhv
         ZDWUWgSokBSLh6EXtcQ3uWIwWk3CfMVzgQLKT8+jvfyP0ntIUobefOjSMiyulKjAMymY
         5aL2VBdN2klkm/e5IBfZrY281FZhbe+bPM1gIfKwkMvD+S0DKtrc7Yn1c0Y8zPl6BFeI
         NghBbid8O1wwWUJvAHflgzAM+dDyG20He50nsHJFFyK8SeI6aQW/bxL5187h4l7tKT0N
         dH/Q==
X-Gm-Message-State: AC+VfDzfsmBQnzOUUqnSDwm+q2DoCXfirxxd2LrSzlSS/HGcB2U4P3gy
        bZmldyi64BjYkgMC8g+FX8VjsiywmuxZyXOkdNc=
X-Google-Smtp-Source: ACHHUZ45HBR/jH2rKbzPtvOEGIOCHKzNXTygBftC8iEHgmSOHjbE8WcXHXBXcZX+dWcu6pKcBVEumnrc2XLZcSmRuHM=
X-Received: by 2002:a17:902:e5c2:b0:1b5:5162:53bd with SMTP id
 u2-20020a170902e5c200b001b5516253bdmr11360352plf.33.1687265598786; Tue, 20
 Jun 2023 05:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230614134750.1056293-1-a1ba.omarov@gmail.com>
In-Reply-To: <20230614134750.1056293-1-a1ba.omarov@gmail.com>
From:   Alibek Omarov <a1ba.omarov@gmail.com>
Date:   Tue, 20 Jun 2023 15:53:07 +0300
Message-ID: <CAKyg=SXcZHf7=7-3fvXTp74FV6EDCDwUuk7J7sHSo=o==55-Zw@mail.gmail.com>
Subject: Re: [PATCH] clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz
To:     linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bump
