Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92B6F5A97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjECPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjECPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:06:30 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6C4C15
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:06:28 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-77d05b9c4a6so1406666241.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683126388; x=1685718388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2G6zCVpZBA8Bi5Qg2u57sCLo1L4bahHOTfcF61tOCo=;
        b=ELi7xLe+e1zOXrvGYuZnxRx7kT7aKmwPLfkSdKiQ8dDXT+4VWlwgjNzSe5Q1rLlB3W
         jFB+rZDpW8JIJ2KGMUFSFSj0ra3q/K4pW6G2puKqCMrMCahEVjx86fiSd3MdaxeNu59W
         wAjVfltdQUHiTiw+X8S/aJ8azIjFAHoRGax5N3QZdjQvNoXNo52nxrn02RcVLW/uiBqf
         gXc1XhoTdyr+m5Iri6qdvVVFOyzoAV51If5zEN56nmFlpCuFz5inQE6IzzBac3AdjqZB
         sXnMTHsKKAlFW7NpCge06vPLp7LzIFeONvJJXJZgq+3ipjOe+frhzLcHBvKyDI5W6r5M
         XjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126388; x=1685718388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2G6zCVpZBA8Bi5Qg2u57sCLo1L4bahHOTfcF61tOCo=;
        b=Z/IPGJIsccyc4X3g5ZUaDOEwYQ0Z1UeVhINoV0J8sCet4gGR77svT9hE83xfHPcIEL
         vvGoLz4MmbvMVJscOzwasL0EKtdRYl5hqMsEzrpFrIeYbbs6PohIWLlpWSEpfX83rly8
         yEwbEWjHrpQtG9r7FxFWJ6SiKxRoeRH1zN16xcwHDJWJ3h8jZ+3B1FARcIwXZnuY4q5/
         GOL2kBqY6+MlQ+iPau8rZIh24h5132IspGIEq2zpAtp67vuaNraezPA6g7Jxs2F9kLvw
         wwAnnTyyoL5CQLSLz1AI9reLr3U0E/aAx4qiaBs/KFxHe+ozeVlGJG4n5XQdMHBwIQ7u
         qnAQ==
X-Gm-Message-State: AC+VfDxy+7rvvzgvjl36K0FvugllM2vSX2zG6r43xbMWogap7WX3HQVL
        YroxzUsHfOm84n5uGQBryWcOdcUPYaq89QurYSM0dybVCnA=
X-Google-Smtp-Source: ACHHUZ7HLbZLB6d12oS8ucEaSgkooAfF9tSc1BPKuGGdL08er5o1oim9Jgtbwz5SYgbaag+9mfjbiVsnbEU0e+HZtZg=
X-Received: by 2002:a67:ed85:0:b0:42c:78a3:bd4c with SMTP id
 d5-20020a67ed85000000b0042c78a3bd4cmr1783772vsp.4.1683126387815; Wed, 03 May
 2023 08:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
 <ZE9ngFLRqLkN6faH@ugly> <CAAJw_ZtKnZ3QruicqFRG_TLV0Ltbc8LSvdJSCEQRkr5GMSWvCw@mail.gmail.com>
 <63bcc1eb-b0f5-4da1-0a22-31e0c86c0851@gmail.com> <07f50016-5e24-56f8-0d02-df8d237059b6@gmail.com>
 <87jzxqne3z.wl-tiwai@suse.de> <CAAJw_ZsGZaypS1C=XwLDdNFQ9jbF8RFOOiEY0ZSWQvFmWx+Gwg@mail.gmail.com>
 <87a5ylcyw4.wl-tiwai@suse.de>
In-Reply-To: <87a5ylcyw4.wl-tiwai@suse.de>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Wed, 3 May 2023 23:06:16 +0800
Message-ID: <CAAJw_Ztu=Ki91wJUTAHrtW6xqaHvn-ZPii6bCoAjK_YmigZ3TQ@mail.gmail.com>
Subject: Re: linux-6.4 alsa sound broken
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 9:45=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 03 May 2023 14:19:54 +0200,
> Jeff Chua wrote:
> >
> > On Wed, May 3, 2023 at 2:06=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wro=
te:
> > >
> > > On Wed, 03 May 2023 06:37:48 +0200,
> > > Bagas Sanjaya wrote:
> > > >
> > > > On 5/3/23 11:34, Bagas Sanjaya wrote:
> > > > >> Just send .. in another email. If the atttachment got stripped o=
ff,
> > > > >> please let me know.
> > > > >>
> > > > >>
> > > > >
> > > > > I don't see your attachment. Can you please post the link
> > > > > to your test file on file storage hosting instead?
> > > > >
> > > >
> > > > Oops, I don't see the attachment on your reply at [1]. Sorry for th=
e
> > > > inconvenience.
> > > >
> > > > [1]: https://lore.kernel.org/lkml/CAAJw_ZveoPfnBsSkHZqmLiVWATcOosR-=
-6Ds4cdekdi=3Dt1yV7A@mail.gmail.com/
> > >
> > > I see no attachment of the recorded sound.  In the mail above, only
> > > Side_Right.wav was attached, and this is the same file in
> > > /usr/share/sounds/alsa/.
> > >
> > > But, I wonder how you played a mono channel file with "hw:1,0" PCM.
> > > Isn't this a HD-audio device?
> > > Usually HD-audio codec can't play a mono file.  For example, on my
> > > machine with a Realtek codec fails like:
> > >
> > > % aplay -Dhw:0,0 Side_Right.wav
> > > Playing WAVE 'Side_Right.wav' : Signed 16 bit Little Endian, Rate 480=
00 Hz, Mono
> > > aplay: set_params:1358: Channels count non available
> > >
> > > So, if it works on yours, please show the output of playback with
> > > aplay -v option.  This will show more details.
> >
> > # aplay -v
> > Playing WAVE '/local/share/sounds/alsa/Side_Right.wav' : Signed 16 bit
> > Little Endian, Rate 48000 Hz, Mono
> > Plug PCM: Route conversion PCM (sformat=3DS32_LE)
> >   Transformation table:
> >     0 <- 0
> >     1 <- 0
> > Its setup is:
> >   stream       : PLAYBACK
> >   access       : RW_INTERLEAVED
> >   format       : S16_LE
> >   subformat    : STD
> >   channels     : 1
> >   rate         : 48000
> >   exact rate   : 48000 (48000/1)
> >   msbits       : 16
> >   buffer_size  : 16384
> >   period_size  : 1024
> >   period_time  : 21333
> >   tstamp_mode  : NONE
> >   tstamp_type  : MONOTONIC
> >   period_step  : 1
> >   avail_min    : 1024
> >   period_event : 0
> >   start_threshold  : 16384
> >   stop_threshold   : 16384
> >   silence_threshold: 0
> >   silence_size : 0
> >   boundary     : 4611686018427387904
> > Slave: Soft volume PCM
> > Control: PCM Playback Volume
> > min_dB: -51
> > max_dB: 0
> > resolution: 256
> > Its setup is:
> >   stream       : PLAYBACK
> >   access       : MMAP_INTERLEAVED
> >   format       : S32_LE
> >   subformat    : STD
> >   channels     : 2
> >   rate         : 48000
> >   exact rate   : 48000 (48000/1)
> >   msbits       : 32
> >   buffer_size  : 16384
> >   period_size  : 1024
> >   period_time  : 21333
> >   tstamp_mode  : NONE
> >   tstamp_type  : MONOTONIC
> >   period_step  : 1
> >   avail_min    : 1024
> >   period_event : 0
> >   start_threshold  : 16384
> >   stop_threshold   : 16384
> >   silence_threshold: 0
> >   silence_size : 0
> >   silence_size : 0
> >   boundary     : 4611686018427387904
> > Slave: Direct Stream Mixing PCM
> > Its setup is:
> >   stream       : PLAYBACK
> >   access       : MMAP_INTERLEAVED
> >   format       : S32_LE
> >   subformat    : STD
> >   channels     : 2
> >   rate         : 48000
> >   exact rate   : 48000 (48000/1)
> >   msbits       : 32
> >   buffer_size  : 16384
> >   period_size  : 1024
> >   period_time  : 21333
> >   tstamp_mode  : NONE
> >   tstamp_type  : MONOTONIC
> >   period_step  : 1
> >   avail_min    : 1024
> >   period_event : 0
> >   start_threshold  : 16384
> >   stop_threshold   : 16384
> >   silence_threshold: 0
> >   silence_size : 0
> >   boundary     : 4611686018427387904
> > Hardware PCM card 0 'HDA Intel PCH' device 0 subdevice 0
> > Its setup is:
> >   stream       : PLAYBACK
> >   access       : MMAP_INTERLEAVED
> >   format       : S32_LE
> >   subformat    : STD
> >   channels     : 2
> >   rate         : 48000
> >   exact rate   : 48000 (48000/1)
> >   msbits       : 32
> >   buffer_size  : 16384
> >   period_size  : 1024
> >   period_time  : 21333
> >   tstamp_mode  : ENABLE
> >   tstamp_type  : MONOTONIC
> >   period_step  : 1
> >   avail_min    : 1024
> >   period_event : 0
> >   start_threshold  : 1
> >   stop_threshold   : 4611686018427387904
> >   silence_threshold: 0
> >   silence_size : 4611686018427387904
> >   boundary     : 4611686018427387904
> >   appl_ptr     : 0
> >   hw_ptr       : 0
>
> OK, that explains.  This is a completely different from the
> configuration with hw:X,Y I expected from your description.
> So, this is with dmix, and it indeed relies on the auto-silencing, so
> the commit must be relevant.
>
>
> > > Last but not least, please double-check that the problem is really
> > > gone after reverting the commit 9f656705c5fa.  The commit is about th=
e
> > > auto-silencing, and it should be irrelevant unless the application
> > > gives non-zero silence_size sw_params, and aplay doesn't set up it at
> > > all.
> >
> > 100% sure. I just compiled the latest linux git pull. Rebooted. Tested
> > that the problem exists, and revert just that patch
> > (9f656705c5faa18afb26d922cfc64f9fd103c38d), and the problem went away!
> >
> > Sorry about the recorded.wav file that I attached earlier ... didn't
> > realized that when I recorded via the loop-back, I could heard that it
> > was "corrupted" on the unpatched kernel, but when I play back the same
> > file on the "patched" kernel, the sound played ok.
> >
> > So, loop-back using the following did not capture the problem ...
> > # arecord -D hw:1,0,0 -f S16_LE -r 48000 recorded.wav
> > # aplay -D hw:1,1,0 /local/share/sounds/alsa/Side_Right.wav
> >
> > Attached is the problem file captured using my iPhone. bad1.m4a.
> >
> > I've uploaded to
> > https://github.com/jeffersonchua/linux-6.4-alsa/blob/main/bad1.m4a in
> > case the attachment got stripped-off.
>
> Ah, the arecord and aplay above with -Dhw:1,1 is for a different
> (still working) card?  Better to explain it more clearly...

I use this to record the sound, but it's the playback that's having
the issue ...

# modprobe snd-aloop
# arecord -D hw:1,0,0 -f S16_LE -r 48000 recorded.wav
# aplay -D hw:1,1,0 /local/share/sounds/alsa/Side_Right.wav

The issue is still without reversing the patch, I'm getting the bad
audio (bad1.m4a)

Just let me know what else I can provide. I'm not sure what's need,
and don't want to bombard everyone with diagnostics that are
irrelavant.

Thank you!

Jeff
