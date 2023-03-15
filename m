Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E096BABDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCOJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjCOJOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:14:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078107C3E4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:13:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so663916wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678871629;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uTYqdvS7CTqX6IUu3AFWJKisW4+Wnz2lhp7ImHDpKA=;
        b=mKyM+6+HKdqL526yAvlvsBE+dJA4oHbWFu8jV3a/1gUpN0TCBWQbVL6y7qVMis9C7g
         aOZWppvVYdAOOFgLAgPp/K1/3SRUpZ+7z/VgCp5TDAKKNBG2/UQiEJBAAAqTRb65AJp9
         dYX7wvWzVTNsSqDvdMCwJ/7k9dYgmBhQF+AEe3a1tNaN8Kh+Iptmxrg3iZnOgCtDAX8X
         Fbqe3FpjzLs0xpXwIIGVPDAvZxwKhARWaVwizzpVj7UmmixMQFGKVyQre7cLf6AoTjEi
         JzeimVrMleuLbj8ugfIvDToFUxZtWXMApUQLiziW4/nhqWjexYPX+ATA8DkIccNQ0E9r
         S9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871629;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uTYqdvS7CTqX6IUu3AFWJKisW4+Wnz2lhp7ImHDpKA=;
        b=EHYpkMwUzCuleJzMY43CI8kF/t4/lH9k1yL/BiKBwu1DrtHSmytRjsr+chR2KVfYjk
         BnpD9NqWL9pU1AKZJiQUeIH+gSKrJxPXcK5ceFfildF0DYFSPspiZUabH6LgzcHr3bVS
         LPM2eBX1s1tTvv9j4d4Yi8eZkBhDdPLcyfg3ddQl39YHuqfudl+wa5QVefbtuRy9E2ZV
         fyukHNlwqMbj1A3a7J0t0TrqTbT9ux/N1mV5dGLh5ZIQXzOV33KJmSpDKl5pILJ/k832
         r8zdzrNA9ivECbobYJufnGlySPb2oXNFsKswQkqfQmmLEb1jRzEnV17UmfRVNokNClVZ
         XHlA==
X-Gm-Message-State: AO0yUKUlN1i34hHogbvXU9QtWHNpPIQZ6PgGzHFwuGVLIWKSj8LgRyyj
        Q2N/y6og0Gbcl6icLvBAe+cRdounF2pNIezazmyzVg==
X-Google-Smtp-Source: AK7set/Md5DRQey8UO3qNiwZdaJHsk4PoYK2Vc1uHAestzEkUcF5GDWcB8ctU6IvucKUgVX1Czt7pg==
X-Received: by 2002:a05:600c:4748:b0:3e7:f108:664c with SMTP id w8-20020a05600c474800b003e7f108664cmr16536728wmo.40.1678871629526;
        Wed, 15 Mar 2023 02:13:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y16-20020a05600c365000b003ed23845666sm1136212wmq.45.2023.03.15.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 02:13:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     sam@ravnborg.org, daniel@ffwll.ch,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230314090549.11418-1-zhouruihai@huaqin.corp-partner.google.com>
References: <20230314090549.11418-1-zhouruihai@huaqin.corp-partner.google.com>
Subject: Re: [PATCH 2/2] drm/panel: support for STARRY 2081101QFH032011-53G
 MIPI-DSI panel
Message-Id: <167887162888.2174720.11455500671990621678.b4-ty@linaro.org>
Date:   Wed, 15 Mar 2023 10:13:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Mar 2023 17:05:49 +0800, Ruihai Zhou wrote:
> The STARRY 2081101QFH032011-53G is a 10.1" WUXGA TFT LCD panel,
> which fits in nicely with the existing panel-boe-tv101wum-nl6
> driver. Hence, we add a new compatible with panel specific config.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[2/2] drm/panel: support for STARRY 2081101QFH032011-53G MIPI-DSI panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6069b66cd9622c4b29817d4e19737e6f023b909a

-- 
Neil

