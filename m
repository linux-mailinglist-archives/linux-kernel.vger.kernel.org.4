Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632C3730E65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjFOEuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243198AbjFOEtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:49:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF99212C;
        Wed, 14 Jun 2023 21:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686804553; x=1718340553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ztdfkkx6Ws3Eq21dPslOfdeBjbIJO8QQvfbeNKntcXQ=;
  b=Qo8Mpru5oVenHRRPYvPdblfkGM3LTSx8kFO5V322ipuI0xn8+umNdGk5
   C8O52ZnDWM9lTtc3Ry/CQHKuH9Lh+6AMOp2RKmYzle8oXzbVbqBHVrsnF
   QUFevUhZWw4N2Awo7wTc2ECgK7KMBkTK5sSUEPZ92pHR/b8DWfGIKSM81
   d7fVTlxEaVwdT+pXKIXDAzGjSWI0zLhzwKdHjgIIogGnFPbvcR0YGLttZ
   HlNTGmpgb9q8lTMic39+LKIEAZsCXCcaPqlwyLsRkptnmRkusy+1FMhbE
   bPyLpeGhjsuFYrj6EwOR/8ohAaVrzEPLHiPW4nwBhwgcVEW4wjbqxsBXH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="422418022"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="422418022"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 21:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712323585"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="712323585"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2023 21:48:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7542D30C; Thu, 15 Jun 2023 07:49:05 +0300 (EEST)
Date:   Thu, 15 Jun 2023 07:49:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Matthias Kaehlcke <mka@google.com>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: thunderbolt: resume from hibernation CPUs racing in tb_ring_start
Message-ID: <20230615044905.GU45886@black.fi.intel.com>
References: <CADyq12w_c=pq5sph9Ne+nshz2haeYK-kGYVwQTUqSb3W_kzrdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyq12w_c=pq5sph9Ne+nshz2haeYK-kGYVwQTUqSb3W_kzrdA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2023 at 04:26:49PM -0400, Brian Geffon wrote:
> Hi,
> On ChromeOS we're running a 5.15 kernel patched up to 6.4-rc6 w.r.t to
> drivers/thunderbolt code and we're seeing a similar issue to the one
> discussed in https://lore.kernel.org/lkml/20230421140725.495-1-mario.limonciello@amd.com/T/#
> / https://bugzilla.kernel.org/show_bug.cgi?id=217343 where when
> resuming from hibernation you'll see warnings along the lines of
> 
> [  126.292769] thunderbolt 0000:00:0d.3: interrupt for RX ring 0 is
> already enabled
> 
> The thing that's odd is it appears three CPUs are racing through this code path:
> 
> [  126.292076] ------------[ cut here ]------------
> [  126.292077] thunderbolt 0000:00:0d.2: interrupt for TX ring 0 is
> already enabled
> [  126.292080] proc_thermal_pci 0000:00:04.0: PM:
> pci_pm_thaw_noirq+0x0/0x7c returned 0 after 606 usecs
> [  126.292086] ------------[ cut here ]------------
> [  126.292087] thunderbolt 0000:00:0d.3: interrupt for TX ring 0 is
> already enabled
> [  126.292089] WARNING: CPU: 6 PID: 7879 at
> drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
> [  126.292092] Modules linked in:
> [  126.292091] WARNING: CPU: 0 PID: 175 at
> drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
> [  126.292157] CPU: 0 PID: 175 Comm: kworker/u24:2 Tainted: G     U
>         5.15.116-19568-g766d8095041b #24
> fdadcb2517d1d37363ad385ffddbc1ad5dc72550
> [  126.292158]  lzo_rle zram joydev
> [  126.292159] Hardware name: Google Anahera/Anahera, BIOS
> Google_Anahera.14505.143.0 06/22/2022
> [  126.292159]
> [  126.292160] Workqueue: events_unbound async_run_entry_fn
> [  126.292160] CPU: 6 PID: 7879 Comm: kworker/u24:13 Tainted: G     U
>           5.15.116-19568-g766d8095041b #24

Do you have this one?

https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/commit/?h=fixes&id=9f9666e65359d5047089aef97ac87c50f624ecb0
