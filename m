Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C037C6B768E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCMLtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCMLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:49:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033217CCB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678708125; x=1710244125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wa9svA1I+8OZGsRu2QKTnWAj+EdcwmRsgApr32RKku8=;
  b=iVj6fGZqYMJnTNx/l9sjayaqySQtOiTgnhTQDn7eeNXbihBA0iNcjhEk
   mBo6WYqNMAjLbzisV8GmrtbD8iRcgK39W16UsF4QMecbwjU80wDFy+D9M
   IwpE/tZeBHXtjsvdzMauzOBy8Ybz241EIcN1EuuFy7Hy4aCSLcDgeSYG2
   DrVapXVbHq9yErp5blIJCfMtrGDkWqTKTHkwp8plTAu71FhmlugKqN/WS
   jXmcy7nljjxEe+amv7uksq8ivGV62iyIozOEDcwbohIJ5oglaG1d1ByxB
   xu2Q0GTuul3keFL86CCmxEx5IJ2k69IHfXuRcxY9X6SOsMuBGKhnXW1Y/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="337147059"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="337147059"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 04:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="681011113"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="681011113"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 13 Mar 2023 04:48:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbgfQ-002bd5-08;
        Mon, 13 Mar 2023 13:48:40 +0200
Date:   Mon, 13 Mar 2023 13:48:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH v1 1/2] LSM: add a release() hook for the clean exit
 cleanup of the LSM modules
Message-ID: <ZA8Nl2z4Tl+0wCj6@smile.fi.intel.com>
References: <20230310231107.10954-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310231107.10954-1-mirsad.todorovac@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:11:08AM +0100, Mirsad Goran Todorovac wrote:
> The LSM modules, namely integrity, do not have a clean way to deallocate
> resources allocated in the init() hook or later in their lifetime. The
> resources are destroyed on kernel shutdown in an undefined order.
> 
> This will allow a .release member per LSM module and calling proper
> destructors in a well-behaved order.

...

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Christian Göttsche <cgzones@googlemail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Frederick Lawler <fred@cloudflare.com>

As I told you, try to use my script instead, run it as

`ge2maintainer.sh -c 2 -v 2 HEAD~0 --annotate --cover-letter`

(assuming your 2 patches are on the top of the current branch
 in the Git tree of Linux kernel source code).

It will create a template for the cover letter, automatically
applies To and Cc lists based on the MAINTAINERS database and
sends them.

-- 
With Best Regards,
Andy Shevchenko


