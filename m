Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDB6DFB88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDLQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:40:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBB6591;
        Wed, 12 Apr 2023 09:40:31 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:c2e:89bd:4b8e:9e98] (unknown [IPv6:2a01:e0a:120:3210:c2e:89bd:4b8e:9e98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C05F6600011;
        Wed, 12 Apr 2023 17:40:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681317630;
        bh=40qgncWMpJsImu8j0tyhlnqKuv6wj7h9AE86nzJygBA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YaQluPs3x1r3u84B59FyzTXFEKPsgHQq9czz2coLTcYajkhQgynleX1zKc007kNkS
         fFMLBiS2aFwHzslouRSkP/MTbqGoX8sTw4rBYXMObG1kGsgasxIT1kcEcgnFFn1Ngz
         jTAlQZbXwUZ9xPpwK+JBw1W7bZKvuejbMCFNOrrUnAQDbqxlLVLElp1ZXQOyz99d0U
         k+78I2sjCJSoViEdoUBFpyt2l35wn8D0HNyhTHj7Kzy/GMjBN5GoCY0ymHohYiqoai
         ip14c/F2CUtxCMelMnhB/z4wrlbAT7BYq5ZLwFsVGyfFPiKKVrl21omGv03Ba62nij
         dO5Fte/m+BP3w==
Content-Type: multipart/mixed; boundary="------------0Rh70bg2G8NwMJJ0e06mZwQC"
Message-ID: <a0a00172-ce86-dfa2-267d-b318a9c076dc@collabora.com>
Date:   Wed, 12 Apr 2023 18:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 1/6] media: verisilicon: Do not set context src/dst
 formats in reset functions
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk,
        robert.mader@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
 <20230220104849.398203-2-benjamin.gaignard@collabora.com>
 <CGME20230412161415eucas1p1536b537c3f866e9820d3bea8bb9ea2d9@eucas1p1.samsung.com>
 <5fda9b2f-a339-8a23-dc7b-f1bac2c385b6@samsung.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <5fda9b2f-a339-8a23-dc7b-f1bac2c385b6@samsung.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0Rh70bg2G8NwMJJ0e06mZwQC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 12/04/2023 à 18:14, Marek Szyprowski a écrit :
> Hi,
>
> On 20.02.2023 11:48, Benjamin Gaignard wrote:
>> Setting context source and destination formats should only be done
>> in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
>> the targeted queue is not busy.
>> Remove these calls from hantro_reset_encoded_fmt() and
>> hantro_reset_raw_fmt() to clean the driver.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> This patch landed recently in linux-next as commit db6f68b51e5c ("media:
> verisilicon: Do not set context src/dst formats in reset functions").

Hi,

I do not have this board up and running with Hantro encoder but
I think the attached patch may solve the issue.
Could you tell me if it works ?

Regards,
Benjamin

>
> Unfortunately it causes the following regression during Debian boot on
> Odroid-M1 board:
>
> --->8---
>
> hantro-vpu fdea0000.video-codec: Adding to iommu group 0
> hantro-vpu fdea0000.video-codec: registered rockchip,rk3568-vpu-dec as
> /dev/video0
> hantro-vpu fdee0000.video-codec: Adding to iommu group 1
> hantro-vpu fdee0000.video-codec: registered rockchip,rk3568-vepu-enc as
> /dev/video1
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000008
> Mem abort info:
>     ESR = 0x0000000096000004
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x04: level 0 translation fault
> Data abort info:
>     ISV = 0, ISS = 0x00000004
>     CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=00000001f446f000
> [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in: hantro_vpu v4l2_vp9 v4l2_h264 v4l2_mem2mem
> videobuf2_dma_contig snd_soc_simple_card display_connector
> snd_soc_simple_card_utils videobuf2_memops crct10dif_ce dwmac_rk
> rockchip_thermal videobuf2_v4l2 stmmac_platform rockchip_saradc
> industrialio_triggered_buffer kfifo_buf stmmac videodev pcs_xpcs
> rtc_rk808 videobuf2_common rockchipdrm panfrost mc drm_shmem_helper
> analogix_dp gpu_sched dw_mipi_dsi dw_hdmi drm_display_helper ip_tables
> x_tables ipv6
> CPU: 3 PID: 171 Comm: v4l_id Not tainted 6.3.0-rc2+ #13478
> Hardware name: Hardkernel ODROID-M1 (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : hantro_try_fmt+0xb4/0x280 [hantro_vpu]
> lr : hantro_try_fmt+0xa8/0x280 [hantro_vpu]
> ...
> Call trace:
>    hantro_try_fmt+0xb4/0x280 [hantro_vpu]
>    hantro_set_fmt_out+0x3c/0x278 [hantro_vpu]
>    hantro_reset_raw_fmt+0x94/0xb4 [hantro_vpu]
>    hantro_set_fmt_cap+0x23c/0x250 [hantro_vpu]
>    hantro_reset_fmts+0x94/0xcc [hantro_vpu]
>    hantro_open+0xd4/0x20c [hantro_vpu]
>    v4l2_open+0x80/0x120 [videodev]
>    chrdev_open+0xc0/0x22c
>    do_dentry_open+0x13c/0x490
>    vfs_open+0x2c/0x38
>    path_openat+0x550/0x938
>    do_filp_open+0x80/0x12c
>    do_sys_openat2+0xb4/0x16c
>    __arm64_sys_openat+0x64/0xac
>    invoke_syscall+0x48/0x114
>    el0_svc_common.constprop.0+0xfc/0x11c
>    do_el0_svc+0x38/0xa4
>    el0_svc+0x48/0xb8
>    el0t_64_sync_handler+0xb8/0xbc
>    el0t_64_sync+0x190/0x194
> Code: 97fe726c f940aa80 52864a61 72a686c1 (b9400800)
> ---[ end trace 0000000000000000 ]---
>
> I know that v4l_id tool, which is a part of systemd/udev, is known to
> crash badly on various vendor kernels (fixing this would be a really
> hard, especially assuming the brokenness of some vendor hacks), but I
> hoped that at least it should not be able to crash the mainline kernel.
>
>
>> ---
>>    drivers/media/platform/verisilicon/hantro_v4l2.c | 9 ++-------
>>    1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index c0d427956210..d8aa42bd4cd4 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -382,13 +382,10 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>>    
>>    	vpu_fmt = hantro_get_default_fmt(ctx, true);
>>    
>> -	if (ctx->is_encoder) {
>> -		ctx->vpu_dst_fmt = vpu_fmt;
>> +	if (ctx->is_encoder)
>>    		fmt = &ctx->dst_fmt;
>> -	} else {
>> -		ctx->vpu_src_fmt = vpu_fmt;
>> +	else
>>    		fmt = &ctx->src_fmt;
>> -	}
>>    
>>    	hantro_reset_fmt(fmt, vpu_fmt);
>>    	fmt->width = vpu_fmt->frmsize.min_width;
>> @@ -408,11 +405,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>>    	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
>>    
>>    	if (ctx->is_encoder) {
>> -		ctx->vpu_src_fmt = raw_vpu_fmt;
>>    		raw_fmt = &ctx->src_fmt;
>>    		encoded_fmt = &ctx->dst_fmt;
>>    	} else {
>> -		ctx->vpu_dst_fmt = raw_vpu_fmt;
>>    		raw_fmt = &ctx->dst_fmt;
>>    		encoded_fmt = &ctx->src_fmt;
>>    	}
> Best regards
--------------0Rh70bg2G8NwMJJ0e06mZwQC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-media-verisilicon-Fix-crash-when-probing-encoder.patch"
Content-Disposition: attachment;
 filename*0="0001-media-verisilicon-Fix-crash-when-probing-encoder.patch"
Content-Transfer-Encoding: base64

RnJvbSBjNjAxY2NjOWI5OGEzZjczNTQ5M2ZhZjg0ODdkYmZhNTllYzRlMGM2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2Fp
Z25hcmRAY29sbGFib3JhLmNvbT4KRGF0ZTogV2VkLCAxMiBBcHIgMjAyMyAxODozODoyOSAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIG1lZGlhOiB2ZXJpc2lsaWNvbjogRml4IGNyYXNoIHdo
ZW4gcHJvYmluZyBlbmNvZGVyCgpjdHgtPnZwdV9kc3RfZm10IGlzIG5vIG1vcmUgaW5pdGlh
bGl6ZWQgYmVmb3JlIGNhbGxpbmcgaGFudHJvX3RyeV9mbXQoKQpUaGlzIGxlZCB0byBjcmFz
aCB0aGUga2VybmVsLgoKU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmph
bWluLmdhaWduYXJkQGNvbGxhYm9yYS5jb20+CkZpeGVzOiBkYjZmNjhiNTFlNWMgKCJtZWRp
YTogdmVyaXNpbGljb246IERvIG5vdCBzZXQgY29udGV4dCBzcmMvZHN0IGZvcm1hdHMgaW4g
cmVzZXQgZnVuY3Rpb25zIikKLS0tCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3ZlcmlzaWxp
Y29uL2hhbnRyb192NGwyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L3ZlcmlzaWxpY29uL2hhbnRyb192NGwyLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Zl
cmlzaWxpY29uL2hhbnRyb192NGwyLmMKaW5kZXggOGYxNDE0MDg1ZjQ3Li5lOGJjYjZkNjY5
ZmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vdmVyaXNpbGljb24vaGFu
dHJvX3Y0bDIuYworKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3ZlcmlzaWxpY29uL2hh
bnRyb192NGwyLmMKQEAgLTI5Nyw3ICsyOTcsNyBAQCBzdGF0aWMgaW50IGhhbnRyb190cnlf
Zm10KGNvbnN0IHN0cnVjdCBoYW50cm9fY3R4ICpjdHgsCiAJCXBpeF9tcC0+bnVtX3BsYW5l
cyA9IDE7CiAJCXZwdV9mbXQgPSBmbXQ7CiAJfSBlbHNlIGlmIChjdHgtPmlzX2VuY29kZXIp
IHsKLQkJdnB1X2ZtdCA9IGN0eC0+dnB1X2RzdF9mbXQ7CisJCXZwdV9mbXQgPSBmbXQ7CiAJ
fSBlbHNlIHsKIAkJdnB1X2ZtdCA9IGZtdDsKIAkJLyoKLS0gCjIuMzQuMQoK

--------------0Rh70bg2G8NwMJJ0e06mZwQC--
