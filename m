Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9277A64CE61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiLNQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiLNQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:51:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4C118B2F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:51:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f7so23381958edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czD2rPOx9OiZcdJviML+H8nDE1bCxJVFDnkUjNKkP+g=;
        b=LEb7HZpqHNLosW6dXyA2OiFJA5bKjR1TN9jw+WfKLEhClD5CLL0XhnsrSv2L52/cU8
         zJ+wJrRlHXk+bv9u/XHT+erWxwYGz7SC2xfPO0xfOdZDbHsV2ATwck18gEyxqOuAnYWY
         VLwmSwjjF5HXLbcNg2nLJiarnFZucgdCw6sX1jV9MfQdvWRe8L68Ku6Ft3KkBDcw7k5g
         C+enr++FiA8f1yNt19eONDe5kTEEeNMB8X3FFg1H7ZaFXS8thAkGk4SXh6T5eJCLxlgw
         CqW8QncumriceyvwjREh3FkFdovcNlbrqhcmzTtvYQbiNGXnyLylVXkkuAaji1hhelWr
         T9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czD2rPOx9OiZcdJviML+H8nDE1bCxJVFDnkUjNKkP+g=;
        b=N03APHGVdUbW3eHSoUk0YGMbWMMnfp57E6LUDh5wiaQbND+DL1X1CV/ukcBVZRfC/5
         kCWyHB/RomOD/0z+PxulZN5UN6roNPEdp/ztIV94FP6nOMFBMrom4J+N91ABc9TZwrhV
         uy4dVie1JvhkgSgh0+YLLjfomsXhoZjopIi3IKgod6ukjZYVAAY9hEIQloXuXUqOS/N4
         fUmW2Mot0Mr/kt6/Yt7qH0UwWYijLvF9Bk5jQjB+xqZsn4SjPWiStkuAARNVGtvUc3id
         9OWWztVo40+KmF6cP7aE/b4FjJCwVNfX4pPGzBS30dHCjBN3at9WXVTNlreKPCc3wRvN
         VgsQ==
X-Gm-Message-State: ANoB5pkX0ZAT2kiC2j/KaLOvsv+dr9W78R39LQm7OtTEq/+/6qnSnw2b
        9tmeHQLZ/Gry7Ozc6eVAQINuxg==
X-Google-Smtp-Source: AA0mqf6jNv3/NX9rm+O5/sllvALiPUWVimAqqQ0Ee8xAiZf4HNQ9uqqhxFGKpzX7BsoWPTZm1IGcHQ==
X-Received: by 2002:a05:6402:110c:b0:46f:7453:a99d with SMTP id u12-20020a056402110c00b0046f7453a99dmr12178462edv.6.1671036702339;
        Wed, 14 Dec 2022 08:51:42 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id lb19-20020a170907785300b007c0a90663d5sm6010023ejc.162.2022.12.14.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:51:41 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        allen chen <allen.chen@ite.com.tw>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: it6505: Add caching for EDID
Date:   Wed, 14 Dec 2022 17:51:33 +0100
Message-Id: <167103665890.995711.9267085599513513874.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115112720.911158-1-treapking@chromium.org>
References: <20221115112720.911158-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 19:27:20 +0800, Pin-yen Lin wrote:
> Add caching when EDID is read, and invalidate the cache until the
> bridge detects HPD low or sink count changes on HPD_IRQ.
> 
> It takes 1.2s for IT6505 bridge to read a 3-block EDID, and skipping
> one EDID read would be a notable difference on user experience.
> 
> 
> [...]

Applied, thanks!

Repo: https://cgit.freedesktop.org/drm/drm-misc/


[1/1] drm/bridge: it6505: Add caching for EDID
      (no commit info)



rob

