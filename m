Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15D874645C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGCUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:43:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5751DE6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=0euS
        Nt7PROWlpp+746sCIFZ+fqkH7LiSwrfRk8JXXS0=; b=foo6YzgxVaoTEVrwnEG8
        aMACgMqa/KT8cmWyS8kyE3qi96v2wOkuB04IY2HXccPqENZG5W5/+aKtoANibNom
        jXdpavLNjlqesJtuQLTBFD9NfMhIyhmdNuGH1+Bj4TVKG485xzfdOoIfFLjUBzbV
        P54PpkZGz2rFK7N6aw7VBbcd3BVE0haJZl5cErft4ASQcPWcypp6oFt7TeC58AS5
        Yp+UTwAttgMgw0RYQFzKVp2tf8BFG8IrnFUBDU4E0vpDZxWupMDwqX6pOttIWhiA
        /u+F8Dsd/dIQEyjs0Rjhb4OgurNLRdhN6CyqDz7+tbG+ehzYEQk4YL48Bw3C4Kut
        Pw==
Received: (qmail 977144 invoked from network); 3 Jul 2023 22:43:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jul 2023 22:43:36 +0200
X-UD-Smtp-Session: l3s3148p1@gBlTOJv/WLRehh98
Date:   Mon, 3 Jul 2023 22:43:33 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        weiping zhang <zhangweiping@didichuxing.com>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] virtio-mmio: don't break lifecycle of vm_dev
Message-ID: <ZKMy9ZKdIfyf9GYF@sai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        weiping zhang <zhangweiping@didichuxing.com>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230629120526.7184-1-wsa+renesas@sang-engineering.com>
 <1688350297.9197447-5-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3uDdjR2afeqP8IHK"
Content-Disposition: inline
In-Reply-To: <1688350297.9197447-5-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uDdjR2afeqP8IHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Allocating the vm_dev struct with devres totally breaks this protection,
>=20
> device? or driver?

devres is the short name for 'managed devices'. That is, all the devm_*
functions.

> And why?

This is written in the below paragraph...

> > though. Instead of waiting for the vm_dev release callback, the memory
> > is freed when the platform_device is removed. Resulting in a
> > use-after-free when finally the callback is to be called.

=2E.. right here. Sadly, the video of my talk about device lifetime issues
is not online yet. But my slides are [1]. Please check pages 29-31.

[1] https://static.sched.com/hosted_files/eoss2023/e3/LifecycleIssues_Wolfr=
amSang_2023.pdf

> Can we have the break stack?

Sure!

root@Lager:/sys/bus/platform/drivers/virtio-mmio# echo virtio-mmio.0  > unb=
ind
[   25.258132] kobject: 'virtio0' ((ptrval)): kobject_release, parent 00000=
000 (delayed 300)
[   25.266592] ------------[ cut here ]------------
[   25.271219] WARNING: CPU: 0 PID: 606 at lib/debugobjects.c:505 debug_pri=
nt_object+0xa4/0xcc
[   25.279595] ODEBUG: free active (active state 0) object: (ptrval) object=
 type: timer_list hint: kobject_delayed_cleanup+0x0/0x68
[   25.291186] Modules linked in:
[   25.294250] CPU: 0 PID: 606 Comm: sh Tainted: G        W          6.4.0-=
00001-g1279c634d910 #1215
[   25.303134] Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
[   25.309580] Backtrace:=20
[   25.312032]  dump_backtrace from show_stack+0x20/0x24
[   25.317104]  r7:00000009 r6:c0745e4a r5:60000093 r4:c073ddc2
[   25.322768]  show_stack from dump_stack_lvl+0x2c/0x34
[   25.327836]  dump_stack_lvl from dump_stack+0x14/0x1c
[   25.332906]  r5:c02fcc34 r4:c2db3880
[   25.336484]  dump_stack from __warn+0x90/0x118
[   25.340944]  __warn from warn_slowpath_fmt+0x88/0xcc
[   25.345921]  r10:c2607c78 r9:00000000 r8:c0745e02 r7:00000009 r6:c02fcc3=
4 r5:000001f9
[   25.353759]  r4:c0745e4a
[   25.356293]  warn_slowpath_fmt from debug_print_object+0xa4/0xcc
[   25.362314]  r8:c0b1a3b4 r7:c06020f8 r6:c0735cc1 r5:c0a0492c r4:c1004a08
[   25.369019]  debug_print_object from debug_check_no_obj_freed+0x184/0x1bc
[   25.375822]  r8:c2607c00 r7:c06020f8 r6:c2db3880 r5:c2608000 r4:c2607000
[   25.382527]  debug_check_no_obj_freed from __kmem_cache_free+0x40/0x80
[   25.389072]  r10:00000004 r9:c2db3880 r8:c073257a r7:00000013 r6:c03952b=
0 r5:c2607c00
[   25.396909]  r4:c1000280
[   25.399443]  __kmem_cache_free from kfree+0x90/0x98
[   25.404335]  r7:f1581dec r6:c201e010 r5:c03952b0 r4:c2607c00
[   25.409998]  kfree from release_nodes+0x58/0x68
[   25.414548]  r7:f1581dec r6:c201e010 r5:f1581dec r4:c2607c00
[   25.420210]  release_nodes from devres_release_all+0xb8/0xe8
[   25.425891]  r9:c2db3880 r8:c0a9e1d0 r7:80000013 r6:c2db3880 r5:00000004=
 r4:c201e010
[   25.433640]  devres_release_all from device_unbind_cleanup+0x1c/0x70
[   25.440022]  r7:c0a99488 r6:00000000 r5:c0a99290 r4:c201e010
[   25.445684]  device_unbind_cleanup from device_release_driver_internal+0=
xb4/0x128
[   25.453187]  r5:c0a99290 r4:c201e010
[   25.456764]  device_release_driver_internal from device_driver_detach+0x=
20/0x24
[   25.464088]  r7:c0a99488 r6:c201e010 r5:c0a9e1d0 r4:0000000e
[   25.469750]  device_driver_detach from unbind_store+0x60/0x94
[   25.475512]  unbind_store from drv_attr_store+0x34/0x40
[   25.480759]  r9:c2db3880 r8:f1581f00 r7:c2d43a10 r6:c2d43a00 r5:c2d37e40=
 r4:c038ecfc
[   25.488508]  drv_attr_store from sysfs_kf_write+0x48/0x54
[   25.493928]  sysfs_kf_write from kernfs_fop_write_iter+0x160/0x1ac
[   25.500128]  r5:c2d37e40 r4:0000000e
[   25.503705]  kernfs_fop_write_iter from vfs_write+0x154/0x1b4
[   25.509469]  r8:00000000 r7:000f3070 r6:f1581f58 r5:c24a36c0 r4:0000000e
[   25.516173]  vfs_write from ksys_write+0x84/0xd8
[   25.520802]  r8:0000000e r7:f1581f64 r6:f1581f58 r5:000f3070 r4:c24a36c0
[   25.527507]  ksys_write from sys_write+0x18/0x1c
[   25.532135]  r8:c0100264 r7:00000004 r6:0000000e r5:000f3070 r4:00000001
[   25.538839]  sys_write from ret_fast_syscall+0x0/0x54
[   25.543901] Exception stack(0xf1581fa8 to 0xf1581ff0)
[   25.548960] 1fa0:                   00000001 000f3070 00000001 000f3070 =
0000000e 00000000
[   25.557147] 1fc0: 00000001 000f3070 0000000e 00000004 000f09f4 00000020 =
000f1284 000f1418
[   25.565333] 1fe0: 000f0250 beaca868 00018ef0 b6f40ae8
[   25.570387] ---[ end trace 0000000000000000 ]---


--3uDdjR2afeqP8IHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSjMvEACgkQFA3kzBSg
KbZ81g//eqwIDTGxrzepxC6C+X32wFZTMh4Ikv6ESlEXGYbamSqdj902JO+Fki1i
fD4v4uMxz7MW1DbvrDQxETZX3nMH/0uZaSA5ccnCiXk/a2epGSmsSSKLmGHpNGE6
d5nSaYQeDuj7kDxpH7II6BgnfJH6Lx54L80gGvwg3ymtb+Tr4xQ/eF2a8s1iC69q
kDw0OUluoVFCBTBFgIOJd4e262m6x84/EHhqZ5B6hZPKmrExpn1lhFwpqhUB82Kb
K1uYXYJdswQHsmVPAD44I1jnpA/hFOQywzHT75NJWR7wpxPo0KLcndjjE6lFc8QZ
1Z+Ol1qZW7gbVN+TdeG0EngCxcyoC4pexfLIKcKk67apJl7DoM7TCiPF9oCmtDFV
SZaDLVCqizKAJOcm3YD68tleJreGJW/BndqPYynUT9aN9soVwqyHfAeDGj9CxBAf
iWW9gcUaCzIO8fSxAg9uhhCl7nfdHpsbgbp2gVPoYGHJuXAHvTcHwrHP8/ZCjJDW
5BGI3JE+72QdhzReOL1Wem5NIn4JiCwLO/I0SzdWaQFFHX8Pcp/82Vazif1IaqmF
qL3aAwS0YB+sIV8a+EjTB9oIO3bScs7/siCLJaGIYcaLin7cWhXM+ANnyTpkEIeR
/9zKWSD/JjxEMm1kVwLY5GSj0iCyCiLa4K0F3cW4a99UqXevR58=
=iBFt
-----END PGP SIGNATURE-----

--3uDdjR2afeqP8IHK--
