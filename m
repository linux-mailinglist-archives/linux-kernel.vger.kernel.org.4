Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E8C60E165
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiJZNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiJZNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:02:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FC3F984A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:02:19 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j130so18709675ybj.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4glVzmWsTbBlCQmTnSNI123LuVL+ieI4yytV81hjliI=;
        b=Oot5BrIF853TW65wZY1ze+RZRzXtGQpd3nFZPzVZfZQe9HC2K+KdVB467TVUjtYvka
         KCFDSQXooBqHARrvM+AeFu2L+hCxBdiXUx5vXmsdiQyQsZYYp9RwZFkvIMEOcFF/V2WL
         njyS+YjN2MqQgoZ8sm4jdIvJy8Bcsm3ZHAfpgjivgi9TirYHAi2Lgl+P2uw/e81O5lBz
         tELCsbpw3TXe04r65ftHb1r5f841Pf6eQhrsCoZtQr3pDaOnvCzDQFb+0Tb4pe6uX0k2
         PM1qAL0wZAMSezPxagjErjlcZxIg6s3ImDh1V6z8PwbE6UAJiI8wMqQRF+ALQJuYsNwP
         Tk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4glVzmWsTbBlCQmTnSNI123LuVL+ieI4yytV81hjliI=;
        b=JtGBQ/rK5NL36bb3b1N1bXgs1de/rPKsRqgo+mZtOQWBHAXrVud531gAuc8wDfdsyL
         pqMWpa91E1NgkxJ3dsyzbIHZ2xS/8H2egrFxfiPAs3DL4f8xE93h4rh8hg7RMvMqDRTo
         2k3a8Qu63UXqfiQxJ4TaV6J6n/FUnBiJNSAl0Rg3vRazi+bnu09gYmB4yo0RE0OGZRdd
         Q+MxOEC9OrfMyCYLgcKJp6afVPG8C+IgnqNmxXcG/wXDnugXQjxrs2fLCqn5hshDK0+e
         782CJia2W76huRUCgiDkZRzXy/ikt+0WNcQEBCuEHMdtVE/JZcdCyJzUD1jfuKS+zl7Z
         jCwQ==
X-Gm-Message-State: ACrzQf1s3+aRbBcGIM0sQScUHLsVnkiFlpZAHilt6dDW9nxfs7TvjHkI
        7IEtn5hDFkhn9JTLEk5zMvj2OG9QbP2NH0e+mPc=
X-Google-Smtp-Source: AMsMyM6qlz1dbMzPR1SAfePuUVwC4H/jq2ipBZgH0seGZQdGDKasj8QxPBivL0DK4NjUYtQQFygciaR3L8cvdUf+ssQ=
X-Received: by 2002:a25:5f07:0:b0:6cb:70a7:359e with SMTP id
 t7-20020a255f07000000b006cb70a7359emr7895526ybb.110.1666789338724; Wed, 26
 Oct 2022 06:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221026083950.3712598-1-nunes.erico@gmail.com> <20221026093604.nuielehywjtxe2mn@vireshk-i7>
In-Reply-To: <20221026093604.nuielehywjtxe2mn@vireshk-i7>
From:   Erico Nunes <nunes.erico@gmail.com>
Date:   Wed, 26 Oct 2022 15:02:06 +0200
Message-ID: <CAK4VdL1HxrZmhsXg8JjsN=BYSYJawWxoyTu7gpaFyU9d7L-chw@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Fix dev_pm_opp_set_config in case of missing regulator
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 26, 2022 at 11:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> You can directly call devm_pm_opp_set_clkname() and
> devm_pm_opp_set_regulators(), like it was done before my patch, for
> single configurations. So basically a simple revert of my commit, with
> additional comments you added above.

Ok, I'll send a v2 with that.

Thanks

Erico
