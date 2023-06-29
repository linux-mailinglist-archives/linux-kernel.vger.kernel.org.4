Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26D742BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjF2SaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjF2SaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:30:05 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98F30F6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:29:58 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-565a8d9d832so681911eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688063397; x=1690655397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMce3Jy4xVvIgBoxTrKuWPOih2+aU/EBFPj3X3f8Uyo=;
        b=fQmQ9jJilIF7fBOW5+q8Lx+VA5QmUQH9lXv9bAwKahNpl6VmSxqpHKYy5j7haKOfsB
         BkXNHcWbHAOUVbfKiTauDRFFtphnpJ0J8No2v75ZFCoxkOo/ytFKgMwXit2jXiWAv3dQ
         bQ/MUMhazkN+ou19hlMgtc4faYhLmBgq3H/TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688063398; x=1690655398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMce3Jy4xVvIgBoxTrKuWPOih2+aU/EBFPj3X3f8Uyo=;
        b=JAXG0/i01WoGFZ2nO+XvoaM7Y+40vkbsy9aeugGpxtgZC23teFT+tOaldBRVhAYBd7
         b/N3MqPwYnvlBqcfXz0lOI8XKX3PYBtEDJ/bPYkFx9RAAO2IoFkmO5U3Y51nTWtoqCj9
         4i6m3yYigcVd152aeX/cEnYeCchwkOCEpTb+XdzAFcOGy/V4Vh+CWAt6XhndUgn7fzfH
         rwid0f8GCYCreSersTCQ8vhRNRpD5TJmepA44OMc5Pj6Z+8PL5d8JV7/Ilz5MaCyPzeh
         S3EK3SaLReCYYNorrBiy2x2N+VyRql8ob+pmXDMBivpFW7mZTPw8AqoYwbQx28rXHOLx
         DPFw==
X-Gm-Message-State: AC+VfDxBIOsw/bQT+gwbf1nYXjST1gaaABs4HRSvauVSjqYa7w6ULIzG
        cvOaF89Mdsd165z4KEklu7eV44Wv7xBOrNY9tYPoOA==
X-Google-Smtp-Source: ACHHUZ4ejsfayrlMI+O/AeOtQ/SaIAxdLDzQ0G84h5Dm/KZBqUi9zeJjuxPLKhbK983kLCH/oMZing==
X-Received: by 2002:a05:6808:cf:b0:39a:abe8:afb9 with SMTP id t15-20020a05680800cf00b0039aabe8afb9mr169846oic.42.1688063397659;
        Thu, 29 Jun 2023 11:29:57 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id bi5-20020a056808188500b003a1ae2d2638sm540588oib.7.2023.06.29.11.29.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:29:56 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3a0423ea749so713649b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:29:55 -0700 (PDT)
X-Received: by 2002:a05:6808:128f:b0:39c:59e2:dd79 with SMTP id
 a15-20020a056808128f00b0039c59e2dd79mr268860oiw.36.1688063395004; Thu, 29 Jun
 2023 11:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org> <0efd9388-4cbc-d27c-f82f-d14291580150@arm.com>
In-Reply-To: <0efd9388-4cbc-d27c-f82f-d14291580150@arm.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 29 Jun 2023 20:29:44 +0200
X-Gmail-Original-Message-ID: <CANiDSCvvtdtS2E1a5qyOERG=DKzcTX2oLGWSecRz2gCi-Oo1tw@mail.gmail.com>
Message-ID: <CANiDSCvvtdtS2E1a5qyOERG=DKzcTX2oLGWSecRz2gCi-Oo1tw@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-mtk: set the dma max_seg_size
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin

On Thu, 29 Jun 2023 at 20:11, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2023-06-28 22:00, Ricardo Ribalda wrote:
> > Allow devices to have dma operations beyond 64K, and avoid warnings suc=
h
> > as:
>
> Hang on, is this actually correct? I just had a vague memory of XHCI
> having some restrictions, and sure enough according to the spec it
> *does* require buffers to be split at 64KB boundaries, since that's the
> maximum length a single TRB can encode - that's exactly the kind of
> constraint that the max_seg_size abstraction is intended to represent,
> so it seems a bit odd to be explicitly claiming a very different value.
>
> Thanks,
> Robin.

I think we had a similar discussion for  93915a4170e9 ("xhci-pci: set
the dma max_seg_size")
on
https://lore.kernel.org/all/1fe8f8a7-c88f-0c91-e74f-4d3f2f885c89@linux.inte=
l.com/

```
Preferred max segment size of sg list would be 64k as xHC hardware has
64k TRB payload size
limit, but xhci driver will take care of larger segments, splitting
them into 64k chunks.
```

>
> > DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device c=
laims to support [len=3D98304] [max=3D65536]
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Fix warnings such as:
> >
> > [  451.089443] ------------[ cut here ]------------
> > [  451.089498] DMA-API: xhci-mtk 11200000.usb: mapping sg segment longe=
r than device claims to support [len=3D98304] [max=3D65536]
> > [  451.089617] WARNING: CPU: 7 PID: 14227 at kernel/dma/debug.c:1163 de=
bug_dma_map_sg+0x5bc/0x950
> > [  451.089674] Modules linked in: xfrm_interface tun hci_vhci bridge st=
p llc veth xt_cgroup xt_MASQUERADE uinput rfcomm ip6table_nat fuse 8021q al=
gif_hash algif_skcipher af_alg r8153_ecm cdc_ether usbnet r8152 mii mtk_vco=
dec_dec_hw mt7921s mt76_sdio mt7921_common mt76_connac_lib mt76 uvcvideo vi=
deobuf2_vmalloc mtk_vcodec_dec v4l2_h264 mtk_vcodec_enc mtk_jpeg v4l2_vp9 v=
ideobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2 btmtksdio =
videobuf2_common mtk_vcodec_common btmtk mac80211 snd_sof_mt8186 snd_sof_xt=
ensa_dsp snd_sof_of snd_sof snd_sof_utils mtk_scp mtk_rpmsg rpmsg_core mtk_=
scp_ipi hid_rmi rmi_core serio bluetooth ecdh_generic ecc cfg80211 lzo_rle =
lzo_compress zram joydev
> > [  451.090285] CPU: 7 PID: 14227 Comm: syz-executor.0 Not tainted 5.15.=
118-lockdep-19753-g1b0a8b16661d #1 cd3ddfc5e13dbbbea438d3161fcad4d98ec474f4
> > [  451.090333] Hardware name: Google Rusty sku196608/196609/196610/1966=
11 board (DT)
> > [  451.090356] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [  451.090401] pc : debug_dma_map_sg+0x5bc/0x950
> > [  451.090433] lr : debug_dma_map_sg+0x5bc/0x950
> > [  451.090462] sp : ffffffc01fdd75e0
> > [  451.090479] x29: ffffffc01fdd7640 x28: ffffff80c1280300 x27: 0000000=
000010000
> > [  451.090531] x26: ffffff80c1ec9600 x25: 1ffffff01a749501 x24: ffffff8=
0d3a4a800
> > [  451.090581] x23: dfffffc000000000 x22: ffffff80d3a4a80c x21: ffffffc=
00aae5740
> > [  451.090631] x20: ffffffffffffffff x19: ffffff80d3a4a810 x18: 0000000=
000000000
> > [  451.090680] x17: 64206e6168742072 x16: 65676e6f6c20746e x15: 656d676=
573206773
> > [  451.090731] x14: 20676e697070616d x13: 0000000000000001 x12: 0000000=
000000001
> > [  451.090779] x11: 0000000000000000 x10: 0000000000040000 x9 : 3c6fd66=
e79e32400
> > [  451.090828] x8 : 3c6fd66e79e32400 x7 : 0000000000000001 x6 : 0000000=
000000001
> > [  451.090877] x5 : ffffffc01fdd7158 x4 : ffffffc00b64e2a0 x3 : ffffffc=
008f92adc
> > [  451.090926] x2 : 0000000100000000 x1 : ffffff8057afd940 x0 : 0000000=
00000006f
> > [  451.090976] Call trace:
> > [  451.090994]  debug_dma_map_sg+0x5bc/0x950
> > [  451.091026]  dma_alloc_noncontiguous+0x2f4/0x404
> > [  451.091060]  uvc_alloc_urb_buffers+0x1e8/0x600 [uvcvideo 1a151fdc876=
854366480a9c6b7aaa4b7999fb493]
> > [  451.091150]  uvc_video_start_transfer+0xaf4/0x1628 [uvcvideo 1a151fd=
c876854366480a9c6b7aaa4b7999fb493]
> > [  451.091228]  uvc_video_start_streaming+0x154/0x2d8 [uvcvideo 1a151fd=
c876854366480a9c6b7aaa4b7999fb493]
> > [  451.091305]  uvc_start_streaming+0x20c/0x3d4 [uvcvideo 1a151fdc87685=
4366480a9c6b7aaa4b7999fb493]
> > [  451.091379]  vb2_start_streaming+0x118/0x400 [videobuf2_common 252dc=
8c49960dcb8e329e2787100c89e1899c17f]
> > [  451.091446]  vb2_core_streamon+0x258/0x360 [videobuf2_common 252dc8c=
49960dcb8e329e2787100c89e1899c17f]
> > [  451.091507]  vb2_streamon+0x88/0xbc [videobuf2_v4l2 f4acca89bfe3410c=
d8f3ca536255fc3877fe63db]
> > [  451.091555]  uvc_queue_streamon+0x44/0x68 [uvcvideo 1a151fdc87685436=
6480a9c6b7aaa4b7999fb493]
> > [  451.091631]  uvc_ioctl_streamon+0xd8/0x124 [uvcvideo 1a151fdc8768543=
66480a9c6b7aaa4b7999fb493]
> > [  451.091705]  v4l_streamon+0x74/0xa8
> > [  451.091738]  __video_do_ioctl+0x90c/0xa40
> > [  451.091769]  video_usercopy+0xa44/0x1ef8
> > [  451.091799]  video_ioctl2+0x44/0x58
> > [  451.091830]  v4l2_ioctl+0x138/0x164
> > [  451.091860]  __arm64_sys_ioctl+0x154/0x1d0
> > [  451.091892]  invoke_syscall+0x98/0x278
> > [  451.091923]  el0_svc_common+0x214/0x274
> > [  451.091953]  do_el0_svc+0x9c/0x19c
> > [  451.091982]  el0_svc+0x5c/0xc0
> > [  451.092013]  el0t_64_sync_handler+0x78/0x108
> > [  451.092045]  el0t_64_sync+0x1a4/0x1a8
> > [  451.092081] Kernel panic - not syncing: kernel: panic_on_warn set ..=
.
> > [  451.092103] CPU: 7 PID: 14227 Comm: syz-executor.0 Not tainted 5.15.=
118-lockdep-19753-g1b0a8b16661d #1 cd3ddfc5e13dbbbea438d3161fcad4d98ec474f4
> > [  451.092148] Hardware name: Google Rusty sku196608/196609/196610/1966=
11 board (DT)
> > [  451.092171] Call trace:
> > [  451.092186]  dump_backtrace+0x0/0x4e8
> > [  451.092219]  show_stack+0x34/0x44
> > [  451.092247]  dump_stack_lvl+0xdc/0x11c
> > [  451.092278]  dump_stack+0x1c/0x48
> > [  451.092307]  panic+0x2a4/0x7b8
> > [  451.092335]  check_panic_on_warn+0xb8/0x104
> > [  451.092369]  __warn+0x16c/0x230
> > [  451.092399]  report_bug+0x160/0x280
> > [  451.092432]  bug_handler+0x48/0xb8
> > [  451.092466]  call_break_hook+0x180/0x1b4
> > [  451.092498]  brk_handler+0x30/0xbc
> > [  451.092529]  do_debug_exception+0x16c/0x31c
> > [  451.092563]  el1_dbg+0x64/0x80
> > [  451.092592]  el1h_64_sync_handler+0x70/0xb4
> > [  451.092624]  el1h_64_sync+0x7c/0x80
> > [  451.092653]  debug_dma_map_sg+0x5bc/0x950
> > [  451.092685]  dma_alloc_noncontiguous+0x2f4/0x404
> > [  451.092717]  uvc_alloc_urb_buffers+0x1e8/0x600 [uvcvideo 1a151fdc876=
854366480a9c6b7aaa4b7999fb493]
> > [  451.092794]  uvc_video_start_transfer+0xaf4/0x1628 [uvcvideo 1a151fd=
c876854366480a9c6b7aaa4b7999fb493]
> > [  451.092868]  uvc_video_start_streaming+0x154/0x2d8 [uvcvideo 1a151fd=
c876854366480a9c6b7aaa4b7999fb493]
> > [  451.092942]  uvc_start_streaming+0x20c/0x3d4 [uvcvideo 1a151fdc87685=
4366480a9c6b7aaa4b7999fb493]
> > [  451.093015]  vb2_start_streaming+0x118/0x400 [videobuf2_common 252dc=
8c49960dcb8e329e2787100c89e1899c17f]
> > [  451.093079]  vb2_core_streamon+0x258/0x360 [videobuf2_common 252dc8c=
49960dcb8e329e2787100c89e1899c17f]
> > [  451.093139]  vb2_streamon+0x88/0xbc [videobuf2_v4l2 f4acca89bfe3410c=
d8f3ca536255fc3877fe63db]
> > [  451.093187]  uvc_queue_streamon+0x44/0x68 [uvcvideo 1a151fdc87685436=
6480a9c6b7aaa4b7999fb493]
> > [  451.093261]  uvc_ioctl_streamon+0xd8/0x124 [uvcvideo 1a151fdc8768543=
66480a9c6b7aaa4b7999fb493]
> > [  451.093334]  v4l_streamon+0x74/0xa8
> > [  451.093366]  __video_do_ioctl+0x90c/0xa40
> > [  451.093398]  video_usercopy+0xa44/0x1ef8
> > [  451.093428]  video_ioctl2+0x44/0x58
> > [  451.093457]  v4l2_ioctl+0x138/0x164
> > [  451.093487]  __arm64_sys_ioctl+0x154/0x1d0
> > [  451.093518]  invoke_syscall+0x98/0x278
> > [  451.093548]  el0_svc_common+0x214/0x274
> > [  451.093578]  do_el0_svc+0x9c/0x19c
> > [  451.093607]  el0_svc+0x5c/0xc0
> > [  451.093637]  el0t_64_sync_handler+0x78/0x108
> > [  451.093669]  el0t_64_sync+0x1a4/0x1a8
> > [  451.093701] SMP: stopping secondary CPUs
> > [  451.093777] Kernel Offset: disabled
> > [  451.093797] CPU features: 0xc00181c1,a3300e42
> > [  451.093822] Memory Limit: none
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
> > ---
> >   drivers/usb/host/xhci-mtk.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > index 90cf40d6d0c3..605b1e1a5098 100644
> > --- a/drivers/usb/host/xhci-mtk.c
> > +++ b/drivers/usb/host/xhci-mtk.c
> > @@ -643,6 +643,8 @@ static int xhci_mtk_probe(struct platform_device *p=
dev)
> >       pm_runtime_put_autosuspend(dev);
> >       pm_runtime_forbid(dev);
> >
> > +     dma_set_max_seg_size(dev, UINT_MAX);
> > +
> >       return 0;
> >
> >   dealloc_usb3_hcd:
> >
> > ---
> > base-commit: 1b2c92a1cb2469d8c0079dbf496ab86e22e1cb7c
> > change-id: 20230628-mtk-usb-bf0059f64bd7
> >
> > Best regards,



--=20
Ricardo Ribalda
