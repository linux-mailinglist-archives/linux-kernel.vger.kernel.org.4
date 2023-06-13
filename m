Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEFC72D703
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjFMBfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFMBft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:35:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F849E56
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1686620129; x=1687224929; i=w_armin@gmx.de;
 bh=J0pf1cXUiaFD57OWtNP+P+YW1hjLD8enAD7/1aYVyks=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=Vx3RGqCVuRqEVWnPpMxsHeAD7enZgfJu3aVRLkf5Gap5LEKdN+oeYJRQsuKDN9rvg3zxyx6
 vOHAErHeSwIddA5nYgIR6J6ShE7dPkWqIgRmiCJCSCJlb6DAq+UAeSAPK4EoEsjIOYAqElJ+u
 C4vdnyZwCbeSTibs87jBLi7+PiMH4PHtgjGze3DQEBVdW+xi9VnwY6DBerdDH8CUZvz2BjgfD
 ha9iqPWbAsNtBDuqVbzCjF21TgTn9IRNb35x2Ef+HRux739cP8KFL90yp0rNS/8Xp8kKbarhf
 1Ubu4gxue9HlUIz9iflt+vBQl/koDsHc2gIb7Ga6iVv/gir/NUYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1qad3q1Z7r-00TU0r; Tue, 13
 Jun 2023 03:35:29 +0200
Subject: Re: [PATCH] pcmcia: rsrc_nonstatic: Fix memory leak in
 nonstatic_release_resource_db()
From:   Armin Wolf <W_Armin@gmx.de>
To:     linux@dominikbrodowski.net
Cc:     logang@deltatee.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512184529.5094-1-W_Armin@gmx.de>
Message-ID: <f2f66f6a-8917-1b48-c598-f7b42868a7b9@gmx.de>
Date:   Tue, 13 Jun 2023 03:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230512184529.5094-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:qn3HIILsBooumwuX0/huD3Kd7J0YSr+T4wGu3L6Ydlc61qd9x4y
 XxXkDN2Q6DcEjzTqy16/lL4QafllLc6D6CqYzHz7HOt4m87GlUqzud7DF/HW/M4sFClf7an
 5aao3aYGYjvdAkwRhIoShDJe5quzG3+F1yVogPshN6a6PW3J0Gc59iZ64H8RCh/hJOIFJMb
 NFjxcH1M5FROosUtxZMZA==
UI-OutboundReport: notjunk:1;M01:P0:7aUdcedJp1c=;kD4QCksw3Z0JxA8jW/H4SxdMGu8
 ok9MOuZz/pMTWoOXmh87GcmIfTCnhC0I7uKgsXXGo1Ys3MeQ5eqCWBoWc72ywUlm/iNU2meZ4
 xM9bDTxmtxiK+N0Vusb26ODqJ5EJ+9rsjkCZZsPwUbRyB48VRMw06B4H1kdTbUv3C/dpViMIT
 aHMKFFEJnUEvdBKpSeGoZOLOjQai+XTGdhrxbvNCjNitqFYLBTkeK/0uE0DgUpmCBtV2XE2tB
 DIwwYgu9GcR2XJ6hzxg90P9eL4uG8B3Nylc303DOCNQXAHku7Y85IA6xtMUsfrlrit+mRMOJC
 8MiJcHYrTpZYuhsJh7ZKLB6eTlgAkOH0Pajp+b3MlR1PpFCPgEujB13Tk57NSmuV7rl9LoD5O
 /3jnVcaBCsVBQxAV0Cz/DMKo7mO8T3xckDJA1tOKbtX+lpd+pnXFCpVomCdh9OOFHsyLnRd8o
 mYP7WfnDs0N+WKn2PfJb05waldfW2pLF71gMw5pS01MzXCDbDGG9ynlc9yg+Uq+mAtYCknk7p
 vYvTDq73w4L2GqqAdwSdAMeJVBlSozD9J0u6MuH+J2GK8yQ7vpsuGB24pol1YbmW4pQ88xd6r
 k77d8pjEy6Ydc7jQkgdEsOm5ixyClfeBXK//XN19NfDLN3K/G3MVpcGinE2U4Um46wSQSLzsH
 rLe6YgVaVS54Xk5HR296g96zEpX6E81KXh6Knpy78h+MNyBUBdd8xYpFayeJap8tj11hWr/2T
 m6Rt/l1u7+dryKlROIDHxJL1EG5YRRtQxfaQqfL+tx04z9qlifRuG5EUCUNshS3ZI2iGKyAU2
 2NFy9fakng2cknmdpkS9daIthwpQH2Q0OWQ4JxrmBdcIn51ezgliMWEv1N2AFIiTrqxffpq8T
 Kfm1lwi4sAZuZpnjwAJd9eJtLCGgaFNXaahrhTREU8gdT68zOYfBxENOSniSAelz4k5F+90EJ
 QEKW99U1SfYa4iqU/GisQ3CgDvA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.05.23 um 20:45 schrieb Armin Wolf:

> When nonstatic_release_resource_db() frees all resources associated
> with an PCMCIA socket, it forgets to free socket_data too, causing
> a memory leak observable with kmemleak:
>
> unreferenced object 0xc28d1000 (size 64):
>    comm "systemd-udevd", pid 297, jiffies 4294898478 (age 194.484s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 f0 85 0e c3 00 00 00 00  ................
>      00 00 00 00 0c 10 8d c2 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffda4245>] __kmem_cache_alloc_node+0x2d7/0x4a0
>      [<7e51f0c8>] kmalloc_trace+0x31/0xa4
>      [<d52b4ca0>] nonstatic_init+0x24/0x1a4 [pcmcia_rsrc]
>      [<a2f13e08>] pcmcia_register_socket+0x200/0x35c [pcmcia_core]
>      [<a728be1b>] yenta_probe+0x4d8/0xa70 [yenta_socket]
>      [<c48fac39>] pci_device_probe+0x99/0x194
>      [<84b7c690>] really_probe+0x181/0x45c
>      [<8060fe6e>] __driver_probe_device+0x75/0x1f4
>      [<b9b76f43>] driver_probe_device+0x28/0xac
>      [<648b766f>] __driver_attach+0xeb/0x1e4
>      [<6e9659eb>] bus_for_each_dev+0x61/0xb4
>      [<25a669f3>] driver_attach+0x1e/0x28
>      [<d8671d6b>] bus_add_driver+0x102/0x20c
>      [<df0d323c>] driver_register+0x5b/0x120
>      [<942cd8a4>] __pci_register_driver+0x44/0x4c
>      [<e536027e>] __UNIQUE_ID___addressable_cleanup_module188+0x1c/0xfffff000 [iTCO_vendor_support]
>
> Fix this by freeing socket_data too.
>
> Tested on a Acer Travelmate 4002WLMi by manually binding/unbinding
> the yenta_cardbus driver (yenta_socket).
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/pcmcia/rsrc_nonstatic.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
> index 471e0c5815f3..bf9d070a4496 100644
> --- a/drivers/pcmcia/rsrc_nonstatic.c
> +++ b/drivers/pcmcia/rsrc_nonstatic.c
> @@ -1053,6 +1053,8 @@ static void nonstatic_release_resource_db(struct pcmcia_socket *s)
>   		q = p->next;
>   		kfree(p);
>   	}
> +
> +	kfree(data);
>   }
>
>
> --
> 2.30.2

Any progress on this one?

Armin Wolf

