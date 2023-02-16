Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630D69898F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBPA6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPA6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:58:10 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5E298F1;
        Wed, 15 Feb 2023 16:58:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b2so1359073ejz.9;
        Wed, 15 Feb 2023 16:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ezmrG/sOZbkfRK1NLR5fLERLXGxJdhb7yn9bDGpi7v8=;
        b=OfIq5oGygvJyp/wgd4xHbSY1M1Kqk3g7bGo3odmZB8EsIeG2FJiNSlCdaAmL7S8/Ca
         RJ3bFwo+l2GJdGWxWosjuIXTwewp12A2zm789qhrWjfbjJhyFNNKVs14n1odCZjRSzJ/
         /jo8iBIzInJTLvEfIz0rxgn1BoWqOL7XXrLDfEAgWhS0J9Gd6LY7rA2gU3onyoZ3e4Ls
         oAIfSRxuWgbVuiH3cvisWjGF8dWkm6Mv6pLvk7FsxH9Vx5ssZDw5VZUKwZbKeUmY2kJs
         Uq7n0V6fjqOR27Fnv9wq/TjeUdwvkhEAVS5hetzEQkFZyMuJQ+bTrG4MGWY1SGLxJAxi
         H4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezmrG/sOZbkfRK1NLR5fLERLXGxJdhb7yn9bDGpi7v8=;
        b=QaXEOaKcFqGV+kM995L388Qws6j3Y1EEhNGwq8oGHgBxPXFcSqgiQZv1YPXjjvqjBS
         oPhmR6J2dkUziQL3Mryq7DuyVrD/jyT7FQCJaHYWMdwIvl0M9NJa0m0W7iZn7zMc4+34
         Nd0vbWZwzfXis/J5g/rBtjlR3H7emrqM5EsTWfOMcBDxwmJqVfh/ehSHEY3fRJe1G1st
         YDz9hAAVBQDIovZ3QbqFFu2i4MWUkXTrX+CHZe5Qqdn8L3OB3rFCC2yldfZOu8KtWxxP
         XYKAhtyFRuRjXUCqVOLnlcsz59S8thPa/iGhPRlQoZorXDpZRWZeQOa474VaI14M/lmT
         jvxg==
X-Gm-Message-State: AO0yUKXobRAzlHniACvxf7YNeBCvs0F7w1VONtuettCsavRnz6EENOgv
        ZHLVHYhFYthbTnMnYGLLDk/6hSsDazBr3B//
X-Google-Smtp-Source: AK7set+2OIGCsB09ZBMpZEveYY/8a0IjQJ+ZU0hsZ+BkXrje6Dl6j3EDX23bWoxXuMlBE/MR7Krpzg==
X-Received: by 2002:a17:906:4a58:b0:8af:4314:24a6 with SMTP id a24-20020a1709064a5800b008af431424a6mr4310464ejv.31.1676509087561;
        Wed, 15 Feb 2023 16:58:07 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709064a0500b008b144796d9esm73458eju.143.2023.02.15.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 16:58:07 -0800 (PST)
Date:   Thu, 16 Feb 2023 01:57:45 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     linux-staging@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-media@vger.kernel.org
Subject: [Paatch] [staging][atomisp] Remove unneeded version.h include pointed
 out by 'make versioncheck'
Message-ID: <4b9f2443-3360-bdb0-c4d4-7687db333d0a@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d0b9a59ac1bc69523b5cc8b2bab0b0e0b4bd0ab6 Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Feb 2023 02:52:24 +0100
Subject: [PATCH 05/12] [staging][atomisp] Remove unneeded version.h include
  pointed out by 'make versioncheck'

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  drivers/staging/media/atomisp/include/linux/atomisp.h | 1 -
  1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp.h b/drivers/staging/media/atomisp/include/linux/atomisp.h
index 3f602b5aaff9..3deffcb81683 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp.h
@@ -20,7 +20,6 @@
  #define _ATOM_ISP_H

  #include <linux/types.h>
-#include <linux/version.h>

  /* struct media_device_info.hw_revision */
  #define ATOMISP_HW_REVISION_MASK	0x0000ff00
-- 
2.39.2

