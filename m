Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590AC6112BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJ1N3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJ1N3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:29:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF9B792E6;
        Fri, 28 Oct 2022 06:29:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 14-20020a05600c228e00b003cf4eaef74eso3513438wmf.0;
        Fri, 28 Oct 2022 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0nD/LNlHlt38vxJmkfyENuvomL8INpY7GnsGTg4hbs=;
        b=lUWW3ewHAXClpPsmhaNOjolWAai2QjCka1CD/0NuqiD8EhR95uan3qiJqm9mIFt8E3
         U19gtrt7AOd6u0vVKZeCO2Wwjxy3LXI4Wuk2k2BA39t8WBFMWvQASH7zReQiMObGffA9
         Cx4sr1jAyjLQaw/RRXZTVmvn/lQ+wopc0RHkBDNwphGKO/zmG9eIIOcsdSbSb17bf4N1
         PGv0AywyCJQnBqwtflT8E0/rxHaicbpTK3cvT0uW4TCyIHHOdiZ153PCoha7Wxfvl7HY
         2SarsHg29d2lJ/GDaByXlyv6Dhhyck0hVz9nB37EwlJDn2UYp+tum7p+mKVfYvqfpNIK
         QUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0nD/LNlHlt38vxJmkfyENuvomL8INpY7GnsGTg4hbs=;
        b=bfLlpYFieU+s+qlzgogkdKsmP06dj8vT1TWO5RKlfbVu2l4GfPbQn+ux5Mt2AxPAPu
         hLLk/fl1hVngCgxYNT0k+Ir+Il+6E541YVzCkGXJ5AMeM2hq3pMsvV9Bwso72peJTOd5
         VTHIATImf28Fg6gWCWK1odf+LuYKfaqHzQBrrUdAMTElJXVxWvk+mI20N2GFdmA8rl4M
         Pb97g2tr7tUNuOl6Dnjt1dwyPBzzJucvu9gEiPmvuaUy9yvWvKAQJCGMOI7cOvDp1zC2
         bgSfbNKOvgQGP6L1yl+PHehxLoBuu1NvpP61/vOt8BwRPz/Tk7vFShL+ZQQf2i6xAC+q
         Tg4g==
X-Gm-Message-State: ACrzQf0Cuj36zKtgMcneP76tJjmNFC/CfMWZlp7yGX66OEVy/Q+1twVh
        gB+uA4uWSzpEZVWUbU7Ira10g524P0A=
X-Google-Smtp-Source: AMsMyM7ZwvE8HivzpQpYDtG1+fKGyikrsM1ggL3aahlOvBZKHZt93W4MeV0UhI04A2IBmmpBgvsGww==
X-Received: by 2002:a05:600c:6019:b0:3c6:e21e:4e9d with SMTP id az25-20020a05600c601900b003c6e21e4e9dmr9572645wmb.53.1666963756222;
        Fri, 28 Oct 2022 06:29:16 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c230600b003cf37c5ddc0sm4141504wmo.22.2022.10.28.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:29:15 -0700 (PDT)
Date:   Fri, 28 Oct 2022 14:29:14 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: boot failure of linux-next due to 1248fb6a8201 ("x86/mm: Randomize
 per-cpu entry area")
Message-ID: <Y1vZKg6UHjdUZt1W@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Our qemu boots were failing since next-20221024, and a git bisect of
next-20221028 showed the bad commit as 1248fb6a8201 ("x86/mm: Randomize per-cpu entry area")

After reverting the commit I could boot qemu again with next-20221028.

This is my config:

make defconfig
make kvm_guest.config
scripts/config -e KCOV -e KCOV_INSTRUMENT_ALL -e KCOV_ENABLE_COMPARISONS -e DEBUG_FS -e DEBUG_KMEMLEAK -e DEBUG_INFO -e KALLSYMS -e KALLSYMS_ALL -e NAMESPACES -e UTS_NS -e IPC_NS -e PID_NS -e NET_NS -e CGROUP_PIDS -e MEMCG -e USER_NS -e CONFIGFS_FS -e SECURITYFS -e KASAN -e KASAN_INLINE -e FAULT_INJECTION -e FAULT_INJECTION_DEBUG_FS -e FAULT_INJECTION_USERCOPY -e FAILSLAB -e FAIL_PAGE_ALLOC -e FAIL_MAKE_REQUEST -e FAIL_IO_TIMEOUT -e FAIL_FUTEX -e LOCKDEP -e PROVE_LOCKING -e DEBUG_ATOMIC_SLEEP -e PROVE_RCU -e DEBUG_VM -e REFCOUNT_FULL -e FORTIFY_SOURCE -e HARDENED_USERCOPY -e LOCKUP_DETECTOR -e SOFTLOCKUP_DETECTOR -e HARDLOCKUP_DETECTOR -e BOOTPARAM_HARDLOCKUP_PANIC -e DETECT_HUNG_TASK -e WQ_WATCHDOG -e USB_GADGET -e USB_RAW_GADGET -e TUN -e KCSAN -d RANDOMIZE_BASE -e MAC80211_HWSIM -e IEEE802154 -e MAC802154 -e IEEE802154_DRIVERS -e IEEE802154_HWSIM -e BT -e BT_HCIVHCI
echo "CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140" >> .config
echo "CONFIG_RCU_CPU_STALL_TIMEOUT=100" >> .config

I will be happy to test any patch or provide any extra log if needed.
Though I am not sure how I will collect extra logs (if needed) as there
was no output from qemu.


-- 
Regards
Sudip
