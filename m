Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BCD6A5EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjB1Spd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjB1Spc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:45:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD623C54;
        Tue, 28 Feb 2023 10:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677609913; i=deller@gmx.de;
        bh=xC4mv9H9pJblFBF7YkDJhJo1H9/5OAuWYUzB/h8CUhU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TM9TVncuNGf2j70P02Ae9jnrDYn77Br667yprt8G7iKDZtOSyfc1Cg6d9dIZ+u/4q
         gJGatpl0X8YoVHnd1CeGnRqoVGm+mUveFUBDah6WGHCCxKcy6IIf0oKnguWuDTfZrn
         StJgiBVsQ2A2G2w+X0lX1hVhAentpnVDI42+kZAIoB2rH9rzilBGcVePGqZEpJsVNn
         c10qdzLaV1J1hp88z/d3R3Zv+s1Xm998IJ4Q2IcX/hu59FVtNWqf7ukvLbMsuLqmXJ
         SWcrrMSRib7+Tjr/fCYk51afgYalpmNLfJnrP1e/lpkJV0/ejSJVpLfvtXpia2nyHL
         R5s9vYMcypJ/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7R1T-1oQAnF3QqL-017mkM; Tue, 28
 Feb 2023 19:45:12 +0100
Message-ID: <9b75b8ec-4006-9606-2db4-e1ad5a0b3f8d@gmx.de>
Date:   Tue, 28 Feb 2023 19:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] parisc: Replace regular spinlock with spin_trylock on
 panic path
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeroen Roovers <jer@xs4all.nl>
References: <20230220211105.151401-1-gpiccoli@igalia.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230220211105.151401-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AYEo+fLw83pVG8JaWlKFqryBjkR6m1sEIwz5xZj4D8CSC7w+seF
 y0D4fmkPH7L+NmsDKNrHCx9iyrbgxvIi3gEyqIuEG0Xu60W+zYlATRSRNyzVOq91dOP1lR7
 YAXYGegmufj23cVsWIw2gg+e7NGLx6VysR0krg0QEBgYTMc6CpnLTihi49e0hIYuLRxisE6
 Dd8WRBB/7286y/h+qCpyQ==
UI-OutboundReport: notjunk:1;M01:P0:4ynow6gXnfU=;5+1L77mAidF6JB78375blQj7xiY
 sf1ABrLon9fbj8HBbtZvARGX8JcmTjhLOESp53hFE7t6uWyIOCVMicU17SoeI4qLnyDtb8Dwv
 6q/GgE5Ykf6Tk0ShUPibtzxdqxYeO+Sep5PZ8uWHe1c4MRiA55qFwbZ8cI1svalUawkcWDixN
 Mr5UYBfoofu1dZdSPnzzgHGWpU62gW4rND0fxs5BbHe94DnBS2lqOMp4VFxDBv32BholCokhT
 7anQliH5HDGzWNWPkmTXiDjDuNHRMJB7wbQ8Gg9piPZrBVKt/jslVeo8TPTH7+Kx9PmV2rPE1
 4EDC3rgFb9IiQJs/ZHbWNe+SU3HTM5EuAHBMSxuEuyPMLyTlSQf7XTd9dnAID5jnqyYWim4lc
 zcm4Ld3YUTlOx5O9YzA0BVGuFFqnHw7xtF88u3lF8y5qRlvw7CzfjUk/9P4MckiJZsuco/dJO
 Sfexrd6plPI57OHntPgOJGgRtp/2BohAp55VgYFdgAuo6hjV2SKvvhrvNzkQ7I3RaurV1TWAd
 ssXFjEveiu8p+G2ZVOfwSteqQm1sbMJnPxtOjRF+BWgFo59k1WvgNDFiknEdc2vpNSiALnTrb
 a53auPddxopdgQNZyupmphFgTnWL+c77MbRNkU48ncmI/DexMkHQw5IrHgsQcmgBj4mNjfufa
 R20XcfshyopD4DlcegCwjC3qHOcHhHox1gUxh3Y/xZkp3wPd5YhoGRsDJ2n1ZP2AftbuRLia2
 pe3+UHC6O72cAKgyEdVzLaS0fqMig21T423o0VilJuFxDV+XgpZXu3fdKAeqzNE+2OMt0eKT3
 e118oOqaBH8h2w7wraThsz7XKOx5V1A6xyh7bYOzN7YNFw3yj4ilCHnG1eaHMb744S1b+Kzba
 JHKNZi6S47ufIz6aICqHkSPshuO5gQrbsTykMzGr5Q5uaMT65+atMske6BnQaeh8Dfz0s5J8J
 7gY9rBSDa3ftd64OooNUcW4G5vk=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 22:11, Guilherme G. Piccoli wrote:
> The panic notifiers' callbacks execute in an atomic context, with
> interrupts/preemption disabled, and all CPUs not running the panic
> function are off, so it's very dangerous to wait on a regular
> spinlock, there's a risk of deadlock.
>
> Refactor the panic notifier of parisc/power driver to make use
> of spin_trylock - for that, we've added a second version of the
> soft-power function. Also, some comments were reorganized and
> trailing white spaces, useless header inclusion and blank lines
> were removed.
>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Jeroen Roovers <jer@xs4all.nl>
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>
> ---
> V4:
> - rebase against v6.2 (build-tested).
>
> V3:
> - s/in/on as per Jeroen's suggestion - thanks!
>
> V2:
> - Added Helge's ACK - thanks!
>
>
> Hey Helge, this is the V4 - just rebased and build-tested on v6.2.
> I remember we discussed the possibility of this getting merged through
> the series I've submitted [0], but happens the series is "gone", most of
> the patches were picked by maintainers, others I'm dropping. This is rea=
lly
> a standalone fix, similar ones were merged in other notifiers.
>
> I'd appreciate if you/James could pick it for the next kernel, there's n=
o
> rush at all, but there's also no series we could throw this patch to get
> merged with heh
>
> Thanks in advance,
> Guilherme

Thank you Guilherme!

I've now picked it up in the parisc-for-next tree.

Helge


>
> [0] https://lore.kernel.org/lkml/43de5653-7587-3e8e-274c-b2729649d0fd@gm=
x.de/
>
>
>   arch/parisc/include/asm/pdc.h |  1 +
>   arch/parisc/kernel/firmware.c | 27 +++++++++++++++++++++++----
>   drivers/parisc/power.c        | 17 ++++++++++-------
>   3 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc=
.h
> index 40793bef8429..2b4fad8328e8 100644
> --- a/arch/parisc/include/asm/pdc.h
> +++ b/arch/parisc/include/asm/pdc.h
> @@ -80,6 +80,7 @@ int pdc_do_firm_test_reset(unsigned long ftc_bitmap);
>   int pdc_do_reset(void);
>   int pdc_soft_power_info(unsigned long *power_reg);
>   int pdc_soft_power_button(int sw_control);
> +int pdc_soft_power_button_panic(int sw_control);
>   void pdc_io_reset(void);
>   void pdc_io_reset_devices(void);
>   int pdc_iodc_getc(void);
> diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware=
.c
> index 6817892a2c58..cc124d9f1f7f 100644
> --- a/arch/parisc/kernel/firmware.c
> +++ b/arch/parisc/kernel/firmware.c
> @@ -1232,15 +1232,18 @@ int __init pdc_soft_power_info(unsigned long *po=
wer_reg)
>   }
>
>   /*
> - * pdc_soft_power_button - Control the soft power button behaviour
> - * @sw_control: 0 for hardware control, 1 for software control
> + * pdc_soft_power_button{_panic} - Control the soft power button behavi=
our
> + * @sw_control: 0 for hardware control, 1 for software control
>    *
>    *
>    * This PDC function places the soft power button under software or
>    * hardware control.
> - * Under software control the OS may control to when to allow to shut
> - * down the system. Under hardware control pressing the power button
> + * Under software control the OS may control to when to allow to shut
> + * down the system. Under hardware control pressing the power button
>    * powers off the system immediately.
> + *
> + * The _panic version relies on spin_trylock to prevent deadlock
> + * on panic path.
>    */
>   int pdc_soft_power_button(int sw_control)
>   {
> @@ -1254,6 +1257,22 @@ int pdc_soft_power_button(int sw_control)
>   	return retval;
>   }
>
> +int pdc_soft_power_button_panic(int sw_control)
> +{
> +	int retval;
> +	unsigned long flags;
> +
> +	if (!spin_trylock_irqsave(&pdc_lock, flags)) {
> +		pr_emerg("Couldn't enable soft power button\n");
> +		return -EBUSY; /* ignored by the panic notifier */
> +	}
> +
> +	retval =3D mem_pdc_call(PDC_SOFT_POWER, PDC_SOFT_POWER_ENABLE, __pa(pd=
c_result), sw_control);
> +	spin_unlock_irqrestore(&pdc_lock, flags);
> +
> +	return retval;
> +}
> +
>   /*
>    * pdc_io_reset - Hack to avoid overlapping range registers of Bridges=
 devices.
>    * Primarily a problem on T600 (which parisc-linux doesn't support) bu=
t
> diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
> index 456776bd8ee6..8512884de2cf 100644
> --- a/drivers/parisc/power.c
> +++ b/drivers/parisc/power.c
> @@ -37,7 +37,6 @@
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
> -#include <linux/notifier.h>
>   #include <linux/panic_notifier.h>
>   #include <linux/reboot.h>
>   #include <linux/sched/signal.h>
> @@ -175,16 +174,21 @@ static void powerfail_interrupt(int code, void *x)
>
>
>
> -/* parisc_panic_event() is called by the panic handler.
> - * As soon as a panic occurs, our tasklets above will not be
> - * executed any longer. This function then re-enables the
> - * soft-power switch and allows the user to switch off the system
> +/*
> + * parisc_panic_event() is called by the panic handler.
> + *
> + * As soon as a panic occurs, our tasklets above will not
> + * be executed any longer. This function then re-enables
> + * the soft-power switch and allows the user to switch off
> + * the system. We rely in pdc_soft_power_button_panic()
> + * since this version spin_trylocks (instead of regular
> + * spinlock), preventing deadlocks on panic path.
>    */
>   static int parisc_panic_event(struct notifier_block *this,
>   		unsigned long event, void *ptr)
>   {
>   	/* re-enable the soft-power switch */
> -	pdc_soft_power_button(0);
> +	pdc_soft_power_button_panic(0);
>   	return NOTIFY_DONE;
>   }
>
> @@ -193,7 +197,6 @@ static struct notifier_block parisc_panic_block =3D =
{
>   	.priority	=3D INT_MAX,
>   };
>
> -
>   static int __init power_init(void)
>   {
>   	unsigned long ret;

