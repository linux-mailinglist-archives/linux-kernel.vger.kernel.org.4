Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606C25FEC98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJNKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:31:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9F252BF;
        Fri, 14 Oct 2022 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665743516; x=1697279516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptDZqIUqk3munuUKVxS0oc3Bl5qrSZ+Czm3phxJrSjQ=;
  b=eQofEcQcBRytGBhdtkNtgtCCqEubujQsksvsPcYThFSDLHWantJhmwG2
   xQdMoWrk74weH0brIBzLBfVMGPnqPi9zAIqLl+dB/GJj6tBt0eaJull+2
   NgNa46Fq49w6rvFADQjSw1ihDgLZA2rDpKCrVQ7lz398T0sY+B/mmWflH
   v+rm5JzZIRCHugLo1BfKnjCruNMubmBFLdZKkZeVRKw7ifM6OB1mR6QgK
   CuWXKejITuKzk5wdYofrkGlJcoRQ0z2WyJi0+KuJPIVeL39fB8t/uqJ+z
   ul5CF8j3DKtMCevVrOM0gNan+AGV1lfyHOM4AUWmBQxp+HL6FY/ZduTIa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="304083164"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="304083164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 03:31:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="660688519"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="660688519"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 03:31:52 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 370C720146;
        Fri, 14 Oct 2022 13:31:50 +0300 (EEST)
Date:   Fri, 14 Oct 2022 10:31:50 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: i2c: ov5645: Use runtime PM
Message-ID: <Y0k6lrytZctR/UnX@paasikivi.fi.intel.com>
References: <20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0Ulvmyg8rBOPbRF@paasikivi.fi.intel.com>
 <CA+V-a8v6ZGC7Ea6zdWGcLVyyq2Q=pUb0C_OwHWjFqSmuo5f-ZA@mail.gmail.com>
 <CA+V-a8vkB=Fok5S-L_zLT+unxuuSJJk+pkeS52N_kcugCoeT6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8vkB=Fok5S-L_zLT+unxuuSJJk+pkeS52N_kcugCoeT6w@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Oct 12, 2022 at 07:55:25PM +0100, Lad, Prabhakar wrote:
> On a closer look, I can move the above after registering the subdev,
> but I can get rid of err_pm_runtime label as PM is enabled further up
> the code path to detect the senosr.
> 
> If you are OK with this i'll post a v2 along with the below two
> patches + the suggestions you mentioned earlier on this patch.

Sounds good to me.

-- 
Sakari Ailus
