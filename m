Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06626047DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiJSNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiJSNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:45:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D32B1D20EC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186308; x=1697722308;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=4wtOeT8RZIX6dw14IAJ0yPqq/FxpKzeHezEAY45EG/I=;
  b=ISaE+F6bi5RSfwgBEnN6ZFFNmwDLn0ee1s6pBQLzylyErAAwUw8w8lCy
   WkVDsu+z5jYAVpVxJgNxxS6PT9KpwNwe5WlaNizxNBXh7VCRq/XJIERrg
   yp3rEMaiZRVMQv6JfcQKHQgTq9hiDaQxL6ue6jYP8yWqQ1nkMgFYwgaPJ
   IYYsjgz9Jy8CKYTArJ8T/FLHEL4qtfixG9TIqfplddw8HUtKl5+IgErwP
   zm4oQarfNBLRR/c0S+q/nvvqha8VuFXaDyUQeId71cOMHFHo6CVVJyJ6i
   orUx8B9OxYTF1snP2e0Gb/jrQd5KpLpR5pzP7pd/mscgEAgfBMDnhTtf6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="308095458"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="308095458"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:31:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="660348012"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="660348012"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO [10.213.233.40]) ([10.213.233.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:31:03 -0700
Message-ID: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com>
Date:   Wed, 19 Oct 2022 14:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: Re: signal: break out of wait loops on kthread_stop()
Organization: Intel Corporation UK Plc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

A question regarding a7c01fa93aeb ("signal: break out of wait loops on 
kthread_stop()") if I may.

We have a bunch code in i915, possibly limited to self tests (ie debug 
builds) but still important for our flows, which spawn kernel threads 
and exercises parts of the driver.

Problem we are hitting with this patch is that code did not really need 
to be signal aware until now. Well to say that more accurately - we were 
able to test the code which is normally executed from userspace, so is 
signal aware, but not worry about -ERESTARTSYS or -EINTR within the test 
cases itself.

For example threads which exercise an internal API for a while until the 
parent calls kthread_stop. Now those tests can hit unexpected errors.

Question is how to best approach working around this change. It is of 
course technically possible to rework our code in more than one way, 
although with some cost and impact already felt due reduced pass rates 
in our automated test suites.

Maybe an opt out kthread flag from this new behavior? Would that be 
acceptable as a quick fix? Or any other comments?

Regards,

Tvrtko
