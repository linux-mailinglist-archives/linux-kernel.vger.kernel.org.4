Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A646F5B67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjECPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjECPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:39:51 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D76EB8
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:39:50 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-32b625939d4so1249485ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683128390; x=1685720390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVVLdXvIfrw5/3NYijIBIn8HUk/59pymTlkCnyX4gZk=;
        b=hhwOQ1IRNoMXnJdreafhurd7FFlfWlG7ggNpHvGfTwl86HQaxurUdjbTsPCn5g21J1
         WZJUWtptO9CY6OjNiJxnwf2pAtUpeg45ezOSpKhFaDLQj/DAo03745KRyQ2F+QyJoIC9
         4naFiUVk5u0JT3Ssp6HMtEKLywdZYoB54T3elj56qZ3er+ZZv4fyn9T/mJBkQ/dPt/tY
         tE/fUiEnL/YH6Y0TeFqQkPJI5ZEUkgUzquCEMsLcJOOtiES45axH7nEo7sWfo1YQQFRC
         eYhAld8YCZZzXDAqT3Q+RvaF8Lp4Cojc9jUdaquf4cvNbFV7wjzl8SMIGxY1Gjl7gFWK
         3YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128390; x=1685720390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVVLdXvIfrw5/3NYijIBIn8HUk/59pymTlkCnyX4gZk=;
        b=agTTvs6ihsM9fL1Wy+yyv6iSObSGLLoFbW2Yq42nerfMgwFraPmPwl/Y645rnG18Yr
         IDqQgvh+VzDQrd/kF61N+vG6lAPswy3nFHRhYl7UoZqcrtbEWkGhPeo5Dbsu07uZOl5C
         Pi9Kt6JvT0uJLS5emO7E2GCdXvuqBavpXKdqfglFRFjVrwG4OWAqyFlh3C1CgppjxI79
         bo1X/3d9nVmZdZkmOANqzmtQEBEPolMyW1v/BTgMZBj3wfxCpnXKY4/yQ9TUMKhUBH1T
         DZkQ94EyJaZYm+0lU5IECV2zKh/nm9p9bCEEjLGkiFDCIyWJe1I1XUFh7JYL3pAbwAke
         aN7g==
X-Gm-Message-State: AC+VfDwTIiiKvCyMP4oV+yfzIU/+Q1Fpu/DqqJQyds5eKJFro0hGAtjK
        V856F4GIHhQmTo3+ZCCCzEbGlS+B89Sf+p8D+rk=
X-Google-Smtp-Source: ACHHUZ5d4YwH96Tpn6LfKIxiZcp69KtZgmoa3BJZVXRNO88gwL/jKwNV6SF+0qAXwiCYWhzG65q3sg==
X-Received: by 2002:a92:7402:0:b0:330:a1eb:c5a4 with SMTP id p2-20020a927402000000b00330a1ebc5a4mr4047857ilc.1.1683128389782;
        Wed, 03 May 2023 08:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cd23-20020a0566381a1700b00406147dad72sm10232284jab.104.2023.05.03.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:39:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        stable@vger.kernel.org, Thomas Voegtle <tv@lio96.de>
In-Reply-To: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
References: <20230503121937.17232-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: correctly submit flush bio on barrier
Message-Id: <168312838868.941317.975898202413701616.b4-ty@kernel.dk>
Date:   Wed, 03 May 2023 09:39:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 03 May 2023 14:19:37 +0200, Christoph Böhmwalder wrote:
> When we receive a flush command (or "barrier" in DRBD), we currently use
> a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.
> 
> The correct way to submit a flush bio is by using a REQ_OP_WRITE without
> any data, and set the REQ_PREFLUSH flag.
> 
> Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
> flush/fua bios"), this triggers a warning in the block layer, but this
> has been broken for quite some time before that.
> 
> [...]

Applied, thanks!

[1/1] drbd: correctly submit flush bio on barrier
      commit: 3899d94e3831ee07ea6821c032dc297aec80586a

Best regards,
-- 
Jens Axboe



