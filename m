Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51084700F05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjELSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjELSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:45:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637821FF6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683917134; i=w_armin@gmx.de;
        bh=+eTiMBMEYCQmTIVOXXB3t4eOtrkdVUr1eVgLYUzYkj4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KtBsBY+orvFPSjbDjFOEFVrtblOjpOIYob9bSUEjVKfcbJ+fCdfPtiGS1H+89TtD4
         np1U/Ry9TG+js6EtLB7rOMSMOF193Q6n3p11r/oipazpmLWjxZjpuncYkNDgG+IGqs
         9YQ1BZLNfaPs+g6azmvQcWrULX18qntJfzJMh98lI728NMHI0yyBNkfCxq8fzWBc5Q
         pr/M4fWuDZL9l1p7OiMHBUcvuQHd0oeFU7rdATkQ3gUY016CB2VRktq2G18worKQFk
         K782cIl8f60+YErr8x4J82k/45gBkDon91BuhPUTXJ1Lho77Xd1cMiVrz9ut6u3Z/+
         TBh1WVq3l+Tqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MjS9I-1qcgLs376o-00kz94; Fri, 12 May 2023 20:45:34 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     linux@dominikbrodowski.net
Cc:     logang@deltatee.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()
Date:   Fri, 12 May 2023 20:45:29 +0200
Message-Id: <20230512184529.5094-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bwpWglXSi456kA93f1yP0W0SEIWl5d5lWj4CdveJSIjyvgA6iHQ
 TGK6apcrUligWDGiJStxzUCTowgmYFdopmT6MzhykyOT8B4aED//I19KUvprja43uRal3+b
 vNWwfkKWT2ctPA8I5S3Ju7C78cVepS0e8KmYz8t0eI9z82nEqi+jLOS2KHh93zt/T4DYkCE
 g7d2t3/CfFllc9elR5NYQ==
UI-OutboundReport: notjunk:1;M01:P0:FXyfl2Ke9V8=;RjMkDwHamgIoJLMcvzeGhis8UEq
 KTmBRrj2KZQnHGhf9P6ZZwnmxVk/foKaH8+/3ufxh7VrXwUfS30ORS4sRxGwXeS1IdVsxGuxS
 I/MAUD1c6Sv0J2vkvp5pQTnxavjje/b+Pa7pHIqmAvxlJnj37d+JD6XkmiTRMNDMfNPUDOqN8
 pRcDxKDDt38d2EZYgVLg9+maV5kv9iW7klrHbWZg7bbgMmozFMxtwyYpsweYkbfNgfCrq5Jvs
 xD87p91YYulVIw0biJ0TgiL2Yg4hvRdbyjW3UkgqdaEFUDV5x5zitO9w/XJ2NAtqF5ABIny23
 lUtsFO/DqsQHuadoye1YizfBwjtrjHcMPPNmv29sJBfARs2nbkMPY9lZ7iSIrrl3Qfgzm4kSP
 LG0skV/McvjB9xW29ZMbSVgst0EBWvqiaT+CkA+u35Sjt01kHtzURVzw66qv2XY+k4XuzaBk7
 c/PeVKKtzmnzpEilPRJKS8jEg7ZWvrKnUfy6cTGgqIY0H3mQ9IhlJmL5eHBudQPxdtQFB5MLn
 Llwsmol3DCV5Lk9w+qy7StfIG7r3Kd88AfJ+u9paJWwgXhgpOjKQR9cWXYmjIW5Q+CDWBbNIA
 kgdRZmd13imgCMZd87C9eb1szrh3d0PnYJ1UDZOHSNBSGY5bir/unl7bOzXgffgIli3fkH26o
 fEav834mg+z44IQ7CvyS6ycLTXdH72PKo+GxsDH3CeaT9o0WOtmVph6QsyBz+/PDmUOH8oCsE
 AZwknpbjAkmaAjMOwuRZLIO8jplJYQZwj31IzJRx8PpeM33G7RzCC73tC4Ni4PtxNcBPGLoOh
 87bsqPiSV82bAfswbFdm9Tc2hpvuP6crKmV6hbBmGOjnZnNfZ5uO34AYUgqY7DSKhLY6bN8SR
 iyKclBHcwTiGaOv2gZYJtwd4uk3NDMnLfx6F6j92O4ytl5fXs4Z9rDXmzxYo1KIsjjEEKVYoZ
 wZeFRlsUVtn1f22PIltBgw4uOXw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nonstatic_release_resource_db() frees all resources associated
with an PCMCIA socket, it forgets to free socket_data too, causing
a memory leak observable with kmemleak:

unreferenced object 0xc28d1000 (size 64):
  comm "systemd-udevd", pid 297, jiffies 4294898478 (age 194.484s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 f0 85 0e c3 00 00 00 00  ................
    00 00 00 00 0c 10 8d c2 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffda4245>] __kmem_cache_alloc_node+0x2d7/0x4a0
    [<7e51f0c8>] kmalloc_trace+0x31/0xa4
    [<d52b4ca0>] nonstatic_init+0x24/0x1a4 [pcmcia_rsrc]
    [<a2f13e08>] pcmcia_register_socket+0x200/0x35c [pcmcia_core]
    [<a728be1b>] yenta_probe+0x4d8/0xa70 [yenta_socket]
    [<c48fac39>] pci_device_probe+0x99/0x194
    [<84b7c690>] really_probe+0x181/0x45c
    [<8060fe6e>] __driver_probe_device+0x75/0x1f4
    [<b9b76f43>] driver_probe_device+0x28/0xac
    [<648b766f>] __driver_attach+0xeb/0x1e4
    [<6e9659eb>] bus_for_each_dev+0x61/0xb4
    [<25a669f3>] driver_attach+0x1e/0x28
    [<d8671d6b>] bus_add_driver+0x102/0x20c
    [<df0d323c>] driver_register+0x5b/0x120
    [<942cd8a4>] __pci_register_driver+0x44/0x4c
    [<e536027e>] __UNIQUE_ID___addressable_cleanup_module188+0x1c/0xfffff0=
00 [iTCO_vendor_support]

Fix this by freeing socket_data too.

Tested on a Acer Travelmate 4002WLMi by manually binding/unbinding
the yenta_cardbus driver (yenta_socket).

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/pcmcia/rsrc_nonstatic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstat=
ic.c
index 471e0c5815f3..bf9d070a4496 100644
=2D-- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1053,6 +1053,8 @@ static void nonstatic_release_resource_db(struct pcm=
cia_socket *s)
 		q =3D p->next;
 		kfree(p);
 	}
+
+	kfree(data);
 }


=2D-
2.30.2

