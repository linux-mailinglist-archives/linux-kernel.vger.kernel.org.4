Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA406D7D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbjDENKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbjDENJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:09:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2700271C;
        Wed,  5 Apr 2023 06:09:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fi11so17438451edb.10;
        Wed, 05 Apr 2023 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680700195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lrrn9Os7k/oSQLAsT1c79tz/mKrZxstzRd8x/1yg5OY=;
        b=jq671NIvFC1RCtZAsM8SH4MdrPC/7JD0eGHg73Ked+Uqr2YYRYUTCfiFbzp6Vy0jUO
         bcUyq8S95NmcCSGNMjba7bfl4G8ud/MVmch4PrJklkL6EJwBV2GAGqqSGmMS00zcHCSO
         uMel4YZsnM+WGlUFXPOrx576FOPsPMItMJamtg+qY7cm6YLxXVy1dnQxWOzumNs/3+Nb
         BPdAtYBijvc2ed34pB3WJSS7A0VhS943F3bYimc6oQqkjn8yuzhe90uYlVxfqT1neuDW
         0x5zlV0JUOQWSru2rPW9NDnwsEOSEQZMlObWkKvcHm/nFCdtXZW7BDzbBZRy+EQo/PG5
         V2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrrn9Os7k/oSQLAsT1c79tz/mKrZxstzRd8x/1yg5OY=;
        b=UAJWy1KnDA/3y+nlAoG0RStlwjtxnii46gclKkSPnOZbMgSj6QlJ3dPbP8aSP/hh5K
         cjHhzZpS9Hgf3PWuQPtDbFaojI2ceCgEH6BqeJt5O+cnbPZXf7sWUbfwFjwPP9xG/3ay
         74b+3IBs5B9I4/huRc4b72oMVTtALMFNEFYBab3LY4hEff9HCEaaYWdjbHWnjHdocyoq
         2pISBFLKLVxWwjA5Kxb9e9nUaSW7EAYGq+OHw0ypzDxSJZDvzAwNNgDi2rCflet3N+R8
         P/ACGy+zUwEIYNugTQTiOacmjwoCquHbmZG9NqmFrBrTpk4YZx4GwcAwrzHwdp94gvrm
         AV7Q==
X-Gm-Message-State: AAQBX9cHeM35i0/QeAVF7RZb96o3lSjVzGcXXGrQN2Vj5keGmVRY8ZPV
        krM69RkPx5CZKuPgb47bcVU=
X-Google-Smtp-Source: AKy350a5Nz3W7YKjiebz8MBrsJk59qHlbv1+CekqwjMDfRDUGg3XAjtJfBeqDSAfgIvKy1kTkhxcTA==
X-Received: by 2002:a17:907:1b1c:b0:949:87e1:5b31 with SMTP id mp28-20020a1709071b1c00b0094987e15b31mr1050535ejc.19.1680700195086;
        Wed, 05 Apr 2023 06:09:55 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qq8-20020a17090720c800b008def483cf79sm7327438ejb.168.2023.04.05.06.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:09:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     will@kernel.org, catalin.marinas@arm.com,
        Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        vsethi@nvidia.com, jonathanh@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable ARM CoreSight PMU driver
Date:   Wed,  5 Apr 2023 15:09:48 +0200
Message-Id: <168070017414.4044223.13292657935768427902.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321200535.10584-1-bwicaksono@nvidia.com>
References: <20230321200535.10584-1-bwicaksono@nvidia.com>
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

On Tue, 21 Mar 2023 15:05:35 -0500, Besar Wicaksono wrote:
> Enable driver for Coresight PMU arch device.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable ARM CoreSight PMU driver
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
