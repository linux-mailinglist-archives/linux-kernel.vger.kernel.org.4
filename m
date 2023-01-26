Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0367CE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjAZOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAZOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:37:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792573A592;
        Thu, 26 Jan 2023 06:37:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y15so1358832edq.13;
        Thu, 26 Jan 2023 06:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neC2J2NiikFKD1DH99boQHYW1Cc4DcDPvmoJjFl/uiw=;
        b=XIYectCzSHJAAaa7Bdi8U6Ff08nfXOoYrDHsNb7SbpoNtqPdFF8MkVD8QHIW+EkyLR
         dXJQWv6k+3+rW4zuLt8EwEyg6A7MS+h1o7Zb4oTE+m9Z9Q7Dg8fM1QZTiJUwXm+KU8SC
         jNjf7zcRQlNrAM5fLPUAyr7l6+mH3jL5n62mmqgjwOAgPmmtgkFuauSTOz5mFqydVdBy
         7YQlkcitzbFZBLHYoYPZRFaXdg6z/83VwoOVulICMS+UOxXj2x4D5foljp1T+s6yR8Au
         srs0Ad3bu7N/RP+gV0QwauU55vYnO2venRkhbqkJtqTCjTZXVuF+R8ailzvgq3CAufGG
         WvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neC2J2NiikFKD1DH99boQHYW1Cc4DcDPvmoJjFl/uiw=;
        b=y8hh1Zh4JmRmHJvCJnrKh0flPrmE2c2G7lAPCiWRwP27EEa5LC8Ae0pSOtBhWjyGma
         lhGEHEl6OxTXl0jD2280WZTSMxErY4a8DAIUTwwdGEEJB2hfLC3wLlTlYOZbjniHGCIR
         UYBgKOrzHNT4G1OjfwktF55dldbLuXqb0mqAU7JFMvG/gO6daBfBlNEb0mBFKUw9HPi3
         CtV36zorwlGFN/h/mW04sFr9Idxgyi0ul1DDREGQcbOvQGKVJ/6LMSPmbNRXy4E3pg1/
         4ZdsVjoY+WcZ3/v4wnMWm8l8g5zaxGr8m5vDDrq6I2NgtPc3xHMF3KoGvwZm+QKwDAJH
         t9+A==
X-Gm-Message-State: AFqh2krtXQwkYE3J1WMt4OS3r3ZA+yDVCMaG5Gn98ThsRPLYFZu85FwK
        MNZs4IRiMeBJdvKCY3Uljpw=
X-Google-Smtp-Source: AMrXdXv65LpAxJbI8nt34DB2ZlyWFFhGPxslQDQj/tP65D8A7gBzAMVLrZAxzV4ggdokLf55fcbbXQ==
X-Received: by 2002:aa7:de94:0:b0:474:a583:2e1a with SMTP id j20-20020aa7de94000000b00474a5832e1amr37658467edv.12.1674743839858;
        Thu, 26 Jan 2023 06:37:19 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7cfd8000000b00495c3573b36sm834221edy.32.2023.01.26.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:37:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: tegra: Mark host1x as dma-coherent on Tegra194/234
Date:   Thu, 26 Jan 2023 15:37:15 +0100
Message-Id: <167474380847.1640957.15918634834244629931.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119133901.1892413-1-cyndis@kapsi.fi>
References: <20230119133901.1892413-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Thu, 19 Jan 2023 15:38:58 +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Ensure appropriate configuration is done to make the host1x device
> and context devices DMA coherent by adding the dma-coherent flag.
> 
> 

Applied, thanks!

[1/4] arm64: tegra: Mark host1x as dma-coherent on Tegra194/234
      (no commit info)
[2/4] gpu: host1x: Fix mask for syncpoint increment register
      commit: c42babb37bc2ba84d692d8d13ce900636b19d2b7
[3/4] gpu: host1x: Don't skip assigning syncpoints to channels
      commit: 529babe886a29b3e4ffcdc61b755c3d7245c6cf2
[4/4] drm/tegra: firewall: Check for is_addr_reg existence in IMM check
      commit: 40aef7daa1bdf73bd66aa97e6e2069e340415a38

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
