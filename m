Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2637D62BF40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiKPNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiKPNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:19:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E017421;
        Wed, 16 Nov 2022 05:19:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p21so16393634plr.7;
        Wed, 16 Nov 2022 05:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpqKb4lhf4Ox3aXbS6ZVbIYbgJNdN32hGzbeNBKgyKo=;
        b=H7X/Ph3K8hi9qxqMrkAU+OPdQ+wgInpmZ4tDynQUM1wiGAEqzDDX4ZyZrKtKdK7FSu
         Aw3kgSlmvqJMBENX3K9foSEeXv2MSrXszIFk8b8THbmYibbVSudEtB+NSRzP6GGHZFai
         w9khhfwcvwTpAvIsq2nPHJfZFDiV1neEASz1asDGoocEzXc8SyNi1UOPzA5Z2Hge6y+C
         XL7dCVSEQWm+gCrMFCbGnb/yaTXp8uDRN9EeTnoav3UYBbApRq4tdv9da4ylrnykNQlm
         oyFHamJyCLdWaqJFTsEYE++8a0qLxopgIQFC779jEVVcEOX8RG7KDu8zVlonDF5RuzzO
         trfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpqKb4lhf4Ox3aXbS6ZVbIYbgJNdN32hGzbeNBKgyKo=;
        b=PRdyYVqUFTwBTy5tCiQ4HXDJ67Ek+i1YyOTMwq7TxW+PfkWSYbka7Q404RlXbfJrBl
         7icN4yw3zjrUl/3E4azUKC8BjiINgzjP+i8T+HmdctZC0q+EFC7Nr0pH7Eo7mrQhhFhy
         qdnhJZwP2sHuJgbi7l9pe3ddnxKFXEdx/VGUv0njf4zjdKKVENOoKd7Se4L0GqIpQJ7b
         Pzoe96nG3Ev9ImLw8iy3o6M3Bdl3UTYMAfi+Vl06GO7nxSlOyivdjEAYAMsa9xGIkwZ4
         +skP95UJIMcp42gdMXyeTG5u121cSq3E+bXEHLwy69wvdf8gai2kyZz/zF1EbLMSGigC
         P55g==
X-Gm-Message-State: ANoB5plF5rFL3yvFe1O+XEE+ZK9jh19JUGaltyuFlswH5thR8FD2cVSt
        bTQknQ6YeydKsR3/NlLMepE=
X-Google-Smtp-Source: AA0mqf5mGKgsBRp23LZ+hvij7pemhsMYWSfdR5H6yuc8o94A+nlAEuzXKU/INbG8bPLNjQnRZxtgKg==
X-Received: by 2002:a17:902:a586:b0:188:5681:4dc7 with SMTP id az6-20020a170902a58600b0018856814dc7mr9117157plb.97.1668604773213;
        Wed, 16 Nov 2022 05:19:33 -0800 (PST)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b00217cdc4b0a5sm1533616pjb.16.2022.11.16.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:19:32 -0800 (PST)
Date:   Wed, 16 Nov 2022 05:19:28 -0800
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        imv4bel@gmail.com
Subject: Re: [PATCH] media: dvb-core: Fix UAF due to refcount races at
 releasing
Message-ID: <20221116131928.GA7144@ubuntu>
References: <20220908132754.30532-1-tiwai@suse.de>
 <87sfklgozd.wl-tiwai@suse.de>
 <87k056dekm.wl-tiwai@suse.de>
 <Y3TEk7Nr3yAQIozQ@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TEk7Nr3yAQIozQ@eldamar.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 12:08:03PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Tue, Oct 11, 2022 at 09:06:33AM +0200, Takashi Iwai wrote:
> > On Wed, 21 Sep 2022 09:34:30 +0200,
> > Takashi Iwai wrote:
> > > 
> > > On Thu, 08 Sep 2022 15:27:54 +0200,
> > > Takashi Iwai wrote:
> > > > 
> > > > The dvb-core tries to sync the releases of opened files at
> > > > dvb_dmxdev_release() with two refcounts: dvbdev->users and
> > > > dvr_dvbdev->users.  A problem is present in those two syncs: when yet
> > > > another dvb_demux_open() is called during those sync waits,
> > > > dvb_demux_open() continues to process even if the device is being
> > > > closed.  This includes the increment of the former refcount, resulting
> > > > in the leftover refcount after the sync of the latter refcount at
> > > > dvb_dmxdev_release().  It ends up with use-after-free, since the
> > > > function believes that all usages were gone and releases the
> > > > resources.
> > > > 
> > > > This patch addresses the problem by adding the check of dmxdev->exit
> > > > flag at dvb_demux_open(), just like dvb_dvr_open() already does.  With
> > > > the exit flag check, the second call of dvb_demux_open() fails, hence
> > > > the further corruption can be avoided.
> > > > 
> > > > Also for avoiding the races of the dmxdev->exit flag reference, this
> > > > patch serializes the dmxdev->exit set up and the sync waits with the
> > > > dmxdev->mutex lock at dvb_dmxdev_release().  Without the mutex lock,
> > > > dvb_demux_open() (or dvb_dvr_open()) may run concurrently with
> > > > dvb_dmxdev_release(), which allows to skip the exit flag check and
> > > > continue the open process that is being closed.
> > > > 
> > > > Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > 
> > > Any review on this?
> > > 
> > > FWIW, now CVE-2022-41218 is assigned for those bugs as a security
> > > issue.
> > 
> > A gentle ping again.
> > 
> > Or if any other fix for this security issue is already available,
> > please let me know.
> 
> is this correct, the fix is yet missing (or was it fixed by other
> means?).

This patch has been re-send and has been missing for a long time:
https://lore.kernel.org/linux-media/20221031100245.23702-1-tiwai@suse.de/

However, I noticed yesterday that the status of the re-send patch 
changed to 'accpet':
https://patchwork.linuxtv.org/project/linux-media/patch/20221031100245.23702-1-tiwai@suse.de/

But there was no other feedback.


Regards,
Hyunwoo Kim
