Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5C64D983
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLOK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLOK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:26:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC819C3B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:26:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a16so26386065edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asgpSUX6LyiRFZtSEAHAKhPF0T2KdzBQAin+Qp7x+js=;
        b=EM2QBbE4O8GJHLTgP8L7ZVce2CBowpgQGBKAFUsgug71cPEZitEoMhMcEMyFgGRvmJ
         krvuAEi0j8CYG3UHj7pY+kXllxjYpQSvme5dJ/XNI0LwoHJcg2kM9lUKiNmoE3d19o7L
         XGQ52hLM57kHi890RMIlrJiC2X49zCdvKfisoYm/BRpHgibcWLbb9g5P4HaFION/G9MJ
         THIJDJ9V6ayM/+wzphgCVjIpG0zq6lPVuJGLLNUDFzbyc5uCwivbveZK5Ssw8vR3FyG4
         2pua5XjSRGMTJ21hrMqBvN6Jrb5l/CYGx3uB+uTHybPbaJrRBumg7SMKUWDUKAjQ0TqG
         AfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asgpSUX6LyiRFZtSEAHAKhPF0T2KdzBQAin+Qp7x+js=;
        b=PLMg/1YX7eIp17ORrmC5h0KahCbW4MxpXqDgvH4JDi0tSycGnVPwv4hnz0zTVIU5tV
         61Mh6Fe3YQz+WyEfawmdfHKmLwbF04NcANIMrGn2n5iLn3+XnZxD+rV+m60kPGxk2scR
         2uEo33ImOzRC8W+3ywNqs0SvEK1R906UZhug7muJnfF8PcuQF0bs+BQ4CMCxEUrA2cZQ
         Vg5hgpFCM2ZuZqwiKRCkRo4IPkIsMDsET46ZJmON4OeA6A4DT4KnhTaOeb2Dak35OsNg
         scR/4O4A6/DSBA7LyhuknnmRjpJ58jjCcgRouFQ9Lp6SS3OCb8KExVVQVimVHn+g2pEZ
         +Rpw==
X-Gm-Message-State: AFqh2kp4/4Ry+peYTZyat4dQQIDtt1UrhlV6nNt5zhf74zJZbNlQGvU5
        2Q2Dr01PhR3xGtDqQu73+yD+Kw==
X-Google-Smtp-Source: AMrXdXvdpZnmpaP26++xeN7CVZElmcnN3H2kASYSBNlYRUKRd3pl+JXlDHAysiHbubPvU0MrT6TE1A==
X-Received: by 2002:a50:d71d:0:b0:473:bd4:84ba with SMTP id t29-20020a50d71d000000b004730bd484bamr3210116edi.23.1671100013721;
        Thu, 15 Dec 2022 02:26:53 -0800 (PST)
Received: from prec5560.. ([2001:bf7:830:a7a8:7e6a:e951:1d52:a2ae])
        by smtp.gmail.com with ESMTPSA id p4-20020aa7d304000000b00461cdda400esm7326226edq.4.2022.12.15.02.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:26:53 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
        andrzej.hajda@intel.com, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        airlied@gmail.com, Robert Foss <robert.foss@linaro.org>,
        daniel@ffwll.ch, jernej.skrabec@gmail.com,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v1] drm/bridge: lt9611: Fix PLL being unable to lock
Date:   Thu, 15 Dec 2022 11:26:46 +0100
Message-Id: <167109999520.488696.7695301244949222536.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213150304.4189760-1-robert.foss@linaro.org>
References: <20221213150304.4189760-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 16:03:04 +0100, Robert Foss wrote:
> This fixes PLL being unable to lock, and is derived from an equivalent
> downstream commit.
> 
> Available LT9611 documentation does not list this register, neither does
> LT9611UXC (which is a different chip).
> 
> This commit has been confirmed to fix HDMI output on DragonBoard 845c.
> 
> [...]

Applied, thanks!

Repo: https://cgit.freedesktop.org/drm/drm-misc/


[1/1] drm/bridge: lt9611: Fix PLL being unable to lock
      commit: 2a9df204be0bbb896e087f00b9ee3fc559d5a608



rob

