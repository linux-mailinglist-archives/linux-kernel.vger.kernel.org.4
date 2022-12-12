Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37B4649BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiLLKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiLLKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B5A1BB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:05 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Wzv2iq00hDsFMWM9rrzX19ySSCYgDjfa9n0B9Y19Fv0=;
        b=BZcwOjiw3X7jzccylIZjKF1qw3eRsOzSZ9ekSBMYgCvOQ8UwKTdLqz0qPGkdy8sIWSWNa+
        AdBPXcT9UDkSiylSMDI5xixLIVa9PPvpB+rlDXwXbRUq90NYFlAykt77jU5Hpa0wbBhkzc
        i1p4Umx7T4zRkQi8ifBFBIhSou9emH9/+f4BXhaOYZK/nbrL8ayqTdi1YSC32tSIVnxbwQ
        f430Iqt6D8co7eyLBG4YK5tC89XL7Vgc19Z68ghojHslLqX5YDvjv0n4NaG+D8HFL3Iv7S
        Z2EScC+l1BA//6AoAEwJks7zIH2gUkaFRVt4hp6p8T1ks9+OdB1ESpKogxWWcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Wzv2iq00hDsFMWM9rrzX19ySSCYgDjfa9n0B9Y19Fv0=;
        b=UVHASI/flge7NM9XVdBjkvjm3Iy8LOic/W493VOOhwISb5Qqri6+wkWbLiMLjNPxTrvWa2
        1KKLQWHZH410oMBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.2-rc1
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Message-ID: <167083908288.564878.16194193666147663160.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:09:04 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022=
-12-10

up to:  18a207849218: Merge tag 'timers-v6.2-rc1' of https://git.linaro.org/p=
eople/daniel.lezcano/linux into timers/core

Updates for timers, timekeeping and drivers:

 - Core:

   - The timer_shutdown[_sync]() infrastructure:

     Tearing down timers can be tedious when there are circular
     dependencies to other things which need to be torn down. A prime
     example is timer and workqueue where the timer schedules work and the
     work arms the timer.

     What needs to prevented is that pending work which is drained via
     destroy_workqueue() does not rearm the previously shutdown
     timer. Nothing in that shutdown sequence relies on the timer being
     functional.

     The conclusion was that the semantics of timer_shutdown_sync() should
     be:

	- timer is not enqueued
    	- timer callback is not running
    	- timer cannot be rearmed

     Preventing the rearming of shutdown timers is done by discarding rearm
     attempts silently. A warning for the case that a rearm attempt of a
     shutdown timer is detected would not be really helpful because it's
     entirely unclear how it should be acted upon. The only way to address
     such a case is to add 'if (in_shutdown)' conditionals all over the
     place. This is error prone and in most cases of teardown not required
     all.

   - The real fix for the bluetooth HCI teardown based on
     timer_shutdown_sync().

     A larger scale conversion to timer_shutdown_sync() is work in
     progress.

   - Consolidation of VDSO time namespace helper functions

   - Small fixes for timer and timerqueue

 - Drivers:

   - Prevent integer overflow on the XGene-1 TVAL register which causes
     an never ending interrupt storm.

   - The usual set of new device tree bindings

   - Small fixes and improvements all over the place

Thanks,

	tglx

------------------>
Barnab=C3=A1s P=C5=91cze (1):
      timerqueue: Use rb_entry_safe() in timerqueue_getnext()

Christophe JAILLET (1):
      clocksource/drivers/arm_arch_timer: Use kstrtobool() instead of strtobo=
ol()

Jann Horn (1):
      vdso/timens: Refactor copy-pasted find_timens_vvar_page() helper into o=
ne copy

Joe Korty (1):
      clocksource/drivers/arm_arch_timer: Fix XGene-1 TVAL register math error

Johan Jonker (1):
      dt-bindings: timer: rockchip: Add rockchip,rk3128-timer

Jonathan Neusch=C3=A4fer (2):
      dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
      clocksource/drivers/timer-npcm7xx: Enable timer 1 clock before use

Lukas Bulwahn (2):
      clocksource/drivers/ingenic-ost: Define pm functions properly in platfo=
rm_driver struct
      clockevents: Repair kernel-doc for clockevent_delta2ns()

Steven Rostedt (Google) (4):
      ARM: spear: Do not use timer namespace for timer_shutdown() function
      clocksource/drivers/arm_arch_timer: Do not use timer namespace for time=
r_shutdown() function
      clocksource/drivers/sp804: Do not use timer namespace for timer_shutdow=
n() function
      timers: Update the documentation to reflect on the new timer_shutdown()=
 API

Thomas Gleixner (13):
      Documentation: Remove bogus claim about del_timer_sync()
      timers: Get rid of del_singleshot_timer_sync()
      timers: Replace BUG_ON()s
      timers: Update kernel-doc for various functions
      timers: Use del_timer_sync() even on UP
      timers: Rename del_timer_sync() to timer_delete_sync()
      timers: Rename del_timer() to timer_delete()
      Documentation: Replace del_timer/del_timer_sync()
      timers: Silently ignore timers with a NULL function
      timers: Split [try_to_]del_timer[_sync]() to prepare for shutdown mode
      timers: Add shutdown mechanism to the internal functions
      timers: Provide timer_shutdown[_sync]()
      Bluetooth: hci_qca: Fix the teardown problem for real

Tony Lindgren (3):
      clocksource/drivers/timer-ti-dm: Fix warning for omap_timer_match
      clocksource/drivers/timer-ti-dm: Make timer_get_irq static
      clocksource/drivers/timer-ti-dm: Clear settings on probe and free

Wolfram Sang (3):
      clocksource/drivers/sh_cmt: Access registers according to spec
      dt-bindings: timer: renesas,tmu: Add r8a779g0 support
      dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support

Yang Yingliang (1):
      clocksource/drivers/timer-ti-dm: Fix missing clk_disable_unprepare in d=
mtimer_systimer_init_clock()

ye xingchen (1):
      timers: Replace in_irq() with in_hardirq()


 .../RCU/Design/Requirements/Requirements.rst       |   2 +-
 Documentation/core-api/local_ops.rst               |   2 +-
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml      |   8 +-
 .../devicetree/bindings/timer/renesas,cmt.yaml     |   2 +
 .../devicetree/bindings/timer/renesas,tmu.yaml     |   1 +
 .../bindings/timer/rockchip,rk-timer.yaml          |   1 +
 Documentation/kernel-hacking/locking.rst           |  17 +-
 Documentation/timers/hrtimers.rst                  |   2 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |  14 +-
 .../translations/zh_CN/core-api/local_ops.rst      |   2 +-
 arch/arm/mach-spear/time.c                         |   8 +-
 arch/arm64/kernel/vdso.c                           |  22 --
 arch/powerpc/kernel/vdso.c                         |  22 --
 arch/riscv/kernel/vdso.c                           |  22 --
 arch/s390/kernel/vdso.c                            |  20 -
 arch/x86/entry/vdso/vma.c                          |  23 --
 drivers/bluetooth/hci_qca.c                        |  10 +-
 drivers/char/tpm/tpm-dev-common.c                  |   4 +-
 drivers/clocksource/arm_arch_timer.c               |  22 +-
 drivers/clocksource/ingenic-ost.c                  |  10 +-
 drivers/clocksource/sh_cmt.c                       |  88 +++--
 drivers/clocksource/timer-npcm7xx.c                |  10 +
 drivers/clocksource/timer-sp804.c                  |   6 +-
 drivers/clocksource/timer-ti-dm-systimer.c         |   4 +-
 drivers/clocksource/timer-ti-dm.c                  |  21 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |   4 +-
 drivers/staging/wlan-ng/prism2usb.c                |   6 +-
 include/clocksource/timer-ti-dm.h                  |   2 -
 include/linux/time_namespace.h                     |   6 +
 include/linux/timer.h                              |  35 +-
 include/linux/timerqueue.h                         |   2 +-
 kernel/time/clockevents.c                          |   2 +-
 kernel/time/namespace.c                            |  18 +
 kernel/time/timer.c                                | 427 ++++++++++++++++---=
--
 net/sunrpc/xprt.c                                  |   2 +-
 35 files changed, 541 insertions(+), 306 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documen=
tation/RCU/Design/Requirements/Requirements.rst
index a0f8164c8513..49387d823619 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any a=
ttempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via del_timer_sync() or similar.
+with via timer_shutdown_sync() or similar.
=20
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/lo=
cal_ops.rst
index 2ac3f9f29845..0b42ceaaf3c4 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu =
counter using
=20
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
=20
     module_init(test_init);
diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.ya=
ml b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
index 737af78ad70c..d53e1bb98b8a 100644
--- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
@@ -25,7 +25,13 @@ properties:
       - description: The timer interrupt of timer 0
=20
   clocks:
-    maxItems: 1
+    items:
+      - description: The reference clock for timer 0
+      - description: The reference clock for timer 1
+      - description: The reference clock for timer 2
+      - description: The reference clock for timer 3
+      - description: The reference clock for timer 4
+    minItems: 1
=20
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,cmt.yaml
index bde6c9b66bf4..a0be1755ea28 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -102,12 +102,14 @@ properties:
           - enum:
               - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
               - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+              - renesas,r8a779g0-cmt0     # 32-bit CMT0 on R-Car V4H
           - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
=20
       - items:
           - enum:
               - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
               - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
+              - renesas,r8a779g0-cmt1     # 48-bit CMT on R-Car V4H
           - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
=20
   reg:
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index 60f4c059bcff..a67e427a9e7e 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -38,6 +38,7 @@ properties:
           - renesas,tmu-r8a77995 # R-Car D3
           - renesas,tmu-r8a779a0 # R-Car V3U
           - renesas,tmu-r8a779f0 # R-Car S4-8
+          - renesas,tmu-r8a779g0 # R-Car V4H
       - const: renesas,tmu
=20
   reg:
diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b=
/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index dc3bc1e62fe9..b61ed1a431bb 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -18,6 +18,7 @@ properties:
           - enum:
               - rockchip,rv1108-timer
               - rockchip,rk3036-timer
+              - rockchip,rk3128-timer
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-=
hacking/locking.rst
index 6805ae6e86e6..c756786e17ae 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -967,7 +967,7 @@ you might do the following::
=20
             while (list) {
                     struct foo *next =3D list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list =3D next;
             }
@@ -981,7 +981,7 @@ the lock after we spin_unlock_bh(), and then try to free
 the element (which has already been freed!).
=20
 This can be avoided by checking the result of
-del_timer(): if it returns 1, the timer has been deleted.
+timer_delete(): if it returns 1, the timer has been deleted.
 If 0, it means (in this case) that it is currently running, so we can
 do::
=20
@@ -990,7 +990,7 @@ do::
=20
                     while (list) {
                             struct foo *next =3D list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1005,9 +1005,12 @@ do::
 Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
-use del_timer_sync() (``include/linux/timer.h``) to
-handle this case. It returns the number of times the timer had to be
-deleted before we finally stopped it from adding itself back in.
+use timer_delete_sync() (``include/linux/timer.h``) to handle this case.
+
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed. Any subsequent attempt to
+rearm the timer will be silently ignored by the core code.
+
=20
 Locking Speed
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -1335,7 +1338,7 @@ lock.
=20
 -  kfree()
=20
--  add_timer() and del_timer()
+-  add_timer() and timer_delete()
=20
 Mutex API reference
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimer=
s.rst
index c1c20a693e8f..7ac448908d1f 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -118,7 +118,7 @@ existing timer wheel code, as it is mature and well suite=
d. Sharing code
 was not really a win, due to the different data structures. Also, the
 hrtimer functions now have clearer behavior and clearer names - such as
 hrtimer_try_to_cancel() and hrtimer_cancel() [which are roughly
-equivalent to del_timer() and del_timer_sync()] - so there's no direct
+equivalent to timer_delete() and timer_delete_sync()] - so there's no direct
 1:1 mapping between them on the algorithmic level, and thus no real
 potential for code sharing either.
=20
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Do=
cumentation/translations/it_IT/kernel-hacking/locking.rst
index 51af37f2d621..b8ecf41273c5 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -990,7 +990,7 @@ potreste fare come segue::
=20
             while (list) {
                     struct foo *next =3D list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list =3D next;
             }
@@ -1003,7 +1003,7 @@ e prender=C3=A0 il *lock* solo dopo spin_unlock_bh(), e=
 cercher=C3=A0
 di eliminare il suo oggetto (che per=C3=B2 =C3=A8 gi=C3=A0 stato eliminato).
=20
 Questo pu=C3=B2 essere evitato controllando il valore di ritorno di
-del_timer(): se ritorna 1, il temporizzatore =C3=A8 stato gi=C3=A0
+timer_delete(): se ritorna 1, il temporizzatore =C3=A8 stato gi=C3=A0
 rimosso. Se 0, significa (in questo caso) che il temporizzatore =C3=A8 in
 esecuzione, quindi possiamo fare come segue::
=20
@@ -1012,7 +1012,7 @@ esecuzione, quindi possiamo fare come segue::
=20
                     while (list) {
                             struct foo *next =3D list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1026,10 +1026,8 @@ esecuzione, quindi possiamo fare come segue::
 Un altro problema =C3=A8 l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo =C3=A8 un problema abbastanza comune con una propensione
-alle corse critiche, dovreste usare del_timer_sync()
-(``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
-numero di volte che il temporizzatore =C3=A8 stato interrotto prima che
-fosse in grado di fermarlo senza che si riavviasse.
+alle corse critiche, dovreste usare timer_delete_sync()
+(``include/linux/timer.h``) per gestire questo caso.
=20
 Velocit=C3=A0 della sincronizzazione
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
@@ -1374,7 +1372,7 @@ contesto, o trattenendo un qualsiasi *lock*.
=20
 -  kfree()
=20
--  add_timer() e del_timer()
+-  add_timer() e timer_delete()
=20
 Riferimento per l'API dei Mutex
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/core-api/local_ops.rst b/Docume=
ntation/translations/zh_CN/core-api/local_ops.rst
index 41e4525038e8..eb5423f60f17 100644
--- a/Documentation/translations/zh_CN/core-api/local_ops.rst
+++ b/Documentation/translations/zh_CN/core-api/local_ops.rst
@@ -185,7 +185,7 @@ UP=E4=B9=8B=E9=97=B4=E6=B2=A1=E6=9C=89=E4=B8=8D=E5=90=8C=
=E7=9A=84=E8=A1=8C=E4=B8=BA=EF=BC=8C=E5=9C=A8=E4=BD=A0=E7=9A=84=E6=9E=B6=E6=
=9E=84=E7=9A=84 ``local.h`` =E4=B8=AD=E5=8C=85=E6=8B=AC ``asm-g
=20
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
=20
     module_init(test_init);
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index e979e2197f8e..5371c824786d 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -90,7 +90,7 @@ static void __init spear_clocksource_init(void)
 		200, 16, clocksource_mmio_readw_up);
 }
=20
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void spear_timer_shutdown(struct clock_event_device *evt)
 {
 	u16 val =3D readw(gpt_base + CR(CLKEVT));
=20
@@ -101,7 +101,7 @@ static inline void timer_shutdown(struct clock_event_devi=
ce *evt)
=20
 static int spear_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
=20
 	return 0;
 }
@@ -111,7 +111,7 @@ static int spear_set_oneshot(struct clock_event_device *e=
vt)
 	u16 val;
=20
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
=20
 	val =3D readw(gpt_base + CR(CLKEVT));
 	val |=3D CTRL_ONE_SHOT;
@@ -126,7 +126,7 @@ static int spear_set_periodic(struct clock_event_device *=
evt)
 	u16 val;
=20
 	/* stop the timer */
-	timer_shutdown(evt);
+	spear_timer_shutdown(evt);
=20
 	period =3D clk_get_rate(gpt_clk) / HZ;
 	period >>=3D CTRL_PRESCALER16;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 99ae81ab91a7..e59a32aa0c49 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -151,28 +151,6 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
 	mmap_read_unlock(mm);
 	return 0;
 }
-
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm =3D=3D current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops.
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-#else
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
=20
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4abc01949702..507f8228f983 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -129,28 +129,6 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
=20
 	return 0;
 }
-
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm =3D=3D current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops.
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-#else
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
=20
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 123d05255fcf..e410275918ac 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -137,28 +137,6 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
 	mmap_read_unlock(mm);
 	return 0;
 }
-
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm =3D=3D current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops.
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-#else
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
=20
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 3105ca5bd470..d6df7169c01f 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -44,21 +44,6 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 	return (struct vdso_data *)(vvar_page);
 }
=20
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm =3D=3D current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops().
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-	WARN(1, "vvar_page accessed remotely");
-	return NULL;
-}
-
 /*
  * The VVAR page layout depends on whether a task belongs to the root or
  * non-root time namespace. Whenever a task changes its namespace, the VVAR
@@ -84,11 +69,6 @@ int vdso_join_timens(struct task_struct *task, struct time=
_namespace *ns)
 	mmap_read_unlock(mm);
 	return 0;
 }
-#else
-static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
=20
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 311eae30e089..6b36485054e8 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -98,24 +98,6 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 }
=20
 #ifdef CONFIG_TIME_NS
-static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	if (likely(vma->vm_mm =3D=3D current->mm))
-		return current->nsproxy->time_ns->vvar_page;
-
-	/*
-	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
-	 * through interfaces like /proc/$pid/mem or
-	 * process_vm_{readv,writev}() as long as there's no .access()
-	 * in special_mapping_vmops().
-	 * For more details check_vma_flags() and __access_remote_vm()
-	 */
-
-	WARN(1, "vvar_page accessed remotely");
-
-	return NULL;
-}
-
 /*
  * The vvar page layout depends on whether a task belongs to the root or
  * non-root time namespace. Whenever a task changes its namespace, the VVAR
@@ -140,11 +122,6 @@ int vdso_join_timens(struct task_struct *task, struct ti=
me_namespace *ns)
=20
 	return 0;
 }
-#else
-static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
-{
-	return NULL;
-}
 #endif
=20
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8df11016fd51..ba8be8e1bebd 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -696,9 +696,15 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
+	/*
+	 * Shut the timers down so they can't be rearmed when
+	 * destroy_workqueue() drains pending work which in turn might try
+	 * to arm a timer.  After shutdown rearm attempts are silently
+	 * ignored by the timer core code.
+	 */
+	timer_shutdown_sync(&qca->tx_idle_timer);
+	timer_shutdown_sync(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
-	del_timer_sync(&qca->tx_idle_timer);
-	del_timer_sync(&qca->wake_retrans_timer);
 	qca->hu =3D NULL;
=20
 	kfree_skb(qca->rx_skb);
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-com=
mon.c
index dc4c0a0a5129..30b4c288c1bb 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -155,7 +155,7 @@ ssize_t tpm_common_read(struct file *file, char __user *b=
uf,
 out:
 	if (!priv->response_length) {
 		*off =3D 0;
-		del_singleshot_timer_sync(&priv->user_read_timer);
+		del_timer_sync(&priv->user_read_timer);
 		flush_work(&priv->timeout_work);
 	}
 	mutex_unlock(&priv->buffer_mutex);
@@ -262,7 +262,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *w=
ait)
 void tpm_common_release(struct file *file, struct file_priv *priv)
 {
 	flush_work(&priv->async_work);
-	del_singleshot_timer_sync(&priv->user_read_timer);
+	del_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->timeout_work);
 	file->private_data =3D NULL;
 	priv->response_length =3D 0;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index a7ff77550e17..1695c56a2aae 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -18,6 +18,7 @@
 #include <linux/clocksource.h>
 #include <linux/clocksource_ids.h>
 #include <linux/interrupt.h>
+#include <linux/kstrtox.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
@@ -97,7 +98,7 @@ static bool evtstrm_enable __ro_after_init =3D IS_ENABLED(C=
ONFIG_ARM_ARCH_TIMER_EV
=20
 static int __init early_evtstrm_cfg(char *buf)
 {
-	return strtobool(buf, &evtstrm_enable);
+	return kstrtobool(buf, &evtstrm_enable);
 }
 early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
=20
@@ -687,8 +688,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, v=
oid *dev_id)
 	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
 }
=20
-static __always_inline int timer_shutdown(const int access,
-					  struct clock_event_device *clk)
+static __always_inline int arch_timer_shutdown(const int access,
+					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
=20
@@ -701,22 +702,22 @@ static __always_inline int timer_shutdown(const int acc=
ess,
=20
 static int arch_timer_shutdown_virt(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
 }
=20
 static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
=20
 static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
 }
=20
 static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
 }
=20
 static __always_inline void set_next_event(const int access, unsigned long e=
vt,
@@ -806,6 +807,9 @@ static u64 __arch_timer_check_delta(void)
 		/*
 		 * XGene-1 implements CVAL in terms of TVAL, meaning
 		 * that the maximum timer range is 32bit. Shame on them.
+		 *
+		 * Note that TVAL is signed, thus has only 31 of its
+		 * 32 bits to express magnitude.
 		 */
 		MIDR_ALL_VERSIONS(MIDR_CPU_MODEL(ARM_CPU_IMP_APM,
 						 APM_CPU_PART_POTENZA)),
@@ -813,8 +817,8 @@ static u64 __arch_timer_check_delta(void)
 	};
=20
 	if (is_midr_in_range_list(read_cpuid_id(), broken_cval_midrs)) {
-		pr_warn_once("Broken CNTx_CVAL_EL1, limiting width to 32bits");
-		return CLOCKSOURCE_MASK(32);
+		pr_warn_once("Broken CNTx_CVAL_EL1, using 32 bit TVAL instead.\n");
+		return CLOCKSOURCE_MASK(31);
 	}
 #endif
 	return CLOCKSOURCE_MASK(arch_counter_get_width());
diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-=
ost.c
index 06d25754e606..9f7c280a1336 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -141,7 +141,7 @@ static int __init ingenic_ost_probe(struct platform_devic=
e *pdev)
 	return 0;
 }
=20
-static int __maybe_unused ingenic_ost_suspend(struct device *dev)
+static int ingenic_ost_suspend(struct device *dev)
 {
 	struct ingenic_ost *ost =3D dev_get_drvdata(dev);
=20
@@ -150,14 +150,14 @@ static int __maybe_unused ingenic_ost_suspend(struct de=
vice *dev)
 	return 0;
 }
=20
-static int __maybe_unused ingenic_ost_resume(struct device *dev)
+static int ingenic_ost_resume(struct device *dev)
 {
 	struct ingenic_ost *ost =3D dev_get_drvdata(dev);
=20
 	return clk_enable(ost->clk);
 }
=20
-static const struct dev_pm_ops __maybe_unused ingenic_ost_pm_ops =3D {
+static const struct dev_pm_ops ingenic_ost_pm_ops =3D {
 	/* _noirq: We want the OST clock to be gated last / ungated first */
 	.suspend_noirq =3D ingenic_ost_suspend,
 	.resume_noirq  =3D ingenic_ost_resume,
@@ -181,9 +181,7 @@ static const struct of_device_id ingenic_ost_of_match[] =
=3D {
 static struct platform_driver ingenic_ost_driver =3D {
 	.driver =3D {
 		.name =3D "ingenic-ost",
-#ifdef CONFIG_PM_SUSPEND
-		.pm =3D &ingenic_ost_pm_ops,
-#endif
+		.pm =3D pm_sleep_ptr(&ingenic_ost_pm_ops),
 		.of_match_table =3D ingenic_ost_of_match,
 	},
 };
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 64dcb082d4cf..7b952aa52c0b 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -116,6 +117,7 @@ struct sh_cmt_device {
 	void __iomem *mapbase;
 	struct clk *clk;
 	unsigned long rate;
+	unsigned int reg_delay;
=20
 	raw_spinlock_t lock; /* Protect the shared start/stop register */
=20
@@ -247,10 +249,17 @@ static inline u32 sh_cmt_read_cmstr(struct sh_cmt_chann=
el *ch)
=20
 static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch, u32 value)
 {
-	if (ch->iostart)
-		ch->cmt->info->write_control(ch->iostart, 0, value);
-	else
-		ch->cmt->info->write_control(ch->cmt->mapbase, 0, value);
+	u32 old_value =3D sh_cmt_read_cmstr(ch);
+
+	if (value !=3D old_value) {
+		if (ch->iostart) {
+			ch->cmt->info->write_control(ch->iostart, 0, value);
+			udelay(ch->cmt->reg_delay);
+		} else {
+			ch->cmt->info->write_control(ch->cmt->mapbase, 0, value);
+			udelay(ch->cmt->reg_delay);
+		}
+	}
 }
=20
 static inline u32 sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
@@ -260,7 +269,12 @@ static inline u32 sh_cmt_read_cmcsr(struct sh_cmt_channe=
l *ch)
=20
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch, u32 value)
 {
-	ch->cmt->info->write_control(ch->ioctrl, CMCSR, value);
+	u32 old_value =3D sh_cmt_read_cmcsr(ch);
+
+	if (value !=3D old_value) {
+		ch->cmt->info->write_control(ch->ioctrl, CMCSR, value);
+		udelay(ch->cmt->reg_delay);
+	}
 }
=20
 static inline u32 sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
@@ -268,14 +282,33 @@ static inline u32 sh_cmt_read_cmcnt(struct sh_cmt_chann=
el *ch)
 	return ch->cmt->info->read_count(ch->ioctrl, CMCNT);
 }
=20
-static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch, u32 value)
+static inline int sh_cmt_write_cmcnt(struct sh_cmt_channel *ch, u32 value)
 {
+	/* Tests showed that we need to wait 3 clocks here */
+	unsigned int cmcnt_delay =3D DIV_ROUND_UP(3 * ch->cmt->reg_delay, 2);
+	u32 reg;
+
+	if (ch->cmt->info->model > SH_CMT_16BIT) {
+		int ret =3D read_poll_timeout_atomic(sh_cmt_read_cmcsr, reg,
+						   !(reg & SH_CMT32_CMCSR_WRFLG),
+						   1, cmcnt_delay, false, ch);
+		if (ret < 0)
+			return ret;
+	}
+
 	ch->cmt->info->write_count(ch->ioctrl, CMCNT, value);
+	udelay(cmcnt_delay);
+	return 0;
 }
=20
 static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch, u32 value)
 {
-	ch->cmt->info->write_count(ch->ioctrl, CMCOR, value);
+	u32 old_value =3D ch->cmt->info->read_count(ch->ioctrl, CMCOR);
+
+	if (value !=3D old_value) {
+		ch->cmt->info->write_count(ch->ioctrl, CMCOR, value);
+		udelay(ch->cmt->reg_delay);
+	}
 }
=20
 static u32 sh_cmt_get_counter(struct sh_cmt_channel *ch, u32 *has_wrapped)
@@ -319,7 +352,7 @@ static void sh_cmt_start_stop_ch(struct sh_cmt_channel *c=
h, int start)
=20
 static int sh_cmt_enable(struct sh_cmt_channel *ch)
 {
-	int k, ret;
+	int ret;
=20
 	dev_pm_syscore_device(&ch->cmt->pdev->dev, true);
=20
@@ -347,26 +380,9 @@ static int sh_cmt_enable(struct sh_cmt_channel *ch)
 	}
=20
 	sh_cmt_write_cmcor(ch, 0xffffffff);
-	sh_cmt_write_cmcnt(ch, 0);
-
-	/*
-	 * According to the sh73a0 user's manual, as CMCNT can be operated
-	 * only by the RCLK (Pseudo 32 kHz), there's one restriction on
-	 * modifying CMCNT register; two RCLK cycles are necessary before
-	 * this register is either read or any modification of the value
-	 * it holds is reflected in the LSI's actual operation.
-	 *
-	 * While at it, we're supposed to clear out the CMCNT as of this
-	 * moment, so make sure it's processed properly here.  This will
-	 * take RCLKx2 at maximum.
-	 */
-	for (k =3D 0; k < 100; k++) {
-		if (!sh_cmt_read_cmcnt(ch))
-			break;
-		udelay(1);
-	}
+	ret =3D sh_cmt_write_cmcnt(ch, 0);
=20
-	if (sh_cmt_read_cmcnt(ch)) {
+	if (ret || sh_cmt_read_cmcnt(ch)) {
 		dev_err(&ch->cmt->pdev->dev, "ch%u: cannot clear CMCNT\n",
 			ch->index);
 		ret =3D -ETIMEDOUT;
@@ -995,8 +1011,8 @@ MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
=20
 static int sh_cmt_setup(struct sh_cmt_device *cmt, struct platform_device *p=
dev)
 {
-	unsigned int mask;
-	unsigned int i;
+	unsigned int mask, i;
+	unsigned long rate;
 	int ret;
=20
 	cmt->pdev =3D pdev;
@@ -1032,10 +1048,16 @@ static int sh_cmt_setup(struct sh_cmt_device *cmt, st=
ruct platform_device *pdev)
 	if (ret < 0)
 		goto err_clk_unprepare;
=20
-	if (cmt->info->width =3D=3D 16)
-		cmt->rate =3D clk_get_rate(cmt->clk) / 512;
-	else
-		cmt->rate =3D clk_get_rate(cmt->clk) / 8;
+	rate =3D clk_get_rate(cmt->clk);
+	if (!rate) {
+		ret =3D -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* We shall wait 2 input clks after register writes */
+	if (cmt->info->model >=3D SH_CMT_48BIT)
+		cmt->reg_delay =3D DIV_ROUND_UP(2UL * USEC_PER_SEC, rate);
+	cmt->rate =3D rate / (cmt->info->width =3D=3D 16 ? 512 : 8);
=20
 	/* Map the memory resource(s). */
 	ret =3D sh_cmt_map_memory(cmt);
diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-=
npcm7xx.c
index a00520cbb660..9af30af5f989 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -188,6 +188,7 @@ static void __init npcm7xx_clocksource_init(void)
=20
 static int __init npcm7xx_timer_init(struct device_node *np)
 {
+	struct clk *clk;
 	int ret;
=20
 	ret =3D timer_of_init(np, &npcm7xx_to);
@@ -199,6 +200,15 @@ static int __init npcm7xx_timer_init(struct device_node =
*np)
 	npcm7xx_to.of_clk.rate =3D npcm7xx_to.of_clk.rate /
 		(NPCM7XX_Tx_MIN_PRESCALE + 1);
=20
+	/* Enable the clock for timer1, if it exists */
+	clk =3D of_clk_get(np, 1);
+	if (clk) {
+		if (!IS_ERR(clk))
+			clk_prepare_enable(clk);
+		else
+			pr_warn("%pOF: Failed to get clock for timer1: %pe", np, clk);
+	}
+
 	npcm7xx_clocksource_init();
 	npcm7xx_clockevents_init();
=20
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp=
804.c
index e6a87f4af2b5..cd1916c05325 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -155,14 +155,14 @@ static irqreturn_t sp804_timer_interrupt(int irq, void =
*dev_id)
 	return IRQ_HANDLED;
 }
=20
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void evt_timer_shutdown(struct clock_event_device *evt)
 {
 	writel(0, common_clkevt->ctrl);
 }
=20
 static int sp804_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	return 0;
 }
=20
@@ -171,7 +171,7 @@ static int sp804_set_periodic(struct clock_event_device *=
evt)
 	unsigned long ctrl =3D TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
=20
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	writel(common_clkevt->reload, common_clkevt->load);
 	writel(ctrl, common_clkevt->ctrl);
 	return 0;
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource=
/timer-ti-dm-systimer.c
index 2737407ff069..632523c1232f 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -345,8 +345,10 @@ static int __init dmtimer_systimer_init_clock(struct dmt=
imer_systimer *t,
 		return error;
=20
 	r =3D clk_get_rate(clock);
-	if (!r)
+	if (!r) {
+		clk_disable_unprepare(clock);
 		return -ENODEV;
+	}
=20
 	if (is_ick)
 		t->ick =3D clock;
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index cad29ded3a48..b24b903a8822 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -633,6 +633,8 @@ static struct omap_dm_timer *omap_dm_timer_request_by_nod=
e(struct device_node *n
 static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
=20
 	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
@@ -640,10 +642,21 @@ static int omap_dm_timer_free(struct omap_dm_timer *coo=
kie)
=20
 	WARN_ON(!timer->reserved);
 	timer->reserved =3D 0;
+
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	/* Clear timer configuration */
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
+
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
=20
-int omap_dm_timer_get_irq(struct omap_dm_timer *cookie)
+static int omap_dm_timer_get_irq(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer =3D to_dmtimer(cookie);
 	if (timer)
@@ -1135,6 +1148,10 @@ static int omap_dm_timer_probe(struct platform_device =
*pdev)
 			goto err_disable;
 		}
 		__omap_dm_timer_init_regs(timer);
+
+		/* Clear timer configuration */
+		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
+
 		pm_runtime_put(dev);
 	}
=20
@@ -1258,7 +1275,7 @@ static struct platform_driver omap_dm_timer_driver =3D {
 	.remove =3D omap_dm_timer_remove,
 	.driver =3D {
 		.name   =3D "omap_timer",
-		.of_match_table =3D of_match_ptr(omap_timer_match),
+		.of_match_table =3D omap_timer_match,
 		.pm =3D &omap_dm_timer_pm_ops,
 	},
 };
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/=
hfa384x_usb.c
index 02fdef7a16c8..c7cd54171d99 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -1116,8 +1116,8 @@ static int hfa384x_usbctlx_complete_sync(struct hfa384x=
 *hw,
 		if (ctlx =3D=3D get_active_ctlx(hw)) {
 			spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
=20
-			del_singleshot_timer_sync(&hw->reqtimer);
-			del_singleshot_timer_sync(&hw->resptimer);
+			del_timer_sync(&hw->reqtimer);
+			del_timer_sync(&hw->resptimer);
 			hw->req_timer_done =3D 1;
 			hw->resp_timer_done =3D 1;
 			usb_kill_urb(&hw->ctlx_urb);
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/pr=
ism2usb.c
index e13da7fadfff..c13f1699e5a2 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -170,9 +170,9 @@ static void prism2sta_disconnect_usb(struct usb_interface=
 *interface)
 		 */
 		prism2sta_ifstate(wlandev, P80211ENUM_ifstate_disable);
=20
-		del_singleshot_timer_sync(&hw->throttle);
-		del_singleshot_timer_sync(&hw->reqtimer);
-		del_singleshot_timer_sync(&hw->resptimer);
+		del_timer_sync(&hw->throttle);
+		del_timer_sync(&hw->reqtimer);
+		del_timer_sync(&hw->resptimer);
=20
 		/* Unlink all the URBs. This "removes the wheels"
 		 * from the entire CTLX handling mechanism.
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti=
-dm.h
index 77eceeae708c..dcc1712f75e7 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -62,8 +62,6 @@
 struct omap_dm_timer {
 };
=20
-int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
-
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
=20
 /*
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 3146f1c056c9..bb9d3f5542f8 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -45,6 +45,7 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 void free_time_ns(struct time_namespace *ns);
 void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
 struct vdso_data *arch_get_vdso_data(void *vvar_page);
+struct page *find_timens_vvar_page(struct vm_area_struct *vma);
=20
 static inline void put_time_ns(struct time_namespace *ns)
 {
@@ -141,6 +142,11 @@ static inline void timens_on_fork(struct nsproxy *nsprox=
y,
 	return;
 }
=20
+static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
 static inline void timens_add_monotonic(struct timespec64 *ts) { }
 static inline void timens_add_boottime(struct timespec64 *ts) { }
=20
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 648f00105f58..9162f275819a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -169,7 +169,6 @@ static inline int timer_pending(const struct timer_list *=
 timer)
 }
=20
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires=
);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
@@ -183,14 +182,36 @@ extern int timer_reduce(struct timer_list *timer, unsig=
ned long expires);
 extern void add_timer(struct timer_list *timer);
=20
 extern int try_to_del_timer_sync(struct timer_list *timer);
+extern int timer_delete_sync(struct timer_list *timer);
+extern int timer_delete(struct timer_list *timer);
+extern int timer_shutdown_sync(struct timer_list *timer);
+extern int timer_shutdown(struct timer_list *timer);
=20
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
-  extern int del_timer_sync(struct timer_list *timer);
-#else
-# define del_timer_sync(t)		del_timer(t)
-#endif
+/**
+ * del_timer_sync - Delete a pending timer and wait for a running callback
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete_sync() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete_sync() instead.
+ */
+static inline int del_timer_sync(struct timer_list *timer)
+{
+	return timer_delete_sync(timer);
+}
=20
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
+/**
+ * del_timer - Delete a pending timer
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete() instead.
+ */
+static inline int del_timer(struct timer_list *timer)
+{
+	return timer_delete(timer);
+}
=20
 extern void init_timers(void);
 struct hrtimer;
diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 93884086f392..adc80e29168e 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -35,7 +35,7 @@ struct timerqueue_node *timerqueue_getnext(struct timerqueu=
e_head *head)
 {
 	struct rb_node *leftmost =3D rb_first_cached(&head->rb_root);
=20
-	return rb_entry(leftmost, struct timerqueue_node, node);
+	return rb_entry_safe(leftmost, struct timerqueue_node, node);
 }
=20
 static inline void timerqueue_init(struct timerqueue_node *node)
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5d85014d59b5..960143b183cd 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -76,7 +76,7 @@ static u64 cev_delta2ns(unsigned long latch, struct clock_e=
vent_device *evt,
 }
=20
 /**
- * clockevents_delta2ns - Convert a latch value (device ticks) to nanoseconds
+ * clockevent_delta2ns - Convert a latch value (device ticks) to nanoseconds
  * @latch:	value to convert
  * @evt:	pointer to clock event device descriptor
  *
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index aec832801c26..0775b9ec952a 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -192,6 +192,24 @@ static void timens_setup_vdso_data(struct vdso_data *vda=
ta,
 	offset[CLOCK_BOOTTIME_ALARM]	=3D boottime;
 }
=20
+struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm =3D=3D current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops().
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+
 /*
  * Protects possibly multiple offsets writers racing each other
  * and tasks entering the namespace.
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..63a8ce7177dd 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1017,7 +1017,7 @@ __mod_timer(struct timer_list *timer, unsigned long exp=
ires, unsigned int option
 	unsigned int idx =3D UINT_MAX;
 	int ret =3D 0;
=20
-	BUG_ON(!timer->function);
+	debug_assert_init(timer);
=20
 	/*
 	 * This is a common optimization triggered by the networking code - if
@@ -1044,6 +1044,14 @@ __mod_timer(struct timer_list *timer, unsigned long ex=
pires, unsigned int option
 		 * dequeue/enqueue dance.
 		 */
 		base =3D lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
=20
 		if (timer_pending(timer) && (options & MOD_TIMER_REDUCE) &&
@@ -1070,6 +1078,14 @@ __mod_timer(struct timer_list *timer, unsigned long ex=
pires, unsigned int option
 		}
 	} else {
 		base =3D lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function)
+			goto out_unlock;
+
 		forward_timer_base(base);
 	}
=20
@@ -1083,7 +1099,7 @@ __mod_timer(struct timer_list *timer, unsigned long exp=
ires, unsigned int option
 		/*
 		 * We are trying to schedule the timer on the new base.
 		 * However we can't change timer's base while it is running,
-		 * otherwise del_timer_sync() can't detect that the timer's
+		 * otherwise timer_delete_sync() can't detect that the timer's
 		 * handler yet has not finished. This also guarantees that the
 		 * timer is serialized wrt itself.
 		 */
@@ -1121,14 +1137,20 @@ __mod_timer(struct timer_list *timer, unsigned long e=
xpires, unsigned int option
 }
=20
 /**
- * mod_timer_pending - modify a pending timer's timeout
- * @timer: the pending timer to be modified
- * @expires: new timeout in jiffies
+ * mod_timer_pending - Modify a pending timer's timeout
+ * @timer:	The pending timer to be modified
+ * @expires:	New absolute timeout in jiffies
+ *
+ * mod_timer_pending() is the same for pending timers as mod_timer(), but
+ * will not activate inactive timers.
  *
- * mod_timer_pending() is the same for pending timers as mod_timer(),
- * but will not re-activate and modify already deleted timers.
+ * If @timer->function =3D=3D NULL then the start operation is silently
+ * discarded.
  *
- * It is useful for unserialized use of timers.
+ * Return:
+ * * %0 - The timer was inactive and not modified or was in
+ *	  shutdown state and the operation was discarded
+ * * %1 - The timer was active and requeued to expire at @expires
  */
 int mod_timer_pending(struct timer_list *timer, unsigned long expires)
 {
@@ -1137,24 +1159,31 @@ int mod_timer_pending(struct timer_list *timer, unsig=
ned long expires)
 EXPORT_SYMBOL(mod_timer_pending);
=20
 /**
- * mod_timer - modify a timer's timeout
- * @timer: the timer to be modified
- * @expires: new timeout in jiffies
- *
- * mod_timer() is a more efficient way to update the expire field of an
- * active timer (if the timer is inactive it will be activated)
+ * mod_timer - Modify a timer's timeout
+ * @timer:	The timer to be modified
+ * @expires:	New absolute timeout in jiffies
  *
  * mod_timer(timer, expires) is equivalent to:
  *
  *     del_timer(timer); timer->expires =3D expires; add_timer(timer);
  *
+ * mod_timer() is more efficient than the above open coded sequence. In
+ * case that the timer is inactive, the del_timer() part is a NOP. The
+ * timer is in any case activated with the new expiry time @expires.
+ *
  * Note that if there are multiple unserialized concurrent users of the
  * same timer, then mod_timer() is the only safe way to modify the timeout,
  * since add_timer() cannot modify an already running timer.
  *
- * The function returns whether it has modified a pending timer or not.
- * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
- * active timer returns 1.)
+ * If @timer->function =3D=3D NULL then the start operation is silently
+ * discarded. In this case the return value is 0 and meaningless.
+ *
+ * Return:
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
+ * * %1 - The timer was active and requeued to expire at @expires or
+ *	  the timer was active and not modified because @expires did
+ *	  not change the effective expiry time
  */
 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
@@ -1165,11 +1194,22 @@ EXPORT_SYMBOL(mod_timer);
 /**
  * timer_reduce - Modify a timer's timeout if it would reduce the timeout
  * @timer:	The timer to be modified
- * @expires:	New timeout in jiffies
+ * @expires:	New absolute timeout in jiffies
  *
  * timer_reduce() is very similar to mod_timer(), except that it will only
- * modify a running timer if that would reduce the expiration time (it will
- * start a timer that isn't running).
+ * modify an enqueued timer if that would reduce the expiration time. If
+ * @timer is not enqueued it starts the timer.
+ *
+ * If @timer->function =3D=3D NULL then the start operation is silently
+ * discarded.
+ *
+ * Return:
+ * * %0 - The timer was inactive and started or was in shutdown
+ *	  state and the operation was discarded
+ * * %1 - The timer was active and requeued to expire at @expires or
+ *	  the timer was active and not modified because @expires
+ *	  did not change the effective expiry time such that the
+ *	  timer would expire earlier than already scheduled
  */
 int timer_reduce(struct timer_list *timer, unsigned long expires)
 {
@@ -1178,39 +1218,51 @@ int timer_reduce(struct timer_list *timer, unsigned l=
ong expires)
 EXPORT_SYMBOL(timer_reduce);
=20
 /**
- * add_timer - start a timer
- * @timer: the timer to be added
+ * add_timer - Start a timer
+ * @timer:	The timer to be started
  *
- * The kernel will do a ->function(@timer) callback from the
- * timer interrupt at the ->expires point in the future. The
- * current time is 'jiffies'.
+ * Start @timer to expire at @timer->expires in the future. @timer->expires
+ * is the absolute expiry time measured in 'jiffies'. When the timer expires
+ * timer->function(timer) will be invoked from soft interrupt context.
  *
- * The timer's ->expires, ->function fields must be set prior calling this
- * function.
+ * The @timer->expires and @timer->function fields must be set prior
+ * to calling this function.
  *
- * Timers with an ->expires field in the past will be executed in the next
- * timer tick.
+ * If @timer->function =3D=3D NULL then the start operation is silently
+ * discarded.
+ *
+ * If @timer->expires is already in the past @timer will be queued to
+ * expire at the next timer tick.
+ *
+ * This can only operate on an inactive timer. Attempts to invoke this on
+ * an active timer are rejected with a warning.
  */
 void add_timer(struct timer_list *timer)
 {
-	BUG_ON(timer_pending(timer));
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
=20
 /**
- * add_timer_on - start a timer on a particular CPU
- * @timer: the timer to be added
- * @cpu: the CPU to start it on
+ * add_timer_on - Start a timer on a particular CPU
+ * @timer:	The timer to be started
+ * @cpu:	The CPU to start it on
+ *
+ * Same as add_timer() except that it starts the timer on the given CPU.
  *
- * This is not very scalable on SMP. Double adds are not possible.
+ * See add_timer() for further details.
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
 	struct timer_base *new_base, *base;
 	unsigned long flags;
=20
-	BUG_ON(timer_pending(timer) || !timer->function);
+	debug_assert_init(timer);
+
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
=20
 	new_base =3D get_timer_cpu_base(timer->flags, cpu);
=20
@@ -1220,6 +1272,13 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 * wrong base locked.  See lock_timer_base().
 	 */
 	base =3D lock_timer_base(timer, &flags);
+	/*
+	 * Has @timer been shutdown? This needs to be evaluated while
+	 * holding base lock to prevent a race against the shutdown code.
+	 */
+	if (!timer->function)
+		goto out_unlock;
+
 	if (base !=3D new_base) {
 		timer->flags |=3D TIMER_MIGRATING;
=20
@@ -1233,22 +1292,27 @@ void add_timer_on(struct timer_list *timer, int cpu)
=20
 	debug_timer_activate(timer);
 	internal_add_timer(base, timer);
+out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
=20
 /**
- * del_timer - deactivate a timer.
- * @timer: the timer to be deactivated
- *
- * del_timer() deactivates a timer - this works on both active and inactive
- * timers.
- *
- * The function returns whether it has deactivated a pending timer or not.
- * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
- * active timer returns 1.)
+ * __timer_delete - Internal function: Deactivate a timer
+ * @timer:	The timer to be deactivated
+ * @shutdown:	If true, this indicates that the timer is about to be
+ *		shutdown permanently.
+ *
+ * If @shutdown is true then @timer->function is set to NULL under the
+ * timer base lock which prevents further rearming of the time. In that
+ * case any attempt to rearm @timer after this function returns will be
+ * silently ignored.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending and deactivated
  */
-int del_timer(struct timer_list *timer)
+static int __timer_delete(struct timer_list *timer, bool shutdown)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1256,24 +1320,90 @@ int del_timer(struct timer_list *timer)
=20
 	debug_assert_init(timer);
=20
-	if (timer_pending(timer)) {
+	/*
+	 * If @shutdown is set then the lock has to be taken whether the
+	 * timer is pending or not to protect against a concurrent rearm
+	 * which might hit between the lockless pending check and the lock
+	 * aquisition. By taking the lock it is ensured that such a newly
+	 * enqueued timer is dequeued and cannot end up with
+	 * timer->function =3D=3D NULL in the expiry code.
+	 *
+	 * If timer->function is currently executed, then this makes sure
+	 * that the callback cannot requeue the timer.
+	 */
+	if (timer_pending(timer) || shutdown) {
 		base =3D lock_timer_base(timer, &flags);
 		ret =3D detach_if_pending(timer, base, true);
+		if (shutdown)
+			timer->function =3D NULL;
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
=20
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
=20
 /**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
+ * timer_delete - Deactivate a timer
+ * @timer:	The timer to be deactivated
+ *
+ * The function only deactivates a pending timer, but contrary to
+ * timer_delete_sync() it does not take into account whether the timer's
+ * callback function is concurrently executed on a different CPU or not.
+ * It neither prevents rearming of the timer.  If @timer can be rearmed
+ * concurrently then the return value of this function is meaningless.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending and deactivated
+ */
+int timer_delete(struct timer_list *timer)
+{
+	return __timer_delete(timer, false);
+}
+EXPORT_SYMBOL(timer_delete);
+
+/**
+ * timer_shutdown - Deactivate a timer and prevent rearming
+ * @timer:	The timer to be deactivated
  *
- * This function tries to deactivate a timer. Upon successful (ret >=3D 0)
- * exit the timer is not queued and the handler is not running on any CPU.
+ * The function does not wait for an eventually running timer callback on a
+ * different CPU but it prevents rearming of the timer. Any attempt to arm
+ * @timer after this function returns will be silently ignored.
+ *
+ * This function is useful for teardown code and should only be used when
+ * timer_shutdown_sync() cannot be invoked due to locking or context constra=
ints.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+int timer_shutdown(struct timer_list *timer)
+{
+	return __timer_delete(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown);
+
+/**
+ * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
+ * @timer:	Timer to deactivate
+ * @shutdown:	If true, this indicates that the timer is about to be
+ *		shutdown permanently.
+ *
+ * If @shutdown is true then @timer->function is set to NULL under the
+ * timer base lock which prevents further rearming of the timer. Any
+ * attempt to rearm @timer after this function returns will be silently
+ * ignored.
+ *
+ * This function cannot guarantee that the timer cannot be rearmed
+ * right after dropping the base lock if @shutdown is false. That
+ * needs to be prevented by the calling code if necessary.
+ *
+ * Return:
+ * * %0  - The timer was not pending
+ * * %1  - The timer was pending and deactivated
+ * * %-1 - The timer callback function is running on a different CPU
+ */
+static int __try_to_del_timer_sync(struct timer_list *timer, bool shutdown)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1285,11 +1415,34 @@ int try_to_del_timer_sync(struct timer_list *timer)
=20
 	if (base->running_timer !=3D timer)
 		ret =3D detach_if_pending(timer, base, true);
+	if (shutdown)
+		timer->function =3D NULL;
=20
 	raw_spin_unlock_irqrestore(&base->lock, flags);
=20
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer:	Timer to deactivate
+ *
+ * This function tries to deactivate a timer. On success the timer is not
+ * queued and the timer callback function is not running on any CPU.
+ *
+ * This function does not guarantee that the timer cannot be rearmed right
+ * after dropping the base lock. That needs to be prevented by the calling
+ * code if necessary.
+ *
+ * Return:
+ * * %0  - The timer was not pending
+ * * %1  - The timer was pending and deactivated
+ * * %-1 - The timer callback function is running on a different CPU
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	return __try_to_del_timer_sync(timer, false);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
=20
 #ifdef CONFIG_PREEMPT_RT
@@ -1365,44 +1518,29 @@ static inline void timer_sync_wait_running(struct tim=
er_base *base) { }
 static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
=20
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /**
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
- * @timer: the timer to be deactivated
- *
- * This function only differs from del_timer() on SMP: besides deactivating
- * the timer it also makes sure the handler has finished executing on other
- * CPUs.
- *
- * Synchronization rules: Callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts unless the timer is an irqsafe one. The caller must
- * not hold locks which would prevent completion of the timer's
- * handler. The timer's handler must not call add_timer_on(). Upon exit the
- * timer is not queued and the handler is not running on any CPU.
- *
- * Note: For !irqsafe timers, you must not hold locks that are held in
- *   interrupt context while calling this function. Even if the lock has
- *   nothing to do with the timer in question.  Here's why::
- *
- *    CPU0                             CPU1
- *    ----                             ----
- *                                     <SOFTIRQ>
- *                                       call_timer_fn();
- *                                       base->running_timer =3D mytimer;
- *    spin_lock_irq(somelock);
- *                                     <IRQ>
- *                                        spin_lock(somelock);
- *    del_timer_sync(mytimer);
- *    while (base->running_timer =3D=3D mytimer);
- *
- * Now del_timer_sync() will never return and never release somelock.
- * The interrupt on the other CPU is waiting to grab somelock but
- * it has interrupted the softirq that CPU0 is waiting to finish.
- *
- * The function returns whether it has deactivated a pending timer or not.
+ * __timer_delete_sync - Internal function: Deactivate a timer and wait
+ *			 for the handler to finish.
+ * @timer:	The timer to be deactivated
+ * @shutdown:	If true, @timer->function will be set to NULL under the
+ *		timer base lock which prevents rearming of @timer
+ *
+ * If @shutdown is not set the timer can be rearmed later. If the timer can
+ * be rearmed concurrently, i.e. after dropping the base lock then the
+ * return value is meaningless.
+ *
+ * If @shutdown is set then @timer->function is set to NULL under timer
+ * base lock which prevents rearming of the timer. Any attempt to rearm
+ * a shutdown timer is silently ignored.
+ *
+ * If the timer should be reused after shutdown it has to be initialized
+ * again.
+ *
+ * Return:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
-int del_timer_sync(struct timer_list *timer)
+static int __timer_delete_sync(struct timer_list *timer, bool shutdown)
 {
 	int ret;
=20
@@ -1422,7 +1560,7 @@ int del_timer_sync(struct timer_list *timer)
 	 * don't use it in hardirq context, because it
 	 * could lead to deadlock.
 	 */
-	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
+	WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));
=20
 	/*
 	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
@@ -1432,7 +1570,7 @@ int del_timer_sync(struct timer_list *timer)
 		lockdep_assert_preemption_enabled();
=20
 	do {
-		ret =3D try_to_del_timer_sync(timer);
+		ret =3D __try_to_del_timer_sync(timer, shutdown);
=20
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1442,8 +1580,96 @@ int del_timer_sync(struct timer_list *timer)
=20
 	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
-#endif
+
+/**
+ * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * @timer:	The timer to be deactivated
+ *
+ * Synchronization rules: Callers must prevent restarting of the timer,
+ * otherwise this function is meaningless. It must not be called from
+ * interrupt contexts unless the timer is an irqsafe one. The caller must
+ * not hold locks which would prevent completion of the timer's callback
+ * function. The timer's handler must not call add_timer_on(). Upon exit
+ * the timer is not queued and the handler is not running on any CPU.
+ *
+ * For !irqsafe timers, the caller must not hold locks that are held in
+ * interrupt context. Even if the lock has nothing to do with the timer in
+ * question.  Here's why::
+ *
+ *    CPU0                             CPU1
+ *    ----                             ----
+ *                                     <SOFTIRQ>
+ *                                       call_timer_fn();
+ *                                       base->running_timer =3D mytimer;
+ *    spin_lock_irq(somelock);
+ *                                     <IRQ>
+ *                                        spin_lock(somelock);
+ *    timer_delete_sync(mytimer);
+ *    while (base->running_timer =3D=3D mytimer);
+ *
+ * Now timer_delete_sync() will never return and never release somelock.
+ * The interrupt on the other CPU is waiting to grab somelock but it has
+ * interrupted the softirq that CPU0 is waiting to finish.
+ *
+ * This function cannot guarantee that the timer is not rearmed again by
+ * some concurrent or preempting code, right after it dropped the base
+ * lock. If there is the possibility of a concurrent rearm then the return
+ * value of the function is meaningless.
+ *
+ * If such a guarantee is needed, e.g. for teardown situations then use
+ * timer_shutdown_sync() instead.
+ *
+ * Return:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
+ */
+int timer_delete_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer, false);
+}
+EXPORT_SYMBOL(timer_delete_sync);
+
+/**
+ * timer_shutdown_sync - Shutdown a timer and prevent rearming
+ * @timer: The timer to be shutdown
+ *
+ * When the function returns it is guaranteed that:
+ *   - @timer is not queued
+ *   - The callback function of @timer is not running
+ *   - @timer cannot be enqueued again. Any attempt to rearm
+ *     @timer is silently ignored.
+ *
+ * See timer_delete_sync() for synchronization rules.
+ *
+ * This function is useful for final teardown of an infrastructure where
+ * the timer is subject to a circular dependency problem.
+ *
+ * A common pattern for this is a timer and a workqueue where the timer can
+ * schedule work and work can arm the timer. On shutdown the workqueue must
+ * be destroyed and the timer must be prevented from rearming. Unless the
+ * code has conditionals like 'if (mything->in_shutdown)' to prevent that
+ * there is no way to get this correct with timer_delete_sync().
+ *
+ * timer_shutdown_sync() is solving the problem. The correct ordering of
+ * calls in this case is:
+ *
+ *	timer_shutdown_sync(&mything->timer);
+ *	workqueue_destroy(&mything->workqueue);
+ *
+ * After this 'mything' can be safely freed.
+ *
+ * This obviously implies that the timer is not required to be functional
+ * for the rest of the shutdown operation.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown_sync);
=20
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
@@ -1465,8 +1691,8 @@ static void call_timer_fn(struct timer_list *timer,
 #endif
 	/*
 	 * Couple the lock chain with the lock chain at
-	 * del_timer_sync() by acquiring the lock_map around the fn()
-	 * call here and in del_timer_sync().
+	 * timer_delete_sync() by acquiring the lock_map around the fn()
+	 * call here and in timer_delete_sync().
 	 */
 	lock_map_acquire(&lockdep_map);
=20
@@ -1509,6 +1735,12 @@ static void expire_timers(struct timer_base *base, str=
uct hlist_head *head)
=20
 		fn =3D timer->function;
=20
+		if (WARN_ON_ONCE(!fn)) {
+			/* Should never happen. Emphasis on should! */
+			base->running_timer =3D NULL;
+			continue;
+		}
+
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
@@ -1933,7 +2165,7 @@ signed long __sched schedule_timeout(signed long timeou=
t)
 	timer_setup_on_stack(&timer.timer, process_timeout, 0);
 	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
 	schedule();
-	del_singleshot_timer_sync(&timer.timer);
+	del_timer_sync(&timer.timer);
=20
 	/* Remove the timer from the object tracker */
 	destroy_timer_on_stack(&timer.timer);
@@ -2017,8 +2249,6 @@ int timers_dead_cpu(unsigned int cpu)
 	struct timer_base *new_base;
 	int b, i;
=20
-	BUG_ON(cpu_online(cpu));
-
 	for (b =3D 0; b < NR_BASES; b++) {
 		old_base =3D per_cpu_ptr(&timer_bases[b], cpu);
 		new_base =3D get_cpu_ptr(&timer_bases[b]);
@@ -2035,7 +2265,8 @@ int timers_dead_cpu(unsigned int cpu)
 		 */
 		forward_timer_base(new_base);
=20
-		BUG_ON(old_base->running_timer);
+		WARN_ON_ONCE(old_base->running_timer);
+		old_base->running_timer =3D NULL;
=20
 		for (i =3D 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 656cec208371..ab453ede54f0 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1164,7 +1164,7 @@ xprt_request_enqueue_receive(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
=20
 	/* Turn off autodisconnect */
-	del_singleshot_timer_sync(&xprt->timer);
+	del_timer_sync(&xprt->timer);
 	return 0;
 }
=20

