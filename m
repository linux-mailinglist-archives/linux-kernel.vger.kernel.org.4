Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4862FED7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKRUa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKRUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:30:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FE35FFF;
        Fri, 18 Nov 2022 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668803423; x=1700339423;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DVuW18VlC1gJ0gdaPLCyQfLy3BuK+gRicEyi7qDq28Y=;
  b=XqCyQ6P/aaas1NCAPakkmQcTRL+DRWzG7wRLV2YaWzo00xCr3fAjvkba
   gfSykBy1iYsaj+mkyk2XO1QGr8s74ftVuDwalQd323Awf4bH3qrnZoobp
   vjVSNPPWoY81H266OkT1LCrs+wuP5NJ8K0CFDM7kmuExphG0BtxAqSpn0
   augr0jFy2zQc0RhWyveUh19WTarN3zKrzNU6aybFPzFpADZjjDZ+4dha1
   W3Yp374CYmCvmhTBBKUKTcSF90s+PwRZP1ovkTPQD/9wPBBaBRtsrjc0u
   3r/93EXD2SlnuznxCClqbz0B1cPWmXJuJo9KeaZgs3CI5mFcWtWp4FTdN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="296589666"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="296589666"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:30:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="673321058"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="673321058"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:30:23 -0800
Message-ID: <76cf2ce6e286d6226bda8b9b5f3e4b8df7ea5132.camel@linux.intel.com>
Subject: Re: [PATCH RESEND 2/2] thermal: intel: Protect clearing of thermal
 status bits
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 18 Nov 2022 12:30:23 -0800
In-Reply-To: <CAJZ5v0j=LUkTtcQb3YVN0R3W4p7Cg-+wU8EAW75wz7bSTXhp4Q@mail.gmail.com>
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
         <20221116025417.2590275-2-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jrEDkfZbMzdLHzvGwa3jK61vUBBqzUUM8BaQvLLcZnhg@mail.gmail.com>
         <ac94b8218de744a1ca9649fc9585292f11b91063.camel@linux.intel.com>
         <CAJZ5v0j=LUkTtcQb3YVN0R3W4p7Cg-+wU8EAW75wz7bSTXhp4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-18 at 20:49 +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 18, 2022 at 8:40 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Fri, 2022-11-18 at 18:57 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > The clearing of the package thermal status is done by Read-
> > > > Modify-
> > > > Write
> > > > operation. This may result in clearing of some new status bits
> > > > which are
> > > > being or about to be processed.
> > > > 
> > > > For example, while clearing of HFI status, after read of thermal
> > > > status
> > > > register, a new thermal status bit is set by the hardware. But
> > > > during
> > > > write back, the newly generated status bit will be set to 0 or
> > > > cleared.
> > > > So, it is not safe to do read-modify-write.
> > > > 
> > > > Since thermal status Read-Write bits can be set to only 0 not 1,
> > > > it
> > > > is
> > > > safe to set all other bits to 1 which are not getting cleared.
> > > > 
> > > > Create a common interface for clearing package thermal status
> > > > bits.
> > > > Use
> > > > this interface to replace existing code to clear thermal package
> > > > status
> > > > bits.
> > > > 
> > > > It is safe to call from different CPUs without protection as
> > > > there
> > > > is no
> > > > read-modify-write. Also wrmsrl results in just single
> > > > instruction.
> > > > For
> > > > example while CPU 0 and CPU 3 are clearing bit 1 and 3
> > > > respectively. If
> > > > CPU 3 wins the race, it will write 0x4000aa2, then CPU 1 will
> > > > write
> > > > 0x4000aa8. The bits which are not part of clear are set to 1. The
> > > > default
> > > > mask for bits, which can be written here is 0x4000aaa.
> > > > 
> > > > Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>
> > > > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > 
> > > How urgent is this?  Would 6.2 be sufficient?
> > > 
> > Not urgent. 6.2 should be enough.
> 
> OK
> 
> > > Also, do you want it to go into -stable?
> > Yes.
> 
> Which series?
Cc: stable@vger.kernel.org # v5.18+

Thanks,
Srinivas

