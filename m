Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33E6D6300
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjDDNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjDDNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:34:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5D40CD;
        Tue,  4 Apr 2023 06:33:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so130713088edb.6;
        Tue, 04 Apr 2023 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvRrYX/VkYr2liqoThj7T0rsfgCC4S4xc3IvCNfR1Gw=;
        b=C0DT0hcyBMONZrAhs+SSbsdayCm5+Dl8sWjUyveyCgiGBXHX40yw2ouhhJDyA+2NFQ
         ubkrOyEKC6TFyGvs0mScw/RFO1yVHM+2IgaM3hFuTyEi5OblJ3iRbc9hthnTtVI2/uMi
         udW3fN6DOWGURfGTIeafAEVhcDwFoUVgZJGJ+7jsaZdRbeWRSBYvOvV8ZvWLmJPG4xtC
         cqoh3HyYwevl2GLJyV11e22TeBAIyEAY/60DU8tapE/cTNwVXYcYGVcFdTSkQmj9qFTO
         LKP3wRxxiekOGLKXH5FdfqGbTyxirH/jJiFcfZrlppETMpXCacFHtJJbfWmFsPSaG+3d
         Jriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvRrYX/VkYr2liqoThj7T0rsfgCC4S4xc3IvCNfR1Gw=;
        b=JtuU9uyiBGCq34PPerRpLenPvkcR7hrnub+7s5oiQ0coCrIu2cJ+0/MZRJ1SK4o6QF
         t+1RR2FhiIe6cW4nzMf01EDCib8FPXVbDMl9PtG9txW2FzU6cuzE+9YPCWxrRxR4OU1k
         U6OoR2Qy7bmiL5cbZ9OWqV+vovOrGGt0E9AjDagHXMGe1TZkXSnR5okn7SBdMTGSHtQp
         PmQ/zXxCb223MkWSyjagPz/b/o6W5VIoq7J5sBL4DL1w7g2HEhFCujs9SXe533C2V1rA
         AQK0Zy3sM73s0qpisw5OHBL/NBJICglQ7Lihn//QpWgd0pWiDLtkAX+WtE0t/uEcglIk
         1jPg==
X-Gm-Message-State: AAQBX9dH6oUsDmFaBADTS558fDS+Dy1h38/ERRUvFrAK7X13s2HAYJnU
        z5dIWpzqLFQuXUtiOyf4QC4=
X-Google-Smtp-Source: AKy350ajSVQWBzNirJ1Il5vAytxkgh6tu1ZpBDKEDVP5rxKwSHN/faQ4eWdFnWjfXpXhAOx51ewctA==
X-Received: by 2002:a17:906:2306:b0:92b:e3f0:275f with SMTP id l6-20020a170906230600b0092be3f0275fmr2364543eja.40.1680615199985;
        Tue, 04 Apr 2023 06:33:19 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b17-20020a170906491100b008e57b5e0ce9sm5921995ejq.108.2023.04.04.06.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:33:19 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 4/4] ARM: tegra30: peripherals: add 266.5MHz nodes
Date:   Tue,  4 Apr 2023 15:33:15 +0200
Message-Id: <168061516875.2141244.12474864091063517769.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090403.5274-5-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com> <20230329090403.5274-5-clamor95@gmail.com>
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

On Wed, 29 Mar 2023 12:04:03 +0300, Svyatoslav Ryhel wrote:
> LG Optimus Vu (p895) and Optimus 4X HD (p880) have 266.5MHz RAM
> clock and require this entry to work with it correctly.
> 
> 

Applied, thanks!

[4/4] ARM: tegra30: peripherals: add 266.5MHz nodes
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
