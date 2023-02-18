Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4455469B8BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBRIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBRIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:32:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60B51ABE5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:32:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t2-20020a254602000000b007eba3f8e3baso189013yba.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Y2Iaizw/ZWNWr/ZhbETsVsFt94AT5JM61rija8D/4E=;
        b=W1qJd8BM9PSNreJlRFPyaMEeYkajehRaPtUPUUDkegR0SXoNzC6QaddCiA/uy5vG2E
         WW5gCsd/FD/26qb6Lip7S2rPYwIAok0pYTltLvj1C9qFKW9lBkqwzRtgqcyl0H/c1+Ax
         dH+w7rtH0MvFswPfer4OBjfUVXdrs45OKn7h9Q2ZIlT4pBk4s2LVF78QWTx2A1PcnUse
         uuVhHpUaUgHP+eIhdtDf9gduWXr6AqW6K0Q01u+IOj7UlOl9zmlJ3HJ1Td3s/Q0hggE1
         PmiD7slexf+tyLHBvTGhJBG9RtU0IgSKse5XOck/BQI/Vowo8jZSlQ3vwy2jcYYRu//Q
         JyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Y2Iaizw/ZWNWr/ZhbETsVsFt94AT5JM61rija8D/4E=;
        b=F3oKSArwiZhiP4zKiYOWG0KOgns1WOA+3BuM1ACuOC71y/AiL15OnXcXR5JEJ6Ayzj
         LzoyCY6Ke2Q1XMWw1Cyc+RXGyJhd5tImxRwzMlC3upnrGlEHzSvrRzAyBp0lE8sR2lbC
         +i4GKSNDeXZi7aGVxxXTuCtmp3qAz7BCLwvG7uMWmWwvMyDVJQWhWA/tAKs/9Gc3Q/rp
         pWkF1xjoWKCdMclHnevqsKM2i9HeSna/FXkhD4XIuARPiuu4iI1xiE4pa58hw9r9dp5P
         i4idBlhM8Pg5B88AD75skanSTK/X+4JNE4zeqaeOomKrOno8MSVZ3YkixE4LKkMYEuqG
         yn/g==
X-Gm-Message-State: AO0yUKUvdrACV6EjCPj3v71oGhExU6y3MBp73oyru/WxHqtgPxArmuyJ
        fo93YmfEh9PZw/On2B/j8TAi8TjE4IEBfog=
X-Google-Smtp-Source: AK7set+TaqT6S/rZ7sj29z0zsyibXnF0XJtjsbWr8FVW00BxTtBfWuwqurzi4bvbGz5vLbd3CwzE9oY8Ewfwk3k=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:382:7632:f7fc:4737])
 (user=saravanak job=sendgmr) by 2002:a25:f905:0:b0:86d:e2b9:a2bd with SMTP id
 q5-20020a25f905000000b0086de2b9a2bdmr1064578ybe.421.1676709176122; Sat, 18
 Feb 2023 00:32:56 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:32:47 -0800
Message-Id: <20230218083252.2044423-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [RFC v1 0/4] Simplify regulator supply resolution code by offloading
 to driver core
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark/Liam,

This series is just an RFC to see if you agree with where this is going.
Please point out bugs, but don't bother with a proper code review.

The high level idea is to not reimplement what driver core can already
handle for us and use it to do some of the work. Instead of trying to
resolve supplies from all different code paths and bits and pieces of
the tree, we just build it from the root to the leaves by using deferred
probing to sequence things in the right order.

The last patch is the main one. Rest of them are just setting up for it.

I believe there's room for further simplification but this is what I
could whip up as a quick first draft that shows the high level idea.
I'll probably need some help with getting a better understanding of why
things are done in a specific order in regulator_register() before I
could attempt simplifying things further.

Ideally, regulator_register() would just have DT parsing, init data
struct sanity checks and adding the regulator device and then we move
everything else to into the probe function that's guaranteed to run only
after the supply has been resolved/ready to resolve.

fw_devlink/device links should further optimize the flow and also allow
us to simplify some of the guarantees and address some of the existing
FIXMEs. But this patch series is NOT dependent on fw_devlink or device
links.

Any thoughts on where this is going?

I've tested this on one hardware I have and it works and nothing is
broken. But the regulator tree in my hardware isn't that complicated or
deep. The regulators are also added mostly in the right order (due to
existing fw_devlink). So if you agree with the idea, the next step is to
ask people to give it a test.

Also, it's based on driver-core-next since that's what I had synced up
and had a working baseline. I'll rebase it on the regulator tree when I
go from RFC -> PATCH.

Thanks,
Saravana

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Luca Weiss <luca.weiss@fairphone.com>

Saravana Kannan (4):
  regulator: core: Add regulator devices to bus instead of class
  regulator: core: Add sysfs class backward compatibility
  regulator: core: Probe regulator devices
  regulator: core: Move regulator supply resolving to the probe function

 drivers/regulator/core.c         | 102 +++++++++++++++++++------------
 drivers/regulator/internal.h     |   2 +-
 drivers/regulator/of_regulator.c |   2 +-
 3 files changed, 64 insertions(+), 42 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

