Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20AC6AB8B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCFIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCFIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:43:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DA4688
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:43:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h14so7933825wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678092225;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZEJmZby2wtp2N/ubBCyHC+kgDBokSCAHmX4OKZIirk=;
        b=WPfJV8QUOFJvl3Hc2sJI436+4fZlyELC9lxav4xDCRrzwqw6bJIAy15vEd8ed4aC2g
         nUkftZtJAYGvoFUjsQlifxarTc06/hapOZIxCM1W+KhjL/hPicRfR94wRzrVKoc8uV6T
         VCV2v1o+qpckor9f4C4VaqZ2iMtMzCQ2dySiBto2ar7UtpCWThFbc/4E5yna7cfCQGHf
         /bWa5uvsv5ezSYs6aaThhc45rFz6LA97Oip+Mg+qazwrCvmQG9pawfKmmOF7Az14liJI
         ErKKYGoaMOvy+Vj7RT13BGVsM/6wrXK+JK4xT7nho8cD86S52MxVFoPXNFjVAV5P+kpl
         ++wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092225;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZEJmZby2wtp2N/ubBCyHC+kgDBokSCAHmX4OKZIirk=;
        b=5wg2Oaht38FG2E2aG80Q0dGjjBaoYMZ1TTF0p5M6fHNnqecspBvTdG4S9M4o1ZEoma
         uSq2HavKOdTSQvUtFEe3Q7Z0EWQKFHruWwuHPaqCGYGIzq7EPf2fDY/ZLXr5kNP+CRd2
         PJ1fGoZXWKWQix1BKVW+m7GuG7WPqvSYS/dLSmLD0pAIakRiK9y+6dZdawuWjBa7A+g7
         shKHdvf+2cTNyWm5YuHn33QzkP+Y74xBae0NzCSBh2fabjRkepgLFIQNUJx9R1hjMx35
         MBw+63GBV5+KUtBk1XXDw5Rppw8ZryyDdlV2pU0H00/a24xz0fK2J4erkx4QcXGLP5me
         nmXw==
X-Gm-Message-State: AO0yUKWaSROKRp03GSQFrN4/aDvSd0DikRjC7b+e3ABMz95R7HarWQte
        5GZXe/H2scH6hACdDZEcibzX1Q==
X-Google-Smtp-Source: AK7set/ZxD7wiI2b8xRTQAmyrmK9gEAwsitbyEhRqHPRzYROYUlP0inT+LCKU6Vm2ybtKZPkfTr8yQ==
X-Received: by 2002:a5d:4452:0:b0:2ca:ab68:eff3 with SMTP id x18-20020a5d4452000000b002caab68eff3mr6081160wrr.67.1678092225447;
        Mon, 06 Mar 2023 00:43:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d510b000000b002c55b0e6ef1sm9495632wrt.4.2023.03.06.00.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:43:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230303123312.155164-1-christianshewitt@gmail.com>
References: <20230303123312.155164-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2] drm/meson: fix 1px pink line on GXM when scaling
 video overlay
Message-Id: <167809222462.18238.7243626712537618474.b4-ty@linaro.org>
Date:   Mon, 06 Mar 2023 09:43:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 03 Mar 2023 12:33:12 +0000, Christian Hewitt wrote:
> Playing media with a resolution smaller than the crtc size requires the
> video overlay to be scaled for output and GXM boards display a 1px pink
> line on the bottom of the scaled overlay. Comparing with the downstream
> vendor driver revealed VPP_DUMMY_DATA not being set [0].
> 
> Setting VPP_DUMMY_DATA prevents the 1px pink line from being seen.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/meson: fix 1px pink line on GXM when scaling video overlay
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5c8cf1664f288098a971a1d1e65716a2b6a279e1

-- 
Neil

