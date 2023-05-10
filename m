Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9E6FE084
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbjEJOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjEJOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD1359E5;
        Wed, 10 May 2023 07:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D188D64997;
        Wed, 10 May 2023 14:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90D3C43443;
        Wed, 10 May 2023 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683729604;
        bh=TjKlhOtDBWY6sVSqTa1AaoJ81i3ojA2DvjPkKpAO41c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERlwxIN00t6/qzz559l67HTA8LJkeDZi3xxEfyPEXUWbRGMqZgmznIPUkuBuntLPV
         e1p0sE2gUk0AsrvC3MWLaSqRrcNHw/QU4woMV+onoaIIlC1fHets7J0j4baEa8AFmD
         wDf6sV+YW/pTWpZQIPl3609uG38qONAq+gE7QKOQ=
Date:   Wed, 10 May 2023 23:39:57 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yixuan Jiang <yixuanjiang@google.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
Message-ID: <2023051045-ransack-lullaby-a127@gregkh>
References: <20230504092142.4190069-1-yixuanjiang@google.com>
 <2023050644-dwarf-shabby-d44d@gregkh>
 <CAGJzVQGxDHa83uV0w4Q35UaGpwNhLpKzcZ5y_qsfd4ELDi+OnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGJzVQGxDHa83uV0w4Q35UaGpwNhLpKzcZ5y_qsfd4ELDi+OnA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 07:59:49PM +0800, Yixuan Jiang wrote:
> Greg KH <greg@kroah.com> 於 2023年5月6日 週六 下午1:56寫道：
> >
> > On Thu, May 04, 2023 at 05:21:42PM +0800, yixuanjiang wrote:
> > > From: Takashi Iwai <tiwai@suse.de>
> > >
> > > The existing locking for DPCM has several issues
> > > a) a confusing mix of card->mutex and card->pcm_mutex.
> > > b) a dpcm_lock spinlock added inconsistently and on paths that could
> > > be recursively taken. The use of irqsave/irqrestore was also overkill.
> > >
> > > The suggested model is:
> > >
> > > 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> > > pcm_mutex is applied always on either the top PCM callbacks or the
> > > external call from DAPM, not taken in the internal functions.
> > >
> > > 2) the FE stream lock is taken in higher levels before invoking
> > > dpcm_be_dai_trigger()
> > >
> > > 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> > > lock are taken.
> > >
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > [clarification of commit message by plbossart]
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux.intel.com
> > > Cc: stable@vger.kernel.org # 5.15.x
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > ---
> >
> > What is the git commit id of this patch in Linus's tree?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> For this patch I think it is [3/6] b7898396f4bbe160f546d0c5e9fa17cca9a7d153
> 
> >From https://lore.kernel.org/all/163953384515.1515253.13641477106348913835.b4-ty@kernel.org/
> Seems there are total 6 patches.
> 
> [1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
>       commit: d8a9c6e1f6766a16cf02b4e99a629f3c5512c183
> [2/6] ASoC: soc-pcm: align BE 'atomicity' with that of the FE
>       commit: bbf7d3b1c4f40eb02dd1dffb500ba00b0bff0303
> [3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
>       commit: b7898396f4bbe160f546d0c5e9fa17cca9a7d153
> [4/6] ASoC: soc-pcm: serialize BE triggers
>       commit: b2ae80663008a7662febe7d13f14ea1b2eb0cd51
> [5/6] ASoC: soc-pcm: test refcount before triggering
>       commit: 848aedfdc6ba25ad5652797db9266007773e44dd
> [6/6] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
>       commit: 3aa1e96a2b95e2ece198f8dd01e96818971b84df
> 
> These 6 patches could directly cherry-pick to in 5.15 without conflict.

Then please submit them for stable inclusion after you have tested that
they all work properly.  But first, what bug is actually needed to be
fixed here?  What is not working that this patch series fixes?

thanks,

greg k-h
