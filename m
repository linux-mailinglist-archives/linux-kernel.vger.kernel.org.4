Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0773CF44
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFYIUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFYIUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:20:19 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27CE5D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:20:18 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b5d7e60015so2167171a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687681217; x=1690273217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SncSEci6+SesIAIMEYA4eNkEhCr2FK9DrSWSZFeKfe4=;
        b=a5tY3RY26HRwlV8IKq3gVk1hKl2Q6QMrQzMGhW7L8KT9RFxsrQq8s+xzruEvEToCZi
         IU0KV9qiFpPUIW9iWnyckVNZ9PFfIHTJIWMswp1Acz2thTxVnSyj/09TnPPQvbSKo3wW
         8M5XeiEn6G8RNPVq7OVJ4ZnkhMwdpQ6urK5A3euPIkTmcdVgm2pEp4xDYyrz++1fV3fd
         ba38lf3gaHtRxQpay5pkOTn3btb3o73lu5Kt85lik7kx0sp5yfsb79OYP1MXC44ECx5k
         KoK9xVVjhyFF01cK6+xilKlgU17ivsC3TFHydPCnrEmii6QU6RzpxWhMJCOOF9YqT1Cv
         Y1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687681217; x=1690273217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SncSEci6+SesIAIMEYA4eNkEhCr2FK9DrSWSZFeKfe4=;
        b=HAsfuisfHtsRZmcOpgMBevM93Xv19yKYYRlVCXZaLSc49rPPulVGVJMBCFCR6Ak2re
         rY+9CYaihRBWv61GvuGOKl3SwxfWN6DqOMJ3PbFfyzxWFs06tH772xpzwYfbulZpC+v7
         YMDfU1cqOStRVtv+Hp3/sTiylXHLJP/kEDy5SvQaBieaGagAhqIkkEhTNXJbPUeMv2q3
         5vBtoC8fPUFKOKy0My5xUJbPbPzfQnEio88FAYtSpgASde42/++6GdG2ceTOutbpG+y9
         cxHvD2YFS1QtiLTahtQp0yC/dcT25eOLcK4XKfIEqpwTqIAKMEQN8z3AFiPZXJQk4wxD
         daqg==
X-Gm-Message-State: AC+VfDxgpgIACrX5aXjAh8Pon6ffd0WXxCi2fiOM79WJOdNnOOw+s9JO
        YRVjEIo9YerOyfiGvRuz8Om6D18qd5XvBOELefUr
X-Google-Smtp-Source: ACHHUZ4r11svxeTIabfPHioDJasKL3uubG3aMXep7DOh9vzwkRbrhIDQLtmzHatWDBukN0UTt3SITCOeqyeaBiLaBuE=
X-Received: by 2002:a05:6808:5da:b0:3a0:58df:58fb with SMTP id
 d26-20020a05680805da00b003a058df58fbmr11598201oij.39.1687681217581; Sun, 25
 Jun 2023 01:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230622204851.318125-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230622204851.318125-1-maxime.coquelin@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 25 Jun 2023 16:20:06 +0800
Message-ID: <CACycT3vdXymF=Hy6pDqZCspA_0o=UDhoB6yzXSpA4M0NvO66+A@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: fix NULL pointer dereference
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Sheng Zhao <sheng.zhao@bytedance.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 4:49=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> vduse_vdpa_set_vq_affinity callback can be called
> with NULL value as cpu_mask when deleting the vduse
> device.
>
> This patch resets virtqueue's IRQ affinity mask value
> to set all CPUs instead of dereferencing NULL cpu_mask.
>
> [ 4760.952149] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [ 4760.959110] #PF: supervisor read access in kernel mode
> [ 4760.964247] #PF: error_code(0x0000) - not-present page
> [ 4760.969385] PGD 0 P4D 0
> [ 4760.971927] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 4760.976112] CPU: 13 PID: 2346 Comm: vdpa Not tainted 6.4.0-rc6+ #4
> [ 4760.982291] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 2.8.1=
 06/26/2020
> [ 4760.989769] RIP: 0010:memcpy_orig+0xc5/0x130
> [ 4760.994049] Code: 16 f8 4c 89 07 4c 89 4f 08 4c 89 54 17 f0 4c 89 5c 1=
7 f8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 fa 08 72 1b <=
4c> 8b 06 4c 8b 4c 16 f8 4c 89 07 4c 89 4c 17 f8 c3 cc cc cc cc 66
> [ 4761.012793] RSP: 0018:ffffb1d565abb830 EFLAGS: 00010246
> [ 4761.018020] RAX: ffff9f4bf6b27898 RBX: ffff9f4be23969c0 RCX: ffff9f4bc=
adf6400
> [ 4761.025152] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff9f4bf=
6b27898
> [ 4761.032286] RBP: 0000000000000000 R08: 0000000000000008 R09: 000000000=
0000000
> [ 4761.039416] R10: 0000000000000000 R11: 0000000000000600 R12: 000000000=
0000000
> [ 4761.046549] R13: 0000000000000000 R14: 0000000000000080 R15: ffffb1d56=
5abbb10
> [ 4761.053680] FS:  00007f64c2ec2740(0000) GS:ffff9f635f980000(0000) knlG=
S:0000000000000000
> [ 4761.061765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4761.067513] CR2: 0000000000000000 CR3: 0000001875270006 CR4: 000000000=
07706e0
> [ 4761.074645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 4761.081775] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 4761.088909] PKRU: 55555554
> [ 4761.091620] Call Trace:
> [ 4761.094074]  <TASK>
> [ 4761.096180]  ? __die+0x1f/0x70
> [ 4761.099238]  ? page_fault_oops+0x171/0x4f0
> [ 4761.103340]  ? exc_page_fault+0x7b/0x180
> [ 4761.107265]  ? asm_exc_page_fault+0x22/0x30
> [ 4761.111460]  ? memcpy_orig+0xc5/0x130
> [ 4761.115126]  vduse_vdpa_set_vq_affinity+0x3e/0x50 [vduse]
> [ 4761.120533]  virtnet_clean_affinity.part.0+0x3d/0x90 [virtio_net]
> [ 4761.126635]  remove_vq_common+0x1a4/0x250 [virtio_net]
> [ 4761.131781]  virtnet_remove+0x5d/0x70 [virtio_net]
> [ 4761.136580]  virtio_dev_remove+0x3a/0x90
> [ 4761.140509]  device_release_driver_internal+0x19b/0x200
> [ 4761.145742]  bus_remove_device+0xc2/0x130
> [ 4761.149755]  device_del+0x158/0x3e0
> [ 4761.153245]  ? kernfs_find_ns+0x35/0xc0
> [ 4761.157086]  device_unregister+0x13/0x60
> [ 4761.161010]  unregister_virtio_device+0x11/0x20
> [ 4761.165543]  device_release_driver_internal+0x19b/0x200
> [ 4761.170770]  bus_remove_device+0xc2/0x130
> [ 4761.174782]  device_del+0x158/0x3e0
> [ 4761.178276]  ? __pfx_vdpa_name_match+0x10/0x10 [vdpa]
> [ 4761.183336]  device_unregister+0x13/0x60
> [ 4761.187260]  vdpa_nl_cmd_dev_del_set_doit+0x63/0xe0 [vdpa]
>
> Fixes: 28f6288eb63d ("vduse: Support set_vq_affinity callback")
> Cc: xieyongji@bytedance.com
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
