Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433EF66D21F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjAPW7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjAPW7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:59:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D4279AC;
        Mon, 16 Jan 2023 14:59:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso32397677pjf.1;
        Mon, 16 Jan 2023 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHMLhnMFgS56M2Qg/SbxbmEiyvJ1FRxRUZKrLw8fNgw=;
        b=UNmof0K3BdbjZq7/M/94A0y544wFgsY2to7uHlqQBa1hnnfitxHL4bJOa2LXxp/JPC
         32oW+yMiIBzjS5E8aPLrsCqjAgPmkRYSuuaUTtMs6l5jYMGC15nqGFRBUAWQrOr93OCo
         DXDXOwXppQGXP73rIbEnArTKwUsyOYi4j04hJTne8j2Yf6yrbFGzNvS9f99XMbopOM1h
         zXaPxAUnHLOS4YpOJJPRNcwxvd6J1O8UgKQnQmqTOUmmMgDQzKedswWGLuDGYkv4y+Zx
         jMwMNRZULxM7gchIiAO9qpZUGxgOruZLPMssgtW7gpBemItFQATITgiQ41VpWfqKIglF
         gH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHMLhnMFgS56M2Qg/SbxbmEiyvJ1FRxRUZKrLw8fNgw=;
        b=zY21vqxTdIi80/OnboNpv5xvqaOuX0FBmoPM9xRDEJw8mTlL57vTH8ZqMxoi4fi+6x
         fFIPJOF2OW1I/ZC96ZTgCq9jqwkbjMQmqVfAPZMbbnX43ri/kskCbhD5FYzO+iMSnuYe
         x01puNkorchGMVItd46+VJMSOVPFHzvqBeFmnUFFSyRuYJgX2LZpxMscceJvRUALCKxg
         G/hNvxjucvIRvpeUHXfe0YUDqDp/d1Jfh4hMGWrY0bh3GB1qc7ZJcrBM7QZ/0lQ7XfMo
         dGJxoLfgJmHwdrx19MEa7n0Gtdci6P72CNUO5ILPsKf8aDUFIfSnHeQfPG2/3RYl3EmV
         SU/w==
X-Gm-Message-State: AFqh2kr4yRnV/+2qT0sPPjPfL7d8T1LCUOeM8xpAnyCyUMLyLRD13gyf
        BvDnPpfv57Ba+R4wgGeG66k=
X-Google-Smtp-Source: AMrXdXu2fhDEHjZLm6UcQLueHuAtLgXtUrjVOPRxF2ocrk5bMPD8mmu1yZV345Cv6R3za1n2Z1C9Aw==
X-Received: by 2002:a17:903:2289:b0:194:9290:fa6f with SMTP id b9-20020a170903228900b001949290fa6fmr1870030plh.25.1673909987516;
        Mon, 16 Jan 2023 14:59:47 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:746e:9668:c7aa:72b4])
        by smtp.gmail.com with ESMTPSA id l1-20020a170903244100b0019498477f31sm319758pls.123.2023.01.16.14.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:59:46 -0800 (PST)
Date:   Mon, 16 Jan 2023 14:59:43 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, Xaver Hugl <xaver.hugl@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: i8042: Disable wake from keyboard by default on
 several AMD systems
Message-ID: <Y8XW32BChi6A5/am@google.com>
References: <20230116184830.30573-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116184830.30573-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Mon, Jan 16, 2023 at 12:48:30PM -0600, Mario Limonciello wrote:
> By default when the system is configured for suspend to idle by default
> the keyboard is set up as a wake source.  This matches the behavior that
> Windows uses for Modern Standby as well.
> 
> It has been reported that a variety of AMD based designs there are
> spurious wakeups are happening where two IRQ sources are active.
> 
> ```
> PM: Triggering wakeup from IRQ 9
> PM: Triggering wakeup from IRQ 1
> ```
> 
> In these designs IRQ 9 is the ACPI SCI and IRQ 1 is the PS/2 keyboard.
> An example way to trigger this is to suspend the system and then unplug
> the AC adapter.  The SOC will be in a hardware sleep state and plugging
> in the AC adapter returns control to the kernel's s2idle loop.
> 
> Normally if just IRQ 9 was active the s2idle loop would advance any EC
> transactions and no other IRQ being active would cause the s2idle loop
> to put the SOC back into hardware sleep state.
> 
> When this bug occurred IRQ 1 is also active even if no keyboard activity
> occurred. This causes the s2idle loop to break and the system to wake.
> 
> This is a platform firmware bug triggering IRQ1 without keyboard activity.
> This occurs in Windows as well, but Windows will enter "SW DRIPS" and
> then with no activity enters back into "HW DRIPS" (hardware sleep state).
> 
> This issue affects Renoir, Lucienne, Cezanne, and Barcelo based platforms
> that use LPC EC. It does not happen on newer systems such as Mendocino or
> Rembrandt.
> 
> It's been fixed in newer platform firmware, but determining whether the
> system vendor uses an LPC EC and has deployed the fix is not possible.
> 
> To avoid triggering the bug check the CPU model and adjust the policy for
> s2idle wakeup from keyboard on these systems to be disabled by default.

I think there are Chrome devices using these chipsets that use coreboot
firmware and do not exhibit the problematic behavior, so in addition to
CPU model check we need to check the firmware origin as well.

> 
> Users who know that their firmware is fixed and want to use wakeup from
> keyboard can manually enable wakeup from sysfs by modifying
> `/sys/bus/serio/devices/serio0/power/wakeup`.
> 
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Tested-by: Xaver Hugl <xaver.hugl@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2115#note_1724008
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/input/serio/i8042.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 6dac7c1853a54..c9eeca18c0816 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -23,6 +23,7 @@
>  #include <linux/suspend.h>
>  #include <linux/property.h>
>  
> +#include <asm/cpu_device_id.h>

Is it available on all architectures? Historically we were trying to
hide platform details in drivers/input/serio/i8042-acpipnpio.h

>  #include <asm/io.h>
>  
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
> @@ -433,6 +434,26 @@ static void i8042_port_close(struct serio *serio)
>  	i8042_interrupt(0, NULL);
>  }
>  
> +static bool i8042_should_wakeup_by_default(struct serio *serio)
> +{
> +#ifdef CONFIG_X86
> +	const struct x86_cpu_id irq1_bug_cpu_ids[] = {
> +		X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
> +		X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
> +		X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne/Barcelo */
> +		{}
> +	};
> +
> +	if (x86_match_cpu(irq1_bug_cpu_ids)) {
> +		pr_info_once("Disabling wakeup from keyboard to avoid firmware bug\n");
> +		return false;
> +	}
> +#endif
> +	if (!pm_suspend_default_s2idle())
> +		return false;
> +	return serio == i8042_ports[I8042_KBD_PORT_NO].serio;
> +}
> +
>  /*
>   * i8042_start() is called by serio core when port is about to finish
>   * registering. It will mark port as existing so i8042_interrupt can
> @@ -451,10 +472,8 @@ static int i8042_start(struct serio *serio)
>  	 * behavior on many platforms using suspend-to-RAM (ACPI S3)
>  	 * by default.
>  	 */
> -	if (pm_suspend_default_s2idle() &&
> -	    serio == i8042_ports[I8042_KBD_PORT_NO].serio) {
> +	if (i8042_should_wakeup_by_default(serio))
>  		device_set_wakeup_enable(&serio->dev, true);
> -	}
>  
>  	spin_lock_irq(&i8042_lock);
>  	port->exists = true;
> -- 
> 2.34.1
> 

Thanks.

-- 
Dmitry
