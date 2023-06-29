Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E18742BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF2SLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjF2SLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:11:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A75426B6;
        Thu, 29 Jun 2023 11:11:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28C31C14;
        Thu, 29 Jun 2023 11:12:26 -0700 (PDT)
Received: from [10.57.33.98] (unknown [10.57.33.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C3ED3F73F;
        Thu, 29 Jun 2023 11:11:40 -0700 (PDT)
Message-ID: <0efd9388-4cbc-d27c-f82f-d14291580150@arm.com>
Date:   Thu, 29 Jun 2023 19:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] usb: xhci-mtk: set the dma max_seg_size
Content-Language: en-GB
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-28 22:00, Ricardo Ribalda wrote:
> Allow devices to have dma operations beyond 64K, and avoid warnings such
> as:

Hang on, is this actually correct? I just had a vague memory of XHCI 
having some restrictions, and sure enough according to the spec it 
*does* require buffers to be split at 64KB boundaries, since that's the 
maximum length a single TRB can encode - that's exactly the kind of 
constraint that the max_seg_size abstraction is intended to represent, 
so it seems a bit odd to be explicitly claiming a very different value.

Thanks,
Robin.

> DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Fix warnings such as:
> 
> [  451.089443] ------------[ cut here ]------------
> [  451.089498] DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> [  451.089617] WARNING: CPU: 7 PID: 14227 at kernel/dma/debug.c:1163 debug_dma_map_sg+0x5bc/0x950
> [  451.089674] Modules linked in: xfrm_interface tun hci_vhci bridge stp llc veth xt_cgroup xt_MASQUERADE uinput rfcomm ip6table_nat fuse 8021q algif_hash algif_skcipher af_alg r8153_ecm cdc_ether usbnet r8152 mii mtk_vcodec_dec_hw mt7921s mt76_sdio mt7921_common mt76_connac_lib mt76 uvcvideo videobuf2_vmalloc mtk_vcodec_dec v4l2_h264 mtk_vcodec_enc mtk_jpeg v4l2_vp9 videobuf2_dma_contig videobuf2_memops v4l2_mem2mem videobuf2_v4l2 btmtksdio videobuf2_common mtk_vcodec_common btmtk mac80211 snd_sof_mt8186 snd_sof_xtensa_dsp snd_sof_of snd_sof snd_sof_utils mtk_scp mtk_rpmsg rpmsg_core mtk_scp_ipi hid_rmi rmi_core serio bluetooth ecdh_generic ecc cfg80211 lzo_rle lzo_compress zram joydev
> [  451.090285] CPU: 7 PID: 14227 Comm: syz-executor.0 Not tainted 5.15.118-lockdep-19753-g1b0a8b16661d #1 cd3ddfc5e13dbbbea438d3161fcad4d98ec474f4
> [  451.090333] Hardware name: Google Rusty sku196608/196609/196610/196611 board (DT)
> [  451.090356] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  451.090401] pc : debug_dma_map_sg+0x5bc/0x950
> [  451.090433] lr : debug_dma_map_sg+0x5bc/0x950
> [  451.090462] sp : ffffffc01fdd75e0
> [  451.090479] x29: ffffffc01fdd7640 x28: ffffff80c1280300 x27: 0000000000010000
> [  451.090531] x26: ffffff80c1ec9600 x25: 1ffffff01a749501 x24: ffffff80d3a4a800
> [  451.090581] x23: dfffffc000000000 x22: ffffff80d3a4a80c x21: ffffffc00aae5740
> [  451.090631] x20: ffffffffffffffff x19: ffffff80d3a4a810 x18: 0000000000000000
> [  451.090680] x17: 64206e6168742072 x16: 65676e6f6c20746e x15: 656d676573206773
> [  451.090731] x14: 20676e697070616d x13: 0000000000000001 x12: 0000000000000001
> [  451.090779] x11: 0000000000000000 x10: 0000000000040000 x9 : 3c6fd66e79e32400
> [  451.090828] x8 : 3c6fd66e79e32400 x7 : 0000000000000001 x6 : 0000000000000001
> [  451.090877] x5 : ffffffc01fdd7158 x4 : ffffffc00b64e2a0 x3 : ffffffc008f92adc
> [  451.090926] x2 : 0000000100000000 x1 : ffffff8057afd940 x0 : 000000000000006f
> [  451.090976] Call trace:
> [  451.090994]  debug_dma_map_sg+0x5bc/0x950
> [  451.091026]  dma_alloc_noncontiguous+0x2f4/0x404
> [  451.091060]  uvc_alloc_urb_buffers+0x1e8/0x600 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.091150]  uvc_video_start_transfer+0xaf4/0x1628 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.091228]  uvc_video_start_streaming+0x154/0x2d8 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.091305]  uvc_start_streaming+0x20c/0x3d4 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.091379]  vb2_start_streaming+0x118/0x400 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
> [  451.091446]  vb2_core_streamon+0x258/0x360 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
> [  451.091507]  vb2_streamon+0x88/0xbc [videobuf2_v4l2 f4acca89bfe3410cd8f3ca536255fc3877fe63db]
> [  451.091555]  uvc_queue_streamon+0x44/0x68 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.091631]  uvc_ioctl_streamon+0xd8/0x124 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.091705]  v4l_streamon+0x74/0xa8
> [  451.091738]  __video_do_ioctl+0x90c/0xa40
> [  451.091769]  video_usercopy+0xa44/0x1ef8
> [  451.091799]  video_ioctl2+0x44/0x58
> [  451.091830]  v4l2_ioctl+0x138/0x164
> [  451.091860]  __arm64_sys_ioctl+0x154/0x1d0
> [  451.091892]  invoke_syscall+0x98/0x278
> [  451.091923]  el0_svc_common+0x214/0x274
> [  451.091953]  do_el0_svc+0x9c/0x19c
> [  451.091982]  el0_svc+0x5c/0xc0
> [  451.092013]  el0t_64_sync_handler+0x78/0x108
> [  451.092045]  el0t_64_sync+0x1a4/0x1a8
> [  451.092081] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [  451.092103] CPU: 7 PID: 14227 Comm: syz-executor.0 Not tainted 5.15.118-lockdep-19753-g1b0a8b16661d #1 cd3ddfc5e13dbbbea438d3161fcad4d98ec474f4
> [  451.092148] Hardware name: Google Rusty sku196608/196609/196610/196611 board (DT)
> [  451.092171] Call trace:
> [  451.092186]  dump_backtrace+0x0/0x4e8
> [  451.092219]  show_stack+0x34/0x44
> [  451.092247]  dump_stack_lvl+0xdc/0x11c
> [  451.092278]  dump_stack+0x1c/0x48
> [  451.092307]  panic+0x2a4/0x7b8
> [  451.092335]  check_panic_on_warn+0xb8/0x104
> [  451.092369]  __warn+0x16c/0x230
> [  451.092399]  report_bug+0x160/0x280
> [  451.092432]  bug_handler+0x48/0xb8
> [  451.092466]  call_break_hook+0x180/0x1b4
> [  451.092498]  brk_handler+0x30/0xbc
> [  451.092529]  do_debug_exception+0x16c/0x31c
> [  451.092563]  el1_dbg+0x64/0x80
> [  451.092592]  el1h_64_sync_handler+0x70/0xb4
> [  451.092624]  el1h_64_sync+0x7c/0x80
> [  451.092653]  debug_dma_map_sg+0x5bc/0x950
> [  451.092685]  dma_alloc_noncontiguous+0x2f4/0x404
> [  451.092717]  uvc_alloc_urb_buffers+0x1e8/0x600 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.092794]  uvc_video_start_transfer+0xaf4/0x1628 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.092868]  uvc_video_start_streaming+0x154/0x2d8 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.092942]  uvc_start_streaming+0x20c/0x3d4 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.093015]  vb2_start_streaming+0x118/0x400 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
> [  451.093079]  vb2_core_streamon+0x258/0x360 [videobuf2_common 252dc8c49960dcb8e329e2787100c89e1899c17f]
> [  451.093139]  vb2_streamon+0x88/0xbc [videobuf2_v4l2 f4acca89bfe3410cd8f3ca536255fc3877fe63db]
> [  451.093187]  uvc_queue_streamon+0x44/0x68 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.093261]  uvc_ioctl_streamon+0xd8/0x124 [uvcvideo 1a151fdc876854366480a9c6b7aaa4b7999fb493]
> [  451.093334]  v4l_streamon+0x74/0xa8
> [  451.093366]  __video_do_ioctl+0x90c/0xa40
> [  451.093398]  video_usercopy+0xa44/0x1ef8
> [  451.093428]  video_ioctl2+0x44/0x58
> [  451.093457]  v4l2_ioctl+0x138/0x164
> [  451.093487]  __arm64_sys_ioctl+0x154/0x1d0
> [  451.093518]  invoke_syscall+0x98/0x278
> [  451.093548]  el0_svc_common+0x214/0x274
> [  451.093578]  do_el0_svc+0x9c/0x19c
> [  451.093607]  el0_svc+0x5c/0xc0
> [  451.093637]  el0t_64_sync_handler+0x78/0x108
> [  451.093669]  el0t_64_sync+0x1a4/0x1a8
> [  451.093701] SMP: stopping secondary CPUs
> [  451.093777] Kernel Offset: disabled
> [  451.093797] CPU features: 0xc00181c1,a3300e42
> [  451.093822] Memory Limit: none
> 
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
> ---
>   drivers/usb/host/xhci-mtk.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 90cf40d6d0c3..605b1e1a5098 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -643,6 +643,8 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>   	pm_runtime_put_autosuspend(dev);
>   	pm_runtime_forbid(dev);
>   
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
>   	return 0;
>   
>   dealloc_usb3_hcd:
> 
> ---
> base-commit: 1b2c92a1cb2469d8c0079dbf496ab86e22e1cb7c
> change-id: 20230628-mtk-usb-bf0059f64bd7
> 
> Best regards,
