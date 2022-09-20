Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63465BDC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiITF0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiITFZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:25:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B45B785;
        Mon, 19 Sep 2022 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663651534; x=1695187534;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuDq04V3ERIqON4UuLH1RmjGkFR75KWm8lnYzEvFeDI=;
  b=bwThOS93ImKi8FoVPR0KilzgeEBl7U1tFUSXGrqMPQT/t0SerPkn90gq
   4QuqlXw7h3JV4zwYjylQaiWQXBt9eLkZ6c6UpFIGwy4nc/ofTSacckHNJ
   BLo24M4wwT2Ya51A3tm/ZB4EDL/vNU6+t4PI8bsk4cQcBkI7J8DZe+2Fc
   Opoi9aHtid8M7RBnIjKYP3a+1OsGsQeLUOSDcJIB0+F73dDtN8PGe6loG
   VIP5G5UkyE8Ic7xmNjbeA1VKvF1iyHODw25linVuvj/Gs2cvfGkm0n71T
   MOai9PMJXqxi4mPf1TAMqOU5kWXHW/T/dpP2deGr1IuP8vYrnSltndCzq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279981349"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279981349"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 22:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="794124954"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 19 Sep 2022 22:25:01 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.59.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C58B4580713;
        Mon, 19 Sep 2022 22:24:56 -0700 (PDT)
Date:   Tue, 20 Sep 2022 07:24:54 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH v6 0/4] Let userspace know when snd-hda-intel needs i915
Message-ID: <20220920072454.4cf91f24@maurocar-mobl2>
In-Reply-To: <Ynl7xGy+a9MYjXi1@bombadil.infradead.org>
References: <cover.1652113087.git.mchehab@kernel.org>
        <Ynl7xGy+a9MYjXi1@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On Mon, 9 May 2022 13:38:28 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Mon, May 09, 2022 at 06:23:35PM +0200, Mauro Carvalho Chehab wrote:
> > Currently, kernel/module annotates module dependencies when
> > request_symbol is used, but it doesn't cover more complex inter-driver
> > dependencies that are subsystem and/or driver-specific.
> >   
> 
> At this pount v5.18-rc7 is out and so it is too late to soak this
> in for the proper level of testing I'd like to see for modules-next.
> So I can review this after the next merge window. I'd want to beat
> the hell out of this and if possible I'd like to see if we can have
> some test coverage for the intended goal and how to break it.

Any news with regards to this patch series?

Regards,
Mauro
