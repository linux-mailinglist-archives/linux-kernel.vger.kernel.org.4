Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2522C681546
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjA3Pkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjA3Pkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:40:35 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22203EC5D;
        Mon, 30 Jan 2023 07:40:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v10so11325622edi.8;
        Mon, 30 Jan 2023 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieB4CoNGYjKWy78CD6Pc+1g7A4ZX0370ZESWNzfeqmU=;
        b=UmIXA6754haNxru0w2S0/+1sbIVJyzMp4CtMoMyWnZJ0SM0BbgjDnVr3lt1wfvEIp4
         ebac/X7PeMoyquIkWB91h2ulrzVZq5UuS4PfNFHyBkRlcN8IGs4fhZlfCsoUlUDDAVOV
         goFISaWPJWK1B7z3KS7ajSth7Pgm1vYukIBFGHWQ9zvwdSt3iTqo9+3wa5GDqgVyO/YX
         k4kgaBziL24w92FiqkBpFVFJ/jZZUCNQCPdzFa72A/n0Lki8fPqlN/VRJIB5JejA0uRF
         vsW7SyL5EYfUvShNCtV4ucniC+pze/OvkoDLRsBRzDIcd+SUlLjjyJYSdy2oMyA9XFz+
         tRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieB4CoNGYjKWy78CD6Pc+1g7A4ZX0370ZESWNzfeqmU=;
        b=Ggb0fxET3e7Kj2fy27MpaetNqidgdUZkK3kUtUUMdE7R7qERXfnmF2dgr879c6DyGp
         MUNoz2Kk17l6r/QJgjs1m8b9ORJqGQyCyGv4ad3oDS8vYT/t1tYC63aTA6AevHNfpHOQ
         3tJwGJQpa18O95nO26ybEUQXVnFu5lYX39yqgw3i7YdVzChJ3xOQCRaqaTAAmWSpWmSV
         8AGmuk8M5C8OjGXSomL0eGAdt+Zd+hrsTuZqUQsCgH9EuCpBOLVXaxH751Tkx1R9G3+Y
         ESE44e+OzmnXzrSHH76kfN04XuR0nkTDCcIu/rZB8rsfEutrV60L0u8qwp8ya8/fVwcS
         e4vg==
X-Gm-Message-State: AFqh2kq4iHnaoGZX9eiY5XT27p364AtodeSz/n0bJHGF6vghPNKl6D5d
        hvJ64eyGfHSVaKo18m79nK4/+NVncwA=
X-Google-Smtp-Source: AMrXdXubEyEeXpd07VlPWf/PBF8CJ8lChLmPBKvHpFYug52MKwyhhWBZ5Fm/Wub5ZPlr4izqC0ZL6A==
X-Received: by 2002:a05:6402:10c9:b0:49d:a87f:ba78 with SMTP id p9-20020a05640210c900b0049da87fba78mr51507740edu.35.1675093222203;
        Mon, 30 Jan 2023 07:40:22 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id er12-20020a056402448c00b0049668426aa6sm6874326edb.24.2023.01.30.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:40:21 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Move pwm_capture() dummy to restore order
Date:   Mon, 30 Jan 2023 16:40:21 +0100
Message-Id: <167509309545.579973.439111499636077734.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <96b39e1fe0e0c239d56ce321ccbf62cd38133803.1669047294.git.geert+renesas@glider.be>
References: <96b39e1fe0e0c239d56ce321ccbf62cd38133803.1669047294.git.geert+renesas@glider.be>
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

On Mon, 21 Nov 2022 17:15:41 +0100, Geert Uytterhoeven wrote:
> Move the dummy pwm_capture(), to make the declaration order of all
> dummies to match the declaration order of the real functions.
> 
> 

Applied, thanks!

[1/1] pwm: Move pwm_capture() dummy to restore order
      commit: ac7b40c554d3683693ca9d1b49708a8888c4f6ad

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
