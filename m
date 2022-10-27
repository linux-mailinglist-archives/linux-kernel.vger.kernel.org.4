Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770460FB57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiJ0PJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiJ0PJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F8F18F0C2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAC3062377
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECF2C433B5;
        Thu, 27 Oct 2022 15:09:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4VZ-00BvRW-0j;
        Thu, 27 Oct 2022 11:09:25 -0400
Message-ID: <20221027150525.753064657@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before freeing timers
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Back in April, I posted an RFC patch set to help mitigate a common issue
where a timer gets armed just before it is freed, and when the timer
goes off, it crashes in the timer code without any evidence of who the
culprit was. I got side tracked and never finished up on that patch set.
Since this type of crash is still our #1 crash we are seeing in the field,
it has become a priority again to finish it.

This is v2 of that patch set. Thomas Gleixner posted an untested version
that makes timer->function NULL as the flag that it is shutdown. I took that
code, tested it (fixed it up), added more comments, and changed the
name to del_timer_shutdown() as Linus had asked. I also converted it to use
WARN_ON_ONCE() instead of just WARN_ON() as Linus asked for that too.

(Thomas, you never added a SoB, so I only added a link to your email
 in that commit. But as this will likely go through your tree anyway,
 I'm sure you'll have your SoB on all these).

I then created a trivial coccinelle script to find where del_timer*()
is called before being freed, and converted them all to del_timer_shutdown()
(There was a couple that still used del_timer() instead of del_timer_sync()).

I also updated DEBUG_OBJECTS_TIMERS to check from where the timer is ever
armed, to calling of del_timer_shutdown(), and it will trigger if a timer
is freed in between. The current way is to only check if the timer is armed,
but that means it only triggers if the race condition is hit, and with
experience, it's not run on enough machines to catch all of them. By triggering
it from the time the timer is armed to the time it is shutdown, it catches
all potential cases even if the race condition is not hit.

I went though the result of the cocinelle script, and updated the locations.
Some locations were caught by DEBUG_OBJECTS_TIMERS as the coccinelle script
only checked for timers being freed in the same function as the del_timer*().

V1 is found here: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Here's the original text of that version:

   [
     This is an RFC patch. As we hit a few bugs were del_timer() is called
     instead of del_timer_sync() before the timer is freed, and there could
     be bugs where even del_timer_sync() is used, but the timer gets rearmed,
     I decided to introduce a "del_timer_free()" function that can be used
     instead. This will at least educate developers on what to call before they
     free a structure that holds a timer.

     In this RFC, I modified hci_qca.c as a use case, even though that change
     needs some work, because the workqueue could still rearm it (I'm looking
     to see if I can trigger the warning).

     If this approach is acceptable, then I will remove the hci_qca.c portion
     from this patch, and create a series of patches to use the
     del_timer_free() in all the locations in the kernel that remove the timer
     before freeing.
   ]

   We are hitting a common bug were a timer is being triggered after it is
   freed. This causes a corruption in the timer link list and crashes the
   kernel. Unfortunately it is not easy to know what timer it was that was
   freed. Looking at the code, it appears that there are several cases that
   del_timer() is used when del_timer_sync() should have been.

   Add a del_timer_free() that not only does a del_timer_sync() but will mark
   the timer as freed in case it gets rearmed, it will trigger a WARN_ON. The
   del_timer_free() is more likely to be used by developers that are about to
   free a timer, then using del_timer_sync() as the latter is not as obvious
   to being needed for freeing. Having the word "free" in the name of the
   function will hopefully help developers know that that function needs to
   be called before freeing.

   The added bonus is the marking of the timer as being freed such that it
   will trigger a warning if it gets rearmed. At least that way if the system
   crashes on a freed timer, at least we may see which timer it was that was
   freed.

You can pull this series down from here:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
timers


Head SHA1: 581931395e77326bb76d7648be080ce302244dd5


Steven Rostedt (Google) (31):
      timers: Add del_timer_shutdown() to be called before freeing timers
      timers: s390/cmm: Use del_timer_shutdown() before freeing timer
      timers: sh: Use del_timer_shutdown() before freeing timer
      timers: block: Use del_timer_shutdown() before freeing timer
      timers: ACPI: Use del_timer_shutdown() before freeing timer
      timers: atm: Use del_timer_shutdown() before freeing timer
      timers: PM: Use del_timer_shutdown()
      timers: Bluetooth: Use del_timer_shutdown() before freeing timer
      timers: hangcheck: Use del_timer_shutdown() before freeing timer
      timers: ipmi: Use del_timer_shutdown() before freeing timer
      timers: random: Use del_timer_shutdown() before freeing timer
      timers: dma-buf: Use del_timer_shutdown() before freeing timer
      timers: drm: Use del_timer_shutdown() before freeing timer
      timers: HID: Use del_timer_shutdown() before freeing timer
      timers: Input: Use del_timer_shutdown() before freeing timer
      timers: mISDN: Use del_timer_shutdown() before freeing timer
      timers: leds: Use del_timer_shutdown() before freeing timer
      timers: media: Use del_timer_shutdown() before freeing timer
      timers: net: Use del_timer_shutdown() before freeing timer
      timers: usb: Use del_timer_shutdown() before freeing timer
      timers: cgroup: Use del_timer_shutdown() before freeing timer
      timers: workqueue: Use del_timer_shutdown() before freeing timer
      timers: nfc: pn533: Use del_timer_shutdown() before freeing timer
      timers: pcmcia: Use del_timer_shutdown() before freeing timer
      timers: scsi: Use del_timer_shutdown() before freeing timer
      timers: tty: Use del_timer_shutdown() before freeing timer
      timers: ext4: Use del_timer_shutdown() before freeing timer
      timers: fs/nilfs2: Use del_timer_shutdown() before freeing timer
      timers: ALSA: Use del_timer_shutdown() before freeing timer
      timers: x86/mce: Use __init_timer() for resetting timers
      timers: Expand DEBUG_OBJECTS_TIMER to check if it ever was used

----
 .../RCU/Design/Requirements/Requirements.rst       |  2 +-
 Documentation/core-api/local_ops.rst               |  2 +-
 Documentation/kernel-hacking/locking.rst           |  4 ++
 arch/s390/mm/cmm.c                                 |  4 +-
 arch/sh/drivers/push-switch.c                      |  2 +-
 arch/x86/kernel/cpu/mce/core.c                     | 14 +++++-
 block/blk-iocost.c                                 |  2 +-
 block/blk-iolatency.c                              |  2 +-
 block/blk-stat.c                                   |  2 +-
 block/blk-throttle.c                               |  2 +-
 block/kyber-iosched.c                              |  2 +-
 drivers/acpi/apei/ghes.c                           |  2 +-
 drivers/atm/idt77105.c                             |  4 +-
 drivers/atm/idt77252.c                             |  4 +-
 drivers/atm/iphase.c                               |  2 +-
 drivers/base/power/wakeup.c                        |  7 +--
 drivers/block/drbd/drbd_main.c                     |  2 +-
 drivers/block/loop.c                               |  2 +-
 drivers/block/sunvdc.c                             |  2 +-
 drivers/bluetooth/hci_bcsp.c                       |  2 +-
 drivers/bluetooth/hci_h5.c                         |  2 +-
 drivers/bluetooth/hci_qca.c                        |  4 +-
 drivers/char/hangcheck-timer.c                     |  2 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  2 +-
 drivers/char/ipmi/ipmi_ssif.c                      |  4 +-
 drivers/char/random.c                              |  2 +-
 drivers/dma-buf/st-dma-fence.c                     |  2 +-
 drivers/gpu/drm/gud/gud_pipe.c                     |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |  2 +-
 drivers/hid/hid-wiimote-core.c                     |  2 +-
 drivers/input/keyboard/locomokbd.c                 |  2 +-
 drivers/input/keyboard/omap-keypad.c               |  2 +-
 drivers/input/mouse/alps.c                         |  2 +-
 drivers/input/serio/hil_mlc.c                      |  2 +-
 drivers/input/serio/hp_sdc.c                       |  2 +-
 drivers/isdn/hardware/mISDN/hfcmulti.c             |  2 +-
 drivers/isdn/mISDN/l1oip_core.c                    |  4 +-
 drivers/isdn/mISDN/timerdev.c                      |  4 +-
 drivers/leds/trigger/ledtrig-activity.c            |  2 +-
 drivers/leds/trigger/ledtrig-heartbeat.c           |  2 +-
 drivers/leds/trigger/ledtrig-pattern.c             |  2 +-
 drivers/leds/trigger/ledtrig-transient.c           |  2 +-
 drivers/media/pci/ivtv/ivtv-driver.c               |  2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            | 18 +++----
 drivers/media/usb/s2255/s2255drv.c                 |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  6 +--
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 drivers/net/ethernet/sun/sunvnet.c                 |  2 +-
 drivers/net/usb/sierra_net.c                       |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |  2 +-
 drivers/net/wireless/intersil/hostap/hostap_ap.c   |  2 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |  2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |  8 +--
 drivers/nfc/pn533/pn533.c                          |  2 +-
 drivers/nfc/pn533/uart.c                           |  2 +-
 drivers/pcmcia/bcm63xx_pcmcia.c                    |  2 +-
 drivers/pcmcia/electra_cf.c                        |  2 +-
 drivers/pcmcia/omap_cf.c                           |  2 +-
 drivers/pcmcia/pd6729.c                            |  4 +-
 drivers/pcmcia/yenta_socket.c                      |  4 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |  4 +-
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c |  2 +-
 drivers/tty/n_gsm.c                                |  2 +-
 drivers/tty/sysrq.c                                |  2 +-
 drivers/usb/core/hub.c                             |  3 ++
 drivers/usb/gadget/udc/m66592-udc.c                |  2 +-
 drivers/usb/serial/garmin_gps.c                    |  2 +-
 drivers/usb/serial/mos7840.c                       |  2 +-
 fs/ext4/super.c                                    |  2 +-
 fs/nilfs2/segment.c                                |  2 +-
 include/linux/timer.h                              | 47 +++++++++++++++---
 kernel/cgroup/cgroup.c                             |  2 +-
 kernel/time/timer.c                                | 57 ++++++++++++++--------
 kernel/workqueue.c                                 |  4 +-
 net/802/garp.c                                     |  2 +-
 net/802/mrp.c                                      |  2 +-
 net/bridge/br_multicast.c                          |  6 +--
 net/bridge/br_multicast_eht.c                      |  4 +-
 net/core/gen_estimator.c                           |  2 +-
 net/core/sock.c                                    |  2 +-
 net/ipv4/inet_timewait_sock.c                      |  2 +-
 net/ipv4/ipmr.c                                    |  2 +-
 net/ipv6/ip6mr.c                                   |  2 +-
 net/mac80211/mesh_pathtbl.c                        |  2 +-
 net/netfilter/ipset/ip_set_list_set.c              |  2 +-
 net/netfilter/ipvs/ip_vs_lblc.c                    |  2 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                   |  2 +-
 net/netfilter/xt_LED.c                             |  2 +-
 net/rxrpc/conn_object.c                            |  2 +-
 net/sched/cls_flow.c                               |  2 +-
 net/sunrpc/svc.c                                   |  2 +-
 net/tipc/discover.c                                |  2 +-
 net/tipc/monitor.c                                 |  2 +-
 sound/i2c/other/ak4117.c                           |  2 +-
 sound/synth/emux/emux.c                            |  2 +-
 95 files changed, 213 insertions(+), 153 deletions(-)
