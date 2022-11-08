Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034A0621ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiKHWHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKHWHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:07:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986731EEF2;
        Tue,  8 Nov 2022 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667945228; x=1699481228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t65N9s6vAq03ceuwDncJ3SzQJQNYF4H4fH8zDunO5JA=;
  b=Di9rDTi7asiLAJvSWfcbK/Ex3nQUG1g/K39c+YFLRJ66xbKhLYaClLZc
   c0ivsF8yBYQRmuqxykz5Zru7JP81ADOZwvZ91O2gyJu5lXQtYVcoagobX
   RLS/Ew/6HnZR8zw8bgNNSrgTYinccsgNakMIl0f2quetNLDxzIbB2Zy85
   ynf0Hycy+k2WYfWX4LMIqvRv7c70e8yuuQSmBNLVm4D860ZZo3+idT2VC
   ZLBJgIGezwx5x1RpnpI2VQ95Tv/bcZJbpmA3+Y9lRap01auCIqcNlBZvZ
   Y4CTKc58Yc8GAw3D8yQqAiEcm/qSZnsIKLv/UcYamDbgFnPf0bOgulg8B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298338812"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298338812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:07:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="636494224"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="636494224"
Received: from ehartman-mobl.amr.corp.intel.com (HELO desk) ([10.212.198.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 14:07:07 -0800
Date:   Tue, 8 Nov 2022 14:07:06 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 0/3] Check enumeration before MSR save/restore
Message-ID: <20221108220706.rnv7bc2c4ddztb76@desk>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <aa8f5b80-b94e-b685-ed65-8b9c8f453832@redhat.com>
 <Y2qfY81OphcVRbUk@zn.tnic>
 <Y2qmCJgOY6BOTlOb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y2qmCJgOY6BOTlOb@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 07:55:04PM +0100, Borislav Petkov wrote:
>On Tue, Nov 08, 2022 at 07:26:43PM +0100, Borislav Petkov wrote:
>> Will take a look tomorrow.
>
>Yap, needs a new revision.

Sure, I will revise this.
