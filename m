Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438F96117B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJ1Qln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1Qll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:41:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F8010CFBF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:41:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p3so5304299pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPrinMLVNzECVQltiDii+U9zMSeYiKwIhwl+Yg7fNi0=;
        b=lLT4xXcEMHeKecsFUQt5aQE117UJikYeysInwNoeJtT/Ya5TgE12yAfc2BXwT9dqkF
         T3hQcAdhpxHDqYY8XHY51xbs4Y8oK9RUvTbkTIqO3kWIEHpFLbSb5eg5IPYoEHtR975E
         lO2htdt3xCNK4/Z4fQyHdx4hm03FF75jFU/jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPrinMLVNzECVQltiDii+U9zMSeYiKwIhwl+Yg7fNi0=;
        b=TLl9b+lzGB0VF15gn8Zn223IfEQ4beoMVoJ43+VLqk8TDRvyAUNtBiaONZsz8jKBua
         /rW7QyVMtKv5pKrc9UoL9HeveAAbCDjR5WLiSyQntPW/cTYTvZHSgx4Xu26e0e9Z+faT
         OmDM0qk2Cpuu0vyDMgQye0gsqFgz633G5sQHDbueqIwcBxferpvlWfrUJyl4owiWV4+D
         t50b5twt2CSswqMdZgLifQFriIoCsJX6TPYIj2+2EKnHNLAgCFx+g//scQ4H5EJDpZR3
         ekFfaIyuNz1UdvGhYa9Qvo4Kq2maZRkUCVUgDVpDnj3539IljniWv+3KZbfduaB4P/rC
         KFNw==
X-Gm-Message-State: ACrzQf0v+GKCN+1872cIH8cSdIcQnq048mMU6epU6az8SfSiRSMLPLhC
        Bb2qCutPuaHk5KlT/xRn+byU3Q==
X-Google-Smtp-Source: AMsMyM6lj2aDxuDBQXoD6NHuHKFr9f6is2r8HgfVf24lMs7ZyEQOaHQ5VS2UOe+2yQHWGJhj5bFxQw==
X-Received: by 2002:a17:902:ea0f:b0:186:ffba:882d with SMTP id s15-20020a170902ea0f00b00186ffba882dmr205249plg.21.1666975299419;
        Fri, 28 Oct 2022 09:41:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18-20020aa79ad2000000b0056bfd387c97sm3069430pfp.39.2022.10.28.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:41:38 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:41:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: boot failure of linux-next due to 1248fb6a8201 ("x86/mm:
 Randomize per-cpu entry area")
Message-ID: <202210280940.D7A7330@keescook>
References: <Y1vZKg6UHjdUZt1W@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vZKg6UHjdUZt1W@debian>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:29:14PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> Our qemu boots were failing since next-20221024, and a git bisect of
> next-20221028 showed the bad commit as 1248fb6a8201 ("x86/mm: Randomize per-cpu entry area")
> 
> After reverting the commit I could boot qemu again with next-20221028.
> 
> This is my config:
> 
> make defconfig
> make kvm_guest.config
> scripts/config -e KCOV -e KCOV_INSTRUMENT_ALL -e KCOV_ENABLE_COMPARISONS -e DEBUG_FS -e DEBUG_KMEMLEAK -e DEBUG_INFO -e KALLSYMS -e KALLSYMS_ALL -e NAMESPACES -e UTS_NS -e IPC_NS -e PID_NS -e NET_NS -e CGROUP_PIDS -e MEMCG -e USER_NS -e CONFIGFS_FS -e SECURITYFS -e KASAN -e KASAN_INLINE -e FAULT_INJECTION -e FAULT_INJECTION_DEBUG_FS -e FAULT_INJECTION_USERCOPY -e FAILSLAB -e FAIL_PAGE_ALLOC -e FAIL_MAKE_REQUEST -e FAIL_IO_TIMEOUT -e FAIL_FUTEX -e LOCKDEP -e PROVE_LOCKING -e DEBUG_ATOMIC_SLEEP -e PROVE_RCU -e DEBUG_VM -e REFCOUNT_FULL -e FORTIFY_SOURCE -e HARDENED_USERCOPY -e LOCKUP_DETECTOR -e SOFTLOCKUP_DETECTOR -e HARDLOCKUP_DETECTOR -e BOOTPARAM_HARDLOCKUP_PANIC -e DETECT_HUNG_TASK -e WQ_WATCHDOG -e USB_GADGET -e USB_RAW_GADGET -e TUN -e KCSAN -d RANDOMIZE_BASE -e MAC80211_HWSIM -e IEEE802154 -e MAC802154 -e IEEE802154_DRIVERS -e IEEE802154_HWSIM -e BT -e BT_HCIVHCI
> echo "CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140" >> .config
> echo "CONFIG_RCU_CPU_STALL_TIMEOUT=100" >> .config
> 
> I will be happy to test any patch or provide any extra log if needed.
> Though I am not sure how I will collect extra logs (if needed) as there
> was no output from qemu.

I see KASAN in your config, does this fix it?

https://lore.kernel.org/lkml/166693938482.29415.7034851115705424459.tip-bot2@tip-bot2/


-- 
Kees Cook
