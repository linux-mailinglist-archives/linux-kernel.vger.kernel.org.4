Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492173BAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFWOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjFWOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:51:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB5E42;
        Fri, 23 Jun 2023 07:51:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3094910b150so801258f8f.0;
        Fri, 23 Jun 2023 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531908; x=1690123908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCBNoxP4YRkkVqNHoMdn3r7AEJ8awnU7MdKG7PvTSLY=;
        b=k7G4V2p2vjirSRWFhmCabdHIBO1ZySHwtJ1VeyemWWYdCw1IMquS51z2TtVIy2IJA1
         jZQjxfdYLJ1mVxXcxSnHWtzzVke5yzwTINIiqBszQxLnYGXFPRi8PTjftl0kLb8DNF1y
         6hPoXXp/bmBodE7Jj39sT2rdttUNtPvsB55ifzGh+u8X+Wy+c4YnmajvSwpQCUjhb79j
         xoHXGKrxYlIjrX0pap0S1FJB6uRXO0xnt4iwZ0AnKt46NjohNfnN34qHx/hRXEwMv8CW
         Fj/ZktgTG6HGtfiYrrdi31sgFdPb9iAtxDSlcoGf6ZjUqCdnNUu2vp1mdFbBMVMZIX4Z
         cQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531908; x=1690123908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCBNoxP4YRkkVqNHoMdn3r7AEJ8awnU7MdKG7PvTSLY=;
        b=bPJoA8ukyK8Ulkfjnw912HvFXIEUlBhGKrsHVcAab3KcuOvW4dROEDI9T1d36m+ueg
         YG87dSjP4EK7A5Z0BWDyF3J2Mq4m/Y2BpTEZluD+Vklc8WxQfWxVo7L91qJzOKsG6sVa
         Ahbq4Oaq7VEetbOj1fK2XQz8S6K9MBhQpuzOCw91p//9eA7xQx+kHXh0r1kmLrs1M8Lh
         8WB2zsVUSvQrUSI54AE7WvU/UXFtLsNgzaqyMDW+pT3ZTdRoScyBGrTk/UyvG+oGLn04
         JAuFpDfDkK6XqURW0cc92uVQSCd4JCxgsL7Sbjlkjv1oJYsXkRnxzNRkLgqAaB390qu8
         y9zw==
X-Gm-Message-State: AC+VfDxm0JrxE3Vg7Vp+ddIMw26dxMXX53R6VCQYUvjyKOOBgjntLbb7
        W3V5RAHjZ9w7HWB9uyWAGX0=
X-Google-Smtp-Source: ACHHUZ4RznTaUJsQG4MeWbsn9cfoWhsr9y6msDWfd0fBuzV+5soImwV6+HxOhnpXxlLR0872tAunQQ==
X-Received: by 2002:adf:e447:0:b0:307:88ff:ea26 with SMTP id t7-20020adfe447000000b0030788ffea26mr17985099wrm.25.1687531908030;
        Fri, 23 Jun 2023 07:51:48 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b00307acec258esm9828986wro.3.2023.06.23.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: clk: Use the devm_clk_get_prepared() helper function
Date:   Fri, 23 Jun 2023 16:51:31 +0200
Message-ID: <168753171948.1191890.9936900987085626404.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <9281571825c365c1591fcf31527d45ec576c19b4.1681635694.git.christophe.jaillet@wanadoo.fr>
References: <9281571825c365c1591fcf31527d45ec576c19b4.1681635694.git.christophe.jaillet@wanadoo.fr>
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


On Sun, 16 Apr 2023 11:02:13 +0200, Christophe JAILLET wrote:
> Use the devm_clk_get_prepared() helper function instead of hand-writing it.
> It saves some line of codes.
> 
> 

Applied, thanks!

[1/1] pwm: clk: Use the devm_clk_get_prepared() helper function
      commit: 2b8e30b1bd500df67554f1c183caf333de82f8d2

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
