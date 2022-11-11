Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4283625D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiKKOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiKKOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:30:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3639C14;
        Fri, 11 Nov 2022 06:30:13 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n12so12885564eja.11;
        Fri, 11 Nov 2022 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Koh+dwqZBBf1jlPSzVX0j36YcM7HA7J6ZE4x6mmkVqY=;
        b=BqyOLgVvW1T68MtJxqWJdNcg1P91Dx51CO+9dOyxUd2aYLDziwHjcO2zMnUIHCzqqX
         rhPctuUTkk4xUHR7Lr8nmMfpRMtqHk+VcETg2WyDZNU4lWnwRohx08WPWch+lrYmMOEt
         RVn+NQkQfeum4/VYuCk/CuAg5eIXiJOEX1xqBDxnxTksAuybAhl5IRvL9ie1VctDesqx
         cJDY/AbX1mbhXLrnnPxMipHvqElcV0TGof19vuskFJ28QZDd0bWLOfCza96Q/qN3YkRC
         adRHxDrWGd5HJu0SzieR1+WYe0IMhgMhyfGQwFpUzNt/V8IUWip+JYgJlJwspCDybWXW
         QIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Koh+dwqZBBf1jlPSzVX0j36YcM7HA7J6ZE4x6mmkVqY=;
        b=DYHWu+cVqbfKMVPknNW3kF0vG966yyblZ7FJi7dIjEy+jyB9YlTRImBYXJO6ESottx
         XMlfUk8x0jDOpCYC8jh6pb8EcmaUx737EGIjWQ+uRS31Lc6i99kAhF4CAngbvFx0MUIF
         QZS0Jl8eg4+jIpyctNrVTZfTHHMx+XXagDX5pFbUz6YRpt3ATjGqJpvzSUGWsjDH49AP
         gsX9Lutiq37DpyiGrlQnYwKzrlSQaccCqE2rCrNQb75SBVO9M7Bl41EeICQfg+1rpBgo
         AiwHqllTHLlCGoxobVAgdqF7ykvP+zuNNfkwwvWM98FHkfJ/fWje0+YZenoI9G16TunE
         Iflg==
X-Gm-Message-State: ANoB5pmuk9mFzL9V4UEyeHLZIpAf6YS6KRT3tAj1cgehWkX6zp8VzzPr
        bcw5QKGfLO8lhUS6g51g1Vqnw75Qwlc=
X-Google-Smtp-Source: AA0mqf76HHd4OS1zIfY7lGecxmJawgOec5QGdP+21KJZOhjP/mKmQxkvRVHF+NYHLxe1xLLHO2b1Qg==
X-Received: by 2002:a17:906:5053:b0:7ad:f5a9:ece3 with SMTP id e19-20020a170906505300b007adf5a9ece3mr2005755ejk.635.1668177012323;
        Fri, 11 Nov 2022 06:30:12 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00779cde476e4sm934157ejc.62.2022.11.11.06.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:30:11 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Price <steven.price@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: tegra: Fix 32 bit build
Date:   Fri, 11 Nov 2022 15:30:10 +0100
Message-Id: <166817672258.517436.2580485516581625175.b4-ty@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110114549.34121-1-steven.price@arm.com>
References: <20221110114549.34121-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Thu, 10 Nov 2022 11:45:48 +0000, Steven Price wrote:
> The value of NSEC_PER_SEC << PWM_DUTY_WIDTH doesn't fix within a 32 bit
> integer causing a build warning/error (and the value truncated):
> 
>   drivers/pwm/pwm-tegra.c: In function ‘tegra_pwm_config’:
>   drivers/pwm/pwm-tegra.c:148:53: error: result of ‘1000000000 << 8’ requires 39 bits to represent, but ‘long int’ only has 32 bits [-Werror=shift-overflow=]
>     148 |   required_clk_rate = DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
>         |                                                     ^~
> 
> [...]

Applied, thanks!

[1/1] pwm: tegra: Fix 32 bit build
      commit: dd1f1da4ada5d8ac774c2ebe97230637820b3323

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
