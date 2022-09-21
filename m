Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7B25C01E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiIUPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIUPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:42:52 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F6262
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:42:45 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id b15so3410620vkp.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KFeAEomN6wc2bkWtpf7+3E3G4vNJtHK0TABPjM591K4=;
        b=j6PEQKDXbzUpUGsJj0J+L4yZap4hN7mS78EpJrWYFNixgNWVKNiEtyDcTICM/z3M5n
         +tDBwuVpgHHKDRFmb9RlDE9xeSbsI7mWOO/Sz5aqrtbnhjY6hlM9Y2fXwWwo9voH1TO8
         Xw5zZfYWWY/wbEFAbrOv/3c+hwsND/kX6/yxGbu1aUIkmLoTT6KyS+g9QGRwz7JcKqg5
         rb6TdYJ3+OkZGAyDjq3wPqTfbFCKYJVkM1BjYOn58bhAPG0dXkhCZhm0g96pkBdbOm61
         v7+RDpgU6n9f3+F39IHq/X9vB/tSQTzVAvV4aW6hL8Nvke04kTTqfFHUjvMZvwTNlIjT
         juZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KFeAEomN6wc2bkWtpf7+3E3G4vNJtHK0TABPjM591K4=;
        b=rfbcgiUMVYOhasbVqsIv0abzVFEqnqMMPqxq9r/Uv96Con7c6RkegZL67iWgHfjx4F
         GFQmK53UEyrhL8DrrW22ptBMWRnX6dOFEqirnMDz+rh0oQcxl+Hdxfjh8qVG0Zudyyo/
         GU6HpYcPq2GDp8S25vem7fvY+zRKP2lCNcfHgKS2ltYsuWg17RNno1I3O/sDY1Sl3LBX
         awC8kh+tGR7vZF/yY5/aLAmvIrqht7Zlvg5/VMooTWHOU8P6+REWnDGeAkSt9VvXZjA3
         JeQd6bVUb0lFqTm6XzEeIPR3YvWgWy8pSNZTHlUSpe2x4EXlnyYxbjdWxk2yBi4I9OyI
         G3AA==
X-Gm-Message-State: ACrzQf016GWTgkIldoPKBmuHRQEkd/PTb69kBVv+kuyXVTEC2MZ3v2lU
        zrJk2xoFnUik3PqTtx2TbNzeC0HlsCkYAxEKYZ8=
X-Google-Smtp-Source: AMsMyM5mjgzhOyC1PfAPpGTaYduU7yMyFn4EYyHHMTNna6jnabAfwzyN0ukBimpQT8PKeQpgILa2hQZG5+l4ShB5bcQ=
X-Received: by 2002:a05:6122:a02:b0:3a3:1672:171f with SMTP id
 2-20020a0561220a0200b003a31672171fmr8723463vkn.17.1663774964578; Wed, 21 Sep
 2022 08:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexJP7w1B0mVgDF0dQ+gWor7UdkiwPczmL7pn91xx8xpzOA@mail.gmail.com>
 <87y1ufh3u9.wl-tiwai@suse.de> <875yhigtxe.wl-tiwai@suse.de>
In-Reply-To: <875yhigtxe.wl-tiwai@suse.de>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 21 Sep 2022 23:42:33 +0800
Message-ID: <CAB7eexJu+4Nc+YA3Bi+1Y1-zU6rfO5YtC6R7c70Qhoj0J36JoA@mail.gmail.com>
Subject: Re: possible deadlock in snd_rawmidi_free
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your solution! I am sorry that I was not able to extract
the reproducer. But I am improving the solution to reproduce the crash.
If I succeed in reproducing it, I will check it for you as soon as possible!

Best Regards,
Rondreis

On Tue, Sep 20, 2022 at 7:35 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 19 Sep 2022 15:49:02 +0200,
> Takashi Iwai wrote:
> >
> > On Mon, 19 Sep 2022 14:46:13 +0200,
> > Rondreis wrote:
> > >
> > > Hello,
> > >
> > > When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
> > > triggered.
> > >
> > > HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
> > > git tree: upstream
> > >
> > > kernel config: https://pastebin.com/raw/xtrgsXP3
> > > console output: https://pastebin.com/raw/9tabWDtu
> > >
> > > Sorry for failing to extract the reproducer, and the crash occurred at
> > > the moment of disconnecting the midi device. On other versions of
> > > Linux, I also triggered this crash.
> > >
> > > I would appreciate it if you have any idea how to solve this bug.
> >
> > I think there are two ways to work around it.
> >
> > The first one is to move the unregister_sound*() calls out of the
> > sound_oss_mutex, something like:
> > -- 8< --
> >
> > --- a/sound/core/sound_oss.c
> > +++ b/sound/core/sound_oss.c
> > @@ -162,7 +162,6 @@ int snd_unregister_oss_device(int type, struct snd_card *card, int dev)
> >               mutex_unlock(&sound_oss_mutex);
> >               return -ENOENT;
> >       }
> > -     unregister_sound_special(minor);
> >       switch (SNDRV_MINOR_OSS_DEVICE(minor)) {
> >       case SNDRV_MINOR_OSS_PCM:
> >               track2 = SNDRV_MINOR_OSS(cidx, SNDRV_MINOR_OSS_AUDIO);
> > @@ -174,12 +173,18 @@ int snd_unregister_oss_device(int type, struct snd_card *card, int dev)
> >               track2 = SNDRV_MINOR_OSS(cidx, SNDRV_MINOR_OSS_DMMIDI1);
> >               break;
> >       }
> > -     if (track2 >= 0) {
> > -             unregister_sound_special(track2);
> > +     if (track2 >= 0)
> >               snd_oss_minors[track2] = NULL;
> > -     }
> >       snd_oss_minors[minor] = NULL;
> >       mutex_unlock(&sound_oss_mutex);
> > +
> > +     /* call unregister_sound_special() outside sound_oss_mutex;
> > +      * otherwise may deadlock, as it can trigger the release of a card
> > +      */
> > +     unregister_sound_special(minor);
> > +     if (track2 >= 0)
> > +             unregister_sound_special(track2);
> > +
> >       kfree(mptr);
> >       return 0;
> >  }
> > -- 8< --
> >
> > This should be OK, as the unregister_sound_*() itself can be called
> > concurrently.
> >
> > Another workaround would be just to remove the register_mutex call at
> > snd_rawmidi_free(), e.g. something like:
> >
> > -- 8< --
> > --- a/sound/core/rawmidi.c
> > +++ b/sound/core/rawmidi.c
> > @@ -1899,10 +1899,8 @@ static int snd_rawmidi_free(struct snd_rawmidi *rmidi)
> >
> >       snd_info_free_entry(rmidi->proc_entry);
> >       rmidi->proc_entry = NULL;
> > -     mutex_lock(&register_mutex);
> >       if (rmidi->ops && rmidi->ops->dev_unregister)
> >               rmidi->ops->dev_unregister(rmidi);
> > -     mutex_unlock(&register_mutex);
> >
> >       snd_rawmidi_free_substreams(&rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT]);
> >       snd_rawmidi_free_substreams(&rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT]);
> > -- 8< --
> >
> > This register_mutex there should be superfluous since the device has
> > been already processed and detached by snd_rawmidi_dev_disconnect()
> > beforehand.  But if the first one is confirmed to work, the second one
> > can be left untouched.
>
> Could you check whether one of two changes above fixes the bug?
> Once after confirmed, I'll cook a proper patch for the submission.
>
>
> thanks,
>
> Takashi
