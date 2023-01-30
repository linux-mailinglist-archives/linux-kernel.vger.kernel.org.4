Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD653681A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbjA3T2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjA3T2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:28:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA329170
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:28:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x7so8807374edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eitmlabs-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pde1HtL0jbaSii0M64UiQFU/qnbGbv9/KpkjEUAcgCs=;
        b=TWVNEU/0hAjW3MpjjnPz0cWL/yot4kqsCxV/7jfjoHxjkEOtTBUeb2P/yoA66RqRIa
         SAmHwnIZaHuvl9SOPBm3mOdaeVwtrFifxKu6m5kSL/ElyJo5UcJOrhEhlRpIz3phkLpi
         ixOd/FAnQe9kWf1puy9uSBXk4lTbWjG1IOX/+TL8JmYuYsmsWDR2pJ1du2f8pdw2n9Hz
         0Ve1I0rr+DaICglug0SuufzQ3VTcDQc74xhodhtm4bKROyuG8Lf4XienJMU14TR2LcLW
         uT6TIDHidO9VGv7DnWWfIEl1K8aVpoKL/zFREXx0YhBytGpyBRvzSI1c0ikePVJxSFke
         aQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pde1HtL0jbaSii0M64UiQFU/qnbGbv9/KpkjEUAcgCs=;
        b=fxRlcQ9DpTo6X9xoaNoYni2wvxoB+0F/cHjLgPgrz9NVFHqyF+1drOMZApX5nL5vYt
         5ZDvYalLcB0q7+AB4OdORANXs9imi3hBBbC+5LQcQRnPcPpBIhcFcsZjmJeI1/htbJq1
         bi2RyjhE2YTpgUPn4z6tWgHqrrV9+jpPliHPR4JAcdWsZ+5jkL4q7Fy/JMy5PC/PNtYy
         M69n51sfIOjN1s+BXPVD0tqdWB8M2Bw3wmMTQ98BNBDpCMBCXjLqUq8WbDiOOR7GuRtD
         e2BPG5FoWS6oSbFOjAuKfg982ZnTfiByaD0Rnzs1vgYjztFwdqntB4zHMvABY2eVSTUH
         TBKw==
X-Gm-Message-State: AO0yUKVhyOu4SFU12Yu86iujzwmGlsuDWl6T9rCnxmbwsAvZQxw2bJRG
        Wfiilf/4CRXZcNU1iiBNTKsWWm80kA8NwvGCKTXRMw==
X-Google-Smtp-Source: AK7set+Cbyu/gjwSId0z57qj4f7ODqmywQnBSUV4JGQR6P/djfb+lISYHaaBj+8ytqXxSzZC0HNu79mPM8DJ8vII9aw=
X-Received: by 2002:a05:6402:2807:b0:4a0:e275:6844 with SMTP id
 h7-20020a056402280700b004a0e2756844mr4935501ede.74.1675106889050; Mon, 30 Jan
 2023 11:28:09 -0800 (PST)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
 <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
 <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
 <56E6CAAE-FF25-4898-8F9D-048164582E7B@kohlschutter.com> <490c5026-27bd-1126-65dd-2ec975aae94c@eitmlabs.org>
 <CAJfpegt7CMMapxD0W41n2SdwiBn8+B08vsov-iOpD=eQEiPN1w@mail.gmail.com>
In-Reply-To: <CAJfpegt7CMMapxD0W41n2SdwiBn8+B08vsov-iOpD=eQEiPN1w@mail.gmail.com>
Reply-To: jonathan@eitm.org
From:   Jonathan Katz <jkatz@eitmlabs.org>
Date:   Mon, 30 Jan 2023 11:27:53 -0800
Message-ID: <CALKgVmeaPJj4e9sYP7g+v4hZ7XaHKAm6BUNz14gvaBd=sFCs9Q@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 5:26 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 18 Jan 2023 at 04:41, Jonathan Katz <jkatz@eitmlabs.org> wrote:
>
> > I believe that I am still having issues occur within Ubuntu 22.10 with
> > the 5.19 version of the kernel that might be associated with this
> > discussion.  I apologize up front for any faux pas I make in writing
> > this email.
>
> No need to apologize.   The fix in question went into v6.0 of the
> upstream kernel.  So apparently it's still missing from the distro you
> are using.

Thank you for the reply! ---  I have upgraded the Kernel and it still
seems to be throwing errors.  Details follow:

Distro: Ubuntu 22.10.
Upgraded kernel using mainline (mainline --install-latest)

# uname -a
Linux instance-20220314-1510-fileserver-for-overlay
6.1.8-060108-generic #202301240742 SMP PREEMPT_DYNAMIC Tue Jan 24
08:13:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

On mount I still get the following notice in syslog (representative):
Jan 30 19:11:46 instance-20220314-1510-fileserver-for-overlay kernel:
[   71.613334] overlayfs: null uuid detected in lower fs '/', falling
back to xino=off,index=off,nfs_export=off.

And on access (via samba) I still see the following errors in the
syslog (representative):
Jan 30 19:19:34 instance-20220314-1510-fileserver-for-overlay kernel:
[  539.181858] overlayfs: failed to retrieve lower fileattr (8020
MeOHH2O RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1722.d/Storage.mcf_idx,
err=-38)

And on the Windows client, the software still fails with the same symptomology.




>
> > An example error from our syslog:
> >
> > kernel: [2702258.538549] overlayfs: failed to retrieve lower fileattr
> > (8020 MeOHH2O
> > RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1722.d/analysis.tsf,
> > err=-38)
>
> Yep, looks like the same bug.
>
> Thanks,
> Miklos
