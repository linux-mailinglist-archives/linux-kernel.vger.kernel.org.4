Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275346F0FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbjD1BRY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 21:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjD1BRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:17:22 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E62122;
        Thu, 27 Apr 2023 18:17:19 -0700 (PDT)
X-UUID: cd50ef11d3c34755ab4be2551cc1b666-20230428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:408dea53-6e23-4300-b724-4ae2918a6d1e,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-4
X-CID-INFO: VERSION:1.1.22,REQID:408dea53-6e23-4300-b724-4ae2918a6d1e,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-4
X-CID-META: VersionHash:120426c,CLOUDID:8eda256a-2f20-4998-991c-3b78627e4938,B
        ulkID:230428091715JX7J7YU3,BulkQuantity:0,Recheck:0,SF:19|41|24|17|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: cd50ef11d3c34755ab4be2551cc1b666-20230428
X-User: zhouzongmin@kylinos.cn
Received: from [172.20.12.156] [(116.128.244.169)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 710927598; Fri, 28 Apr 2023 09:17:14 +0800
Message-ID: <6599319fea8ed1e3d6968e5b986661f0cf175902.camel@kylinos.cn>
Subject: Re: [PATCH] drm/probe_helper: fix the warning reported when calling
 drm_kms_helper_poll_disable during suspend
From:   zongmin zhou <zhouzongmin@kylinos.cn>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Janne Grunau <j@jannau.net>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, neil.armstrong@linaro.org, tony.luck@intel.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, laurentiu.palcu@oss.nxp.com,
        regressions@lists.linux.dev
Date:   Fri, 28 Apr 2023 09:17:12 +0800
In-Reply-To: <CAA8EJppmUtuhAF+VHPh3Q8tNYp1m4T6P7dZ0wYZ8Vzwo0DF6cg@mail.gmail.com>
References: <20230328023129.3596968-1-zhouzongmin@kylinos.cn>
         <20230420200148.GD3280@jannau.net>
         <CAA8EJpoK3yv3E==bJuDoQhsW2Q1LdqKakJgdZx6S=ec-CvyGyw@mail.gmail.com>
         <1682386644754589.204.seg@mailgw>
         <1186d62a5fe7f2aa6e06f06a3dc7605c0072f1eb.camel@kylinos.cn>
         <CAA8EJppmUtuhAF+VHPh3Q8tNYp1m4T6P7dZ0wYZ8Vzwo0DF6cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-26 at 16:10 +0300, Dmitry Baryshkov wrote:
> On Wed, 26 Apr 2023 at 12:09, zongmin zhou <zhouzongmin@kylinos.cn>
> wrote:
> > 
> > On Sun, 2023-04-23 at 22:51 +0200, Janne Grunau wrote:
> > > On 2023-04-20 23:07:01 +0300, Dmitry Baryshkov wrote:
> > > > On Thu, 20 Apr 2023 at 23:01, Janne Grunau <j@jannau.net>
> > > > wrote:
> > > > > 
> > > > > On 2023-03-28 10:31:29 +0800, Zongmin Zhou wrote:
> > > > > > When drivers call drm_kms_helper_poll_disable from
> > > > > > their device suspend implementation without enabled output
> > > > > > polling before,
> > > > > > following warning will be reported,due to work->func not be
> > > > > > initialized:
> > > > > 
> > > > > we see the same warning with the wpork in progress kms driver
> > > > > for
> > > > > apple
> > > > > silicon SoCs. The connectors do not need to polled so the
> > > > > driver
> > > > > never
> > > > > calls drm_kms_helper_poll_init().
> > > > > 
> > > > > > [   55.141361] WARNING: CPU: 3 PID: 372 at
> > > > > > kernel/workqueue.c:3066 __flush_work+0x22f/0x240
> > > > > > [   55.141382] Modules linked in: nls_iso8859_1
> > > > > > snd_hda_codec_generic ledtrig_audio snd_hda_intel
> > > > > > snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
> > > > > > snd_hda_core
> > > > > > snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event
> > > > > > snd_rawmidi
> > > > > > snd_seq intel_rapl_msr intel_rapl_common bochs
> > > > > > drm_vram_helper
> > > > > > drm_ttm_helper snd_seq_device nfit ttm crct10dif_pclmul
> > > > > > snd_timer ghash_clmulni_intel binfmt_misc sha512_ssse3
> > > > > > aesni_intel drm_kms_helper joydev input_leds syscopyarea
> > > > > > crypto_simd snd cryptd sysfillrect sysimgblt mac_hid
> > > > > > serio_raw
> > > > > > soundcore qemu_fw_cfg sch_fq_codel msr parport_pc ppdev lp
> > > > > > parport drm ramoops reed_solomon pstore_blk pstore_zone
> > > > > > efi_pstore virtio_rng ip_tables x_tables autofs4
> > > > > > hid_generic
> > > > > > usbhid hid ahci virtio_net i2c_i801 crc32_pclmul psmouse
> > > > > > virtio_scsi libahci i2c_smbus lpc_ich xhci_pci net_failover
> > > > > > virtio_blk xhci_pci_renesas failover
> > > > > > [   55.141430] CPU: 3 PID: 372 Comm: kworker/u16:9 Not
> > > > > > tainted
> > > > > > 6.2.0-rc6+ #16
> > > > > > [   55.141433] Hardware name: QEMU Standard PC (Q35 + ICH9,
> > > > > > 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org
> > > > > > 04/01/2014
> > > > > > [   55.141435] Workqueue: events_unbound async_run_entry_fn
> > > > > > [   55.141441] RIP: 0010:__flush_work+0x22f/0x240
> > > > > > [   55.141444] Code: 8b 43 28 48 8b 53 30 89 c1 e9 f9 fe ff
> > > > > > ff
> > > > > > 4c 89 f7 e8 b5 95 d9 00 e8 00 53 08 00 45 31 ff e9 11 ff ff
> > > > > > ff
> > > > > > 0f 0b e9 0a ff ff ff <0f> 0b 45 31 ff e9 00 ff ff ff e8 e2
> > > > > > 54
> > > > > > d8 00 66 90 90 90 90 90 90
> > > > > > [   55.141446] RSP: 0018:ff59221940833c18 EFLAGS: 00010246
> > > > > > [   55.141449] RAX: 0000000000000000 RBX: 0000000000000000
> > > > > > RCX:
> > > > > > ffffffff9b72bcbe
> > > > > > [   55.141450] RDX: 0000000000000001 RSI: 0000000000000001
> > > > > > RDI:
> > > > > > ff3ea01e4265e330
> > > > > > [   55.141451] RBP: ff59221940833c90 R08: 0000000000000000
> > > > > > R09:
> > > > > > 8080808080808080
> > > > > > [   55.141453] R10: ff3ea01e42b3caf4 R11: 000000000000000f
> > > > > > R12:
> > > > > > ff3ea01e4265e330
> > > > > > [   55.141454] R13: 0000000000000001 R14: ff3ea01e505e5e80
> > > > > > R15:
> > > > > > 0000000000000001
> > > > > > [   55.141455] FS:  0000000000000000(0000)
> > > > > > GS:ff3ea01fb7cc0000(0000) knlGS:0000000000000000
> > > > > > [   55.141456] CS:  0010 DS: 0000 ES: 0000 CR0:
> > > > > > 0000000080050033
> > > > > > [   55.141458] CR2: 0000563543ad1546 CR3: 000000010ee82005
> > > > > > CR4:
> > > > > > 0000000000771ee0
> > > > > > [   55.141464] DR0: 0000000000000000 DR1: 0000000000000000
> > > > > > DR2:
> > > > > > 0000000000000000
> > > > > > [   55.141465] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> > > > > > DR7:
> > > > > > 0000000000000400
> > > > > > [   55.141466] PKRU: 55555554
> > > > > > [   55.141467] Call Trace:
> > > > > > [   55.141469]  <TASK>
> > > > > > [   55.141472]  ? pcie_wait_cmd+0xdf/0x220
> > > > > > [   55.141478]  ? mptcp_seq_show+0xe0/0x180
> > > > > > [   55.141484]  __cancel_work_timer+0x124/0x1b0
> > > > > > [   55.141487]  cancel_delayed_work_sync+0x17/0x20
> > > > > > [   55.141490]  drm_kms_helper_poll_disable+0x26/0x40
> > > > > > [drm_kms_helper]
> > > > > > [   55.141516]  drm_mode_config_helper_suspend+0x25/0x90
> > > > > > [drm_kms_helper]
> > > > > > [   55.141531]  ? __pm_runtime_resume+0x64/0x90
> > > > > > [   55.141536]  bochs_pm_suspend+0x16/0x20 [bochs]
> > > > > > [   55.141540]  pci_pm_suspend+0x8b/0x1b0
> > > > > > [   55.141545]  ? __pfx_pci_pm_suspend+0x10/0x10
> > > > > > [   55.141547]  dpm_run_callback+0x4c/0x160
> > > > > > [   55.141550]  __device_suspend+0x14c/0x4c0
> > > > > > [   55.141553]  async_suspend+0x24/0xa0
> > > > > > [   55.141555]  async_run_entry_fn+0x34/0x120
> > > > > > [   55.141557]  process_one_work+0x21a/0x3f0
> > > > > > [   55.141560]  worker_thread+0x4e/0x3c0
> > > > > > [   55.141563]  ? __pfx_worker_thread+0x10/0x10
> > > > > > [   55.141565]  kthread+0xf2/0x120
> > > > > > [   55.141568]  ? __pfx_kthread+0x10/0x10
> > > > > > [   55.141570]  ret_from_fork+0x29/0x50
> > > > > > [   55.141575]  </TASK>
> > > > > > [   55.141575] ---[ end trace 0000000000000000 ]---
> > > > > > 
> > > > > > Fixes: a4e771729a51 ("drm/probe_helper: sort out
> > > > > > poll_running
> > > > > > vs poll_enabled")
> > > > > > Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_probe_helper.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/drm_probe_helper.c
> > > > > > b/drivers/gpu/drm/drm_probe_helper.c
> > > > > > index 8127be134c39..ac72b18e2257 100644
> > > > > > --- a/drivers/gpu/drm/drm_probe_helper.c
> > > > > > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > > > > > @@ -855,7 +855,8 @@ void drm_kms_helper_poll_disable(struct
> > > > > > drm_device *dev)
> > > > > >       if (dev->mode_config.poll_running)
> > > > > >               drm_kms_helper_disable_hpd(dev);
> > > > > > 
> > > > > > -     cancel_delayed_work_sync(&dev-
> > > > > > > mode_config.output_poll_work);
> > > > > > +     if (dev->mode_config.poll_enabled)
> > > > > > +             cancel_delayed_work_sync(&dev-
> > > > > > > mode_config.output_poll_work);
> > > > > 
> > > > > Checking for dev->mode_config.poll_enabled at the start of
> > > > > the
> > > > > function
> > > > > and return early if it is not true looks more in style with
> > > > > the
> > > > > rest of
> > > > > drm_probe_helper.c.
> > > > 
> > > > I think it is an error to call drm_kms_helper_poll_disable() if
> > > > polling was not initialized. So, in my opinion the fix should
> > > > go to
> > > > the drm_mode_config_helper_suspend() / _resume() instead.
> > > > Please
> > > > add a
> > > > guard there using dev->mode_config.poll_enabled.
> > > 
> > > While I tend to agree to the sentiment I do not think this is the
> > > correct fix in this situation. drm_kms_helper_poll_disable had
> > > the
> > > check since at least 2014. a4e771729a51 is a regression. If we
> > > want
> > > to
> > > change the behavior it should be done explicitly and after
> > > verifying
> > > all
> > > drm_kms_helper_poll_disable() calls.
> > > 
> > > #regzbot ^introduced a4e771729a51
> > > 
> > > ciao
> > > Janne
> > 
> > Dear Janne:
> > 
> > I agree with you like I mentioned on last letter.
> > Thanks for your time.
> > 
> > 
> > Dear Dmitry:
> > 
> > Is there anything else I can do?
> > Looking forward to your reply.
> 
> If it is a common consensus, I'm fine with your approach.
> 
Dear Dmitry:

Ok.Thanks for your reply.

Best regards!
