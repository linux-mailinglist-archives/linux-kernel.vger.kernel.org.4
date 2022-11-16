Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA862BE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiKPMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiKPMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:48:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BD1FCF4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668602887; x=1700138887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x5iIiz9jywgrUG1nuX5QXt7YbSQl4qoJ01nGzaWkFck=;
  b=dGXWgUoOGijwU3F3lBtGuynEaChILNhXCYRQ5NqguJH/PnB96ZEzLqeW
   THShnniav/NCgd1l553GPhhuhmc6alDq9aMuWjQcBj22e0GKCQa0YO+9W
   Gw1B7azlNvV5PHGEHwWcjhVLQc0rrXmw+YzZfs1guZnJFj5YtmTvA2qek
   KR4EPfEYVjZtaV/pmxmC0a6LVY965Mcw268MvZWm7PejobFFBs8pj7JhO
   j1ZqeWlU00sjJwPieDdCIRBe1qIhhSUegOF4kXpdQDti1fMXMNv+J41LO
   rNyq/d6KXeKiG/z48rhwavCcJ0xPIiZslz7zn1miZD7/Xvz5sMAZf+j8t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292240421"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292240421"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:48:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633618112"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633618112"
Received: from sannilnx.jer.intel.com ([10.12.26.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:47:46 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mei: add timeout to send
Date:   Wed, 16 Nov 2022 14:47:33 +0200
Message-Id: <20221116124735.2493847-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When driver wakes up the firmware from the low power state,
it is sending a memory ready message.
The send is done via synchronous/blocking function to ensure
that firmware is in ready state. However, in case of firmware
undergoing reset send might be block forever.
To address this issue a timeout is added to blocking
write command on the internal bus.

Introduce the __mei_cl_send_timeout function to use instead of
__mei_cl_send in cases where timeout is required.
The mei_cl_write has only two callers and there is no need to split
it into two functions.

V2: address review comments:
 - split __mei_cl_send and __mei_cl_send_timeout
 - add units to timeout KDoc
 - use MAX_SCHEDULE_TIMEOUT to squash wait to one macro

V3: - split the state fix into separate patch
    - document define unit
    - expand timeout KDoc

Alexander Usyskin (2):
  mei: add timeout to send
  mei: bus-fixup: change pxp mode only if message was sent

 drivers/misc/mei/bus-fixup.c | 14 +++++++++-----
 drivers/misc/mei/bus.c       | 22 +++++++++++++++++++++-
 drivers/misc/mei/client.c    | 20 ++++++++++++++++----
 drivers/misc/mei/client.h    |  2 +-
 drivers/misc/mei/main.c      |  2 +-
 drivers/misc/mei/mei_dev.h   |  2 ++
 6 files changed, 50 insertions(+), 12 deletions(-)

-- 
2.34.1

