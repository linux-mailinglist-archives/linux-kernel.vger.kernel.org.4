Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8099645A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiLGM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:56:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A35133D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670417766; x=1701953766;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0mCc63PYXRSLNyoU3BugGf4BruhyAiG1jc49h4GgrDo=;
  b=Sburl5FwohTb4OX9x6/LvQDmCB7GVEZcEjKDsyoFca68Wyk56O9YXlLN
   pBhl2Tj8O0Vo+Y70cd0X6A1P0JGFBKWNsY3LP3n7QA6zkf5eN+N1f1MEj
   rfGzoD5OWS+0GS3Z5zD/lN4A03iC9ROeZ0sD/e7WEVLn7qUh/cRZrQ3dS
   Haa7pBxOaiyXEgEICd3OquR5fXQSDz7N6x9MSagftm3JUmqGP/m6p300f
   Bo/5bOrDoIckXlJaMXItYuD16irXbF1e3r9fqojelzJVbjw8KqZlwAku4
   +CBQibsgCDvEsaTdXHTPB/hZbkVCpURUzxfEJNgL/QRvpMuxsYIV/tU4x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="318026083"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="318026083"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 04:56:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="624292451"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="624292451"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 04:56:03 -0800
Date:   Wed, 7 Dec 2022 14:55:45 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Takashi Iwai <tiwai@suse.de>
cc:     Zhen Ni <nizhen@uniontech.com>, Jaroslav Kysela <perex@perex.cz>,
        tiwai@suse.com, Alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH] ASoc: SOF: Fix sof-audio-pci-intel-tgl shutdown timeout
 during hibernation
In-Reply-To: <87cz8va4hc.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2212071452350.3532114@eliteleevi.tm.intel.com>
References: <20221207102229.25962-1-nizhen@uniontech.com> <87cz8va4hc.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2022, Takashi Iwai wrote:

> On Wed, 07 Dec 2022 11:22:29 +0100, Zhen Ni wrote:
> > On Dell Latitude 3420 Notebook, sof-audio-pci-intel-tgl may fail to shutdown
> > sporadically during hibernation as following log:
> > 
> > [   43.281110] PM: Image saving done
> > [   43.281699] PM: hibernation: Wrote 2828852 kbytes in 2.78 seconds(1017.57 MB/s)
> > [   43.282359] PM: SI
> > [   43.345156] kvm: exiting hardware virtualization
> > [   43.345865] auxiliary snd_sof.hda-probes.0: shutdown
>
> 
> It's a known problem and being discussed (although it's a slightly
> different code path):
>   https://lore.kernel.org/r/20221127-snd-freeze-v4-0-51ca64b7f2ab@chromium.org

thanks Zhen Ni for the report and patch. We have a fix candidate
in review+testing at:
https://github.com/thesofproject/linux/pull/4072

... that should help in your case as well. Once testing is complete,
we'll be sending the patch series to alsa-devel.

Br, Kai
