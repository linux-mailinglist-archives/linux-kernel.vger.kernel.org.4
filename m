Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65760432D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJSL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiJSL3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:29:24 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE316C211;
        Wed, 19 Oct 2022 04:03:32 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1ol5li-00B8K8-3z;
        Wed, 19 Oct 2022 11:56:36 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 8/8] documentation: create a document about how balloon drivers operate
Date:   Wed, 19 Oct 2022 12:56:20 +0300
Message-Id: <20221019095620.124909-9-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe ballooning and how it works. Explain the two values
and why they are there.
Point the places where a user can see more balloon information and
how each driver operates.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 Documentation/mm/balloon.rst | 138 +++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/mm/balloon.rst

diff --git a/Documentation/mm/balloon.rst b/Documentation/mm/balloon.rst
new file mode 100644
index 000000000000..9fe9e7b228de
--- /dev/null
+++ b/Documentation/mm/balloon.rst
@@ -0,0 +1,138 @@
+===========================================
+Balloon: usage information visible by guest
+===========================================
+Background:
+===========
+The ballooning mechanism allows VM guests to reduce their memory size
+(thus relinquishing memory to the Host) and to increase it back (thus
+taking back memory from the Host).
+During OOM guest issues or guest low-performance issues
+investigations it is important to know if the Host has grabbed some of the
+Guest memory via the ballooning mechanism.
+
+Implementation description:
+===========================
+/proc/meminfo::
+
+  InflatedTotal:   2097152 kB
+  InflatedFree:          0 kB
+
+The difference comes from the way drivers account for inflated memory:
+ - Drivers that call adjust_managed_page_count InflateTotal
+ - Drivers that do NOT call adjust_managed_page_count InflateFree
+
+ * It is possible for one driver to operate in both modes depending on config options.
+
+
+The balloon statistics are also printed by show_mem() function, which
+is called on OOM condition or Alt+SysRQ+m is pressed.
+The show_mem() string is similar to /proc/meminfo and it is like::
+
+  Balloon InflatedTotal:XXXkB InflatedFree:YYYkB
+
+Additional balloon information is available via debugfs:
+ - KVM          features file: /sys/devices/pci\*/\*/virtio\*/features
+ - Hyper-V balloon guest file: /sys/kernel/debug/hv-balloon
+ - VMware  balloon guest file: /sys/kernel/debug/vmmemctl
+
+KVM balloon
+-----------
+The ballooning is implemented via virtio balloon device.
+Depending on the options the ballooned memory is accounted for in two ways:
+
+1. If deflate on OOM is enabled - ballooned memory is accounted as used.
+2. If deflate on OOM is not enabled - ballooned memory is subtracted
+   from total RAM.
+
+Q: How to check if "deflate on OOM" feature is enabled?
+A: Check balloon "features" file content.
+To decipher balloon bits are defined in include/uapi/linux/virtio_balloon.h
+Currently "deflate on OOM" feature is stored in the 2nd bit::
+  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM 2 /* Deflate balloon on OOM */
+Examples::
+
+  Without deflate on OOM:
+  # cat /sys/devices/pci0000:00/0000:00:03.0/virtio0/features
+  0100000000000000000000000000110010000000000000000000000000000000
+  With deflate on OOM:
+  # cat /sys/devices/pci0000:00/0000:00:03.0/virtio0/features
+  0110000000000000000000000000110010000000000000000000000000000000
+How to find virtio balloon device among other virtio devices?
+(check if the "virtio_balloon" module is loaded)::
+  # ls -l /sys/bus/virtio/drivers/virtio_balloon/virtio*
+    /sys/bus/virtio/drivers/virtio_balloon/virtio3 ->
+        ../../../../devices/pci0000:00/0000:00:07.0/virtio3
+
+To check virtio_balloon features::
+
+  # cat /sys/bus/virtio/drivers/virtio_balloon/virtio*/features
+  0110000000000000000000000000110010000000000000000000000000000000
+Balloon guest statistics output example::
+
+  # cat /sys/kernel/debug/virtio-balloon
+  InflatedTotal: 0 kB
+  InflatedFree: 0 kB
+
+- If "InflatedTotal" is not zero, it means the "deflate on OOM" feature is
+  **not** set and the provided amount of memory is subtracted from the total RAM
+  inside the Guest.
+- If "InflatedFree" is not zero, it means "deflate on OOM" feature is set and
+  the provided amount of memory is accounted as "used" inside the Guest.
+- Both "InflatedTotal" and "InflatedFree" cannot be non-zero at the same time.
+
+Hyper-V balloon
+---------------
+Balloon guest statistics output example::
+
+  # cat /sys/kernel/debug/hv-balloon
+  host_version : 2.0                // Hyper-V version the Guest is running under
+  capabilities : enabled hot_add
+  state : 1 (Initialized)
+  page_size : 4096
+  pages_added : 0                   // pages that are hot_add-ed to the Guest
+  pages_onlined : 0                 // pages that are added and then put online
+                                    // as available/used
+  pages_ballooned_out : 0           // pages the Host have taken back
+  vm_pages_commited : 795365        // total pages used by the Guest userspace
+  total_pages_commited : 977790     // total pages used by the Guest user+kernel
+  max_dynamic_page_count: 268435456 // maximum pages the Guest can have added
+                                    // via hot_add
+Hyper-V balloon driver changes the total RAM size reported by the Guest,
+thus the "InflatedTotal" counter will be non-zero in memory statistic
+reported during OOM or upon Alt+SysRQ+m.
+
+VMWare balloon
+---------------
+Balloon guest statistics output example::
+
+  # cat /sys/kernel/debug/vmmemctl
+  balloon capabilities: 0x1e
+  used capabilities: 0x6
+  is resetting: n
+  target: 0 pages
+  current: 0 pages
+  rateSleepAlloc: 2048 pages/sec
+  timer: 118
+  doorbell: 0
+  start: 1 ( 0 failed)
+  guestType: 1 ( 0 failed)
+  2m-lock: 0 ( 0 failed)
+  lock: 0 ( 0 failed)
+  2m-unlock: 0 ( 0 failed)
+  unlock: 0 ( 0 failed)
+  target: 118 ( 0 failed)
+  prim2mAlloc: 0 ( 0 failed)
+  primNoSleepAlloc: 0 ( 0 failed)
+  primCanSleepAlloc: 0 ( 0 failed)
+  prim2mFree: 0
+  primFree: 0
+  err2mAlloc: 0
+  errAlloc: 0
+  err2mFree: 0
+  errFree: 0
+  doorbellSet: 0
+  doorbellUnset: 1
+
+VMware balloon driver makes ballooned pages accounted as "used" in the
+Guest OS thus the "InflatedFree" counter will be non-zero in memory
+the statistic reported during OOM or upon Alt+SysRQ+m.
-- 
2.31.1

