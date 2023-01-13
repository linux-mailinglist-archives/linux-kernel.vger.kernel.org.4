Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620D666A447
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjAMUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAMUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:44:10 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C14C8793B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:44:09 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k18so563716pll.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFX1TAztefX49Dlr88yQWueCiK9uug2GKKIgj7SNmgw=;
        b=t3T7bdFcRj0TMIIRv4lrC1ysO6ZajfDnSWPjuxjJd+Z67qU9yBY0ugR12YXRcDDZfb
         yxwtc1P88m6Fg+/6USQKKxCzVsFQoZD/MtbG9DRbDTR5xBKx/xgu7ciOHyNwzZmVZi+s
         ydPfsQJTDM1ncZiqGQ9/l24VlAYJuNoTLRzH9MBWSEYpmXSbp34j2yAS6MFCeLDgeQm8
         ZNo+3pnPUV0pxPVZBiGOY6ZyoSFOUpg/X3U3pPZpILQgREGmZAzaZqGTKFQIJ/LeFaBH
         vdFaoek2Uoosyfl7wDUCuHP/3gfWzAhfm662amVz9GYoWPxYoAaWiJoesYH25hvo6SIx
         b5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFX1TAztefX49Dlr88yQWueCiK9uug2GKKIgj7SNmgw=;
        b=daLESfoXoMk6+5WvTyeYzjyH+wijdMmwJD+Aby3ESxjKO3R9P3I/hta9eNhY3nWzeM
         3R/ovTo9tqYtxSZ4rsxt2tyIZRv5kiP6tyXmxyPf6yqoUKePjfeu+a+tWPz3Tz64AirI
         Hb5zHLSzZ8EN6TvGbp9/uhCagn3xUTXE9P6o5ENz9gbi4Le1tAKkYajnvhFn+d4Ytaip
         7GsfyEu2kLc7pfNNopUuoVNo4vXVaa6pVCVo3kwcVCHTzq5FDY4H4KBTmBSntVIEZHLg
         FKZzhg8BOpWPqUQxCjwlSU0uWIAXOxHyUKhtZeZv2AOxQ2XEnTSeKujzhLtioiiXWTmT
         2/mA==
X-Gm-Message-State: AFqh2krixaIjcm9Z7rKGefXW3kaw6iR4OVKJCGwgiBItqP7Gi1Y3HMrK
        B+hVKnfBfTnqMiap7c01AeK40A==
X-Google-Smtp-Source: AMrXdXtX0nXp49pBZlB9bSrCFWdMWJXGiP3+ghZrlZ3nXV0E++DXWEHapsnIM08THmpGR7hFMQhz1Q==
X-Received: by 2002:a17:90a:5416:b0:226:6470:af3d with SMTP id z22-20020a17090a541600b002266470af3dmr10568808pjh.3.1673642648824;
        Fri, 13 Jan 2023 12:44:08 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lb3-20020a17090b4a4300b0021900ba8eeesm1447661pjb.2.2023.01.13.12.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:44:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
Subject: Re: [RESEND PATCH 0/8] Miscellaneous DRBD reorganization
Message-Id: <167364264790.13167.1164501758187135700.b4-ty@kernel.dk>
Date:   Fri, 13 Jan 2023 13:44:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2023 13:35:30 +0100, Christoph Böhmwalder wrote:
> Some more mostly trivial "alignment patches" to (slowly but surely)
> move further in the direction of re-upstreaming DRBD.
> 
> These should be fairly uncontroversial.
> 
> Andreas Gruenbacher (1):
>   drbd: drbd_insert_interval(): Clarify comment
> 
> [...]

Applied, thanks!

[1/8] drbd: adjust drbd_limits license header
      commit: f4095e7643c0fd00f1c125388d6d83d60875d489
[2/8] drbd: fix DRBD_VOLUME_MAX 65535 -> 65534
      commit: f7fb0227ae90fff4d09d969c353e8a30f2e0edcc
[3/8] drbd: make limits unsigned
      commit: 4e5ebce4a5dde36316a78550c9f7b97a9e03302b
[4/8] drbd: remove unnecessary assignment in vli_encode_bits
      commit: 93a8026b0d7161597437eb2d87ceac4f194991c4
[5/8] drbd: remove macros using require_context
      commit: 00f0c8eccb383782621c74e5bd2ce9b4b8dbad5a
[6/8] MAINTAINERS: add drbd headers
      commit: 463afd417b268d18d3c83ec0851e978dd12daaa2
[7/8] drbd: interval tree: make removing an "empty" interval a no-op
      commit: 6928e2f7919aa3cd4e31aba5b16f6f212df2bb35
[8/8] drbd: drbd_insert_interval(): Clarify comment
      commit: 2b0802d1ac9333d060312b22e9d898614253adcf

Best regards,
-- 
Jens Axboe



