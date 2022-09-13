Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C1F5B64A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIMAu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIMAu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:50:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1451EC41;
        Mon, 12 Sep 2022 17:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663030255; x=1694566255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Iv/g7byxZbzJva06wgZTQxsrYf7vHQYkFAE98ZRf4s=;
  b=RJ/WaLkLQVq/ahIwe/UVP5FS75HaU60YSrDlhZ/qg0Ddqs/1iUksKtv2
   0y8D8Exr54q4FTF1Dbb7ZB/aAyngZZyWCJ+/+LigYUkm7PYvwB1tBJBeU
   X43B8l0LfAkkXFg6FUeRMV0xWWjSbBKMTCRqqk5MHhB42NA8iQCnDwAfr
   OY/1fcbuRNKzJrRVB9o3bMrJqKpCVzqOAO5C86k26c9++w2SC17lVZuZO
   HlWaDSKdZk2UkFcsUzSJcXdS+BbvpThXch7rzjpUkebs4B3pd39qAI2tg
   vWOvRQMMPpxVm3ClwaVr0JPaGDI8xIrCU/mnOQBIk8rBYJNRGqWTDwIB+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298007584"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="298007584"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:50:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="649458540"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.251.9.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:50:54 -0700
Date:   Mon, 12 Sep 2022 17:50:53 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 0/3] Check enumeration before MSR save/restore
Message-ID: <20220913005053.vk7qmhr6tqqynags@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 04:38:44PM -0700, Pawan Gupta wrote:
> Hi,
> 
> This patchset is to fix the "unchecked MSR access error" [1] during S3
> resume. Patch 1/3 adds a feature bit for MSR_IA32_TSX_CTRL.
> 
> Patch 2/3 adds a feature bit for MSR_AMD64_LS_CFG.
> 
> Patch 3/3 adds check for feature bit before adding any speculation
> control MSR to the list of MSRs to save/restore.
> 
> [1] https://lore.kernel.org/lkml/20220906201743.436091-1-hdegoede@redhat.com/

Added the correct email-id of Hans de Goede <hdegoede@redhat.com>.
