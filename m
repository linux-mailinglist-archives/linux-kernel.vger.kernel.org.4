Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25D5FE6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJNCGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJNCGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:06:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0488218D808;
        Thu, 13 Oct 2022 19:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665713170; x=1697249170;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cjsA7tOGWV+2g8lrU2CSnPRwpnh8ov+jdIT4b7dHTw4=;
  b=OMoHmmHc7RktOW7IUWtVWKnoU0pg7V5W9bxCc+MmtkWx4nl8+vfrpPrA
   fvBSzjgarZeif9sBZYM2YoqsHmIM3fMYkUhu0VubATrwTq4CIpIK8cgoT
   Wi7FqywDHwDx+4nG7lDzKUwhYrYjoWrUYEzS6+gnd0dnqTzcsYCA+W2Do
   ZvqYVIUH2028n0lXSC6Jg2bTqnsblw14IPUwMju5NOpN/2aeudo4cWwP8
   WC8H9q/ZoU7Mt6Tb1Jupl9sqXa24YU8zJyk+VbgoTe2tbNh4W7TmQ8QJ6
   1nbuhqeBfCezKU4ibRAb5xAHcvSPhyPC7xdzK9gPurrJXbjBUnIZ7Domv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="303999273"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="303999273"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 19:06:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="627404902"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="627404902"
Received: from keweilu-mobl.ccr.corp.intel.com ([10.254.208.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 19:06:05 -0700
Message-ID: <0307a5881c875e0b104051792b0f5e7f0ff973c1.camel@intel.com>
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, corbet@lwn.net, fenghua.yu@intel.com,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com
Date:   Fri, 14 Oct 2022 10:06:02 +0800
In-Reply-To: <668e5126-f344-c30b-a743-877b1783cec7@intel.com>
References: <20220922133800.12918-1-rui.zhang@intel.com>
         <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
         <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
         <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
         <668e5126-f344-c30b-a743-877b1783cec7@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

On Thu, 2022-10-13 at 08:56 -0700, Dave Hansen wrote:
> On 10/13/22 03:58, Len Brown wrote:
> > This series of BUG FIXES needs to be marked for -stable.
> 
> Hi Len,
> 
> That would have been great feedback to include with your review when
> your provided your acks.  It's also not clear where the bug fixes
> stop
> and the "related fixes" begin.  Is the entire series bug fixes that
> need
> to be marked for -stable?

Patch 4/8 ~ 5/8 are real fixes and they depends on patch 2/8 and 3/8 to
avoid possible regressions. So patch 2/8 ~ 5/8 should be stable
material.

patch 6/8 is also a bugfix, but we have not observed any functionality
issues so far.

thanks,
rui

