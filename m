Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA573BAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFWOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjFWOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:51:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101FD2;
        Fri, 23 Jun 2023 07:51:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9c532fa45so8296035e9.2;
        Fri, 23 Jun 2023 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531909; x=1690123909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhZSgj6bpUo/705/plmFjcm6PUsGWACkSEON4vQAII4=;
        b=rn1fual0Mz6TDpK+3vlaxFQtzuoeKXztrBpXY3wjAh+sHDrQ8xPI9QfS6voemk3Fwl
         UVU6yV0ZpCpr9TNFQ/C/lP+5MmCA1skGpE8lBwZBL2j5DjHT1HeWimUwNJms5Xq6ANwL
         9mKmwahi7YMaZx2M9bzmyfVC6mUn5rYhXZOK1w7Y+rLJeLCP+z7wuc5pnlGzfRaBHsm7
         0ILKr9qaBUsyt/oSK22ey8RzopMtW3qzv6epOhdrhDOYf0RZVivhERgl4M59mnD2LOHq
         iFv5g79lruagIKsDPvgvB+FqB+IDV+accT0vzfHAv+ieZoE93h+ze76L3t7eN7MII+JC
         p6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531909; x=1690123909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhZSgj6bpUo/705/plmFjcm6PUsGWACkSEON4vQAII4=;
        b=mBB1Sqr4xquEuugx1YQJV3QLXALE5mOKuWPkTyRNqwaiMIA47QZCZ8wuOAUKBjeWHR
         8PZr30OJA3seM5zOnh6RpsHX7Vnvk8cAeiQ8aIg1JqFt4EKvwBLTrac1tmJ/0ZgOhWff
         8y70MGRzHMEMzHupb8eyia4Y3KbEKbgFnNSySrdKOBBqKvuuDMoUPy29lUyM54+mhQHJ
         1fnhYcL4aPcqMH8rPZC5y+k6oHQN3K2HV7xUtqbWMPMr3epH+TPTI300HpJFLgoClQta
         7uArEspfbn/4/BsL916HcrewmqjZdu+g7wFUiUhOJeIsu65Pzxj7vhG8Rs6SjUSTcGeE
         judQ==
X-Gm-Message-State: AC+VfDxX0gOrKkiyL4W/jv/ZiL/12ICQVVj6A6bskBv0dcSpShjLqn73
        VsbEB5hdYpjkTMAU1ouBed0=
X-Google-Smtp-Source: ACHHUZ5B/eh6bQ1Zrp3umUoe7CU0DZsC4zBzCEUGrPSKaPyNWIHXvBnlhS7B3OlFNJbNgcGbQ1Ol0w==
X-Received: by 2002:adf:fc47:0:b0:30f:ca87:8e09 with SMTP id e7-20020adffc47000000b0030fca878e09mr3818910wrs.30.1687531909041;
        Fri, 23 Jun 2023 07:51:49 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d4283000000b00312780bedc3sm9691276wrq.56.2023.06.23.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:48 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v18 0/2] Microchip Soft IP corePWM driver
Date:   Fri, 23 Jun 2023 16:51:32 +0200
Message-ID: <168753171968.1191890.12812740879836968278.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230518-reactive-nursing-23b7fe093048@wendy>
References: <20230518-reactive-nursing-23b7fe093048@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 May 2023 13:29:19 +0100, Conor Dooley wrote:
> Another version, although a lot smaller of a range-diff than previously!
> All you get this time is the one change requested by Uwe on v17, along
> with a rebase on -rc1.
> 
> Thanks,
> Conor.
> 
> [...]

Applied, thanks!

[1/2] pwm: add microchip soft ip corePWM driver
      commit: 2bf7ecf7b4fffd87d8eb5c072395239d6ff54728
[2/2] MAINTAINERS: add pwm to PolarFire SoC entry
      commit: de0bb6a8883342c19a5d20f28d5430169f87373e

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
