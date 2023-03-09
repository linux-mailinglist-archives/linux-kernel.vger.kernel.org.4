Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE86B3214
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCIXda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCIXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:33:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB555C116;
        Thu,  9 Mar 2023 15:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678404804; x=1709940804;
  h=message-id:subject:from:reply-to:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=fURQFsvjsw/isrhS07s6cUz/AKobP94qJzaPR6T3Bdk=;
  b=J4G5Mtz+5Psp3eN30ygCtmpBcSNmIfJF1YJKex9YxoJlf4eJccWY4OAt
   Ca09QhxXOofEOzeInoCf7XstocXNy5CDGUw87ppeb0b2YjUB6N0hdcXxV
   c4DAyUKco05kklWKgH+wNUl64KIzrZAWi8bgiDb3nvNGVuFBsAsUN0TnI
   rDSfLaE8w9hX8NndBYeKNhzG4cSOKLc/d/xWSIBbBb/e4rHX6t0NVeOBr
   dXPYfolSw2BN0wy6HB4B1/1u7PJUQDJqGoSRA+JAb4qWZRqSi/ipO3yih
   fYgZ6xPyzioHzttjLmWDAuPqbApztOl+PHzjHTGlty7MnrE0LCXP1Mieq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320454160"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="320454160"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 15:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="851704649"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="851704649"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 15:33:23 -0800
Message-ID: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
Subject: BUG: hid-sensor-ids code includes binary data in device name
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     p.jungkamp@gmx.net, Jonathan.Cameron@huawei.com,
        srinivas.pandruvada@linux.intel.com, jkosina@suse.cz,
        todd.e.brandt@intel.com
Date:   Thu, 09 Mar 2023 15:33:08 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I've run into an issue in 6.3.0-rc1 that causes problems with
ftrace and I've bisected it to this commit:

commit 98c062e8245199fa9121141a0bf1035dc45ae90e (HEAD, refs/bisect/bad)
Author: Philipp Jungkamp p.jungkamp@gmx.net
Date:   Fri Nov 25 00:38:38 2022 +0100

    HID: hid-sensor-custom: Allow more custom iio sensors

    The known LUID table for established/known custom HID sensors was
    limited to sensors with "INTEL" as manufacturer. But some vendors
such
    as Lenovo also include fairly standard iio sensors (e.g. ambient
light)
    in their custom sensors.

    Expand the known custom sensors table by a tag used for the
platform
    device name and match sensors based on the LUID as well as
optionally
    on model and manufacturer properties.

    Signed-off-by: Philipp Jungkamp p.jungkamp@gmx.net
    Reviewed-by: Jonathan Cameron Jonathan.Cameron@huawei.com
    Acked-by: Srinivas Pandruvada srinivas.pandruvada@linux.intel.com
    Signed-off-by: Jiri Kosina jkosina@suse.cz

You're using raw data as part of the devname in the "real_usage"
string, but it includes chars other than ASCII, and those chars end
up being printed out in the ftrace log which is meant to be ASCII only.

-       /* HID-SENSOR-INT-REAL_USAGE_ID */
-       dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s",
real_usage);
+       /* HID-SENSOR-TAG-REAL_USAGE_ID */
+       dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-%s-%s",
+                            match->tag, real_usage);

My sleepgraph tool started to crash because it read these lines from
ftrace:

device_pm_callback_start: platform HID-SENSOR-INT-020b?.39.auto,
parent: 001F:8087:0AC2.0003, [suspend]
device_pm_callback_end: platform HID-SENSOR-INT-020b?.39.auto, err=0

The "HID-SENSOR-INT-020b?.39.auto" string includes a binary char that
kills
python3 code that loops through an ascii file as such:

  File "/usr/bin/sleepgraph", line 5579, in executeSuspend
    for line in fp:
  File "/usr/lib/python3.10/codecs.py", line 322, in decode
    (result, consumed) = self._buffer_decode(data, self.errors, final)
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff in position
1568: invalid start byte

I've updated sleepgraph to handle random non-ascii chars, but other
tools
may suffer the same fate. Can you rewrite this to ensure that no binary
chars make it into the devname?

