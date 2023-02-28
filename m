Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C434F6A5FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjB1TmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjB1TmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:42:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419634037
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m7so14680171lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CU51/xRqo0gCQSPRwoSaK4v3RgM9oPo21XTP6YwhidI=;
        b=yNpxTDhlgy1P6lSm1oufFnRV2trLMxYPixpNT/OpkLpbpJPGOlpkPLrSKKyBkUoO0H
         k4yNle3XfENu2W7/bPCyB5QVGO6gmIunpSxfm8Jt/izwxysIffUcEQvLFiki8UCRIDt2
         iy0ayKlH0C2+PhYY7t3MwibImgXgdLXFNuoxFD5CvRyCMy5jskjMD7LcfgAVY+hKAHo2
         xoYBCtUNQflDtH4l+UNQBxjCqomNfzgn9P7dCP0FHy1ksQmAc1ve9Ts6B0cQuLWG5pwK
         lDmxRhsSj4uSL5orMIZ0WbW3PM/VAH5B4kmJ1mBlMp9i/JY/P0LxVoH0IfsnBexAVGXs
         g8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU51/xRqo0gCQSPRwoSaK4v3RgM9oPo21XTP6YwhidI=;
        b=ccpjbUFfwBnoJeKt/8Bq9RR0Ue6XY+8YpHzF5kEsc2/eOf01Q7Aw+vxcWQKMPSKNnU
         EzQEn639aQKMt5nhJnyboqu8aMsCY8rF2rNs7pgiEtAkROqeCWP45TZCLUW+AMa3GTZs
         gtI3fzCOWUWI8ZipqRWGaGQy8JjLAQwJxMfB/KNO7cwmAwavkaeYyIC7tIjw33zhEEYb
         sqSA/krBlDjJJmTbchWtOdH2pmPxWKJUA0Yo1UYNIT80es9KjvszkXuEFjr2ejwIfGr1
         kYg8IuWc1KRMigJovyDY7D/YpXNuld5jUkJ3nqK+Wy18jKE7lZ5BBWB390SjXCJSHxaK
         GysA==
X-Gm-Message-State: AO0yUKWtMUBh1ISU2D06AbGa99uVsfxh6xeGnrXgrrIUiXXZ1GM+3sJ8
        nwvjriF+85TzWkBTQIKNTx5Onn6UoAS7rn/wh/4=
X-Google-Smtp-Source: AK7set9UI7KQg0PSFsYEjv7ZRTqyk2Ng3E3ZUnkqe/sBq1ZyTCuVK9BhzZO6iQqN5+c7DbLrAxLplA==
X-Received: by 2002:a19:7012:0:b0:4d8:6577:d2bf with SMTP id h18-20020a197012000000b004d86577d2bfmr870791lfc.37.1677613339333;
        Tue, 28 Feb 2023 11:42:19 -0800 (PST)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id c24-20020ac244b8000000b004b40c2fccfdsm1442158lfm.59.2023.02.28.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 11:42:18 -0800 (PST)
Date:   Tue, 28 Feb 2023 20:42:17 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix race condition in AMDTEE driver
Message-ID: <Y/5ZGX0lSTnZz27E@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this fix for the AMDTEE driver in the TEE subsystem.

Note that this isn't a usual Arm driver update. This targets AMD
instead, but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/amdtee-fix-for-v6.3

for you to fetch changes up to f8502fba45bd30e1a6a354d9d898bc99d1a11e6d:

  tee: amdtee: fix race condition in amdtee_open_session (2023-02-28 18:39:19 +0100)

----------------------------------------------------------------
AMDTEE fix race condition in amdtee_open_session()

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: fix race condition in amdtee_open_session

 drivers/tee/amdtee/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)
