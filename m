Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB17460CB43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJYLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiJYLuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:50:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C92F64E;
        Tue, 25 Oct 2022 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666698617; x=1698234617;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Xb9y1sL2yBm6531F/bavSgt2tsu3zlbPV+g/ABHSgpA=;
  b=WIuqe/7P678zJpSd9HHWtDCcvqxqBswhONzwoVvcCucTqrKAgQE/Hskx
   XVjZxr9GVTJV4FOaXSE0yg8G5OjRJ404h1feLi40Dk6b6Z/1Eo5F0Gbvz
   FMJhvJCIukmDQaN3aWwVKE+z1xNGIiBigB81KwbGL183rhy7tyIOcC7Ud
   bpduC/hmvd8zwGCDKs9OPA9lrcr1wk85MHf1jXmnLkiJwPLdkxalWdhZD
   SbuOuBTu2Q5SjhCqXAzkw4Q/T/oqYez5b50JCE1lD+KkdJXXz8qgMFCw5
   p1RVa7UOxc6wwwvY8Mx3BFFydmUOTDDflUV/FQXYZvU/13gzJ2OhzUBwp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334248926"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="334248926"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 04:50:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694924313"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="694924313"
Received: from pweidel-mobl.ger.corp.intel.com ([10.252.44.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 04:50:15 -0700
Date:   Tue, 25 Oct 2022 14:50:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
In-Reply-To: <GV1PR10MB5892040CAC0FED4857BB771AE0319@GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <d253f864-5585-ce29-b9b4-92a0e2bc374@linux.intel.com>
References: <20221024130114.2070-1-daniel.starke@siemens.com> <20221024130114.2070-3-daniel.starke@siemens.com> <403445fd-fc99-290-2a5d-cd7c18fb715c@linux.intel.com> <GV1PR10MB5892040CAC0FED4857BB771AE0319@GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022, Starke, Daniel wrote:

> > > +	n1 = FIELD_GET(PN_N_FIELD_N1, le16_to_cpu(params->n_bits));
> > 
> > Should this be using get_unaligned...()?
> 
> Is this really necessary if the structure is already __packed? I did not
> receive any warning by the compiler.

It would be arch dependent to begin with. But honestly, I'm not entirely 
certain here myself.

Documentation/core-api/unaligned-memory-access.rst claims compiler would 
indeed do extra work to ensure access of unaligned member in a packed 
struct is handled ok. But then you call le16_to_cpu() for the member field 
which is full of cast magic so I'd be a bit hesitant to claim the 
knowledge about the unalignment is carried all the way down there through 
those casts.

Other subtle detail is the reply side struct which is allocated from stack
and with packed compiler is allowed (I don't know if it does that or not)
to make the struct unaligned as well (so perhaps put_unaligned would be 
necessary there too if packed is retained).

If you want my recommendation, I'd just remove the packed altogether from 
the struct because there seems to be no natural holes in it, use 
get_unaligned for the receive side, and add this build time check:

static_assert(sizeof(struct gsm_dlci_param_bits) == 8);

If lkp builds all its current archs fine with that static_assert(), I'd be 
pretty sure the struct that the unpacked struct is ok on all archs. Would 
it ever stop being true on any arch/compiler setting, the assert would 
catch it right away.


-- 
 i.

