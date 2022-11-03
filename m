Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161366174CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKCDNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKCDNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:13:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452031402B;
        Wed,  2 Nov 2022 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667445181; x=1698981181;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0vI5uOf/x137Tle9H7IRzeDNxM47nec6nZEZGKSQEc=;
  b=BJgtm6+RP+ibeDtXJMZcYtN5o3UX0WNp9oElYehs3GW4p729ai/3Dv+5
   UZAyks4qURAKXcz0gyqGz6nuORsNQa9a0vXNC6ZmetWLO73wZInvq2wD3
   dGE8VAns/xwJIPocZZABZhgMJt/xLtltIgeoY18FjaeDke9JXKY9m4vMF
   oT/ZXMEx8AclOi4NHOIHtyLA0GPlrakDs+OLF6mbGn4LeEET5Q2QrkDiT
   bK2R7be90lB3P3FJat7P/zmNuo9bEhNDTl2uATB0dCNyGbZQPsx9IcvXw
   F/bN1s0d5/E3qCrnBcC2eC675HRLe7I7ChrIuA0xQ9vCvnPFeIu1ASLz0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="297027442"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="297027442"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 20:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723787972"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723787972"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 20:12:58 -0700
Received: from dshivaku-MOBL.amr.corp.intel.com (unknown [10.212.195.54])
        by linux.intel.com (Postfix) with ESMTP id 794A4580D42;
        Wed,  2 Nov 2022 20:12:58 -0700 (PDT)
Message-ID: <f33ef0981a808e9f1c9a4446f68ddbe3c2497a68.camel@linux.intel.com>
Subject: Re: [PATCH 3/9] platform/x86/intel/sdsi: Support different GUIDs
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Nov 2022 20:12:58 -0700
In-Reply-To: <Y2JKEjSridtRubSm@smile.fi.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
         <20221101191023.4150315-4-david.e.box@linux.intel.com>
         <Y2JKEjSridtRubSm@smile.fi.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-02 at 12:44 +0200, Andy Shevchenko wrote:
> On Tue, Nov 01, 2022 at 12:10:17PM -0700, David E. Box wrote:
> > Newer versions of Intel On Demand hardware may have an expanded list of
> > registers to support new features. The register layout is identified by a
> > unique GUID that's read during driver probe. Add support for handling
> > different GUIDs and add support for current GUIDs [1].
> > [1] https://github.com/intel/intel-sdsi/blob/master/os-interface.rst
> 
> Link: tag?

Ack

> 
> ...
> 
> >  #define SDSI_MIN_SIZE_DWORDS		276
> > -#define SDSI_SIZE_CONTROL		8
> >  #define SDSI_SIZE_MAILBOX		1024
> > -#define SDSI_SIZE_REGS			72
> > +#define SDSI_SIZE_REGS			80
> >  #define SDSI_SIZE_CMD			sizeof(u64)
> > +#define SDSI_SIZE_MAILBOX		1024
> 
> Why do you need this second time?

typo

> 
> ...
> 
> > +static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table
> > *table)
> > +{
> > +	switch (table->guid) {
> > +	case SDSI_GUID_V1:
> > +		priv->control_size = 8;
> > +		priv->registers_size = 72;
> > +		break;
> > +	case SDSI_GUID_V2:
> > +		priv->control_size = 16;
> > +		priv->registers_size = 80;
> 
> Maybe it makes sense to use previously defined constants here instead of
> magics?

The constant is used for the file size, which since is static is set to the max.
But I'll add defines for these.

> 
> > +		break;
> > +	default:
> > +		dev_err(priv->dev, "Unrecognized GUID 0x%x\n", table->guid);
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}

