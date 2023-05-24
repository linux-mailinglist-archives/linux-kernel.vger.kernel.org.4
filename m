Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B170F366
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjEXJsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjEXJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:48:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB69E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:48:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso6817635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684921715; x=1687513715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8l4VvjVr94dZvrHGrr+e0WzgjbnJVVHX2dBYB3myQU=;
        b=TI3rCsYo2SNzhf5zQfmZSRtYeNc8hUycL+Z4AvQVV8sW/Al2OnQLdnPrx/QxQlRSyJ
         /cgF15H0vt2fqgiB0apLuzvj1YjFtbQhdaFJGfQzrKotWJ0G897+K0O8zvDhF/9PNw81
         4+J1wgyQQJJL1A5hafGylJaGRkNjkxfEvUYC3uX+ixSPK4F6JGqZV/97nUd/v0lrn5m2
         5FGBqOiEGLxvO8K2QWxixuSdsmjo8FAYS97QvHlEpuniHFjtYLeHg2EsXUB988zpfkZ8
         OjYtzDOu89NghcIDpRFFdM4qS+iZEmlowN7Ei8I4Bb8G5aUWWa/PjTcBoEnUMLw7Nk7m
         hzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684921715; x=1687513715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8l4VvjVr94dZvrHGrr+e0WzgjbnJVVHX2dBYB3myQU=;
        b=dr9i2WTz74mRrhBbg4uq73j+Yh6x3fS+Vqs0NAzddftDSngHfiHQUTdTcIkgvE85pz
         j89nTKY54oPopTju57Uqj0VnuVO2OFYDwq2INqh83xJmDoqMvWNIxLkp6wiQHJUozhGW
         N3vZ81pe4xNaZvtn2TydhoZF0UDmmH0XtNzYIx8rwZZvvXAi7v0r3KpxtOf1X7DHsml5
         QW6WWQ9BJTqiJUlnSUiw8hIUjYpm9XZla4UzNv19RUxvR3qd71B50yNKv7NWt4zVyokB
         LPLsmIlsKR4mZ3daRhKb4ElYv69bE5oWOyKPyEqyQuZq7lk8f/RP37ogqrQps5Xampe+
         wTBA==
X-Gm-Message-State: AC+VfDxphq2g5i792ayZiweNXBH+6a0lFak1vpeQMn8gOuoDAPDBcj5n
        3+5pyiLTH0D6l/HCLy3+xPJSjQ==
X-Google-Smtp-Source: ACHHUZ4XMDdStQgKrff85NZEZKRFlVA8V9QFMCe0slXyyQJwfdTbHSQ4YIcgmdFK84dT03iLAg2KDA==
X-Received: by 2002:a05:600c:2942:b0:3f4:2158:28a0 with SMTP id n2-20020a05600c294200b003f4215828a0mr12600097wmd.12.1684921714948;
        Wed, 24 May 2023 02:48:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d53c2000000b002ffbf2213d4sm14031808wrw.75.2023.05.24.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:48:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Artur Weber <aweber.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, Nikita Travkin <nikita@trvn.ru>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci . org bot" <bot@kernelci.org>
In-Reply-To: <20230524084324.11840-1-aweber.kernel@gmail.com>
References: <20230524084324.11840-1-aweber.kernel@gmail.com>
Subject: Re: [PATCH v2] drm/panel: samsung-s6d7aa0: use pointer for
 drm_mode in panel desc struct
Message-Id: <168492171413.2467334.7480313657663164313.b4-ty@linaro.org>
Date:   Wed, 24 May 2023 11:48:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 May 2023 10:43:24 +0200, Artur Weber wrote:
> Fixes compilation issues with older GCC versions and Clang after
> changes introduced in commit 6810bb390282 ("drm/panel: Add Samsung
> S6D7AA0 panel controller driver"). Tested with GCC 13.1.1, GCC 6.4.0
> and Clang 16.0.3.
> 
> Fixes the following errors with Clang:
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: samsung-s6d7aa0: use pointer for drm_mode in panel desc struct
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6a038f0183dd5d3e289f6c1fe6962de9b31f8fd2

-- 
Neil

