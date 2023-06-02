Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7749F7203B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjFBNtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:49:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F31137
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:49:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so1372274f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685713759; x=1688305759;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pq/KH2F2S+w1oE3jYRiu2cFEHPIXuQlNq6CCdo5FOk=;
        b=kU6acM8X6Tz+kZf8Z5QBtw7Nd3ZJo2ToZk9x/PnhRsgMiQUMpiVNX2NHtG1Eb2zPm5
         dznqBfagyg34NArpNoM0cIp6xZwWNM9+SDCRozE4oPxjmIWIULzQJfN+uvE+0j9H3Oa5
         dAefSnUlQP/fCUF6/8V4tom9UqjxVNZ3OE1QWvlcJBuACl/acQ9NvTXocu198gyrGGOc
         /hL0Cy9zfxzv+iRMv5TR0qKk82JKxhXmxgM5KC/fpU6kN3+CKo8xKe5RsX3YVwjDbaJw
         2MDbktIQLicvD44aWX2+42ssyP6RwGJfZrKaWL8ZwCJ0LoDFx9nG51dmkUEN8ELNDBYH
         HAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685713759; x=1688305759;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Pq/KH2F2S+w1oE3jYRiu2cFEHPIXuQlNq6CCdo5FOk=;
        b=h0yvjyWdXfpOaaP+NSledgV15CB73w3Rl/HbaalB2XurQLf6Xq0ixUWJGBo+BDQ7E6
         W0Ie2AIMXU1itg4dO8o7fvdxCziFW16a4FDm/2ozpJrVHQ7zXLQ5OZXu5gGklPK6hjo1
         SL6EvcU+2nUsU+uBn913hQGYLHoPhF1fow/ODMpY6uL1CaNrEbdL/jYN3UKUfa+AmykH
         bmfc0x1TVv/fSx1EUhkzBOFzPHR55sy2nB6BISlrFMymkb9dujZQPkLMq7PeVTyoPbEn
         ZeVXcOxTJjd84mCCt6H3JsCPuwHVjofHLuLJMDkgMJJSlfC0JwjZ1DgSG46hJVfi8FJI
         Ut3A==
X-Gm-Message-State: AC+VfDwDPeDudXiW54tfBi4nF4ZO8HOd1UrYOBmj0N+WThFLD3Cc3dte
        drSS0EZoaYTUFxcIsfGMYmHCZg==
X-Google-Smtp-Source: ACHHUZ6Zq2TOiy6uzLCbEig47MxxY+DF5YJCX+nMxWxA5e73/7Nav1yyhAsRqrimhfGNdxIeIBB1tA==
X-Received: by 2002:adf:f14c:0:b0:30a:eee6:60a5 with SMTP id y12-20020adff14c000000b0030aeee660a5mr29306wro.43.1685713758781;
        Fri, 02 Jun 2023 06:49:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6786000000b003078cd719ffsm1752941wru.95.2023.06.02.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:49:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tom Rix <trix@redhat.com>, Carlo Caione <ccaione@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230602124539.894888-1-arnd@kernel.org>
References: <20230602124539.894888-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/meson: venc: include linux/bitfield.h
Message-Id: <168571375798.833434.11400829507182378408.b4-ty@linaro.org>
Date:   Fri, 02 Jun 2023 15:49:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 02 Jun 2023 14:45:24 +0200, Arnd Bergmann wrote:
> Without this header, the use of FIELD_PREP() can cause a build failure:
> 
> drivers/gpu/drm/meson/meson_venc.c: In function 'meson_encl_set_gamma_table':
> drivers/gpu/drm/meson/meson_venc.c:1595:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/meson: venc: include linux/bitfield.h
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=664dba662cb313da9cbb1c944c472638a65c552e

-- 
Neil

