Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7D7419F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjF1VBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjF1VA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:00:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99219B0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:00:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so63040a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687986054; x=1690578054;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UsCShzZlSVVvcFLIXVSwDFqSlgHSwDOBYWNFsuS3DSk=;
        b=gf1z7fvdf39g4KKD/BiXeAwUKU9fw2x0hEBrNDJJyNbmNaK3snqEk5nWKnsdpiXJU9
         rUYr++ERpnuEOlbDGNb4S79qtgq9GIZU3n/Qi6FW0W7le8YRHwHuzpHLVJBoY/KvP7vK
         MmGCrMty3QMhNcwlzFfy2hN6mNU1eA+Ez6H2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687986054; x=1690578054;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsCShzZlSVVvcFLIXVSwDFqSlgHSwDOBYWNFsuS3DSk=;
        b=DpB5Dm5ngikxNaN0TFmKuItPpDwViN9VzL3cMzbbIrOc8HyHBKri0dS4QWeWEnvxsL
         +53ImdvFH3k4ySpjv842rXw60eg2n//eGuVta1btIMnNMgCR2D5nY9PbjR4ZcTv5hYKb
         nQ+tJ4Bmmq3XVli2mvjukyX+65QTl3dTcqS2JkTb6CpB9SbRHbbRcHOyrjfCIQ8UTHSf
         b2PO0a1YaXtiSYvdGfzh1VlH1607lyKm+X85fM6VNZJt5oJmuDT8fnKdGlUZcsbwq6DE
         t9T2gGvIi0H1M1Pee+sgt7LIKkMPZrEAZyfQGpM0NUmNSodBUjaPGN0qS+wCG8HdQEwO
         2oNw==
X-Gm-Message-State: AC+VfDxmxnILSQH03wN01i+5957K76nJQfCF8fHY7Iolc5ravXUM6+VD
        /5ZxrZzSq/UgY6bvGOjjVC0AL9TcL1O/4SWWDMvEq1qW
X-Google-Smtp-Source: ACHHUZ6wFBLRpOlzhZzO5Pxi04Px4+vsIkGOUAynPqMdjBUpai8Jm7HhwUkqfPUqQ1/OO3jy+NGl+w==
X-Received: by 2002:aa7:d68c:0:b0:51d:ad2b:3700 with SMTP id d12-20020aa7d68c000000b0051dad2b3700mr3574181edr.26.1687986054579;
        Wed, 28 Jun 2023 14:00:54 -0700 (PDT)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b0051d9246f963sm4308203edy.9.2023.06.28.14.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:00:54 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 28 Jun 2023 23:00:49 +0200
Subject: [PATCH] usb: xhci-mtk: set the dma max_seg_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org>
X-B4-Tracking: v=1; b=H4sIAICfnGQC/x2MQQqDQAwAvyI5G9hu1bZ+pfSw0WwNtVvZVBHEv
 xs8zjDMBspZWKEtNsi8iMovGVzKArohpDej9Mbgnb+6xt/x+//grIQUnasfsamov4HVFJSRckj
 dYH2ax9HklDnKeu6fr30/ANYVTB1uAAAA
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ricardo Ribalda Delgado <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7476; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=06OAba3Q1UxsiXAo8+me3vjx/v7V85FJ1TwyHzGclyw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBknJ+DwpST5JpzX41iapqQoctiKSPyHtn6bPLuP
 tz8yhw2Zs6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZJyfgwAKCRDRN9E+zzrE
 iChSD/9FF2FMrwkZeGzhZggbNH3e4Uk6Jx8vNjqMwG2i3yk/fNMJ2x/7g/aFczl3+ovGLOTr9lq
 2H5LZFjauIMfxz667H4hEojghWPx96lqu3zOyXN79qnHAJevPITGEYQR99pPowS74KM21fbnVHq
 wWzZP4hlshEqZJDBQrv4GrcM+ysEnlmMKPHOwrYq+4qdeaRNPVI7WY1k4T4UQCS9SDDm+BGgL68
 GjsFsQbsVyo8/Q+b7aWZkfRCm7rBmupn0LhuWX2l2SHmFfhPnDCj/we3hZI02ij2FgqY2erE1C3
 Rk5wWC3iYzZpDTFYp4KXnVyApVzMWDClSSvafno4C83DaV1zcKFyUPMkpwqaRg4dK5k0J9HskiA
 prA2MxlMEMLX+t2OaeS28tVWIbsChCz+ydUYl4+WyvQ853sW9D3njCQdXZwGzEdy188iCGPVIwt
 AzbG+Nz/7vfgtvYiT44elH6q7DKnbjX4KLfetIlqglgOOqlX5yHlKPQMGQgKCsc4gAxWqO6KgCg
 DuaxYymgoYrpmro+yAaB0Oh2T9kHD4KcJto4wvf3+miqBMQ5iadq0R5wyrUADPL92aMrNtTI4Oz
 vQuoxdZUXVNUNwlRJRg/1v/vj6Q1d1V3ZP6WSboXMzbqBOmG7m52RovcyDOfL/3ODVHwamkQLEK
 AuvkTtlkdNIPPeQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow devices to have dma operations beyond 64K, and avoid warnings such
as:

DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Fix warnings such as:

[  451.089443] ------------[ cut here ]------------
[  451.089498] DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]
[  451.089617] WARNING: CPU: 7 PID: 14227 at kernel/dma/debug.c:1163 debug_dma_map_sg+0x5bc/0x950
[  451.089674] Modules linked in: xfrm_interface tun hci_vhci bridge stp llc veth xt_cgroup xt_MASQUERADE uinput rfcomm ip6table_nat fuse 8021q algif_hash algif_skcipher af_alg r8153_ecm cdc_ether usbnet r8152 mii mtk_vcodec_dec_hw mt7921s mt76_sdio mt7921_common mt76_connac_lib mt76 uvcvideo videobuf2_vmalloc mtk_vcodec_dec v4l2_h264 mtk_vcodec_enc mtk_jpeg v4l2_vp9 videobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2 btmtksdio videobuf2_common mtk_vcodec_common btmtk mac80211 snd_sof_mt8186 snd_sof_xtensa_dsp snd_sof_of snd_sof snd_sof_utils mtk_scp mtk_rpmsg rpmsg_core mtk_scp_ipi hid_rmi rmi_core serio bluetooth ecdh_generic ecc cfg80211 lzo_rle lzo_compress zram joydev
[  451.090285] CPU: 7 PID: 14227 Comm: syz-executor.0 Not tainted 5.15.118-lockdep-19753-g1b0a8b16661d #1 cd3ddfc5e13dbbbea438d3161fcad4d98ec474f4
[  451.090333] Hardware name: Google Rusty sku196608/196609/196610/196611 board (DT)
[  451.090356] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  451.090401] pc : debug_dma_map_sg+0x5bc/0x950
[  451.090433] lr : debug_dma_map_sg+0x5bc/0x950
[  451.090462] sp : ffffffc01fdd75e0
[  451.090479] x29: ffffffc01fdd7640 x28: ffffff80c1280300 x27: 0000000000010000
[  451.090531] x26: ffffff80c1ec9600 x25: 1ffffff01a749501 x24: ffffff80d3a4a800
[  451.090581] x23: dfffffc000000000 x22: ffffff80d3a4a80c x21: ffffffc00aae5740
[  451.090631] x20: ffffffffffffffff x19: ffffff80d3a4a810 x18: 0000000000000000
[  451.090680] x17: 64206e6168742072 x16: 65676e6f6c20746e x15: 656d676573206773
[  451.090731] x14: 20676e697070616d x13: 0000000000000001 x12: 0000000000000001
[  451.090779] x11: 0000000000000000 x10: 0000000000040000 x9 : 3c6fd66e79e32400
[  451.090828] x8 : 3c6fd66e79e32400 x7 : 0000000000000001 x6 : 0000000000000001
[  451.090877] x5 : ffffffc01fdd7158 x4 : ffffffc00b64e2a0 x3 : ffffffc008f92adc
[  451.090926] x2 : 0000000100000000 x1 : ffffff8057afd940 x0 : 000000000000006f
[  451.090976] Call trace:
[  451.090994]  debug_dma_map_sg+0x5bc/0x950
[  451.091026]  dma_alloc_noncontiguous+0x2f4/0x404
[  451.091060]  uvc_alloc_urb_buffers+0x1e8/0x600 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.091150]  uvc_video_start_transfer+0xaf4/0x1628 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.091228]  uvc_video_start_streaming+0x154/0x2d8 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.091305]  uvc_start_streaming+0x20c/0x3d4 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.091379]  vb2_start_streaming+0x118/0x400 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
[  451.091446]  vb2_core_streamon+0x258/0x360 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
[  451.091507]  vb2_streamon+0x88/0xbc [videobuf2_v4l2 f4acca89bfe3410cd8f3ca536255fc3877fe63db]
[  451.091555]  uvc_queue_streamon+0x44/0x68 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.091631]  uvc_ioctl_streamon+0xd8/0x124 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.091705]  v4l_streamon+0x74/0xa8
[  451.091738]  __video_do_ioctl+0x90c/0xa40
[  451.091769]  video_usercopy+0xa44/0x1ef8
[  451.091799]  video_ioctl2+0x44/0x58
[  451.091830]  v4l2_ioctl+0x138/0x164
[  451.091860]  __arm64_sys_ioctl+0x154/0x1d0
[  451.091892]  invoke_syscall+0x98/0x278
[  451.091923]  el0_svc_common+0x214/0x274
[  451.091953]  do_el0_svc+0x9c/0x19c
[  451.091982]  el0_svc+0x5c/0xc0
[  451.092013]  el0t_64_sync_handler+0x78/0x108
[  451.092045]  el0t_64_sync+0x1a4/0x1a8
[  451.092081] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  451.092103] CPU: 7 PID: 14227 Comm: syz-executor.0 Not tainted 5.15.118-lockdep-19753-g1b0a8b16661d #1 cd3ddfc5e13dbbbea438d3161fcad4d98ec474f4
[  451.092148] Hardware name: Google Rusty sku196608/196609/196610/196611 board (DT)
[  451.092171] Call trace:
[  451.092186]  dump_backtrace+0x0/0x4e8
[  451.092219]  show_stack+0x34/0x44
[  451.092247]  dump_stack_lvl+0xdc/0x11c
[  451.092278]  dump_stack+0x1c/0x48
[  451.092307]  panic+0x2a4/0x7b8
[  451.092335]  check_panic_on_warn+0xb8/0x104
[  451.092369]  __warn+0x16c/0x230
[  451.092399]  report_bug+0x160/0x280
[  451.092432]  bug_handler+0x48/0xb8
[  451.092466]  call_break_hook+0x180/0x1b4
[  451.092498]  brk_handler+0x30/0xbc
[  451.092529]  do_debug_exception+0x16c/0x31c
[  451.092563]  el1_dbg+0x64/0x80
[  451.092592]  el1h_64_sync_handler+0x70/0xb4
[  451.092624]  el1h_64_sync+0x7c/0x80
[  451.092653]  debug_dma_map_sg+0x5bc/0x950
[  451.092685]  dma_alloc_noncontiguous+0x2f4/0x404
[  451.092717]  uvc_alloc_urb_buffers+0x1e8/0x600 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.092794]  uvc_video_start_transfer+0xaf4/0x1628 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.092868]  uvc_video_start_streaming+0x154/0x2d8 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.092942]  uvc_start_streaming+0x20c/0x3d4 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.093015]  vb2_start_streaming+0x118/0x400 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
[  451.093079]  vb2_core_streamon+0x258/0x360 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
[  451.093139]  vb2_streamon+0x88/0xbc [videobuf2_v4l2 f4acca89bfe3410cd8f3ca536255fc3877fe63db]
[  451.093187]  uvc_queue_streamon+0x44/0x68 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.093261]  uvc_ioctl_streamon+0xd8/0x124 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
[  451.093334]  v4l_streamon+0x74/0xa8
[  451.093366]  __video_do_ioctl+0x90c/0xa40
[  451.093398]  video_usercopy+0xa44/0x1ef8
[  451.093428]  video_ioctl2+0x44/0x58
[  451.093457]  v4l2_ioctl+0x138/0x164
[  451.093487]  __arm64_sys_ioctl+0x154/0x1d0
[  451.093518]  invoke_syscall+0x98/0x278
[  451.093548]  el0_svc_common+0x214/0x274
[  451.093578]  do_el0_svc+0x9c/0x19c
[  451.093607]  el0_svc+0x5c/0xc0
[  451.093637]  el0t_64_sync_handler+0x78/0x108
[  451.093669]  el0t_64_sync+0x1a4/0x1a8
[  451.093701] SMP: stopping secondary CPUs
[  451.093777] Kernel Offset: disabled
[  451.093797] CPU features: 0xc00181c1,a3300e42
[  451.093822] Memory Limit: none

Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
---
 drivers/usb/host/xhci-mtk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 90cf40d6d0c3..605b1e1a5098 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -643,6 +643,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(dev);
 	pm_runtime_forbid(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 dealloc_usb3_hcd:

---
base-commit: 1b2c92a1cb2469d8c0079dbf496ab86e22e1cb7c
change-id: 20230628-mtk-usb-bf0059f64bd7

Best regards,
-- 
Ricardo Ribalda Delgado <ribalda@chromium.org>

