Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC356D9A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjDFOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjDFOfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:35:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13298BDFA;
        Thu,  6 Apr 2023 07:33:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l17so1888579ejp.8;
        Thu, 06 Apr 2023 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680791532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NE8LMgRiCIjdbrcrGLtDoTN1MqhIW5n6uRWWiPsxx4=;
        b=oAd5hS+uRxlGo7MKVZnAUSQOTtoHWyyYHm/pXDAeI1Tte1vDy7MsgcdQUJBu/ktkiP
         ATEb4RwFRMmLuuWS81gHkksVF7ssGCX2xxbU0LcpZW3jOFY2hDJ1a670yuA+wLlXW/vn
         EegRngxc4WMbelYLWXk5az66RxHtSgdvfmcMPkw1K7spAnbuUWljjdfgiukj23Ru0LzI
         75VJbAu1hzZdZxJKb4l82gAhxT2ref9iXmThsgD6GlFgIsX05mSAY9b0VrNKVGArkO1k
         /7bb+P0eBNGuqgVBOxA8cBVDy2rYH+ZAFu5L9aE4gDHvPP7BUYGcrlDKZPYF78dPKbUK
         KpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NE8LMgRiCIjdbrcrGLtDoTN1MqhIW5n6uRWWiPsxx4=;
        b=W6yo+VRncEW0OrldOnyZjLCjIVv5qkNx9IclDCsQI3drmW7mfkuBdTwXccXi/R2aCK
         xvc1g3yEEem7Hw8zD4EjI40CQDGYU78tv0uqxGFeuONf67gHhfz0Yi6Nyt1sSjEBRjaZ
         Pg4DcTa81uVBPtq9JZj1NOwhucZJKpfHZaU80tUTNmdylSJEjNd4FIwGkYBHwQO3ZYUi
         VWQWw1ClESIyoEBwPPqXGoPDP92GZJ+O67GQarsONi+u6ctx6R+SeQOz2QvK/gl9T/on
         zMcTAvaW7HMK7t6U2vGt7WFgO/qH7DzqdtRTHFnJuNZAJDS/I2vrNtynhkYZHY/yR0Xy
         sTeg==
X-Gm-Message-State: AAQBX9eh8Qalsg9i1385pqNvrJ/EKfd3IzOKzSZYmwP33SaUqDD4f3fO
        czn0a0VI3e8mIQ6u18a7Mv0=
X-Google-Smtp-Source: AKy350bgjv21uhcf1/rq5AbSVXwcWWjZ656MGCrxpKOpbqsIx2AfWLsFXOcTOvV+HGXBkw3mMWKAuA==
X-Received: by 2002:a17:906:2acf:b0:948:b667:e984 with SMTP id m15-20020a1709062acf00b00948b667e984mr6508084eje.27.1680791532591;
        Thu, 06 Apr 2023 07:32:12 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004fa012332ecsm846250edf.1.2023.04.06.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:32:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        - <asahi@lists.linux.dev>, Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sasha Finkelstein <7d578vix8hzw@opayq.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v9 0/5] PWM and keyboard backlight driver for ARM Macs
Date:   Thu,  6 Apr 2023 16:32:11 +0200
Message-Id: <168079151921.2015855.16317182688660324415.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230214-fpwm-v9-0-f3094107b16b@gmail.com>
References: <20230214-fpwm-v9-0-f3094107b16b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:19:18 +0200, Sasha Finkelstein wrote:
> This is the v9 of the patch series to add PWM and keyboard
> backlight driver for ARM macs.
> 
> Changes in v1:
> Addressing the review comments.
> 
> Changes in v2:
> Added the reviewed-by and acked-by tags.
> Addressing a review comment.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: pwm: Add Apple PWM controller
      commit: 87a3a3929c710b863c3a288f6b094edc97662858
[2/5] pwm: Add Apple PWM controller
      commit: bafbbef85fd788074c27892c2391faf249eb7b29
[5/5] MAINTAINERS: Add entries for Apple PWM driver
      commit: de614ac31955fe20f71021fd5f4a9a811e90028f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
