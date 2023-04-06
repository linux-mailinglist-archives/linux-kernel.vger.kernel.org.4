Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704B6DA584
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbjDFWFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbjDFWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:05:02 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA00A5CB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:05:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l11so762434qtj.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680818698; x=1683410698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foA3pXnOMEI3cPd0gEtz9FKmZb7kgJDnrVn+KDAiuIc=;
        b=ghYSPH9xEE45W2qMuxnqlrYh633jNBUmZa7ISrZgxcU8oBUtt/AhavwlWXQru0Pe0h
         2oZjkcezHe7uxIedRmxQV4zn5RPnVai+24WF3s+LT8FF6KehjmQJhIYlXZKTKB3xKWZx
         0uS+ed5K7kZvhYjxJmJiK0BWbAYW0pvL46jvyMQy1woXzwJGwxIbHVn1VxtX7ruJ4IMO
         wOVWBhlic4x2REWr08HMIBZtYMNj53rQImhZat1S+qdlgWnUus0KKYlSbfimL48tNxfh
         x0kSOnr2KOAs1vNzbap+OzrgGAAMrTNm+x7jpDKKd31zeN34H/BMqtIyadxm7zkXkFr2
         0TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818698; x=1683410698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foA3pXnOMEI3cPd0gEtz9FKmZb7kgJDnrVn+KDAiuIc=;
        b=0Nj08dTx0yhMZMVrffclon0phejqAf837CAqZD0cMTFIIAlc3Axbg/M746Lp2U8729
         tvmPtHdg7bUfbhfi0qqMRbmkRKX1B0M6deuRVT9Y17UATTWU/DIIusaRAWY75Sv3qScq
         uUXTtYLLr3OnuXGnIgv57Yo3Ooe443X+4FNQJ0Mx4R1ekAmMJaR8E4D7SC9Zr3X1/JMu
         PubtmG27z1UH7U0EU45fGB6Xx4HpZTpqUPokBOwST02jGA8yxZ9zUP+BGZCgltOmQDtY
         H4VPrqq9DQ8HpXGw6Gt1lhdfa3qc+NHL3ZYW18KMIQ8/NL3KtkCHXWnPaXGAHMMkFiCJ
         VaOQ==
X-Gm-Message-State: AAQBX9fDrD7ivGFh9DccPV6N+9Phvlp0WqXUjFb0Xn/kTAz8x/TxXqGk
        Qc79dNy2koCWiNeKhUKESfCTme0yt2GMjQ==
X-Google-Smtp-Source: AKy350YzF8iFwJcF/VTXOXbvV0W9tZlIp66Pz25bETrgsrh8AoY/Pbq3CV6fVAVOPaRyyqMaNasbFQ==
X-Received: by 2002:ac8:5a8b:0:b0:3e6:6502:16af with SMTP id c11-20020ac85a8b000000b003e6650216afmr649548qtc.40.1680818698555;
        Thu, 06 Apr 2023 15:04:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id dm24-20020a05620a1d5800b00746a7945d87sm786356qkb.52.2023.04.06.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:04:57 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>, kapil.hali@broadcom.com
Subject: [PATCH v2] scripts/gdb: Print interrupts
Date:   Thu,  6 Apr 2023 15:04:51 -0700
Message-Id: <20230406220451.1583239-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GDB script prints the interrupts in the system in the same way that
/proc/interrupts does. This does include the architecture specific part
done by arch_show_interrupts() for x86, ARM, ARM64 and MIPS. Example
output from an ARM64 system:

(gdb) lx-interruptlist
           CPU0       CPU1       CPU2       CPU3
 10:       3167      1225      1276      2629     GICv2   30 Level     arch_timer
 13:          0         0         0         0     GICv2   36 Level     arm-pmu
 14:          0         0         0         0     GICv2   37 Level     arm-pmu
 15:          0         0         0         0     GICv2   38 Level     arm-pmu
 16:          0         0         0         0     GICv2   39 Level     arm-pmu
 28:          0         0         0         0  interrupt-controller@8410640    5 Edge      brcmstb-gpio-wake
 30:        125         0         0         0     GICv2  128 Level     ttyS0
 31:          0         0         0         0  interrupt-controller@8416000    0 Level     mspi_done
 32:          0         0         0         0  interrupt-controller@8410640    3 Edge      brcmstb-waketimer
 33:          0         0         0         0  interrupt-controller@8418580    8 Edge      brcmstb-waketimer-rtc
 34:        872         0         0         0     GICv2  230 Level     brcm_scmi@0
 35:          0         0         0         0  interrupt-controller@8410640   10 Edge      8d0f200.usb-phy
 37:          0         0         0         0     GICv2   97 Level     PCIe PME
 42:          0         0         0         0     GICv2  145 Level     xhci-hcd:usb1
 43:         94         0         0         0     GICv2   71 Level     mmc1
 44:          0         0         0         0     GICv2   70 Level     mmc0
IPI0:        23       666       154        98      Rescheduling interrupts
IPI1:       247      1053      1701       634      Function call interrupts
IPI2:         0         0         0         0      CPU stop interrupts
IPI3:         0         0         0         0      CPU stop (for crash dump) interrupts
IPI4:         0         0         0         0      Timer broadcast interrupts
IPI5:         7         9         5         0      IRQ work interrupts
IPI6:         0         0         0         0      CPU wake-up interrupts
ERR:          0

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- fixed typo in commit message and explained that some architectures do
  get the output of arch_show_interrupts() to be printed out

 scripts/gdb/linux/constants.py.in |  14 ++
 scripts/gdb/linux/interrupts.py   | 232 ++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |   1 +
 3 files changed, 247 insertions(+)
 create mode 100644 scripts/gdb/linux/interrupts.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index e484e2e7e4d5..36fd2b145853 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -15,6 +15,7 @@
 #include <linux/clk-provider.h>
 #include <linux/fs.h>
 #include <linux/hrtimer.h>
+#include <linux/irq.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
 #include <linux/radix-tree.h>
@@ -57,6 +58,10 @@ LX_VALUE(SB_NODIRATIME)
 /* linux/htimer.h */
 LX_GDBPARSED(hrtimer_resolution)
 
+/* linux/irq.h */
+LX_GDBPARSED(IRQD_LEVEL)
+LX_GDBPARSED(IRQ_HIDDEN)
+
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
 LX_VALUE(MNT_NODEV)
@@ -85,3 +90,12 @@ LX_CONFIG(CONFIG_HIGH_RES_TIMERS)
 LX_CONFIG(CONFIG_NR_CPUS)
 LX_CONFIG(CONFIG_OF)
 LX_CONFIG(CONFIG_TICK_ONESHOT)
+LX_CONFIG(CONFIG_GENERIC_IRQ_SHOW_LEVEL)
+LX_CONFIG(CONFIG_X86_LOCAL_APIC)
+LX_CONFIG(CONFIG_SMP)
+LX_CONFIG(CONFIG_X86_THERMAL_VECTOR)
+LX_CONFIG(CONFIG_X86_MCE_THRESHOLD)
+LX_CONFIG(CONFIG_X86_MCE_AMD)
+LX_CONFIG(CONFIG_X86_MCE)
+LX_CONFIG(CONFIG_X86_IO_APIC)
+LX_CONFIG(CONFIG_HAVE_KVM)
diff --git a/scripts/gdb/linux/interrupts.py b/scripts/gdb/linux/interrupts.py
new file mode 100644
index 000000000000..ef478e273791
--- /dev/null
+++ b/scripts/gdb/linux/interrupts.py
@@ -0,0 +1,232 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2023 Broadcom
+
+import gdb
+
+from linux import constants
+from linux import cpus
+from linux import utils
+from linux import radixtree
+
+irq_desc_type = utils.CachedType("struct irq_desc")
+
+def irq_settings_is_hidden(desc):
+    return desc['status_use_accessors'] & constants.LX_IRQ_HIDDEN
+
+def irq_desc_is_chained(desc):
+    return desc['action'] and desc['action'] == gdb.parse_and_eval("&chained_action")
+
+def irqd_is_level(desc):
+    return desc['irq_data']['common']['state_use_accessors'] & constants.LX_IRQD_LEVEL
+
+def show_irq_desc(prec, irq):
+    text = ""
+
+    desc = radixtree.lookup(gdb.parse_and_eval("&irq_desc_tree"), irq)
+    if desc is None:
+        return text
+
+    desc = desc.cast(irq_desc_type.get_type())
+    if desc is None:
+        return text
+
+    if irq_settings_is_hidden(desc):
+        return text
+
+    any_count = 0
+    if desc['kstat_irqs']:
+        for cpu in cpus.each_online_cpu():
+            any_count += cpus.per_cpu(desc['kstat_irqs'], cpu)
+
+    if (desc['action'] == 0 or irq_desc_is_chained(desc)) and any_count == 0:
+        return text;
+
+    text += "%*d: " % (prec, irq)
+    for cpu in cpus.each_online_cpu():
+        if desc['kstat_irqs']:
+            count = cpus.per_cpu(desc['kstat_irqs'], cpu)
+        else:
+            count = 0
+        text += "%10u" % (count)
+
+    name = "None"
+    if desc['irq_data']['chip']:
+        chip = desc['irq_data']['chip']
+        if chip['name']:
+            name = chip['name'].string()
+        else:
+            name = "-"
+
+    text += "  %8s" % (name)
+
+    if desc['irq_data']['domain']:
+        text += "  %*lu" % (prec, desc['irq_data']['hwirq'])
+    else:
+        text += "  %*s" % (prec, "")
+
+    if constants.LX_CONFIG_GENERIC_IRQ_SHOW_LEVEL:
+        text += " %-8s" % ("Level" if irqd_is_level(desc) else "Edge")
+
+    if desc['name']:
+        text += "-%-8s" % (desc['name'].string())
+
+    """ Some toolchains may not be able to provide information about irqaction """
+    try:
+        gdb.lookup_type("struct irqaction")
+        action = desc['action']
+        if action is not None:
+            text += "  %s" % (action['name'].string())
+            while True:
+                action = action['next']
+                if action is not None:
+                    break
+                if action['name']:
+                    text += ", %s" % (action['name'].string())
+    except:
+        pass
+
+    text += "\n"
+
+    return text
+
+def show_irq_err_count(prec):
+    cnt = utils.gdb_eval_or_none("irq_err_count")
+    text = ""
+    if cnt is not None:
+        text += "%*s: %10u\n" % (prec, "ERR", cnt['counter'])
+    return text
+
+def x86_show_irqstat(prec, pfx, field, desc):
+    irq_stat = gdb.parse_and_eval("&irq_stat")
+    text = "%*s: " % (prec, pfx)
+    for cpu in cpus.each_online_cpu():
+        stat = cpus.per_cpu(irq_stat, cpu)
+        text += "%10u " % (stat[field])
+    text += "  %s\n" % (desc)
+    return text
+
+def x86_show_mce(prec, var, pfx, desc):
+    pvar = gdb.parse_and_eval(var)
+    text = "%*s: " % (prec, pfx)
+    for cpu in cpus.each_online_cpu():
+        text += "%10u " % (cpus.per_cpu(pvar, cpu))
+    text += "  %s\n" % (desc)
+    return text
+
+def x86_show_interupts(prec):
+    text = x86_show_irqstat(prec, "NMI", '__nmi_count', 'Non-maskable interrupts')
+
+    if constants.LX_CONFIG_X86_LOCAL_APIC:
+        text += x86_show_irqstat(prec, "LOC", 'apic_timer_irqs', "Local timer interrupts")
+        text += x86_show_irqstat(prec, "SPU", 'irq_spurious_count', "Spurious interrupts")
+        text += x86_show_irqstat(prec, "PMI", 'apic_perf_irqs', "Performance monitoring interrupts")
+        text += x86_show_irqstat(prec, "IWI", 'apic_irq_work_irqs', "IRQ work interrupts")
+        text += x86_show_irqstat(prec, "RTR", 'icr_read_retry_count', "APIC ICR read retries")
+        if utils.gdb_eval_or_none("x86_platform_ipi_callback") is not None:
+            text += x86_show_irqstat(prec, "PLT", 'x86_platform_ipis', "Platform interrupts")
+
+    if constants.LX_CONFIG_SMP:
+        text += x86_show_irqstat(prec, "RES", 'irq_resched_count', "Rescheduling interrupts")
+        text += x86_show_irqstat(prec, "CAL", 'irq_call_count', "Function call interrupts")
+        text += x86_show_irqstat(prec, "TLB", 'irq_tlb_count', "TLB shootdowns")
+
+    if constants.LX_CONFIG_X86_THERMAL_VECTOR:
+        text += x86_show_irqstat(prec, "TRM", 'irq_thermal_count', "Thermal events interrupts")
+
+    if constants.LX_CONFIG_X86_MCE_THRESHOLD:
+        text += x86_show_irqstat(prec, "THR", 'irq_threshold_count', "Threshold APIC interrupts")
+
+    if constants.LX_CONFIG_X86_MCE_AMD:
+        text += x86_show_irqstat(prec, "DFR", 'irq_deferred_error_count', "Deferred Error APIC interrupts")
+
+    if constants.LX_CONFIG_X86_MCE:
+        text += x86_show_mce(prec, "&mce_exception_count", "MCE", "Machine check exceptions")
+        text == x86_show_mce(prec, "&mce_poll_count", "MCP", "Machine check polls")
+
+    text += show_irq_err_count(prec)
+
+    if constants.LX_CONFIG_X86_IO_APIC:
+        cnt = utils.gdb_eval_or_none("irq_mis_count")
+        if cnt is not None:
+            text += "%*s: %10u\n" % (prec, "MIS", cnt['counter'])
+
+    if constants.LX_CONFIG_HAVE_KVM:
+        text += x86_show_irqstat(prec, "PIN", 'kvm_posted_intr_ipis', 'Posted-interrupt notification event')
+        text += x86_show_irqstat(prec, "NPI", 'kvm_posted_intr_nested_ipis', 'Nested posted-interrupt event')
+        text += x86_show_irqstat(prec, "PIW", 'kvm_posted_intr_wakeup_ipis', 'Posted-interrupt wakeup event')
+
+    return text
+
+def arm_common_show_interrupts(prec):
+    text = ""
+    nr_ipi = utils.gdb_eval_or_none("nr_ipi")
+    ipi_desc = utils.gdb_eval_or_none("ipi_desc")
+    ipi_types = utils.gdb_eval_or_none("ipi_types")
+    if nr_ipi is None or ipi_desc is None or ipi_types is None:
+        return text
+
+    if prec >= 4:
+        sep = " "
+    else:
+        sep = ""
+
+    for ipi in range(nr_ipi):
+        text += "%*s%u:%s" % (prec - 1, "IPI", ipi, sep)
+        desc = ipi_desc[ipi].cast(irq_desc_type.get_type().pointer())
+        if desc == 0:
+            continue
+        for cpu in cpus.each_online_cpu():
+            text += "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu))
+        text += "      %s" % (ipi_types[ipi].string())
+        text += "\n"
+    return text
+
+def aarch64_show_interrupts(prec):
+    text = arm_common_show_interrupts(prec)
+    text += "%*s: %10lu\n" % (prec, "ERR", gdb.parse_and_eval("irq_err_count"))
+    return text
+
+def arch_show_interrupts(prec):
+    text = ""
+    if utils.is_target_arch("x86"):
+        text += x86_show_interupts(prec)
+    elif utils.is_target_arch("aarch64"):
+        text += aarch64_show_interrupts(prec)
+    elif utils.is_target_arch("arm"):
+        text += arm_common_show_interrupts(prec)
+    elif utils.is_target_arch("mips"):
+        text += show_irq_err_count(prec)
+    else:
+        raise gdb.GdbError("Unsupported architecture: {}".format(target_arch))
+
+    return text
+
+class LxInterruptList(gdb.Command):
+    """Print /proc/interrupts"""
+
+    def __init__(self):
+        super(LxInterruptList, self).__init__("lx-interruptlist", gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        nr_irqs = gdb.parse_and_eval("nr_irqs")
+        prec = 3
+        j = 1000
+        while prec < 10 and j <= nr_irqs:
+            prec += 1
+            j *= 10
+
+        gdb.write("%*s" % (prec + 8, ""))
+        for cpu in cpus.each_online_cpu():
+            gdb.write("CPU%-8d" % cpu)
+        gdb.write("\n")
+
+        if utils.gdb_eval_or_none("&irq_desc_tree") is None:
+            return
+
+        for irq in range(nr_irqs):
+            gdb.write(show_irq_desc(prec, irq))
+        gdb.write(arch_show_interrupts(prec))
+
+
+LxInterruptList()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 2f57adcf3dff..2a72f91059b5 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -42,3 +42,4 @@ else:
     import linux.device
     import linux.mm
     import linux.radixtree
+    import linux.interrupts
-- 
2.34.1

