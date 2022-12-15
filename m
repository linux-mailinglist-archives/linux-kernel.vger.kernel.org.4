Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1675B64E0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLOSY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiLOSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:24:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B04876F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671128666; x=1702664666;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bdCtT+5ElJmr9KjTrYdZQTFR2w3Tb5egfy2oVKPmxjI=;
  b=gJzTQ6Y9ZOhfbMfhQ4ZVyLocmEZnE/uTwhVTDNawRqc9RR5YmOmLNvad
   Nwbyi+QF/iZbqBbDHu1YgZuA51VxWn9iFZQ5Xr/iNid+xjJkOLl6NrgXO
   ZV2J/cKB7VY+bln+BLK0PrF2pSJNpfSPbI4bcMG10XwuL/dHgIaZmbhxy
   12VerS0mH6M43HheUQWYVadMiDkHPK5Gej0A9GPk8SU7kdo6WA+Hf3B8+
   BiWm01FgwMOY5rP0DCYWNCwz+nSaskxjx33brxqSHML/v44rR1+Ksfjil
   OdJtXcY/F3Td7puaYsoJkFbnm16tBIxPm9x3fT0I+j/2aqLOZSsBNUmjw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="316408394"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="316408394"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:24:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="978287239"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="978287239"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:24:23 -0800
Date:   Thu, 15 Dec 2022 20:23:59 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        hch@lst.de, m.szyprowski@samsung.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [6.2][regression] after commit ffcb754584603adf7039d7972564fbf6febdc542
 all sound devices disappeared (due BUG at mm/page_alloc.c:3592!)
In-Reply-To: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2212152017110.3532114@eliteleevi.tm.intel.com>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Dec 2022, Mikhail Gavrilov wrote:

> The kernel 6.2 preparation cycle has begun and yesterday after the
> kernel was updated on my Fedora Rawhide all audio devices disappeared.

I can confirm this breaks audio in our SOF tests if I cherry-pick the 
identified patch ffcb754584603a to sound tree. This affects audio on a 
very large number of x86 systems.

Br, Kai
