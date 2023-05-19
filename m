Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8A708E45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjESD1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESD1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC012F;
        Thu, 18 May 2023 20:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37B7F653B7;
        Fri, 19 May 2023 03:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4B7C433EF;
        Fri, 19 May 2023 03:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684466859;
        bh=+wLKMKDFIfX1RfZ8TT5dxrKZ8bHUzQuwoS2mcuqnDqs=;
        h=From:To:Cc:Subject:Date:From;
        b=iXK0yz1hYPfSOPAysP9pADwFv5oCSjwAIQJ/Elaa7PV3SFuRStlFb0viQiIrNp+ju
         9VrF4t2hHlPxCraZNwjrciVcY55ubxzg+fgMWf50TTgSy0wYszXRRAP7xFIKK6Bvqu
         3dhckaBkfbwuLQa4s+oAtiT/KH2Gybat1qthSgzYUqtADQLIbvKOrSODInB6gruse3
         ygkLnbsZEUSFKLdUo7Scunn+ZR+HPyrXgZ6CxjeFXL3Vlw7YP9biaH6iFJ+pWbSxn2
         U5gEFObIgp/CuR49ERfhkoSAsh+GUORMJJY/g2LFEg0i0PzjckK3PmCHsRzGDROsrQ
         +Ytv8hZeJFoFQ==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     eduval@amazon.com, linux-pm@vger.kernel.org
Cc:     Eduardo Valentin <evalenti@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] thermal: enhancements on thermal stats
Date:   Thu, 18 May 2023 20:27:12 -0700
Message-Id: <20230519032719.2581689-1-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafael and Daniel

After a long hiatus, I am returning to more frequent contributions
to the thermal subsystems, as least until I drain some of the
commits I have in my trees.

This is a first series of several that will come as improvements
on the thermal subsystem that will enable using this subsystem
in the Baseboard Management Controller (BMC) space, as part
of the Nitro BMC project. To do so, there were a few improvements
and new features wrote.

In this series in particular, I present a set of enhancements
on how we are handling statistics. The cooling device stats
are awesome, but I added a few new entries there. I also
introduce stats per thermal zone here too.

I tried to keep documentation as current as possible.
I may have missed a thing or two, so please help me out here.
Testing/Examples are in each code.

Let me know any feeback,

BR,

Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-pm@vger.kernel.org (open list:THERMAL)
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)

Eduardo Valentin (7):
  thermal: stats: track time each dev changes due to tz
  thermal: stats: track number of change requests due to tz
  thermal: stats: introduce thermal zone stats/ directory
  thermal: stats: introduce thermal zone stats/min_gradient
  thermal: stats: introduce tz time in trip
  ythermal: core: report errors to governors
  thermal: stats: add error accounting to thermal zone

 .../driver-api/thermal/sysfs-api.rst          |  10 +
 drivers/thermal/thermal_core.c                |  15 +-
 drivers/thermal/thermal_core.h                |  16 +
 drivers/thermal/thermal_helpers.c             |  11 +-
 drivers/thermal/thermal_sysfs.c               | 495 +++++++++++++++++-
 include/linux/thermal.h                       |   5 +
 6 files changed, 539 insertions(+), 13 deletions(-)

-- 
2.34.1

