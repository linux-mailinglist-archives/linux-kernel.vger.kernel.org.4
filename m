Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8466C6FF2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjEKNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbjEKNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54210E70;
        Thu, 11 May 2023 06:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8317064D69;
        Thu, 11 May 2023 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF3AC433EF;
        Thu, 11 May 2023 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683811927;
        bh=oca3P+InscaRA4pHJGwip27OKZH2PogExy8mHm/WhQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuFEV+jnE3lOJ1L9Y0Ct31oKVhU85Numto5xxLdt4NguDQDAXgHCFozjE1QcvOi3g
         wBMs4JlzcSslV+20d/pwdhUPqjoMi60LdZEAa1XaNPM4b/bj3LEmlgQ41pOyLb1/N8
         /j1Jwk7prPAdzmwHtEGQBw370/FZJlZBgAXMxM+M=
Date:   Thu, 11 May 2023 22:32:03 +0900
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
Message-ID: <2023051151-unarmored-expansive-01bd@gregkh>
References: <20230504092142.4190069-1-yixuanjiang@google.com>
 <2023050644-dwarf-shabby-d44d@gregkh>
 <CAGJzVQGxDHa83uV0w4Q35UaGpwNhLpKzcZ5y_qsfd4ELDi+OnA@mail.gmail.com>
 <2023051045-ransack-lullaby-a127@gregkh>
 <CAGJzVQEy2E9WZOgiMtmXq0F=EEcse3YgQdrrqXhBS0dQmwtVGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGJzVQEy2E9WZOgiMtmXq0F=EEcse3YgQdrrqXhBS0dQmwtVGw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:06:42PM +0800, Yixuan Jiang wrote:
> Greg KH <gregkh@linuxfoundation.org> 於 2023年5月10日 週三 下午10:40寫道：
> >
> > On Wed, May 10, 2023 at 07:59:49PM +0800, Yixuan Jiang wrote:
> > > Greg KH <greg@kroah.com> 於 2023年5月6日 週六 下午1:56寫道：
> > > >
> > > > On Thu, May 04, 2023 at 05:21:42PM +0800, yixuanjiang wrote:
> > > > > From: Takashi Iwai <tiwai@suse.de>
> > > > >
> > > > > The existing locking for DPCM has several issues
> > > > > a) a confusing mix of card->mutex and card->pcm_mutex.
> > > > > b) a dpcm_lock spinlock added inconsistently and on paths that could
> > > > > be recursively taken. The use of irqsave/irqrestore was also overkill.
> > > > >
> > > > > The suggested model is:
> > > > >
> > > > > 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> > > > > pcm_mutex is applied always on either the top PCM callbacks or the
> > > > > external call from DAPM, not taken in the internal functions.
> > > > >
> > > > > 2) the FE stream lock is taken in higher levels before invoking
> > > > > dpcm_be_dai_trigger()
> > > > >
> > > > > 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> > > > > lock are taken.
> > > > >
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > [clarification of commit message by plbossart]
> > > > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > > > Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > > > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > > > Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux.intel.com
> > > > > Cc: stable@vger.kernel.org # 5.15.x
> > > > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > > > ---
> > > >
> > > > What is the git commit id of this patch in Linus's tree?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Hi Greg,
> > > For this patch I think it is [3/6] b7898396f4bbe160f546d0c5e9fa17cca9a7d153
> > >
> > > >From https://lore.kernel.org/all/163953384515.1515253.13641477106348913835.b4-ty@kernel.org/
> > > Seems there are total 6 patches.
> > >
> > > [1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
> > >       commit: d8a9c6e1f6766a16cf02b4e99a629f3c5512c183
> > > [2/6] ASoC: soc-pcm: align BE 'atomicity' with that of the FE
> > >       commit: bbf7d3b1c4f40eb02dd1dffb500ba00b0bff0303
> > > [3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
> > >       commit: b7898396f4bbe160f546d0c5e9fa17cca9a7d153
> > > [4/6] ASoC: soc-pcm: serialize BE triggers
> > >       commit: b2ae80663008a7662febe7d13f14ea1b2eb0cd51
> > > [5/6] ASoC: soc-pcm: test refcount before triggering
> > >       commit: 848aedfdc6ba25ad5652797db9266007773e44dd
> > > [6/6] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
> > >       commit: 3aa1e96a2b95e2ece198f8dd01e96818971b84df
> > >
> > > These 6 patches could directly cherry-pick to in 5.15 without conflict.
> >
> > Then please submit them for stable inclusion after you have tested that
> > they all work properly.  But first, what bug is actually needed to be
> > fixed here?  What is not working that this patch series fixes?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> The bug is, in 5.15
> It will always deadlock after stop compress playback.
> 
> The patch A
>   ASoC: soc-compress: Reposition and add pcm_mutex commit:
> aa9ff6a4955fdba02b54fbc4386db876603703b7
> >From patch A comment it is about to fix the issue by adding lock hold
> becasue patch B will check if lock is held.
> 
> The patch B
>   ASoC: soc-pcm: Fix and cleanup DPCM locking commit:
> b7898396f4bbe160f546d0c5e9fa17cca9a7d153
> Patch B remove lock aquire then check if lock is already held.
> 
> In 5.15 it only include patch A then cause the deadlock.
> 
> [  198.670679][    T1] Call trace:
> [  198.670690][    T1]  __switch_to+0x174/0x328
> [  198.670744][    T1]  __schedule+0x5d0/0xaec
> [  198.670784][    T1]  schedule+0xc8/0x134
> [  198.670803][    T1]  schedule_preempt_disabled+0x30/0x50
> [  198.670820][    T1]  __mutex_lock+0x39c/0xa70
> [  198.670845][    T1]  __mutex_lock_slowpath+0x1c/0x2c
> [  198.670862][    T1]  mutex_lock+0x4c/0x104
> [  198.670878][    T1]  soc_pcm_hw_clean+0x38/0x16c            <--
> Patch B will remove lock aquire, if no patch B, it will aquire lock
> again then cause AA deadlock
> [  198.670958][    T1]  dpcm_be_dai_hw_free+0x17c/0x1b4
> [  198.670983][    T1]  soc_compr_free_fe+0x84/0x158             <--
> Patch A aquire the lock
> [  198.671025][    T1]  snd_compr_free+0xac/0x148
> 
> So is it better by revert patch A because purpose of patch A doesn't
> exist in 5.15 ?
> Or just backport full 6 patches series B to 5.15 ?

A full backport is always best.

thanks,

greg k-h
