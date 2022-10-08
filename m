Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32E5F873C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJHTrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJHTrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:47:16 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BA32D96;
        Sat,  8 Oct 2022 12:47:11 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so5652950oom.1;
        Sat, 08 Oct 2022 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOx6jUDDqH+LMikqvjmE2CcwI1yn+q2awUlypYAS4s4=;
        b=NXwd+pCyt00P96ygRa+3U8yVCD0gC2WhAeQyezElxlARfHGWbn74WN84N8V4eicfVD
         7m1r1DIaTL9Ni0+vYlN9wxT93YmYlWrn3iDbZBLX3ri6cLDlrKxXFQvPFaSQR9ltLBsr
         Hdyzne58MbkxMrWAx5XwqcwBPqivpk7hyCb2hZ6JmNTK/e3n5WQ67123MKNxu5kp+tSx
         V/pwlkseOc7znQJOGhPvQvJzP4tw/1+ECw5ZfJFODE5vBcqcExTCQcPmI+QbDTVTOYJJ
         3+3f24ReTX8/EzOfE7L2n/8JO9a2HqLNKmnYEfFx1j/TYWcDA0O5JsmR7kBbz7U6WGW8
         77tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOx6jUDDqH+LMikqvjmE2CcwI1yn+q2awUlypYAS4s4=;
        b=JxJx9RDcfIiP5eukChrSbnXN1k3zDZLL4HbM8s2jnqUHLfymPuYoJZjrFzsYTUevkM
         hfVYxU5kMNuVnawr2Mla5BE5xPBCeFnOY+NKCeue5pXXk58g1VR70zDpd4NxmbdcsWFx
         QAYLTuCCO+RagBkLJUpUHYWk9rViHQWOSskhNbe7HY8aque+Mowtqdft7P4l1yshogmu
         uudXy8ZnLGhlJGYOgTVbqg4WnRzykRiJy+HpN+YaLsfC76TsJYGCPkEbQ1PHgHw3QobC
         R0aTj/1zMOrg8dA20BUkv7Jh+A6mxGc4Cw1TFm8VRA6HliIf6B7m1ufDb4K+OAh4bscS
         /Q1w==
X-Gm-Message-State: ACrzQf0HaaYPoiSOkNEuP4DKe/QgD1KPAM5czcMj4AgKs+vlHNVRniYm
        92rPy64CGRQE3g+s0Kr2Hfo=
X-Google-Smtp-Source: AMsMyM5IKu2of+mN+drNmafO8nvo0fVBHt391G7vy1Pg4XNyNvQ//zVkeTCpFeBi8EEX8cybGM2toQ==
X-Received: by 2002:a05:6830:6084:b0:65c:3942:e3bf with SMTP id by4-20020a056830608400b0065c3942e3bfmr4959495otb.49.1665258430078;
        Sat, 08 Oct 2022 12:47:10 -0700 (PDT)
Received: from ian.penurio.us ([47.184.52.85])
        by smtp.gmail.com with ESMTPSA id y16-20020a9d4610000000b00656039161b1sm2976854ote.40.2022.10.08.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 12:47:09 -0700 (PDT)
From:   Ian Pilcher <arequipeno@gmail.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kabel@kernel.org
Subject: [RESEND PATCH v12 2/2] leds: trigger: Add block device LED trigger
Date:   Sat,  8 Oct 2022 14:47:07 -0500
Message-Id: <20221008194707.370805-3-arequipeno@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221008194707.370805-1-arequipeno@gmail.com>
References: <20221008194707.370805-1-arequipeno@gmail.com>
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

Add "blkdev" LED trigger to blink LEDs in response to block device
activity.

Add LEDS_TRIGGER_BLKDEV (tristate) config option to control building of
the trigger.

Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
Tested-by: Tor Vic <torvic9@mailbox.org>
---
 drivers/leds/trigger/Kconfig          |    9 +
 drivers/leds/trigger/Makefile         |    1 +
 drivers/leds/trigger/ledtrig-blkdev.c | 1220 +++++++++++++++++++++++++
 3 files changed, 1230 insertions(+)
 create mode 100644 drivers/leds/trigger/ledtrig-blkdev.c

diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index dc6816d36d06..bda249068182 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -154,4 +154,13 @@ config LEDS_TRIGGER_TTY
 
 	  When build as a module this driver will be called ledtrig-tty.
 
+config LEDS_TRIGGER_BLKDEV
+	tristate "LED Trigger for block devices"
+	depends on BLOCK
+	help
+	  The blkdev LED trigger allows LEDs to be controlled by block device
+	  activity (reads and writes).
+
+	  See Documentation/leds/ledtrig-blkdev.rst.
+
 endif # LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index 25c4db97cdd4..d53bab5d93f1 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
 obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+= ledtrig-pattern.o
 obj-$(CONFIG_LEDS_TRIGGER_AUDIO)	+= ledtrig-audio.o
 obj-$(CONFIG_LEDS_TRIGGER_TTY)		+= ledtrig-tty.o
+obj-$(CONFIG_LEDS_TRIGGER_BLKDEV)	+= ledtrig-blkdev.o
diff --git a/drivers/leds/trigger/ledtrig-blkdev.c b/drivers/leds/trigger/ledtrig-blkdev.c
new file mode 100644
index 000000000000..8614e308fadc
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-blkdev.c
@@ -0,0 +1,1220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ *	Block device LED trigger
+ *
+ *	Copyright 2021-2022 Ian Pilcher <arequipeno@gmail.com>
+ */
+
+#include <linux/blkdev.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/part_stat.h>
+#include <linux/xarray.h>
+
+/**
+ * DOC: Overview
+ *
+ * The ``blkdev`` LED trigger works by periodically checking the activity
+ * counters of block devices that have been linked to one or more LEDs and
+ * blinking those LED(s) if the correct type of activity has occurred.  The
+ * periodic check is scheduled with the Linux kernel's deferred work facility.
+ *
+ * Trigger-specific data about block devices and LEDs is stored in two data
+ * structures --- &struct blkdev_trig_bdev (a "BTB") and &struct blkdev_trig_led
+ * (a "BTL").  Each structure contains a &struct xarray that holds links to any
+ * linked devices of the other type.  I.e. &blkdev_trig_bdev.linked_btls
+ * contains links to all BTLs whose LEDs have been linked to the BTB's block
+ * device, and &blkdev_trig_led.linked_btbs contains links to all BTBs whose
+ * block devices have been linked to the BTL's LED.  Thus, a block device can
+ * be linked to more than one LED, and an LED can be linked to more than one
+ * block device.
+ */
+
+/* Default, minimum & maximum blink duration (milliseconds) */
+#define BLKDEV_TRIG_BLINK_DEF	75
+#define BLKDEV_TRIG_BLINK_MIN	10
+#define BLKDEV_TRIG_BLINK_MAX	86400000  /* 24 hours */
+
+/* Default, minimum & maximum activity check interval (milliseconds) */
+#define BLKDEV_TRIG_CHECK_DEF	100
+#define BLKDEV_TRIG_CHECK_MIN	25
+#define BLKDEV_TRIG_CHECK_MAX	86400000  /* 24 hours */
+
+/*
+ * If blkdev_trig_check() can't lock the mutex, how long to wait before trying
+ * again (milliseconds)
+ */
+#define BLKDEV_TRIG_CHECK_RETRY	5
+
+/* Mode argument for calls to blkdev_get_by_path() and blkdev_put() */
+#define BLKDEV_TRIG_FMODE	0
+
+/**
+ * struct blkdev_trig_bdev - Trigger-specific data about a block device.
+ * @last_checked:	Time (in jiffies) at which the trigger last checked this
+ *			block device for activity.
+ * @last_activity:	Time (in jiffies) at which the trigger last detected
+ *			activity of each type.
+ * @ios:		Activity counter values for each type, corresponding to
+ *			the timestamps in &last_activity.
+ * @index:		&xarray index, so the BTB can be included in one or more
+ *			&blkdev_trig_led.linked_btbs.
+ * @bdev:		The block device.
+ * @linked_btls:	The BTLs that represent the LEDs linked to the BTB's
+ *			block device.
+ *
+ * Every block device linked to at least one LED gets a "BTB."  A BTB is created
+ * when a block device that is not currently linked to any LEDs is linked to an
+ * LED.
+ *
+ * A BTB is freed when one of the following occurs:
+ *
+ * * The number of LEDs linked to the block device becomes zero, because it has
+ *   been unlinked from its last LED using the trigger's &sysfs interface.
+ *
+ * * The number of LEDs linked to the block device becomes zero, because the
+ *   last LED to which it was linked has been disassociated from the trigger
+ *   (which happens automatically if the LED device is removed from the system).
+ *
+ * * The BTB's block device is removed from the system.  To accomodate this
+ *   scenario, BTB's are created as device resources, so that the release
+ *   function will be called by the driver core when the device is removed.
+ */
+struct blkdev_trig_bdev {
+	unsigned long		last_checked;
+	unsigned long		last_activity[NR_STAT_GROUPS];
+	unsigned long		ios[NR_STAT_GROUPS];
+	unsigned long		index;
+	struct block_device	*bdev;
+	struct xarray		linked_btls;
+};
+
+/**
+ * struct blkdev_trig_led - Trigger-specific data about an LED.
+ * @last_checked:	Time (in jiffies) at which the trigger last checked the
+ *			the block devices linked to this LED for activity.
+ * @index:		&xarray index, so the BTL can be included in one or more
+ *			&blkdev_trig_bdev.linked_btls.
+ * @mode:		Bitmask for types of block device activity that will
+ *			cause this LED to blink --- reads, writes, discards,
+ *			etc.
+ * @led:		The LED device.
+ * @blink_msec:		Duration of a blink (milliseconds).
+ * @check_jiffies:	Frequency with which block devices linked to this LED
+ *			should be checked for activity (jiffies).
+ * @linked_btbs:	The BTBs that represent the block devices linked to the
+ *			BTL's LED.
+ * @all_btls_node:	The BTL's node in the module's list of all BTLs.
+ *
+ * Every LED associated with the block device trigger gets a "BTL."  A BTL is
+ * created when the trigger is "activated" on an LED (usually by writing
+ * ``blkdev`` to the LED's &sysfs &trigger attribute).  A BTL is freed wnen its
+ * LED is disassociated from the trigger, either through the trigger's &sysfs
+ * interface or because the LED device is removed from the system.
+ */
+struct blkdev_trig_led {
+	unsigned long		last_checked;
+	unsigned long		index;
+	unsigned long		mode;  /* must be ulong for atomic bit ops */
+	struct led_classdev	*led;
+	unsigned int		blink_msec;
+	unsigned int		check_jiffies;
+	struct xarray		linked_btbs;
+	struct hlist_node	all_btls_node;
+};
+
+/* Protects everything except atomic LED attributes */
+static DEFINE_MUTEX(blkdev_trig_mutex);
+
+/* BTB device resource release function */
+static void blkdev_trig_btb_release(struct device *dev, void *res);
+
+/* Index for next BTB or BTL */
+static unsigned long blkdev_trig_next_index;
+
+/* All LEDs associated with the trigger */
+static HLIST_HEAD(blkdev_trig_all_btls);
+
+/* Delayed work to periodically check for activity & blink LEDs */
+static void blkdev_trig_check(struct work_struct *work);
+static DECLARE_DELAYED_WORK(blkdev_trig_work, blkdev_trig_check);
+
+/* When is the delayed work scheduled to run next (jiffies) */
+static unsigned long blkdev_trig_next_check;
+
+/* Total number of BTB-to-BTL links */
+static unsigned int blkdev_trig_link_count;
+
+/* Empty sysfs attribute list for next 2 declarations */
+static struct attribute *blkdev_trig_attrs_empty[] = { NULL };
+
+/* linked_leds sysfs directory for block devs linked to 1 or more LEDs */
+static const struct attribute_group blkdev_trig_linked_leds = {
+	.name	= "linked_leds",
+	.attrs	= blkdev_trig_attrs_empty,
+};
+
+/* linked_devices sysfs directory for each LED associated with the trigger */
+static const struct attribute_group blkdev_trig_linked_devs = {
+	.name	= "linked_devices",
+	.attrs	= blkdev_trig_attrs_empty,
+};
+
+
+/*
+ *
+ *	Delayed work to check for activity & blink LEDs
+ *
+ */
+
+/**
+ * blkdev_trig_blink() - Blink an LED, if the correct type of activity has
+ *	occurred on the block device.
+ * @btl:	The BTL that represents the LED
+ * @btb:	The BTB that represents the block device
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ * Return:	&true if the LED is blinked, &false if not.
+ */
+static bool blkdev_trig_blink(const struct blkdev_trig_led *btl,
+			      const struct blkdev_trig_bdev *btb)
+{
+	unsigned long mode, mask, delay_on, delay_off;
+	enum stat_group i;
+
+	mode = READ_ONCE(btl->mode);
+
+	for (i = STAT_READ, mask = 1; i <= STAT_FLUSH; ++i, mask <<= 1) {
+
+		if (!(mode & mask))
+			continue;
+
+		if (time_before_eq(btb->last_activity[i], btl->last_checked))
+			continue;
+
+		delay_on = READ_ONCE(btl->blink_msec);
+		delay_off = 1;	/* 0 leaves LED turned on */
+
+		led_blink_set_oneshot(btl->led, &delay_on, &delay_off, 0);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * blkdev_trig_update_btb() - Update a BTB's activity counters and timestamps.
+ * @btb:	The BTB
+ * @now:	Timestamp (in jiffies)
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ */
+static void blkdev_trig_update_btb(struct blkdev_trig_bdev *btb,
+				   unsigned long now)
+{
+	unsigned long new_ios;
+	enum stat_group i;
+
+	for (i = STAT_READ; i <= STAT_FLUSH; ++i) {
+
+		new_ios = part_stat_read(btb->bdev, ios[i]);
+
+		if (new_ios != btb->ios[i]) {
+			btb->ios[i] = new_ios;
+			btb->last_activity[i] = now;
+		}
+	}
+
+	btb->last_checked = now;
+}
+
+/**
+ * blkdev_trig_check() - Check linked devices for activity and blink LEDs.
+ * @work:	Delayed work (&blkdev_trig_work)
+ *
+ * Context:	Process context.  Takes and releases &blkdev_trig_mutex.
+ */
+static void blkdev_trig_check(struct work_struct *work)
+{
+	struct blkdev_trig_led *btl;
+	struct blkdev_trig_bdev *btb;
+	unsigned long index, delay, now, led_check, led_delay;
+	bool blinked;
+
+	if (!mutex_trylock(&blkdev_trig_mutex)) {
+		delay = msecs_to_jiffies(BLKDEV_TRIG_CHECK_RETRY);
+		goto exit_reschedule;
+	}
+
+	now = jiffies;
+	delay = ULONG_MAX;
+
+	hlist_for_each_entry (btl, &blkdev_trig_all_btls, all_btls_node) {
+
+		led_check = btl->last_checked + btl->check_jiffies;
+
+		if (time_before_eq(led_check, now)) {
+
+			blinked = false;
+
+			xa_for_each (&btl->linked_btbs, index, btb) {
+
+				if (btb->last_checked != now)
+					blkdev_trig_update_btb(btb, now);
+				if (!blinked)
+					blinked = blkdev_trig_blink(btl, btb);
+			}
+
+			btl->last_checked = now;
+			led_delay = btl->check_jiffies;
+
+		} else {
+			led_delay = led_check - now;
+		}
+
+		if (led_delay < delay)
+			delay = led_delay;
+	}
+
+	mutex_unlock(&blkdev_trig_mutex);
+
+exit_reschedule:
+	WARN_ON_ONCE(delay == ULONG_MAX);
+	WARN_ON_ONCE(!schedule_delayed_work(&blkdev_trig_work, delay));
+}
+
+/**
+ * blkdev_trig_sched_led() - Set the schedule of the delayed work when a new
+ *	LED is added to the schedule.
+ * @btl:	The BTL that represents the LED
+ *
+ * Called when the number of block devices to which an LED is linked becomes
+ * non-zero.
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ */
+static void blkdev_trig_sched_led(const struct blkdev_trig_led *btl)
+{
+	unsigned long delay = READ_ONCE(btl->check_jiffies);
+	unsigned long check_by = jiffies + delay;
+
+	/*
+	 * If no other LED-to-block device links exist, simply schedule the
+	 * delayed work according to this LED's check_interval attribute
+	 * (check_jiffies).
+	 */
+	if (blkdev_trig_link_count == 0) {
+		WARN_ON(!schedule_delayed_work(&blkdev_trig_work, delay));
+		blkdev_trig_next_check = check_by;
+		return;
+	}
+
+	/*
+	 * If the next check is already scheduled to occur soon enough to
+	 * accomodate this LED's check_interval, the schedule doesn't need
+	 * to be changed.
+	 */
+	if (time_after_eq(check_by, blkdev_trig_next_check))
+		return;
+
+	/*
+	 * Modify the schedule, so that the delayed work runs soon enough for
+	 * this LED.
+	 */
+	WARN_ON(!mod_delayed_work(system_wq, &blkdev_trig_work, delay));
+	blkdev_trig_next_check = check_by;
+}
+
+
+/*
+ *
+ *	Linking and unlinking LEDs and block devices
+ *
+ */
+
+/**
+ * blkdev_trig_link() - Link a block device to an LED.
+ * @btl:	The BTL that represents the LED
+ * @btb:	The BTB that represents the block device
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ * Return:	&0 on success, negative &errno on error.
+ */
+static int blkdev_trig_link(struct blkdev_trig_led *btl,
+			    struct blkdev_trig_bdev *btb)
+{
+	bool led_first_link;
+	int err;
+
+	led_first_link = xa_empty(&btl->linked_btbs);
+
+	err = xa_insert(&btb->linked_btls, btl->index, btl, GFP_KERNEL);
+	if (err)
+		return err;
+
+	err = xa_insert(&btl->linked_btbs, btb->index, btb, GFP_KERNEL);
+	if (err)
+		goto error_erase_btl;
+
+	/* Create /sys/class/block/<bdev>/linked_leds/<led> symlink */
+	err = sysfs_add_link_to_group(bdev_kobj(btb->bdev),
+				      blkdev_trig_linked_leds.name,
+				      &btl->led->dev->kobj, btl->led->name);
+	if (err)
+		goto error_erase_btb;
+
+	/* Create /sys/class/leds/<led>/linked_devices/<bdev> symlink */
+	err = sysfs_add_link_to_group(&btl->led->dev->kobj,
+				      blkdev_trig_linked_devs.name,
+				      bdev_kobj(btb->bdev),
+				      dev_name(&btb->bdev->bd_device));
+	if (err)
+		goto error_remove_symlink;
+
+	/*
+	 * If this is the first block device linked to this LED, the delayed
+	 * work schedule may need to be changed.
+	 */
+	if (led_first_link)
+		blkdev_trig_sched_led(btl);
+
+	++blkdev_trig_link_count;
+
+	return 0;
+
+error_remove_symlink:
+	sysfs_remove_link_from_group(bdev_kobj(btb->bdev),
+				     blkdev_trig_linked_leds.name,
+				     btl->led->name);
+error_erase_btb:
+	xa_erase(&btl->linked_btbs, btb->index);
+error_erase_btl:
+	xa_erase(&btb->linked_btls, btl->index);
+	return err;
+}
+
+/**
+ * blkdev_trig_put_btb() - Remove and free a BTB, if it is no longer needed.
+ * @btb:	The BTB
+ *
+ * Does nothing if the BTB (block device) is still linked to at least one LED.
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ */
+static void blkdev_trig_put_btb(struct blkdev_trig_bdev *btb)
+{
+	struct block_device *bdev = btb->bdev;
+	int err;
+
+	if (xa_empty(&btb->linked_btls)) {
+
+		sysfs_remove_group(bdev_kobj(bdev), &blkdev_trig_linked_leds);
+		err = devres_destroy(&bdev->bd_device, blkdev_trig_btb_release,
+				     NULL, NULL);
+		WARN_ON(err);
+	}
+}
+
+/**
+ * _blkdev_trig_unlink_always() - Perform the unconditionally required steps of
+ *	unlinking a block device from an LED.
+ * @btl:	The BTL that represents the LED
+ * @btb:	The BTB that represents the block device
+ *
+ * When a block device is unlinked from an LED, certain steps must be performed
+ * only if the block device is **not** being released.  This function performs
+ * those steps that are **always** required, whether or not the block device is
+ * being released.
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ */
+static void _blkdev_trig_unlink_always(struct blkdev_trig_led *btl,
+				       struct blkdev_trig_bdev *btb)
+{
+	--blkdev_trig_link_count;
+
+	if (blkdev_trig_link_count == 0)
+		WARN_ON(!cancel_delayed_work_sync(&blkdev_trig_work));
+
+	xa_erase(&btb->linked_btls, btl->index);
+	xa_erase(&btl->linked_btbs, btb->index);
+
+	/* Remove /sys/class/leds/<led>/linked_devices/<bdev> symlink */
+	sysfs_remove_link_from_group(&btl->led->dev->kobj,
+				     blkdev_trig_linked_devs.name,
+				     dev_name(&btb->bdev->bd_device));
+}
+
+/**
+ * blkdev_trig_unlink_norelease() - Unlink an LED from a block device that is
+ *	**not** being released.
+ * @btl:	The BTL that represents the LED.
+ * @btb:	The BTB that represents the block device.
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ */
+static void blkdev_trig_unlink_norelease(struct blkdev_trig_led *btl,
+					 struct blkdev_trig_bdev *btb)
+{
+	_blkdev_trig_unlink_always(btl, btb);
+
+	/* Remove /sys/class/block/<bdev>/linked_leds/<led> symlink */
+	sysfs_remove_link_from_group(bdev_kobj(btb->bdev),
+				     blkdev_trig_linked_leds.name,
+				     btl->led->name);
+
+	blkdev_trig_put_btb(btb);
+}
+
+/**
+ * blkdev_trig_unlink_release() - Unlink an LED from a block device that is
+ *	being released.
+ * @btl:	The BTL that represents the LED
+ * @btb:	The BTB that represents the block device
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ */
+static void blkdev_trig_unlink_release(struct blkdev_trig_led *btl,
+				       struct blkdev_trig_bdev *btb)
+{
+	_blkdev_trig_unlink_always(btl, btb);
+
+	/*
+	 * If the BTB is being released, the driver core has already removed the
+	 * device's attribute groups, and the BTB will be freed automatically,
+	 * so there's nothing else to do.
+	 */
+}
+
+
+/*
+ *
+ *	BTB creation
+ *
+ */
+
+/**
+ * blkdev_trig_btb_release() - BTB device resource release function.
+ * @dev:	The block device
+ * @res:	The BTB
+ *
+ * Called by the driver core when a block device with a BTB is removed.
+ *
+ * Context:	Process context.  Takes and releases &blkdev_trig_mutex.
+ */
+static void blkdev_trig_btb_release(struct device *dev, void *res)
+{
+	struct blkdev_trig_bdev *btb = res;
+	struct blkdev_trig_led *btl;
+	unsigned long index;
+
+	mutex_lock(&blkdev_trig_mutex);
+
+	xa_for_each (&btb->linked_btls, index, btl)
+		blkdev_trig_unlink_release(btl, btb);
+
+	mutex_unlock(&blkdev_trig_mutex);
+}
+
+/**
+ * blkdev_trig_get_bdev() - Get a block device by path.
+ * @path:	The value written to an LED's &link_dev_by_path or
+ *		&unlink_dev_by_path attribute, which should be the path to a
+ *		special file that represents a block device
+ * @len:	The number of characters in &path (not including its
+ *		terminating null)
+ *
+ * The caller must call blkdev_put() when finished with the device.
+ *
+ * Context:	Process context.
+ * Return:	The block device, or an error pointer.
+ */
+static struct block_device *blkdev_trig_get_bdev(const char *path, size_t len)
+{
+	struct block_device *bdev;
+	char *buf;
+
+	buf = kmemdup(path, len + 1, GFP_KERNEL);  /* +1 to include null */
+	if (buf == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	bdev = blkdev_get_by_path(strim(buf), BLKDEV_TRIG_FMODE, THIS_MODULE);
+	kfree(buf);
+	return bdev;
+}
+
+/**
+ * blkdev_trig_get_btb() - Find or create the BTB for a block device.
+ * @path:	The value written to an LED's &link_dev_by_path attribute,
+ *		which should be the path to a special file that represents a
+ *		block device
+ * @len:	The number of characters in &path
+ *
+ * If a new BTB is created, because the block device was not previously linked
+ * to any LEDs, the block device's &linked_leds &sysfs directory is created.
+ *
+ * Context:	Process context.  Caller must hold &blkdev_trig_mutex.
+ * Return:	Pointer to the BTB, error pointer on error.
+ */
+static struct blkdev_trig_bdev *blkdev_trig_get_btb(const char *path,
+						    size_t len)
+{
+	struct block_device *bdev;
+	struct blkdev_trig_bdev *btb;
+	int err;
+
+	bdev = blkdev_trig_get_bdev(path, len);
+	if (IS_ERR(bdev))
+		return ERR_CAST(bdev);
+
+	btb = devres_find(&bdev->bd_device, blkdev_trig_btb_release,
+			  NULL, NULL);
+	if (btb != NULL) {
+		err = 0;
+		goto exit_put_bdev;
+	}
+
+	if (blkdev_trig_next_index == ULONG_MAX) {
+		err = -EOVERFLOW;
+		goto exit_put_bdev;
+	}
+
+	btb = devres_alloc(blkdev_trig_btb_release, sizeof(*btb), GFP_KERNEL);
+	if (btb == NULL) {
+		err = -ENOMEM;
+		goto exit_put_bdev;
+	}
+
+	err = sysfs_create_group(bdev_kobj(bdev), &blkdev_trig_linked_leds);
+	if (err)
+		goto exit_free_btb;
+
+	btb->index = blkdev_trig_next_index++;
+	btb->bdev = bdev;
+	xa_init(&btb->linked_btls);
+
+	/* Populate BTB activity counters */
+	blkdev_trig_update_btb(btb, jiffies);
+
+	devres_add(&bdev->bd_device, btb);
+
+exit_free_btb:
+	if (err)
+		devres_free(btb);
+exit_put_bdev:
+	blkdev_put(bdev, BLKDEV_TRIG_FMODE);
+	return err ? ERR_PTR(err) : btb;
+}
+
+
+/*
+ *
+ *	Activating and deactivating the trigger on an LED
+ *
+ */
+
+/**
+ * blkdev_trig_activate() - Called by the LEDs subsystem when an LED is
+ *	associated with the trigger.
+ * @led:	The LED
+ *
+ * Context:	Process context.  Takes and releases &blkdev_trig_mutex.
+ * Return:	&0 on success, negative &errno on error.
+ */
+static int blkdev_trig_activate(struct led_classdev *led)
+{
+	struct blkdev_trig_led *btl;
+	int err;
+
+	btl = kzalloc(sizeof(*btl), GFP_KERNEL);
+	if (btl == NULL)
+		return -ENOMEM;
+
+	err = mutex_lock_interruptible(&blkdev_trig_mutex);
+	if (err)
+		goto exit_free;
+
+	if (blkdev_trig_next_index == ULONG_MAX) {
+		err = -EOVERFLOW;
+		goto exit_unlock;
+	}
+
+	btl->index = blkdev_trig_next_index++;
+	btl->last_checked = jiffies;
+	btl->mode = -1;  /* set all bits */
+	btl->led = led;
+	btl->blink_msec = BLKDEV_TRIG_BLINK_DEF;
+	btl->check_jiffies = msecs_to_jiffies(BLKDEV_TRIG_CHECK_DEF);
+	xa_init(&btl->linked_btbs);
+
+	hlist_add_head(&btl->all_btls_node, &blkdev_trig_all_btls);
+	led_set_trigger_data(led, btl);
+
+exit_unlock:
+	mutex_unlock(&blkdev_trig_mutex);
+exit_free:
+	if (err)
+		kfree(btl);
+	return err;
+}
+
+/**
+ * blkdev_trig_deactivate() - Called by the the LEDs subsystem when an LED is
+ *	disassociated from the trigger.
+ * @led:	The LED
+ *
+ * The LEDs subsystem also calls this function when an LED associated with the
+ * trigger is removed or when the trigger is unregistered (if the module is
+ * unloaded).
+ *
+ * Context:	Process context.  Takes and releases &blkdev_trig_mutex.
+ */
+static void blkdev_trig_deactivate(struct led_classdev *led)
+{
+	struct blkdev_trig_led *btl = led_get_trigger_data(led);
+	struct blkdev_trig_bdev *btb;
+	unsigned long index;
+
+	mutex_lock(&blkdev_trig_mutex);
+
+	xa_for_each (&btl->linked_btbs, index, btb)
+		blkdev_trig_unlink_norelease(btl, btb);
+
+	hlist_del(&btl->all_btls_node);
+	kfree(btl);
+
+	mutex_unlock(&blkdev_trig_mutex);
+}
+
+
+/*
+ *
+ *	Link-related attribute store functions
+ *
+ */
+
+/**
+ * link_dev_by_path_store() - &link_dev_by_path device attribute store function.
+ * @dev:	The LED device
+ * @attr:	The &link_dev_by_path attribute (&dev_attr_link_dev_by_path)
+ * @buf:	The value written to the attribute, which should be the path to
+ *		a special file that represents a block device to be linked to
+ *		the LED (e.g. ``/dev/sda``)
+ * @count:	The number of characters in &buf
+ *
+ * Context:	Process context.  Takes and releases &blkdev_trig_mutex.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t link_dev_by_path_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct blkdev_trig_led *btl = led_trigger_get_drvdata(dev);
+	struct blkdev_trig_bdev *btb;
+	int err;
+
+	err = mutex_lock_interruptible(&blkdev_trig_mutex);
+	if (err)
+		return err;
+
+	btb = blkdev_trig_get_btb(buf, count);
+	if (IS_ERR(btb)) {
+		err = PTR_ERR(btb);
+		goto exit_unlock;
+	}
+
+	if (xa_load(&btb->linked_btls, btl->index) != NULL) {
+		err = -EEXIST;
+		goto exit_put_btb;
+	}
+
+	err = blkdev_trig_link(btl, btb);
+
+exit_put_btb:
+	if (err)
+		blkdev_trig_put_btb(btb);
+exit_unlock:
+	mutex_unlock(&blkdev_trig_mutex);
+	return err ? : count;
+}
+
+/**
+ * unlink_dev_by_path_store() - &unlink_dev_by_path device attribute store
+ *	function.
+ * @dev:	The LED device
+ * @attr:	The &unlink_dev_by_path attribute (&dev_attr_unlink_dev_by_path)
+ * @buf:	The value written to the attribute, which should be the path to
+ *		a special file that represents a block device to be unlinked
+ *		from the LED (e.g. ``/dev/sda``)
+ * @count:	The number of characters in &buf
+ *
+ * Context:	Process context.  Takes and releases &blkdev_trig_mutex.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t unlink_dev_by_path_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct blkdev_trig_led *btl = led_trigger_get_drvdata(dev);
+	struct block_device *bdev;
+	struct blkdev_trig_bdev *btb;
+	int err;
+
+	bdev = blkdev_trig_get_bdev(buf, count);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	err = mutex_lock_interruptible(&blkdev_trig_mutex);
+	if (err)
+		goto exit_put_bdev;
+
+	btb = devres_find(&bdev->bd_device, blkdev_trig_btb_release,
+			  NULL, NULL);
+	if (btb == NULL) {
+		err = -EUNATCH;  /* bdev isn't linked to any LED */
+		goto exit_unlock;
+	}
+
+	if (xa_load(&btb->linked_btls, btl->index) == NULL) {
+		err = -EUNATCH;  /* bdev isn't linked to this LED */
+		goto exit_unlock;
+	}
+
+	blkdev_trig_unlink_norelease(btl, btb);
+
+exit_unlock:
+	mutex_unlock(&blkdev_trig_mutex);
+exit_put_bdev:
+	blkdev_put(bdev, BLKDEV_TRIG_FMODE);
+	return err ? : count;
+}
+
+/**
+ * unlink_dev_by_name_store() - &unlink_dev_by_name device attribute store
+ *	function.
+ * @dev:	The LED device
+ * @attr:	The &unlink_dev_by_name attribute (&dev_attr_unlink_dev_by_name)
+ * @buf:	The value written to the attribute, which should be the kernel
+ *		name of a block device to be unlinked from the LED (e.g.
+ *		``sda``)
+ * @count:	The number of characters in &buf
+ *
+ * Context:	Process context.  Takes and releases &blkdev_trig_mutex.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t unlink_dev_by_name_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct blkdev_trig_led *btl = led_trigger_get_drvdata(dev);
+	struct blkdev_trig_bdev *btb;
+	unsigned long index;
+	int err;
+
+	err = mutex_lock_interruptible(&blkdev_trig_mutex);
+	if (err)
+		return err;
+
+	err = -EUNATCH;
+
+	xa_for_each (&btl->linked_btbs, index, btb) {
+
+		if (sysfs_streq(dev_name(&btb->bdev->bd_device), buf)) {
+			blkdev_trig_unlink_norelease(btl, btb);
+			err = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&blkdev_trig_mutex);
+	return err ? : count;
+}
+
+
+/*
+ *
+ *	Atomic attribute show & store functions
+ *
+ */
+
+/**
+ * blink_time_show() - &blink_time device attribute show function.
+ * @dev:	The LED device
+ * @attr:	The &blink_time attribute (&dev_attr_blink_time)
+ * @buf:	Output buffer
+ *
+ * Writes the value of &blkdev_trig_led.blink_msec to &buf.
+ *
+ * Context:	Process context.
+ * Return:	The number of characters written to &buf.
+ */
+static ssize_t blink_time_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	const struct blkdev_trig_led *btl = led_trigger_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", READ_ONCE(btl->blink_msec));
+}
+
+/**
+ * blink_time_store() - &blink_time device attribute store function.
+ * @dev:	The LED device
+ * @attr:	The &blink_time attribute (&dev_attr_blink_time)
+ * @buf:	The new value (as written to the &sysfs attribute)
+ * @count:	The number of characters in &buf
+ *
+ * Sets &blkdev_trig_led.blink_msec to the value in &buf.
+ *
+ * Context:	Process context.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t blink_time_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct blkdev_trig_led *btl = led_trigger_get_drvdata(dev);
+	unsigned int value;
+	int err;
+
+	err = kstrtouint(buf, 0, &value);
+	if (err)
+		return err;
+
+	if (value < BLKDEV_TRIG_BLINK_MIN || value > BLKDEV_TRIG_BLINK_MAX)
+		return -ERANGE;
+
+	WRITE_ONCE(btl->blink_msec, value);
+	return count;
+}
+
+/**
+ * check_interval_show() - &check_interval device attribute show function.
+ * @dev:	The LED device
+ * @attr:	The &check_interval attribute (&dev_attr_check_interval)
+ * @buf:	Output buffer
+ *
+ * Writes the value of &blkdev_trig_led.check_jiffies (converted to
+ * milliseconds) to &buf.
+ *
+ * Context:	Process context.
+ * Return:	The number of characters written to &buf.
+ */
+static ssize_t check_interval_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct blkdev_trig_led *btl = led_trigger_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n",
+		       jiffies_to_msecs(READ_ONCE(btl->check_jiffies)));
+}
+
+/**
+ * check_interval_store() - &check_interval device attribute store function
+ * @dev:	The LED device
+ * @attr:	The &check_interval attribute (&dev_attr_check_interval)
+ * @buf:	The new value (as written to the &sysfs attribute)
+ * @count:	The number of characters in &buf
+ *
+ * Sets &blkdev_trig_led.check_jiffies to the value in &buf (after converting
+ * from milliseconds).
+ *
+ * Context:	Process context.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t check_interval_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct blkdev_trig_led *led = led_trigger_get_drvdata(dev);
+	unsigned int value;
+	int err;
+
+	err = kstrtouint(buf, 0, &value);
+	if (err)
+		return err;
+
+	if (value < BLKDEV_TRIG_CHECK_MIN || value > BLKDEV_TRIG_CHECK_MAX)
+		return -ERANGE;
+
+	WRITE_ONCE(led->check_jiffies, msecs_to_jiffies(value));
+
+	return count;
+}
+
+/**
+ * blkdev_trig_mode_show() - Helper for boolean attribute show functions.
+ * @led:	The LED
+ * @buf:	Output buffer
+ * @bit:	Which bit to show
+ *
+ * Context:	Process context.
+ * Return:	The number of characters written to &buf.
+ */
+static int blkdev_trig_mode_show(const struct blkdev_trig_led *led, char *buf,
+				 enum stat_group bit)
+{
+	return sprintf(buf, READ_ONCE(led->mode) & (1 << bit) ? "Y\n" : "N\n");
+}
+
+/**
+ * blkdev_trig_mode_store() - Helper for boolean attribute store functions.
+ * @led:	The LED
+ * @buf:	The new value (as written to the &sysfs attribute)
+ * @count:	The number of characters in &buf
+ * @bit:	Which bit to set
+ *
+ * Context:	Process context.
+ * Return:	&count on success, negative &errno on error.
+ */
+static int blkdev_trig_mode_store(struct blkdev_trig_led *led,
+				  const char *buf, size_t count,
+				  enum stat_group bit)
+{
+	bool set;
+	int err;
+
+	err = kstrtobool(buf, &set);
+	if (err)
+		return err;
+
+	if (set)
+		set_bit(bit, &led->mode);
+	else
+		clear_bit(bit, &led->mode);
+
+	return count;
+}
+
+/**
+ * blink_on_read_show() - &blink_on_read device attribute show function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_read attribute (&dev_attr_blink_on_read)
+ * @buf:	Output buffer
+ *
+ * Writes ``Y`` or ``N`` to &buf, depending on whether the &STAT_READ bit in
+ * &blkdev_trig_led.mode is set or cleared.
+ *
+ * Context:	Process context.
+ * Return:	The number of characters written to &buf.
+ */
+static ssize_t blink_on_read_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return blkdev_trig_mode_show(led_trigger_get_drvdata(dev),
+				     buf, STAT_READ);
+}
+
+/**
+ * blink_on_read_store() - &blink_on_read device attribute store function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_read attribute (&dev_attr_blink_on_read)
+ * @buf:	The new value (as written to the &sysfs attribute)
+ * @count:	The number of characters in &buf
+ *
+ * Sets the &STAT_READ bit in &blkdev_trig_led.mode to the value in &buf
+ * (interpretted as a boolean).
+ *
+ * Context:	Process context.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t blink_on_read_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	return blkdev_trig_mode_store(led_trigger_get_drvdata(dev),
+				      buf, count, STAT_READ);
+}
+
+/**
+ * blink_on_write_show() - &blink_on_write device attribute show function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_write attribute (&dev_attr_blink_on_write)
+ * @buf:	Output buffer
+ *
+ * Writes ``Y`` or ``N`` to &buf, depending on whether the &STAT_WRITE bit in
+ * in &blkdev_trig_led.mode is set or cleared.
+ *
+ * Context:	Process context.
+ * Return:	The number of characters written to &buf.
+ */
+static ssize_t blink_on_write_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return blkdev_trig_mode_show(led_trigger_get_drvdata(dev),
+				     buf, STAT_WRITE);
+}
+
+/**
+ * blink_on_write_store() - &blink_on_write device attribute store function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_write attribute (&dev_attr_blink_on_write)
+ * @buf:	The new value (as written to the &sysfs attribute)
+ * @count:	The number of characters in &buf
+ *
+ * Sets the &STAT_WRITE bit in &blkdev_trig_led.mode to the value in &buf
+ * (interpretted as a boolean).
+ *
+ * Context:	Process context.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t blink_on_write_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	return blkdev_trig_mode_store(led_trigger_get_drvdata(dev),
+				      buf, count, STAT_WRITE);
+}
+
+/**
+ * blink_on_flush_show() - &blink_on_flush device attribute show function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_flush attribute (&dev_attr_blink_on_flush)
+ * @buf:	Output buffer
+ *
+ * Writes ``Y`` or ``N`` to &buf, depending whether the &STAT_FLUSH bit in
+ * &blkdev_trig_led.mode is set or cleared.
+ *
+ * Context:	Process context.
+ * Return:	The number of characters written to &buf.
+ */
+static ssize_t blink_on_flush_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return blkdev_trig_mode_show(led_trigger_get_drvdata(dev),
+				     buf, STAT_FLUSH);
+}
+
+/**
+ * blink_on_flush_store() - &blink_on_flush device attribute store function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_flush attribute (&dev_attr_blink_on_flush)
+ * @buf:	The new value (as written to the &sysfs attribute)
+ * @count:	The number of characters in &buf
+ *
+ * Sets the &STAT_FLUSH bit in &blkdev_trig_led.mode to the value in &buf
+ * (interpretted as a boolean).
+ *
+ * Context:	Process context.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t blink_on_flush_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	return blkdev_trig_mode_store(led_trigger_get_drvdata(dev),
+				      buf, count, STAT_FLUSH);
+}
+
+/**
+ * blink_on_discard_show() - &blink_on_discard device attribute show function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_discard attribute (&dev_attr_blink_on_discard)
+ * @buf:	Output buffer
+ *
+ * Writes ``Y`` or ``N`` to &buf, depending on whether the &STAT_DISCARD bit in
+ * &blkdev_trig_led.mode is set or cleared.
+ *
+ * Context:	Process context.
+ * Return:	The number of characters written to &buf.
+ */
+static ssize_t blink_on_discard_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return blkdev_trig_mode_show(led_trigger_get_drvdata(dev),
+				     buf, STAT_DISCARD);
+}
+
+/**
+ * blink_on_discard_store() - &blink_on_discard device attribute store function.
+ * @dev:	The LED device
+ * @attr:	The &blink_on_discard attribute (&dev_attr_blink_on_discard)
+ * @buf:	The new value (as written to the &sysfs attribute)
+ * @count:	The number of characters in &buf
+ *
+ * Sets the &STAT_DISCARD bit in &blkdev_trig_led.mode to the value in &buf
+ * (interpretted as a boolean).
+ *
+ * Context:	Process context.
+ * Return:	&count on success, negative &errno on error.
+ */
+static ssize_t blink_on_discard_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	return blkdev_trig_mode_store(led_trigger_get_drvdata(dev),
+				      buf, count, STAT_DISCARD);
+}
+
+/* Device attributes */
+static DEVICE_ATTR_WO(link_dev_by_path);
+static DEVICE_ATTR_WO(unlink_dev_by_path);
+static DEVICE_ATTR_WO(unlink_dev_by_name);
+static DEVICE_ATTR_RW(blink_time);
+static DEVICE_ATTR_RW(check_interval);
+static DEVICE_ATTR_RW(blink_on_read);
+static DEVICE_ATTR_RW(blink_on_write);
+static DEVICE_ATTR_RW(blink_on_flush);
+static DEVICE_ATTR_RW(blink_on_discard);
+
+/* Device attributes in LED directory (/sys/class/leds/<led>/...) */
+static struct attribute *blkdev_trig_attrs[] = {
+	&dev_attr_link_dev_by_path.attr,
+	&dev_attr_unlink_dev_by_path.attr,
+	&dev_attr_unlink_dev_by_name.attr,
+	&dev_attr_blink_time.attr,
+	&dev_attr_check_interval.attr,
+	&dev_attr_blink_on_read.attr,
+	&dev_attr_blink_on_write.attr,
+	&dev_attr_blink_on_flush.attr,
+	&dev_attr_blink_on_discard.attr,
+	NULL
+};
+
+/* Unnamed attribute group == no subdirectory */
+static const struct attribute_group blkdev_trig_attr_group = {
+	.attrs	= blkdev_trig_attrs,
+};
+
+/* Attribute groups for the trigger */
+static const struct attribute_group *blkdev_trig_attr_groups[] = {
+	&blkdev_trig_attr_group,   /* /sys/class/leds/<led>/... */
+	&blkdev_trig_linked_devs,  /* /sys/class/leds/<led>/linked_devices/ */
+	NULL
+};
+
+/* Trigger registration data */
+static struct led_trigger blkdev_trig_trigger = {
+	.name		= "blkdev",
+	.activate	= blkdev_trig_activate,
+	.deactivate	= blkdev_trig_deactivate,
+	.groups		= blkdev_trig_attr_groups,
+};
+
+/**
+ * blkdev_trig_init() - Block device LED trigger initialization.
+ *
+ * Registers the ``blkdev`` LED trigger.
+ *
+ * Return:	&0 on success, negative &errno on failure.
+ */
+static int __init blkdev_trig_init(void)
+{
+	return led_trigger_register(&blkdev_trig_trigger);
+}
+module_init(blkdev_trig_init);
+
+/**
+ * blkdev_trig_exit() - Block device LED trigger module exit.
+ *
+ * Unregisters the ``blkdev`` LED trigger.
+ */
+static void __exit blkdev_trig_exit(void)
+{
+	led_trigger_unregister(&blkdev_trig_trigger);
+}
+module_exit(blkdev_trig_exit);
+
+MODULE_DESCRIPTION("Block device LED trigger");
+MODULE_AUTHOR("Ian Pilcher <arequipeno@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.37.3

