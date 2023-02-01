Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8C686ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBATW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBATW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:22:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17EC7FA3D;
        Wed,  1 Feb 2023 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675279346; x=1706815346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wy1msrIPfznHGysWzTYnh4CoIsPDb+6Js1yj4Dk5Y4w=;
  b=VidhZcNQjPHNc8WHbfFhot7GGMyzlu7ixQDa5yadbBFxP86Som6t2OTN
   FlCN2C5wUQPBEqGPCJFww0tmYct+J9yuQi6FrIYTJX54YvDO2bPXqlg8f
   fF6mjmsCX40HbDEzFBVZjKV6yTkMYqHAqUGb8s112CrtL+UsDsQ1iFYlK
   qbIESl9+eYcPDAch3aV3WeV1awyWJP+zkJUl9E/Z8sblpKwsztW1b2/fx
   NvFt1qb5X/Zc2j8CQVf3qUv+4WjpIXC7VmSAR1IIUNSj9gV2PRHsmMuv0
   z/bE/U5ibClmoBXmeBKSeTMykophZL6Fr4QDMHy+gYtqF+6auLyZNOb8y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="328259717"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="328259717"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:22:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="642569336"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="642569336"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:22:25 -0800
Date:   Wed, 1 Feb 2023 11:22:24 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Message-ID: <Y9q78P9EKlz2k6Fg@agluck-desk3.sc.intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
 <Y9nyWVNtfBEny66w@kroah.com>
 <SJ1PR11MB6083EBD2D2826E0A247AF242FCD19@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9qtI+CZaX051rLo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qtI+CZaX051rLo@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 07:19:15PM +0100, Greg KH wrote:
> It shouldn't be that hard, lots of people use them today.
> 
> Try and see!


Extract from the first of our in-field-scan tests:

	while (activate.start <= activate.stop) {

		... trigger scan ...

		if (status.chunk_num == activate.start) {
			... check for too many retries on same chunk ...
		} else {
			activate.start = status.chunk_num;
		}
	}

using <linux/bitfield.h> becomes:

	while (FIELD_GET(GENMASK(7, 0), activate) <= FIELD_GET(GENMASK(15, 8), activate) {


		if (FIELD_GET(GENMASK(7, 0), status) == FIELD_GET(GENMASK(7, 0), activate) {
			...
		} else {
			activate &= ~GENMASK(7, 0);
			activate |= FIELD_PREP(GENMASK(7, 0), FIELD_GET(GENMASK(7, 0), status));
		}
	}

While I can make that more legible with some helper #defines for the
fields, it becomes more difficult to write, and no easier to read (since
I then have to chase down what the macros are doing).

If this were in some performance critical path, I might worry about
whether the generated code was good enough. But this code path isn't
remotely critical to anyone. The test takes up to 200 usec, so saving
a handful of cycles in the surrounding code will be in the noise.

-Tony
