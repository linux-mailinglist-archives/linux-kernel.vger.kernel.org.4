Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7F6717D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjARJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjARJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:20:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421B65B44C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:38:32 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 127so8326355pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Seq1mX1XtKCwlcIcPQRmNyguKpAMYVn4ufk1mjtx/c=;
        b=H8yMg62Cq5wI/wHrn1Gcd5A/7UHoJqQ4Mc7NinTnr/5hGSO48NgbHgNQa2QuBVBHbN
         VJ/PSuW7KKTckTfWhC8lDoLWSpKEOynWhuH/7iskzZjvs8yBrnWYFOLH80zf2l9Gw59M
         XHUbEQxjaJKBLZLzxO9gYb+ZR2xX5ADI+P8oSTHiJNVH39HPPHqS5YqOqvb3b0h/rUI1
         0kXBUhgR3QjmsFl8l9T82o0xjBIGLcjidI2pWIOtagtqYjwtcQspYcV5YBQpjQpwM7bf
         AEPyic5C+u2QiF34C5tmEdiKMSUXuUvCatYasrKADxfUMeljP4QNsj900ZTbuEqTthgK
         S+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Seq1mX1XtKCwlcIcPQRmNyguKpAMYVn4ufk1mjtx/c=;
        b=iS7rvZgxNwiMeSI8TkcccmhktoYh2rY/Nprs1b7dVWM4ciDohBVu7As+Cqy+86xhDP
         YgZdGymInkoiqTPiG5zl2EnyrAzHT69rWWqfA4gZny4/PrV+p1KnPx7jF+9XB0oPdyRs
         bjxfBOxP5EtPQdzvBmaC4xM+yPaEMOONkluFpkgEd6Zjtx1vAbpgU1OrXqGguCWH+/uA
         jaLyVpclBRJm5lETRKOdCXcYInanZUF5D2ufAQp5NjXZAratjf1Sfk6s4x/GPMs2+M8f
         2ukhi+9lT0gG9F1w/VeqOCUqZmzIJ8bicZnS6Okk9qlr1+72DIwRJXk86R27iFX9IdB0
         VPzg==
X-Gm-Message-State: AFqh2ko1gfSwYgOAS2FO8JG78aAS4XUUr0zBEreJ2TzVXRYBdgzLmMhg
        WuxqXCeg06SSVKVlaJ3/B45n2w==
X-Google-Smtp-Source: AMrXdXuTJH4v7znJMxTMt9jc5jG0ofaVClDu4kQgHlioRTy6pjhtRH5jVqPmJ4Xz+BGXRqadTtX29g==
X-Received: by 2002:aa7:8283:0:b0:588:9c15:65c4 with SMTP id s3-20020aa78283000000b005889c1565c4mr5481132pfm.3.1674031111722;
        Wed, 18 Jan 2023 00:38:31 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id d62-20020a623641000000b005800cb7cbcasm19709245pfa.120.2023.01.18.00.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:38:31 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 0/3] thermal: Fix/cleanup error paths in __thermal_cooling_device_register()
Date:   Wed, 18 Jan 2023 14:08:23 +0530
Message-Id: <cover.1674030722.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The error paths in __thermal_cooling_device_register() are trying to free
un-acquired resources, fix that and clean it up a bit.

Caleb, can you please test this? I have just build tested it for now.

--
Viresh

Viresh Kumar (3):
  thermal: core: call put_device() only after device_register() fails
  thermal: core: Move cdev cleanup to thermal_release()
  thermal: core: Use device_unregister() instead of device_del/put()

 drivers/thermal/thermal_core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.31.1.272.g89b43f80a514

