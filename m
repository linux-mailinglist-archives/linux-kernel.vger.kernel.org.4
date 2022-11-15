Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571586291D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiKOG1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiKOG1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:27:17 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68438D49
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:27:15 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id e205so9430122oif.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eSmIgaNnlZYj8Xz77NOaIleH1gpDUm4h7ef5Y1BoSlQ=;
        b=AHgpv7ANeTUgN52WI85M4/jqBKtn9wVzBIriHOZ4YoOwma+6MPGhhnjHvBbFmLIph0
         OzIIyWNk98axf4JgwDZ324k3Dd16uXAl9VnM8D7KowjkYOJM4TxluO/CReIgZa/A7sl2
         LQjsj4N0swtHSbzxHi4tWqmsNGOxnJkqkcL7G4YEJBo94L1A0eoPxpeTkx3FQmLpBedH
         AL/lmnDHTxrER4BAxnMAQSP2PI+Vzb8u1LSO0rS8kdnIQi8c9w6rmd72vqSY+S9dcbcb
         XPGWG4RVF5rPyZiA36G7XMIWsAe/JWo4ln3Fcmwrai5P7z2igRJGwv8ORAnG1pqoFuay
         BkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSmIgaNnlZYj8Xz77NOaIleH1gpDUm4h7ef5Y1BoSlQ=;
        b=jntY4YTSx0xcCJnlaw2TmVNb2BaOGlfIJLW9HiTqLRAOSSMi7K3IdIl62Z0La8Ntlj
         B1drzgCtKRzTPgawOkzNKp3IruyYUY/f6x9RCLUqCuTgIsolckWSk1/Nx8QLJF11Mg0A
         uG6t6pqzvQprKglWckPsrsVsToZRUJ20va/ZGuzKeQgRpnhspDvfmRMeeFjgszE7mGkj
         LN+fH3sFB2mQWnewn0NQRHUAsIzzzCXtKutMJ5PpiwZYC1LzyKn55IF8xkKspQwwwics
         +ompd1H3L0RNPpLVWyxUafm9/B+5chI5hCSLMrO+KwpYsc3WMPfnQuWbQGG/nTVLdL/a
         0tbQ==
X-Gm-Message-State: ANoB5plRTiRGw+eFLKTkDMbCROdyAa5VxkfRBwcsGXWwOKP4mmRUqyLq
        CfzW+C976Fyi7v8tlnmqspnciMpfWCsMALaD+3NGew==
X-Google-Smtp-Source: AA0mqf7V0OC1PoFz2F8/j/dr0EEysK3t7nl0kt/IzWktucmHWUhyVQgZy03IDg/q5sE+pIExjZpZ3gpP8Qe3tZLHdAg=
X-Received: by 2002:a05:6808:20d:b0:35a:7e1d:3d72 with SMTP id
 l13-20020a056808020d00b0035a7e1d3d72mr77642oie.233.1668493634509; Mon, 14 Nov
 2022 22:27:14 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c183f505eb721745@google.com> <20221021225228.1750-1-hdanton@sina.com>
 <Y2BRzPxroVylPLan@slm.duckdns.org> <Y3J8GKR905SZ84EE@bombadil.infradead.org>
In-Reply-To: <Y3J8GKR905SZ84EE@bombadil.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Nov 2022 07:27:03 +0100
Message-ID: <CACT4Y+aS6_LFUBSZQoKqJwgBP-9LUqNMfzaA+chC8KkRCzfS9w@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
 (2)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Matthieu Castet <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>, dmitry.torokhov@gmail.com,
        ming.lei@redhat.com, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK,URIBL_DBL_ABUSE_REDIR,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 18:34, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Oct 31, 2022 at 12:53:00PM -1000, Tejun Heo wrote:
> > (cc'ing Luis for firmware loader and quoting the whole body)
> >
> > On Sat, Oct 22, 2022 at 06:52:28AM +0800, Hillf Danton wrote:
> > > On 20 Oct 2022 00:15:40 -0700
> > > > syzbot has found a reproducer for the following issue on:
> > > >
> > > > HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1449d53c880000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e01c72880000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1128908c880000
> > >
> > > See if the change to ueagle driver alone can survive syzbot test.
> > >
> > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  aae703b02f92
> > >
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3663,8 +3663,9 @@ static inline bool netif_attr_test_online(unsigned long j,
> > >  static inline unsigned int netif_attrmask_next(int n, const unsigned long *srcp,
> > >                                            unsigned int nr_bits)
> > >  {
> > > -   /* n is a prior cpu */
> > > -   cpu_max_bits_warn(n + 1, nr_bits);
> > > +   /* -1 is a legal arg here. */
> > > +   if (n != -1)
> > > +           cpu_max_bits_warn(n, nr_bits);
> > >
> > >     if (srcp)
> > >             return find_next_bit(srcp, nr_bits, n + 1);
> > > @@ -3685,8 +3686,9 @@ static inline int netif_attrmask_next_and(int n, const unsigned long *src1p,
> > >                                       const unsigned long *src2p,
> > >                                       unsigned int nr_bits)
> > >  {
> > > -   /* n is a prior cpu */
> > > -   cpu_max_bits_warn(n + 1, nr_bits);
> > > +   /* -1 is a legal arg here. */
> > > +   if (n != -1)
> > > +           cpu_max_bits_warn(n, nr_bits);
> > >
> > >     if (src1p && src2p)
> > >             return find_next_and_bit(src1p, src2p, nr_bits, n + 1);
> > > --- a/drivers/usb/atm/ueagle-atm.c
> > > +++ b/drivers/usb/atm/ueagle-atm.c
> > > @@ -597,9 +597,8 @@ static int uea_send_modem_cmd(struct usb
> > >  }
> > >
> > >  static void uea_upload_pre_firmware(const struct firmware *fw_entry,
> > > -                                                           void *context)
> > > +                                   struct usb_device *usb)
> > >  {
> > > -   struct usb_device *usb = context;
> > >     const u8 *pfw;
> > >     u8 value;
> > >     u32 crc = 0;
> > > @@ -679,6 +678,7 @@ static int uea_load_firmware(struct usb_
> > >  {
> > >     int ret;
> > >     char *fw_name = EAGLE_FIRMWARE;
> > > +   const struct firmware *fw;
> > >
> > >     uea_enters(usb);
> > >     uea_info(usb, "pre-firmware device, uploading firmware\n");
> > > @@ -701,13 +701,13 @@ static int uea_load_firmware(struct usb_
> > >             break;
> > >     }
> > >
> > > -   ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
> > > -                                   GFP_KERNEL, usb,
> > > -                                   uea_upload_pre_firmware);
> > > +   ret = request_firmware(&fw, fw_name, &usb->dev);
> > >     if (ret)
> > >             uea_err(usb, "firmware %s is not available\n", fw_name);
> > > -   else
> > > +   else {
> > >             uea_info(usb, "loading firmware %s\n", fw_name);
> > > +           uea_upload_pre_firmware(fw, usb);
> > > +   }
> > >
> > >     uea_leaves(usb);
> > >     return ret;
> >
> > So, the problem is that while request_firmware_nowait() inc's the ref on the
> > device, if the device gets removed later, having a ref isn't sufficient for
> > adding stuff to the device. A relatively easy solution would be putting
> > these firmware load work items into its own workqueue and flushing it on
> > device removal path. Luis, what do you think?
>
> Since we *can* remove a device after we get a module reference and
> since fw_cache_is_setup() tries to use the device before get_device()
> (even though this is not the issue reported), I think perhaps the fix
> below may be generic and best. It would seem this 2After doing this, I considered simply
> removing the try_module_get() but a module which is not respnsible for
> creating a device is allowed to request firmware for an arbitrary
> device, and so that simplification should not be possible. This would
> fix 0cfc1e1e7b534 ("firmware loader: fix device lifetime") since v3.7
> but as that commit mentions, there were issues even prior to this get_device()
> and so this fix is the proper solution to the reported issue in that
> commit. This issue would the date back to f8a4bd3456b98 ("firmware
> loader: embed device into firmware_priv structure") since v2.6.36.
>
> Please re-test and let me know if this fixes the issue reported.

Hi Luis,

syzbot is a self-service, you can ask it to test any patches for
reports with reproducers following these instructions:
https://bit.do/syzbot#testing-patches

> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 7c3590fd97c2..177d5767ad3b 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -1141,18 +1141,20 @@ request_firmware_nowait(
>         const char *name, struct device *device, gfp_t gfp, void *context,
>         void (*cont)(const struct firmware *fw, void *context))
>  {
> +       int err = -ENOMEM;
>         struct firmware_work *fw_work;
>
> +       if (get_device(device))
> +               return -ENODEV;
> +
>         fw_work = kzalloc(sizeof(struct firmware_work), gfp);
>         if (!fw_work)
> -               return -ENOMEM;
> +               goto err_out;
>
>         fw_work->module = module;
>         fw_work->name = kstrdup_const(name, gfp);
> -       if (!fw_work->name) {
> -               kfree(fw_work);
> -               return -ENOMEM;
> -       }
> +       if (!fw_work->name)
> +               goto err_out_free_work;
>         fw_work->device = device;
>         fw_work->context = context;
>         fw_work->cont = cont;
> @@ -1160,21 +1162,26 @@ request_firmware_nowait(
>                 (uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
>
>         if (!uevent && fw_cache_is_setup(device, name)) {
> -               kfree_const(fw_work->name);
> -               kfree(fw_work);
> -               return -EOPNOTSUPP;
> +               err = -EOPNOTSUPP;
> +               goto err_out_free_name;
>         }
>
>         if (!try_module_get(module)) {
> -               kfree_const(fw_work->name);
> -               kfree(fw_work);
> -               return -EFAULT;
> +               err = -EFAULT;
> +               goto err_out_free_name;
>         }
>
> -       get_device(fw_work->device);
>         INIT_WORK(&fw_work->work, request_firmware_work_func);
>         schedule_work(&fw_work->work);
>         return 0;
> +
> +err_out_free_name:
> +       kfree_const(fw_work->name);
> +err_out_free_work:
> +       kfree(fw_work);
> +err_out:
> +       put_device(device);
> +       return err;
>  }
>  EXPORT_SYMBOL(request_firmware_nowait);
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/Y3J8GKR905SZ84EE%40bombadil.infradead.org.
