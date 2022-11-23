Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4277F6350E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiKWHGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiKWHG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:06:28 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9CF2412
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:06:27 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-39451671bdfso140848397b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5UDO+CDsn9tFw1qu+1aLuYY9kc6ZmG6caszAYHBPIs=;
        b=k0ZKc4rlcJ8vbgPMnoksZY0Tqbn8uXGIdhZIDZTu3FonEUgSXrgweYVDesztwfngPG
         loXDpZjKXnzm1r7L//rA0y7smBeXNRHvlS7XQtT3CrMcwe8O8U+cKhPTtXUcA7z9wfoH
         jn+Smm8EhgP61pS6Y6FOFFHzAAUvpA9YD1iskAnq3picfKhw39wVhRoN8HlXrqMf9vtQ
         J5SywyMdFw2KM3zT00i4NdwHIXoXrPQN7h+5i7XMXBfuvBeTG8tizPSHVl4m/H3MkwXs
         SfsLN0j21okXWpn0ciXx+orWLWV6uUURITAS3L79tcKBb8cnPXR0btP4FRMU6G/ExUNV
         xHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5UDO+CDsn9tFw1qu+1aLuYY9kc6ZmG6caszAYHBPIs=;
        b=068RarcAji/XOb21zfnUk+djPmkns7d6TwstMtd7Au0Hz62teT0Nx6ghOm3xaHFk8K
         5sWqB5uRV6fEvBlpZXDQPxV9mjiz4jyqXNASm/fdfC83L6s5hmXHMyWw+JT07NCKQHS3
         /i+J5TxmdjeImNNKL4q+yXF2o/Ynj+rEDvwxSiW/V0MCqYbF5alOv2VmXHqfVOieffBC
         hscMaNnHwyAdAkxbMezmh3pM69Aw90r7j6/a2ZDdUdUCG0L0MoavGHNG5+VwtXX5TtYr
         Dc6BNB0DEzJPM1Myy31lONvfDviyI6lq7D5af3TMyz2OQ/jtsT4nkcXIdcv5t3p/eA/j
         1k1w==
X-Gm-Message-State: ANoB5pl4k9vwfdC/w4y7H/BxgTsps3NVONRigN4VpfIgaDJQZeAqZz3x
        3Wr4Iz+/prDuvl8HxRnCq5SposVN1XVsenfIl2I=
X-Google-Smtp-Source: AA0mqf68y7B7EVuw4un0nSXxSEHbUoayj/EwX1/tdjpicF+MeZYb/u8jBCEz9F+Q1yMrChT7SyVDPs4nfev0Hw65ZUY=
X-Received: by 2002:a81:a18e:0:b0:368:b923:b500 with SMTP id
 y136-20020a81a18e000000b00368b923b500mr9453740ywg.10.1669187187069; Tue, 22
 Nov 2022 23:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20221123050911.1045190-1-butterflyhuangxx@gmail.com> <87mt8i5fcz.wl-tiwai@suse.de>
In-Reply-To: <87mt8i5fcz.wl-tiwai@suse.de>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Wed, 23 Nov 2022 15:06:16 +0800
Message-ID: <CAFcO6XPoNnM+VzY+bj5sPfJ-tCLQQ_pb8yb90KifWTwVpdENKA@mail.gmail.com>
Subject: Re: [RESEND PATCH] ALSA: rawmidi: fix infoleak in snd_rawmidi_ioctl_status_compat64
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, baolin.wang@linux.alibaba.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, the compat_status structure is struct compat_snd_rawmidi_status64 {
s32 stream;
u8 rsvd[4]; /* alignment */
s64 tstamp_sec;
s64 tstamp_nsec;
u32 avail;
u32 xruns;
unsigned char reserved[16];
} __attribute__((packed));
The rsvd[4] and reserved[16] are not  initialized.


Regards,
 butt3rflyh4ck.

On Wed, Nov 23, 2022 at 2:55 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 23 Nov 2022 06:09:11 +0100,
> Xiaolong Huang wrote:
> >
> > The compat_status is declared off of the stack, so it needs to
> > be zeroed out before copied back to userspace to prevent any
> > unintentional data leakage.
> >
> > Fixes: d9e5582c4bb2 ("ALSA: Avoid using timespec for struct snd_rawmidi_status")
> > Signed-off-by: Xiaolong Huang <butterflyhuangxx@gmail.com>
> >
> > ---
> >
> > Reason for resend:
> > 1. add Fixes line.
> > ---
> >  sound/core/rawmidi_compat.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
> > index 68a93443583c..6afa68165b17 100644
> > --- a/sound/core/rawmidi_compat.c
> > +++ b/sound/core/rawmidi_compat.c
> > @@ -80,6 +80,7 @@ static int snd_rawmidi_ioctl_status_compat64(struct snd_rawmidi_file *rfile,
> >       if (err < 0)
> >               return err;
> >
> > +     memset(&compat_status, 0, sizeof(compat_status));
> >       compat_status = (struct compat_snd_rawmidi_status64) {
> >               .stream = status.stream,
> >               .tstamp_sec = status.tstamp_sec,
>
> Here at the line just after your addition, compat_status is fully
> initialized by substitution, so I believe the memset is superfluous.
>
> Or have you verified that it really leaks the uninitialized memory?
>
>
> thanks,
>
> Takashi



-- 
Active Defense Lab of Venustech
