Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ECC5B6477
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIMAMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIMAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:12:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123BD4BD2C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 17:12:03 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 943323F550
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663027921;
        bh=z6N6722jp6gXDXHtSfBIv6r9VA68RRCBbIlOgOGSNmU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ldZIipKvejNnH9/wqYsLtN2r4+koAwJ7IQJz0MyTVwCkccYUrVbeboBPs0pQ+QfbR
         OtTz2YXbyYMzLhkelbenW2TsRLWZsfyGpHrhlpp4Df1U+PXQjE3hATv4tiPxgfhpye
         pROMdYSEJgJIDfof0XhwznT92bXgX0H+YJGY7qneusl1tQ6NwLzM/ZMD9LJjYFMIPv
         SYjZMVvxOHbB9Zrfbok/ybY4s+/REVet5LJHP8+sT8jn/RKhpfnmxd/fhaTxFZneJ0
         pKjjM7SW7r+r5OAJH4I8uhpPRKiIHLwuBueqIGHhoAU/FB4M/CPS8w/bgKfS0XHRlP
         tOfdWVSKqggpw==
Received: by mail-wm1-f72.google.com with SMTP id c128-20020a1c3586000000b003b324bb08c5so8098735wma.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 17:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=z6N6722jp6gXDXHtSfBIv6r9VA68RRCBbIlOgOGSNmU=;
        b=Dcoj1VhJdlHrCxux65bvGRhYcngDh9aMZGBAMZQrBWXc3iyi7BgSdKBW4susdRqK+6
         wDyNGt7iXwWtDtjf52T+wfBopsHiGjlXcgtBFIKsG33EzOyOz1oJ1i4t+0VSp9IHqtXA
         7VdximfpKM3WpRf4nK7WJxTdcq47n+XSnPdgmI5Km4XvPfY/Ok3VlPR2tYU6MwXzhz5p
         Yv+VnLC8w7wMyDa1m0cV05GEI0x1VnRKW/a+t3a1FIQ2LtBUUDBoX156Ts/fvlQSWsKv
         damSrrDTQPP0aTj0Ezm/THJT0OtC4QqFtCoYEBHkJW2V/M9309avaHn0a8lyWLN2B/WB
         0y6w==
X-Gm-Message-State: ACgBeo0MuH0ETcf+GvdMrdGirhc/I8XBJLT5v/f0mRi50GO0/4FmZU2w
        nMy6Aqk8Ba6uYFS+SoqSOcZZC8s40i/y+XnFuhJFo10sa3NmhijeLWNExZkElHsZvzE2M/Bbqte
        XnW9cPmaM6Bpv7NZJs8odjA6K1QxpXCYHbUSvI7B6/KgGMFKMwWrt1h33CA==
X-Received: by 2002:a05:600c:1992:b0:3a6:23f6:8417 with SMTP id t18-20020a05600c199200b003a623f68417mr483060wmq.14.1663027921092;
        Mon, 12 Sep 2022 17:12:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7lLfh2J6xG+T5DjIdovJBNize9y0/aQzz5DQKRB13IBjOsO9e90KyGlFZuFun9ZP92HT7VnA1fdn3+sMqFdzQ=
X-Received: by 2002:a05:600c:1992:b0:3a6:23f6:8417 with SMTP id
 t18-20020a05600c199200b003a623f68417mr483042wmq.14.1663027920787; Mon, 12 Sep
 2022 17:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220906143108.1749183-1-kai.heng.feng@canonical.com> <526160bf-f0f8-a861-55d4-1ed5437c9009@gmail.com>
In-Reply-To: <526160bf-f0f8-a861-55d4-1ed5437c9009@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 13 Sep 2022 08:11:48 +0800
Message-ID: <CAAd53p72POknU3tWyNBtsbZ_rEPVz+FBqi46QVvG3rhEO7ysWQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: ACPI: reboot: Reinstate S5 for reboot
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     rafael.j.wysocki@intel.com, Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        tangmeng <tangmeng@uniontech.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 4:07 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 06.09.2022 17:31, Kai-Heng Feng =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> > PowerEdge r440 hangs at boot.
> >
> > The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> > system reboot to avoid triggering AER"), so reinstate the patch again.
> >
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Use do_kernel_power_off_prepare() instead.
> >
> >  kernel/reboot.c | 55 +++++++++++++++++++++++++------------------------
> >  1 file changed, 28 insertions(+), 27 deletions(-)
> >
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index 3c35445bf5ad3..39cbb45afc54a 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -243,28 +243,6 @@ void migrate_to_reboot_cpu(void)
> >       set_cpus_allowed_ptr(current, cpumask_of(cpu));
> >  }
> >
> > -/**
> > - *   kernel_restart - reboot the system
> > - *   @cmd: pointer to buffer containing command to execute for restart
> > - *           or %NULL
> > - *
> > - *   Shutdown everything and perform a clean reboot.
> > - *   This is not safe to call in interrupt context.
> > - */
> > -void kernel_restart(char *cmd)
> > -{
> > -     kernel_restart_prepare(cmd);
> > -     migrate_to_reboot_cpu();
> > -     syscore_shutdown();
> > -     if (!cmd)
> > -             pr_emerg("Restarting system\n");
> > -     else
> > -             pr_emerg("Restarting system with command '%s'\n", cmd);
> > -     kmsg_dump(KMSG_DUMP_SHUTDOWN);
> > -     machine_restart(cmd);
> > -}
> > -EXPORT_SYMBOL_GPL(kernel_restart);
> > -
> >  static void kernel_shutdown_prepare(enum system_states state)
> >  {
> >       blocking_notifier_call_chain(&reboot_notifier_list,
> > @@ -301,6 +279,34 @@ static BLOCKING_NOTIFIER_HEAD(power_off_prep_handl=
er_list);
> >   */
> >  static ATOMIC_NOTIFIER_HEAD(power_off_handler_list);
> >
> > +static void do_kernel_power_off_prepare(void)
> > +{
> > +     blocking_notifier_call_chain(&power_off_prep_handler_list, 0, NUL=
L);
> > +}
> > +
> > +/**
> > + *   kernel_restart - reboot the system
> > + *   @cmd: pointer to buffer containing command to execute for restart
> > + *           or %NULL
> > + *
> > + *   Shutdown everything and perform a clean reboot.
> > + *   This is not safe to call in interrupt context.
> > + */
> > +void kernel_restart(char *cmd)
> > +{
> > +     kernel_restart_prepare(cmd);
> > +     do_kernel_power_off_prepare();
>
> Looks like an abuse to me. Adding new SYS_OFF_MODE_RESTART_PREPARE and
> updating acpi_sleep_init() to use it should be a better solution.

Thanks, will send a new one based on your comment.

Kai-Heng
