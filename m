Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA606D6303
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjDDNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjDDNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:34:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F410F6;
        Tue,  4 Apr 2023 06:33:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b20so130696074edd.1;
        Tue, 04 Apr 2023 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xyR+ozpTB5/iQfgvMX/uKm9RQHaWxYMiU1fqoI1pJo=;
        b=g9lfSJBGwiWbr5ltzY9QQoks7ZXDckpBe3DvgJyuydIX9hxdm86VSH9zEHJw/iKPFV
         E7Wv5Kv8PxMO/3vJv+SbUnQT4KHk5IdjKy/s0i98azoZQjprwLEUHEMwqZ/GLPLG72Ua
         2TpzohTFy6yDqjTai7OimoWyYqWB+hKY36jX/6RqAA53pZz+cH69XKuRGRt+of6QKMO3
         ZOSNCQ2lSWw8DS+bk7WOHu1nXip1U+nrE76z5iG8ZQSrg8DVRNmIRxtT2tiPtKso/1Kc
         kSOUsP5rc8nlhEkvfpWh6G2hGbU8GwR2r8USPHkvwCBsMWUmFT/Ye4YLocL3e9bNDuUR
         9hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xyR+ozpTB5/iQfgvMX/uKm9RQHaWxYMiU1fqoI1pJo=;
        b=v+hkAmCd6fK/FWjC3n65+cFwgzAur3vtrbtId7BxV5HmSQFxgQPOP9HK4UaNeuL5ks
         K8xa1QIMc9rZe7hn/RTYaE3rHMDkDAGH7H2I8teOS0TZNUqqrrT9FpzgRIC21/t2NFQc
         zn829pgToChHXGKnH/A7WrzhG+yrcCJvCmUNz0btS8O9lsRCVXRpalJhzIVylGpFjo7r
         1NSxRiRlHLwQV/mmfaKsq1e66XKkZLzIDkGxQFX4bsCpwczT5Eq26twTaf57B5GisuQo
         aLgkItDwZcj/pfV9pkutoH5jf5hyeREptdjr7r3+7yaTr0ZL1HwO/zcTphQSms5fWSOH
         g9Iw==
X-Gm-Message-State: AAQBX9c7vDezh1Ca92ZdibgpcL4gnHdPvz9dd4xcg8yIygNJDe4VGQWY
        NWBWsMPtHNlqaRmCMSGNbPA=
X-Google-Smtp-Source: AKy350aviwL4P0cl4+jyR7NnaUVNJR4d1HiM0lorj4WDDx8PIdvhDABL/nihwzoBtes3FDtbsOTAOg==
X-Received: by 2002:a17:906:29d8:b0:92f:fc08:bb0a with SMTP id y24-20020a17090629d800b0092ffc08bb0amr1972934eje.37.1680615199160;
        Tue, 04 Apr 2023 06:33:19 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906328f00b0093e6f40d124sm5951359ejw.139.2023.04.04.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:33:18 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 3/4] ARM: tegra: asus-tf101: fix accelerometer mount matrix
Date:   Tue,  4 Apr 2023 15:33:14 +0200
Message-Id: <168061516874.2141244.5101735402055798162.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090403.5274-4-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com> <20230329090403.5274-4-clamor95@gmail.com>
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

From: Thierry Reding <treding@nvidia.com>

On Wed, 29 Mar 2023 12:04:02 +0300, Svyatoslav Ryhel wrote:
> Accelerometer mount matrix used in tf101 downstream is inverted.
> This new matrix was generated on actual device using calibration
> script, like on other transformers.
> 
> 

Applied, thanks!

[3/4] ARM: tegra: asus-tf101: fix accelerometer mount matrix
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
