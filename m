Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB785ED107
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiI0XcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiI0XcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:32:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487D1C6A41;
        Tue, 27 Sep 2022 16:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S8UJUP0VBuQngd2OEhP0OtJLPeHHAHk+DG1PtoI2pnk=; b=xRpltdoE+BX4wJj6Dn/xqNhxlx
        dNbrhZ20jxjllsS1ta1wO+7ebIr+chPK780UY/3Y9XqriWy5TXjz53IfQpA4PQyuszNpgBF79SQ90
        MKDt/qDALUhpwL/XrjAZzfRVunyxJkfVw3Ka5tk/dqfXjOlsuK0gfBzsGkVG8CToVfU/QRQ+T3nXY
        1wXjQlbfLxb9c/A3hML8pHwk6Qg0VU+eNHdUV1EmLgPH1LTXTjrJr6hx5jOyiC6Lyorup2B3f6XQb
        VQ5Y5BFREOKh5/3Wy8fn0pJIaHZ2+oVmAwD3b9hu1B7FEM9SmJs+RGTJBR8xNdMndP/c5/HTG1pcl
        VCYMtUqQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odK3O-00D9Po-9y; Tue, 27 Sep 2022 23:31:54 +0000
Date:   Tue, 27 Sep 2022 16:31:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
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
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v6 0/4] Let userspace know when snd-hda-intel needs i915
Message-ID: <YzOH6oV6B6UKb7DF@bombadil.infradead.org>
References: <cover.1652113087.git.mchehab@kernel.org>
 <Ynl7xGy+a9MYjXi1@bombadil.infradead.org>
 <20220920072454.4cf91f24@maurocar-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920072454.4cf91f24@maurocar-mobl2>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 07:24:54AM +0200, Mauro Carvalho Chehab wrote:
> Hi Luis,
> 
> On Mon, 9 May 2022 13:38:28 -0700
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > On Mon, May 09, 2022 at 06:23:35PM +0200, Mauro Carvalho Chehab wrote:
> > > Currently, kernel/module annotates module dependencies when
> > > request_symbol is used, but it doesn't cover more complex inter-driver
> > > dependencies that are subsystem and/or driver-specific.
> > >   
> > 
> > At this pount v5.18-rc7 is out and so it is too late to soak this
> > in for the proper level of testing I'd like to see for modules-next.
> > So I can review this after the next merge window. I'd want to beat
> > the hell out of this and if possible I'd like to see if we can have
> > some test coverage for the intended goal and how to break it.
> 
> Any news with regards to this patch series?

0-day had a rant about a bug with it, it would be wonderful if you can
fix that bug and rebase. Yet again we're now on v6.0-rc7 but it doesn't
mean we can't start testing all this on linux-next. I can just get this
merged to linux-next as soon as this is ready for a new spin, but we
certainly will have to wait until 6.2 as we haven't yet gotten proper
coverage for this on v6.1.

Is there any testing situations you can think of using which can demo
this a bit more separately from existing drivers, perhaps a new
selftests or something?

  Luis
