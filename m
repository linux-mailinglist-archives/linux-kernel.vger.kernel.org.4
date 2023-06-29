Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B56742124
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjF2Hfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjF2Hek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:34:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBBFE58;
        Thu, 29 Jun 2023 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688024079; x=1719560079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/axrSWOdtVz/Ckd0cZbOJm+/YGfdBtp+s+fpBkWAL+M=;
  b=KoUp4AERObC8dxqV0BgNgGgyeSBE0QSqfXdwyzAKGjUdthoUTRo1xlUR
   XZs8iienuP3RNCLaebwZxtR6rGZJkMSTuzYNKBU5aYyteF2wKz2pXvEQP
   SoOgQj7FgDwsmd+tdm2s/OUqf5n8zZR7O/Nkg8UeRHJJ17gyRYtuN51Wo
   3bxaNXybVzhAXPecuOJxTw+rQdfahYkuBVYBjz79VW725l3bXagqjBszK
   27Gz4Q+zT8l1sHMQE95VIeb1KfrbGe2n+RZlDGpvfPgDQtYraAfJmh2uE
   b7cCs0Q5+DSsQIQ4HkKcw6z1spxQtSF6e0MXMNffO9eiTixu1EupJ5mE8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="364592006"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="364592006"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 00:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720472979"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="720472979"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 00:34:36 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id E0FA01207EB;
        Thu, 29 Jun 2023 10:34:33 +0300 (EEST)
Date:   Thu, 29 Jun 2023 07:34:33 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] media: staging: imgu: use array_size
Message-ID: <ZJ00CUwiH6DBtape@kekkonen.localdomain>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-24-Julia.Lawall@inria.fr>
 <alpine.DEB.2.22.394.2306271933480.3150@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2306271933480.3150@hadrien>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia, Bingbu,

On Tue, Jun 27, 2023 at 07:35:47PM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 23 Jun 2023, Julia Lawall wrote:
> 
> > Use array_size to protect against multiplication overflows.
> >
> > The changes were done using the following Coccinelle semantic patch:
> >
> > // <smpl>
> > @@
> >     expression E1, E2;
> >     constant C1, C2;
> >     identifier alloc = {vmalloc,vzalloc};
> > @@
> >
> > (
> >       alloc(C1 * C2,...)
> > |
> >       alloc(
> > -           (E1) * (E2)
> > +           array_size(E1, E2)
> >       ,...)
> > )
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  drivers/staging/media/ipu3/ipu3-mmu.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
> > index cb9bf5fb29a5..9c4adb815c94 100644
> > --- a/drivers/staging/media/ipu3/ipu3-mmu.c
> > +++ b/drivers/staging/media/ipu3/ipu3-mmu.c
> > @@ -464,7 +464,7 @@ struct imgu_mmu_info *imgu_mmu_init(struct device *parent, void __iomem *base)
> >  	 * Allocate the array of L2PT CPU pointers, initialized to zero,
> >  	 * which means the dummy L2PT allocated above.
> >  	 */
> > -	mmu->l2pts = vzalloc(IPU3_PT_PTES * sizeof(*mmu->l2pts));
> > +	mmu->l2pts = vzalloc(array_size(IPU3_PT_PTES, sizeof(*mmu->l2pts)));
> >  	if (!mmu->l2pts)
> >  		goto fail_l2pt;
> 
> I think that this patch can be dropped.  Since it is a multiplcation of
> two constants, if there is an overflow, I guess the compiler would detect
> it?

Indeed. vcalloc() would be perhaps nicer but the original isn't wrong
either.

-- 
Kind regards,

Sakari Ailus
