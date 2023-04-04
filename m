Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFADF6D6888
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjDDQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjDDQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:12:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD51708;
        Tue,  4 Apr 2023 09:12:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so132787078edc.3;
        Tue, 04 Apr 2023 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680624751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEde4dazqs8JsdpTq9e976ZMwIeqbEXbVwUyENJtDV0=;
        b=Z/iFB9SXOwMEOpCmleolmC6l2LhvyD3XMh7WKOQsjMrvrxUfm8ennXwNohnigYv577
         B0hcxCfK9O73k2WCkdVlygKAlqYEEo72A8k1oNl+MsgsyTJGhgafCec/5kegRzRVLQXT
         OCOfvy9H+0BPY68owun4pHVK1Y2z87oAUDjbO42Onc2uTvHyqB3Pk9lYHWCIitiB3L+W
         6O1IIhVrJUlTQOnrp6Z+7/NZyyt//bCrMkRfulIemxRMeROJ6K/RYHwuMY84B7/V8FIH
         Esd2Q2uWSlAzo36yuNwBvSFHrCTIQzFqztfrFUU82/mwACajVe92PJiD1PZ2RvDi8R/9
         F1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680624751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEde4dazqs8JsdpTq9e976ZMwIeqbEXbVwUyENJtDV0=;
        b=iUBMRAh5T6utDDl3ynVEUZS5TlACSz+LAp/hUUQOY1NdPj3zDYd7Tl4pitG0RVdmbb
         odyytsm6k/AIscy3PZw+IqHlI4wgqZ6G+x/QHH7ez8isjXr2bZLoe3a4Lv9Z8weCoDXN
         T8dBjNK0i1UcxfJJr+fm46cTCFV4ENzTLkJAVbKYaYbrA7OnbEoiOoh2N3TBzLZh5foS
         fzlrY0evkpyacz44ssRNQ+ODR4WxEYZmkcDvDK2tT2eUdnnI7GzKKG9KaFNvRlXmVNti
         3juFPztn2M48Ej/kVdhEjT9C2G8aLPudKYUeWmmGevG3Up+l14Tdr6nBVkz7rigs2AOZ
         VVqQ==
X-Gm-Message-State: AAQBX9dfd8BN4MN2pI84OYq7OJhZQWlZEuBPlQI6zogVbAVh0jYOgFbu
        aC2nMpFBhiM/foUcUbXy5Dc=
X-Google-Smtp-Source: AKy350Y7Q1EvlaIMvcDZzEKWbHr8fByK3cVf/k9Wwlk6Un7sG8GyowpBQ8MoX8kuqDf1J9EYnHhtUg==
X-Received: by 2002:a17:906:c217:b0:92d:9767:8e0a with SMTP id d23-20020a170906c21700b0092d97678e0amr102818ejz.13.1680624751436;
        Tue, 04 Apr 2023 09:12:31 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id jo25-20020a170906f6d900b0093408d33875sm6126508ejb.49.2023.04.04.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:12:31 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     oder_chiou@realtek.com, thierry.reding@gmail.com,
        Sameer Pujar <spujar@nvidia.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        broonie@kernel.org, jonathanh@nvidia.com
Cc:     kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, tiwai@suse.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: tegra: Audio codec support on Jetson AGX Orin
Date:   Tue,  4 Apr 2023 18:12:30 +0200
Message-Id: <168062474005.2644933.17495662209402914912.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <1676263474-13346-1-git-send-email-spujar@nvidia.com>
References: <1676263474-13346-1-git-send-email-spujar@nvidia.com>
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

On Mon, 13 Feb 2023 10:14:34 +0530, Sameer Pujar wrote:
> Jetson AGX Orin has onboard RT5640 audio codec. This patch adds the
> codec device node and the bindings to I2S1 interface.
> 
> 

Applied, thanks!

[1/1] arm64: tegra: Audio codec support on Jetson AGX Orin
      commit: b903a6c5aaa862f8b88f4be4431ccca3b6fbc187

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
