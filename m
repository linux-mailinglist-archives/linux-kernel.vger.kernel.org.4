Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2D7325C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbjFPDQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbjFPDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:15:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A030F1FD7;
        Thu, 15 Jun 2023 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686885298; x=1718421298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7zLa5fRTN/RtmSvcUQ0HebZNyQL1X00X12foM68gMs=;
  b=dwTMP8ZK5iVpnYNeSbvJZ23050JTHCK7uUpsiz1ml8xIbL2YPmArMXXr
   g9UrysWBENqhlGazrOYrysXQN51l9PcwO34utWIsgL7zct+CmL1KEfAyQ
   Qrco9tOxvMfyzhyGh+9mB3l9T74aTDzi7UMsr4Hif8GZqnla9XnL9l4ee
   SksBsTkSWy0ISamgO+jWn2QAxVRbNLlJS27dK4QZDHvWnXMWhK2oFhe/C
   O5v6dB7GvBee3xoMIQgM/q7IpJIwd64TwaEwUAT3C35hcaLmkyEA1MlXK
   YPU7DXzJrBVhJLYgoiA26q1BVhuf4doRSeNuQOqVxKtKKlScDGEAlK2kZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445484187"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="445484187"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:14:58 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745966001"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="745966001"
Received: from ckale-mobl1.amr.corp.intel.com (HELO desk) ([10.212.176.170])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:14:57 -0700
Date:   Thu, 15 Jun 2023 20:14:47 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org, jordyzomer@google.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <20230616031447.yslq6ep7lxe6sjv4@desk>
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
 <20230615163125.td3aodpfwth5n4mc@desk>
 <ZIufZn+reW0rza1H@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIufZn+reW0rza1H@equinox>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:31:50AM +0100, Phillip Potter wrote:
> I've now looked at this. It is possible for cdi->capacity to be > 1, as
> it is set via get_capabilities() -> cdrom_number_of_slots(), if the
> device is an individual or cartridge changer.

Ohk. Is there an upper limit to cdi->capacity? If not, we are left with
barrier_nospec().

> Therefore, I think using CDI_MAX_CAPACITY of 1 is not the correct
> approach. Jordy's V2 patch is fine therefore, but perhaps using
> array_index_nospec() with cdi->capacity is still better than a
> do/while loop from a performance perspective, given it would be cached
> etc. at that point, so possibly quicker. Thoughts? (I'm no expert on
> spectre-v1 I'll admit).

array_index_nospec() can only clip the arg correctly if the upper bound
is correct. Problem with array_index_nospec(arg, cdi->capacity) is
cdi->capacity is not a constant, so it suffers from the same problem as
arg i.e. cdi->capacity could also be speculated. Although having to
control 2 loads makes the attack difficult, but does not rules out
completely.

barrier_nospec() makes the CPU wait for all previous loads to retire
before executing following instructions speculatively. This causes the
conditional branch to resolve correctly. I hope this does not fall into
a hotpath.
