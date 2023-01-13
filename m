Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C45669C97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAMPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjAMPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:38:34 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2158BA90
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:30:40 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1673623827; x=1673883027;
        bh=jbFxkExsMlV9xsBwHzYnqYf/viHGLmssqbaqiMZo0s0=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=CM7DV48/Ak0H02Fr785pQIKLcDaRYszEE2EFaNPnc4ybCQfBEQZ7R+n6+Pd/KrIT6
         AGKazUm6H8LEs64o5KUZcfw+jyATbRA4hifXgIlQWwCB9ZqR9ll1MXWTx7y0xEE/3p
         uandkFmK0Ol9cOAa/puWvjKUb+/So+dKPOrd9LIHCrE4bJxQ0EkQrPpI3Q44mZeWvl
         oQmc4tmP9RARDw8C0su0K6MWlv4fzuy32NjbYA2s8J2qPW9qwyQPS47KeGcdX0Jl/f
         ViTrriFWaqbVYBvBenZPdwyXntF0DJXlaF2xfSxfgCgW+SLeq5FAxdSyeK8jm6mDtZ
         5UI5OdxSEbDjQ==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
Subject: [PATCH] pcmcia: avoid defines prefixed with CONFIG
Message-ID: <n-Xd5VZl4mxdBIPvH-LgdDqAi8N9cL3TiAQ6fKEOpXLKsyDAxcf9VWQZfnMobTdIXucJJ1U2B82W6KhoODwWr_n3d-V9YkDcV92AjzxMrys=@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros prefixed with "CONFIG_" should be relegated to Kconfig switches,
so we should change the config state flags to avoid conflicts.

This change affects only code readability, not function.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 drivers/pcmcia/cs_internal.h     |  6 +++---
 drivers/pcmcia/pcmcia_resource.c | 26 +++++++++++++-------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
index 580369f3c0b0..95df616fb0a4 100644
--- a/drivers/pcmcia/cs_internal.h
+++ b/drivers/pcmcia/cs_internal.h
@@ -59,9 +59,9 @@ struct pccard_resource_ops {
 };
=20
 /* Flags in config state */
-#define CONFIG_LOCKED=09=090x01
-#define CONFIG_IRQ_REQ=09=090x02
-#define CONFIG_IO_REQ=09=090x04
+#define CFG_LOCKED=09=090x01
+#define CFG_IRQ_REQ=09=090x02
+#define CFG_IO_REQ=09=090x04
=20
 /* Flags in socket state */
 #define SOCKET_PRESENT=09=090x0008
diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resou=
rce.c
index d78091e79a0f..d559977b9332 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -168,7 +168,7 @@ static int pcmcia_access_config(struct pcmcia_device *p=
_dev,
 =09mutex_lock(&s->ops_mutex);
 =09c =3D p_dev->function_config;
=20
-=09if (!(c->state & CONFIG_LOCKED)) {
+=09if (!(c->state & CFG_LOCKED)) {
 =09=09dev_dbg(&p_dev->dev, "Configuration isn't locked\n");
 =09=09mutex_unlock(&s->ops_mutex);
 =09=09return -EACCES;
@@ -262,7 +262,7 @@ int pcmcia_fixup_iowidth(struct pcmcia_device *p_dev)
 =09dev_dbg(&p_dev->dev, "fixup iowidth to 8bit\n");
=20
 =09if (!(s->state & SOCKET_PRESENT) ||
-=09=09!(p_dev->function_config->state & CONFIG_LOCKED)) {
+=09=09!(p_dev->function_config->state & CFG_LOCKED)) {
 =09=09dev_dbg(&p_dev->dev, "No card? Config not locked?\n");
 =09=09ret =3D -EACCES;
 =09=09goto unlock;
@@ -310,7 +310,7 @@ int pcmcia_fixup_vpp(struct pcmcia_device *p_dev, unsig=
ned char new_vpp)
 =09dev_dbg(&p_dev->dev, "fixup Vpp to %d\n", new_vpp);
=20
 =09if (!(s->state & SOCKET_PRESENT) ||
-=09=09!(p_dev->function_config->state & CONFIG_LOCKED)) {
+=09=09!(p_dev->function_config->state & CFG_LOCKED)) {
 =09=09dev_dbg(&p_dev->dev, "No card? Config not locked?\n");
 =09=09ret =3D -EACCES;
 =09=09goto unlock;
@@ -361,9 +361,9 @@ int pcmcia_release_configuration(struct pcmcia_device *=
p_dev)
 =09=09=09s->ops->set_socket(s, &s->socket);
 =09=09}
 =09}
-=09if (c->state & CONFIG_LOCKED) {
-=09=09c->state &=3D ~CONFIG_LOCKED;
-=09=09if (c->state & CONFIG_IO_REQ)
+=09if (c->state & CFG_LOCKED) {
+=09=09c->state &=3D ~CFG_LOCKED;
+=09=09if (c->state & CFG_IO_REQ)
 =09=09=09for (i =3D 0; i < MAX_IO_WIN; i++) {
 =09=09=09=09if (!s->io[i].res)
 =09=09=09=09=09continue;
@@ -407,7 +407,7 @@ static void pcmcia_release_io(struct pcmcia_device *p_d=
ev)
 =09=09release_io_space(s, &c->io[1]);
=20
 =09p_dev->_io =3D 0;
-=09c->state &=3D ~CONFIG_IO_REQ;
+=09c->state &=3D ~CFG_IO_REQ;
=20
 out:
 =09mutex_unlock(&s->ops_mutex);
@@ -491,7 +491,7 @@ int pcmcia_enable_device(struct pcmcia_device *p_dev)
=20
 =09mutex_lock(&s->ops_mutex);
 =09c =3D p_dev->function_config;
-=09if (c->state & CONFIG_LOCKED) {
+=09if (c->state & CFG_LOCKED) {
 =09=09mutex_unlock(&s->ops_mutex);
 =09=09dev_dbg(&p_dev->dev, "Configuration is locked\n");
 =09=09return -EACCES;
@@ -581,7 +581,7 @@ int pcmcia_enable_device(struct pcmcia_device *p_dev)
 =09}
=20
 =09/* Configure I/O windows */
-=09if (c->state & CONFIG_IO_REQ) {
+=09if (c->state & CFG_IO_REQ) {
 =09=09iomap.speed =3D io_speed;
 =09=09for (i =3D 0; i < MAX_IO_WIN; i++)
 =09=09=09if (s->io[i].res) {
@@ -602,7 +602,7 @@ int pcmcia_enable_device(struct pcmcia_device *p_dev)
 =09=09=09}
 =09}
=20
-=09c->state |=3D CONFIG_LOCKED;
+=09c->state |=3D CFG_LOCKED;
 =09p_dev->_locked =3D 1;
 =09mutex_unlock(&s->ops_mutex);
 =09return 0;
@@ -635,11 +635,11 @@ int pcmcia_request_io(struct pcmcia_device *p_dev)
 =09=09goto out;
 =09}
=20
-=09if (c->state & CONFIG_LOCKED) {
+=09if (c->state & CFG_LOCKED) {
 =09=09dev_dbg(&p_dev->dev, "Configuration is locked\n");
 =09=09goto out;
 =09}
-=09if (c->state & CONFIG_IO_REQ) {
+=09if (c->state & CFG_IO_REQ) {
 =09=09dev_dbg(&p_dev->dev, "IO already configured\n");
 =09=09goto out;
 =09}
@@ -663,7 +663,7 @@ int pcmcia_request_io(struct pcmcia_device *p_dev)
 =09} else
 =09=09c->io[1].start =3D 0;
=20
-=09c->state |=3D CONFIG_IO_REQ;
+=09c->state |=3D CFG_IO_REQ;
 =09p_dev->_io =3D 1;
=20
 =09dev_dbg(&p_dev->dev, "pcmcia_request_io succeeded: %pR , %pR",
--=20
2.39.0

