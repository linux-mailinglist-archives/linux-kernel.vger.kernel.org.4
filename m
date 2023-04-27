Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA486F0630
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbjD0MwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjD0MwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:52:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094046AB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:52:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f86ee42669so8169641f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682599920; x=1685191920;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfWLAe/fF1E4LgUmECNUtdr8sZ/Z/BT/KZ2q+zP0IlY=;
        b=ssf4q2tqkQe8GWV2NhnHzlfB1EFlj2xlT5+L+5STyjYwTHyNixHH/xbHNLJ8WQbhDM
         W9Qy/goPwiyWfsS8LeXJSrrqnZI0ibD7BeHltDffIADyQhnklKeJPHc73w/7A/lfFPii
         iuTWxKaE4O+PZBxhfX3Rz8Xw/ZQuoixe5wDDUa3a3ow6YZGUORJC3G8/eTBYqPwLn2cG
         PAHptahVaA7eYA4WoUSXBpAKh0x9DPnoo+boaAWB2y1Cxgl7exLimNNekvidA3nosQvm
         2mHEib5vZ76wooGH11x6nOUXluNRp5mrMM9/gncTpG02QUqKl/pv93mArpb3Il7ciOq3
         1uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682599920; x=1685191920;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfWLAe/fF1E4LgUmECNUtdr8sZ/Z/BT/KZ2q+zP0IlY=;
        b=CSnUdRGE7HPp8ofnLCM5UNrWfpXGd+yxGx7ZLLVL/X1d64BYMVUn3A1rX4X5JXx8GS
         V6YomwRnrh0Jt5jawOV8ZPKBIhC611t9oHWRZ7AGmciN7OeVXnEu/41P/4Fp8NQ4tsrK
         hSf4tIBTqhPbd5Bja9RH/mcnCVC/F3JahAsFUIy+IJoQn/+hrmcgA/1qjSHDJawjl3nI
         JhUbw7woaxqIpaIj3sL2YgoxwONaBK54uS9v3KOzfbZhS3MOIduJO9YdipBrWJJ7xob9
         Gdzai38xhH3jNRFYtz2UgLRnGOCnms5RyrJpPVKomM8Vz3A2Q1Sz0xW2h5Rfpk18WY1H
         wxiQ==
X-Gm-Message-State: AC+VfDxUPw54HfyEMGBm0iHCNQxBKJVlj/JzL+mMxxsLFF+cIpAVAPtk
        LFiWP8z4O+xUuwP89a9U/JSJ7Q==
X-Google-Smtp-Source: ACHHUZ6jkZGtDsfDwIEI40ww2DZomo1siHaiNuHWw1JgWvoQFqIbKz2YXzN8VVmfDkjJ6lOmgvBLeQ==
X-Received: by 2002:a5d:6a83:0:b0:2fb:283a:1757 with SMTP id s3-20020a5d6a83000000b002fb283a1757mr1413955wru.26.1682599920684;
        Thu, 27 Apr 2023 05:52:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d5950000000b0030490c8ccafsm6499980wri.52.2023.04.27.05.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:52:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     airlied@gmail.com, daniel@ffwll.ch, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        Tom Rix <trix@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230423145300.3937831-1-trix@redhat.com>
References: <20230423145300.3937831-1-trix@redhat.com>
Subject: Re: [PATCH] drm/meson: set variables meson_hdmi_*
 storage-class-specifier to static
Message-Id: <168259991963.3093924.6221745093198482770.b4-ty@linaro.org>
Date:   Thu, 27 Apr 2023 14:51:59 +0200
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

On Sun, 23 Apr 2023 10:53:00 -0400, Tom Rix wrote:
> smatch has several simailar warnings to
> drivers/gpu/drm/meson/meson_venc.c:189:28: warning: symbol
>   'meson_hdmi_enci_mode_480i' was not declared. Should it be static?
> 
> These variables are only used in their defining file so should be static
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/meson: set variables meson_hdmi_* storage-class-specifier to static
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=4b733b2c38b7c9304bbb92cf88f1b23f43ca575d

-- 
Neil

