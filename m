Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F7661737
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjAHRMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjAHRMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:12:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB7BC03
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:12:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso4856935wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/lkkL89Pcoe2t45EnzPfXVYePJwfUVNjRNDAwijGT4=;
        b=O94fsp0w3OEjoDHPgganaE27Jq4ovuYTYuIV9blX03IgGgoZXxmmnBI3D6VsE2NCX+
         HcC3wX6uC+m+X/++SnB5c8lct3AQG7YCk32EvlmmK1rNH6B88KI/H2DTmd8uK3aYg04z
         DvaWDWf2C+c6u9Hdl/uXfwMilTeA1HjGITfQwX0rv4nAzGziggDZCsWjw5aSVB5r0Sbh
         6D1Q28xncys+5vEATjs8EdE0sytEKxPlLty/zs+YlAcFhqpnvxan2hLQztHRZMw1gIAU
         PjH7W5bUZIDMpiIwFtANDNTY2Zg/2Qa2OK8s0ElAph5oxkICuPNMvcXWWAgAjizLO+Xl
         dtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/lkkL89Pcoe2t45EnzPfXVYePJwfUVNjRNDAwijGT4=;
        b=p5XiSOFxpbp4Bvyt02czqSGYM3zjoPSxOwId6npdnMvbdvMvPbXj7NXDtS9clxD7pm
         7KTqJ3c2RT2dk01KgYW8SLtEy9tz7LmHGC5b+ovSxvaowhYKQSAYC1sUW+9nmcnZQBh/
         IcWMZlVeJ5tX34bjF9OkCnrQ5HH5WmPRyClVH7MNVvrO+yAJte2JECfGGBV67P/jzp75
         fgIhmRUsD1eMmsLMEsdb/3MMbfvboh5WAaq59FmUM4D57VEl91DMY71Ns1qwpmQmBrTO
         6QmeeNWiZxt4gSKisTRKPfXssuB8mrzYxkAeyAcQx+fKZvE70JIzuQ454IiLnkbs9JFN
         oduw==
X-Gm-Message-State: AFqh2kria1cv2TPAq+1NbQqSZ6EPfdCMk2iro9aLxypXVXW96CU5emtg
        47fdaIgJ8XGVm6R6f1hDk+Tv5YCza9vpPClF
X-Google-Smtp-Source: AMrXdXvz4FlSEZAQ+bLGH+p1FelSnooeORAot1o7bGt7hA2KZqfB08ESUqdIATydgOXVigFDDAu7Yg==
X-Received: by 2002:a7b:ca4f:0:b0:3c6:edc0:5170 with SMTP id m15-20020a7bca4f000000b003c6edc05170mr43335668wml.25.1673197920883;
        Sun, 08 Jan 2023 09:12:00 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003c701c12a17sm12678195wmp.12.2023.01.08.09.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 09:12:00 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Date:   Sun,  8 Jan 2023 17:11:59 +0000
Message-Id: <20230108171159.1311342-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <Y7qp80cK+r247eCU@zn.tnic>
References: <Y7qp80cK+r247eCU@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry that my mail didn't have proper reproduction instructions.

Something important I missed is that on non-affected hardware / QEMU,
the kernel parameter must be `retbleed=stuff,force`, as otherwise
`retbleed=stuff` is a no-op.
In any case, lscpu (or /sys/devices/system/cpu/vulnerabilities/retbleed)
should contain "Mitigation: Stuffing".

That's most likely the missing piece as otherwise, all combinations I've
tested exhibit this behavior, so I assumed that the problem always
reproduces regardless of the config.

More details follow in case it still doesn't reproduce:

The real HW where I found the problem is an HP 250 G6 (Intel i5-7200U),
with a desktop environment (Arch Linux, systemd, Sway, etc.), with both:
* A recent mainline kernel: commit 0a71553536d270e988580a3daa9fc87535908221
* The latest x86-tip: commit 9c4fb147c3492fd4be1b89c22a4c333308f6f44a
The config I use is the following one, which is based on the
Arch Linux kernel config (and I leave any new options at their defaults):
https://aur.archlinux.org/cgit/aur.git/plain/config?h=linux-mainline&id=20ffc62e08f6b0d48a088bccb6e0c3606b88083a
I need to either disable the BPF LSM or apply this patch to boot it:
https://lore.kernel.org/lkml/20230107051456.8800-1-joanbrugueram@gmail.com/
I suspend with `systemctl suspend`. Waking up hangs with `retbleed=stuff`
and works without it.

For verification I booted Fedora-Cloud-Base-Rawhide-20230107.n.0.x86_64.qcow2
(from https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Cloud):
    qemu-system-x86_64 -nodefaults -enable-kvm -smp 1 -m 1024 -vga std \
        -hda Fedora-Cloud-Base-Rawhide-20230107.n.0.x86_64.qcow2 \
        -serial stdio -monitor tcp:127.0.0.1:55555,server,nowait
I appended `retbleed=stuff,force init=/bin/sh` to the kernel command line,
suspended through sysfs and then wrote `system_wakeup` on the QEMU monitor.

For debugging/tracing, I booted the Arch kernel with a busybox initrd:
    qemu-system-x86_64 -nodefaults -no-reboot -initrd initramfs.gz \
        -kernel /boot/vmlinuz-linux-x86tip \
        -append "console=ttyS0 loglevel=4 retbleed=stuff,force" \
        -serial stdio -monitor tcp:127.0.0.1:55555,server,nowait
Suspended through sysfs, enabled singlestep and logs in the QEMU monitor,
then did a system_wakeup.

Regards,
- Joan
