Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59325602108
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJRCTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJRCTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:19:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989B6439;
        Mon, 17 Oct 2022 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666059566; x=1697595566;
  h=message-id:subject:from:reply-to:to:date:
   content-transfer-encoding:mime-version;
  bh=0N6dnPCgSeh2dgOLEqLnHGuzxzo7ZhRs4tVMykumu78=;
  b=LJ0VkfoKMNtmQWxKW/rriKyWZPsdKSZkqfmbual8WpGQCa6ZPm8tFTFh
   Xod6tl+p+peLtkO9mnNMnUvybIg9DEinesvgzm8s4JnxjkOL9OPMeb0+2
   VWFAY8fezxg+ub532Wr+P7OyxCW2taJXTloNDVnd207DqJzK6dicRNBFN
   FEjiu56lj5dE4mXdfkFmyt9PVBkVu8W4P5xAgWBQIxbE6ggNBzsLEYczv
   gQyAsndqFaW3SZWq467EsRB6kLFKoi5Z9bLwSNDfZWazktPsEJNUE8x9w
   Ex0pBxdDUqHoSWjJfFyVQBHQpjU3ct5vHIgxzm18ABqkP7ah9g2D17hWn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="305959218"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="305959218"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 19:19:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="661708685"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="661708685"
Received: from tpavlacx-mobl.amr.corp.intel.com ([10.209.40.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 19:19:25 -0700
Message-ID: <967cfe4e2dba242352ccd1cd00bdbcfb48bdd697.camel@linux.intel.com>
Subject: RTC wakealarm file is missing in v6.1-rc1
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Date:   Mon, 17 Oct 2022 19:19:25 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the v6.1-rc1 kernel release from about 24 hours ago, the wakealarm
file for the real time clock appears to be missing. Specifically:

/sys/class/rtc/rtc0/wakealarm

Without this sysfs file, the rtcwake and sleepgraph tools no longer
function properly (and probably all tools that use the RTC through
sysfs). I've tested on 10 machines so far and this occurs on all of
them regardless of the specific hardware.

The issue is in this patch set for the rtc subsystem. If I remove this
commit and rebuild, the issue goes away. I'm in the process of
bisecting further.

commit b7270c69a36efc61ed6ebd31a8a458f354a6edc0
Merge: 4ce1b97949cb e5f12a398371
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Oct 14 18:36:42 2022 -0700

I've opened a bugzilla issue here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D216600

