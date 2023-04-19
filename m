Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C66E7D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjDSPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjDSPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:00:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992B4228;
        Wed, 19 Apr 2023 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681916453; x=1713452453;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cADiMmosj/SSWkrrDxhXKGvOxbsEnjIHtsEpI7voHlM=;
  b=NsNUXQOUt/ZwNbvmx2/o35vumDPHziFq6eH99HoadqJQu/CxLdpXHj96
   kFqwuND7r5zJ5ri7jYmH5TFM4XvsDbCChzbe909Fkb1KOYYhrL79DS/5L
   SubcPpSAFAmQJrmVPscMSRk9F9qlfy7+xahgwIHP4DZSO6qRJKYYJjMOH
   wHf58mntoNHWtay8t9AdPd1pppft0iF4G77Xq9IH27YChSAeEuRMPFsTK
   qH7tVIP2wKM1O4cdP0UxGJ2+nzbzoIg2TnymvDUGIxrzzAlBTYSCSzNE/
   ml6XfkqexeaZASdUHxf+6HoSk9xHF8WoByE5kdhk/YM9h9MrlwTtUFt7I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="342951222"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="342951222"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 08:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="835335866"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="835335866"
Received: from ravishan-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.244.185])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 08:00:48 -0700
Message-ID: <2d1e5bd2c3725faf8892f30d3b4a980ed594ad85.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Return error on write
 frequency
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Date:   Wed, 19 Apr 2023 08:00:36 -0700
In-Reply-To: <64e98df-1663-1630-e2bf-5472aced5cac@linux.intel.com>
References: <20230418153230.679094-1-srinivas.pandruvada@linux.intel.com>
         <64e98df-1663-1630-e2bf-5472aced5cac@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 16:35 +0300, Ilpo Järvinen wrote:
> On Tue, 18 Apr 2023, Srinivas Pandruvada wrote:
> 
> > Currently when the uncore_write() returns error, it is silently
> > ignored. Return error to user space when uncore_write() fails.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> > Tested-by: Wendy Wang <wendy.wang@intel.com>
> > ---
> > This patch has no dependency on TPMI patches for uncore support.
> > 
> >  .../x86/intel/uncore-frequency/uncore-frequency-common.c    | 6
> > +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency-common.c b/drivers/platform/x86/intel/uncore-
> > frequency/uncore-frequency-common.c
> > index cb24de9e97dc..fa8f14c925ec 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > common.c
> > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > common.c
> > @@ -44,14 +44,18 @@ static ssize_t store_min_max_freq_khz(struct
> > uncore_data *data,
> >                                       int min_max)
> >  {
> >         unsigned int input;
> > +       int ret;
> >  
> >         if (kstrtouint(buf, 10, &input))
> >                 return -EINVAL;
> >  
> >         mutex_lock(&uncore_lock);
> > -       uncore_write(data, input, min_max);
> > +       ret = uncore_write(data, input, min_max);
> >         mutex_unlock(&uncore_lock);
> >  
> > +       if (ret)
> > +               return ret;
> > +
> >         return count;
> >  }
> 
> Shouldn't this have Fixes tag?
With the reorg of the directories, the blame commit is not what which
will be shown by "git blame". The original one is:

Fixes: 49a474c7ba51 ("platform/x86: Add support for Uncore frequency
control")

Didn't mark to stable that the current MSR write can't fail on
production systems.

> 
> Other than that,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> 
Thanks,
Srinivas
