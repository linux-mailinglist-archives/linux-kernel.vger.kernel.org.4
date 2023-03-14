Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B56B97F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCNO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCNO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:28:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1371ABB3C;
        Tue, 14 Mar 2023 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678804087; x=1710340087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A2wRtzqNNWOjm587MT+EDno0PlO1YNRU7HQNzhtlKTQ=;
  b=Gxiqc89XyaS4nAKeWdDAh1ZKTCZwE2Ck7HAYdbg6zXhVYg5NsqZsn20D
   OlsNaK7+fVt8y5GvqK1bTjBBxV8ccZ3Y+P+oXqqNbdY2olXKzdqJUQU3S
   CiDqMCd/IWEj2+WcsIQwIEJ1R681SteZDoNtBgAgZknf/stx1/zL7+uTD
   XWq9nGqVkBHUvxeFzt/Io3GdYIWJDAHmEpcLTwXNpJxSuVPSjh4yKsldg
   5OnlHpl6xjUy0ys7HJpCCid4ZGimVMKTaLIcO2T/ooya9+wPxH00/RE+Y
   VyycrFEtYvAYEvAgJK56KUKD99uGEAusTp7+jlazIyKoxfWzl7VFGCwXE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="423711078"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="423711078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 07:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822398865"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="822398865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2023 07:28:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E907A209; Tue, 14 Mar 2023 16:28:48 +0200 (EET)
Date:   Tue, 14 Mar 2023 16:28:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        linux-usb@vger.kernel.org, anson.tsao@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix TX/RX interrupt handling
Message-ID: <20230314142848.GK62143@black.fi.intel.com>
References: <20230310172050.1394-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310172050.1394-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Fri, Mar 10, 2023 at 11:20:48AM -0600, Mario Limonciello wrote:
> Previously a patch series was sent up to change the way that DROM was read
> to prefer directly from NVM instead of bit banging.
> 
> This series was produced due to issues found where TBT3 DROM CRC wouldn't
> match.  In looking at it from USB4 analyzer the DROM wasn't corrupted
> before it arrived at the router.  In analyzing the failure mode, every
> single failure occurred during a retried TX because RX interrupt
> "never came".
> 
> This was actually a smoking gun; when the hardware responded too quickly
> both TX and RX interrupt status bits were set before the ISR would run.
> By the ISR using auto clear on read to process the TX this would make the
> RX interrupt bit get lost and the RX interrupt was never handled.
> 
> To fix this issue, disable auto clear in the ISR and instead only clear
> the interrupt that is actually triggering the ISR.
> 
> This fixes the communication for a long series of transactions such as
> bit banging and probably also fixes other situations that control transfers
> were retried a number of times due to a missing RX.
> 
> Mario Limonciello (2):
>   thunderbolt: Use const qualifier for `ring_interrupt_index`
>   thunderbolt: Disable interrupt auto clear for rings

Applied both to thunderbolt.git/fixes for v6.3-rc and marked them for
stable as well. Thanks! I dropped the other patch that adjusted the NVM
reading as now it is not necessary anymore (please correct me if I'm
mistaken).
