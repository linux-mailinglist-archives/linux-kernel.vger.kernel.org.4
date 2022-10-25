Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AE60CB83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJYMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJYMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7CCEC531
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CF4618F5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B3AC433C1;
        Tue, 25 Oct 2022 12:08:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CrVd9HRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666699714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lDTzz8RCtiO8TmkrYzfZqplpH5tp9ZvYdKoLxqYoZgw=;
        b=CrVd9HReLy5CSqBBbmToAhk3P2sFOIwgsfi2fIs9mP4dYkJ+WufkgyZDKGUwD12i4tZOqI
        9O2TnmESRupj37Z7svdhOU26hAbpHpVOJkK+SvbYTYbi6d+nsG7bl2NnekwTTS6kHAtCSS
        7LKKuLADDA5VyJ+JapFl8+33A33n+ag=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74f0cab3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Oct 2022 12:08:33 +0000 (UTC)
Date:   Tue, 25 Oct 2022 14:08:29 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ALSA: rme9652: use explicitly signed char
Message-ID: <Y1fRvWfcU4NT1HTU@zx2c4.com>
References: <202210250456.vKv5zoLb-lkp@intel.com>
 <20221025000313.546261-1-Jason@zx2c4.com>
 <87bkq0s9rw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkq0s9rw.wl-tiwai@suse.de>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 08:21:55AM +0200, Takashi Iwai wrote:
> On Tue, 25 Oct 2022 02:03:13 +0200,
> Jason A. Donenfeld wrote:
> > 
> > With char becoming unsigned by default, and with `char` alone being
> > ambiguous and based on architecture, signed chars need to be marked
> > explicitly as such. This fixes warnings like:
> > 
> > sound/pci/rme9652/hdsp.c:3953 hdsp_channel_buffer_location() warn: 'hdsp->channel_map[channel]' is unsigned
> > sound/pci/rme9652/hdsp.c:4153 snd_hdsp_channel_info() warn: impossible condition '(hdsp->channel_map[channel] < 0) => (0-255 < 0)'
> > sound/pci/rme9652/rme9652.c:1833 rme9652_channel_buffer_location() warn: 'rme9652->channel_map[channel]' is unsigned
> > 
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: alsa-devel@alsa-project.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Applied now.  Thanks!

Thanks. For this and the other patch, applied for 6.1 or 6.2?

Jason
