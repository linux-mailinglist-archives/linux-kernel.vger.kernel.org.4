Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC45263D9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiK3Ptq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiK3Pto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:49:44 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6361EEC3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:49:40 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id i80so1327822ioa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cITkc4ydx3t5/WaE8B5C64mzt1Dr4iTKfrMxsULtWPc=;
        b=Uy+DDhU4KWNCz4MeUi8ThR7KIclQ1LieLw0rWkPEBf4NX8Ph3SIGeBRdZGkwVg5BsC
         dfxDBeN3+ZPXROGSwwCjAOZVCHechH+KMEJcMGuBIsNdgi1fazzNt9MCXQpXaHrhEYqJ
         Bcq1QY0JVJr737F9dJ0qI9L6814xZjqjUJSNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cITkc4ydx3t5/WaE8B5C64mzt1Dr4iTKfrMxsULtWPc=;
        b=Ix2rZNhaYcI0PtBKYjNBupuBiWkceYtpzIGFr/OsGcaJg7P/MCCXEHcPqc390oqMji
         SlivUsbs13mVff3TwJNGdmovcqKh96YUXRpXDM0sNkR/ccQi2q0+jcOnC+5jMEGydkt1
         j/1ucqUaiEW24Befs4Sek8a8CVCLi//4Jouv2nKAxWxmFzHz/6uFEf3wfYF+184DQw+6
         oB7JpmB91nUiNvbbfJhWhV4QqxKFtVHJt/z4smpLOy00bjZlvo1tMKzz8GHzMceE+/uF
         pOrLbMeroGjL/ItxcNetTMP6k7iLp1DzuoKTzW5kFeOUJevc6wwcUMWTEayLn6HiQDrM
         prLQ==
X-Gm-Message-State: ANoB5pmLbRNWrhEhXlQkChQ0DTtOiEl18CIJpZxw8hXYQR7M6I3nfJXB
        74NALyPzRvllXVKH82xTcLXgMXtNpTYNk1d9
X-Google-Smtp-Source: AA0mqf61EtPLPQC6LRJyNc+VkhduN7NbHqyrFXtKS/F/vF2jbQgVpF4enmrPIfucdFy0MUNVeQz0Yg==
X-Received: by 2002:a02:cb88:0:b0:38a:db8:d8b6 with SMTP id u8-20020a02cb88000000b0038a0db8d8b6mr279283jap.288.1669823379704;
        Wed, 30 Nov 2022 07:49:39 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id t8-20020a02b188000000b003762327da9bsm688700jah.89.2022.11.30.07.49.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:49:37 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id s16so5610170iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:49:37 -0800 (PST)
X-Received: by 2002:a92:ca8b:0:b0:303:19d2:9def with SMTP id
 t11-20020a92ca8b000000b0030319d29defmr6089993ilo.21.1669823377096; Wed, 30
 Nov 2022 07:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v4-0-51ca64b7f2ab@chromium.org>
 <5171929e-b750-d2f1-fec9-b34d76c18dcb@linux.intel.com> <87mt8bqaca.wl-tiwai@suse.de>
 <16ddcbb9-8afa-ff18-05f9-2e9e01baf3ea@linux.intel.com> <87edtmqjtd.wl-tiwai@suse.de>
 <alpine.DEB.2.22.394.2211291355350.3532114@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2211291355350.3532114@eliteleevi.tm.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 30 Nov 2022 16:49:26 +0100
X-Gmail-Original-Message-ID: <CANiDSCsGZBo=C+Bep8TQp15mA+-4ZRCPwSJzyndFuwokt7Byyw@mail.gmail.com>
Message-ID: <CANiDSCsGZBo=C+Bep8TQp15mA+-4ZRCPwSJzyndFuwokt7Byyw@mail.gmail.com>
Subject: Re: [PATCH v4] ALSA: core: Fix deadlock when shutdown a frozen userspace
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just sent a v6 that only avoids unregistering the clients during
kexec... let me know if that works for you

Thanks!

On Tue, 29 Nov 2022 at 13:12, Kai Vehmanen <kai.vehmanen@linux.intel.com> wrote:
>
> Hi
>
> On Tue, 29 Nov 2022, Takashi Iwai wrote:
>
> > On Mon, 28 Nov 2022 18:26:03 +0100, Pierre-Louis Bossart wrote:
> > > As Kai mentioned it, this step helped with a S5 issue earlier in 2022.
> > > Removing this will mechanically bring the issue back and break other
> > > Chromebooks.
> >
> > Yeah I don't mean that this fix is right, either.  But the earlier fix
> > has apparently a problem and needs another fix.
> >
> > Though, it's not clear why the full unregister of clients is needed at
> > the first place; judging only from the patch description of commit
> > 83bfc7e793b5, what we want is only to shut up the further user space
> > action?  If so, just call snd_card_disconnect() would suffice?
>
> I think the snd_card_disconnect() is what we are looking after here, but
> it's just easiest to do via unregister in SOF as that will trigger will
> look up the platform device, unregister it, and it eventually the driver
> owning the card will do the disconnect. Possibility for sure to do a more
> direct implementation and not run the full unregister.
>
> On the other end of the solution spectrum, we had this alternative to let
> user-space stay connected and just have the DSP implementations handle
> any pending work in their respective shutdown handlers. I.e. we had
> "ASoC: SOF: Intel: pci-tgl: unblock S5 entry if DMA stop has failed"
> https://github.com/thesofproject/linux/pull/3388
>
> This was eventually dropped (and never sent upstream) as 83bfc7e793b5 got
> the same result, and covered all SOF platforms with a single code path.
> Bringing this back is of course one option, but then this might suprise
> other platforms (which might have got used to user-space getting
> disconnected at shutdown via 83bfc7e793b5).
>
> Br, Kai



-- 
Ricardo Ribalda
