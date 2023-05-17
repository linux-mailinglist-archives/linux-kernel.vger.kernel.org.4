Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349B7705F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjEQFZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjEQFZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428C3C0C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684301088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ld8tmuZ729IEP2VIgrvdSghTu7kmfTWaYV5mzTpbirM=;
        b=GGuMtV9m3zl3sO0UFMB4eXiMWoZd8pMpN7wDfdRB1AmMNYv7i4VhIU2juleQWhyOxcp3mT
        AAGXxI0D6NhHkB+SO8J003KHMswQ5UbyxJxm9VSJodEW9rI1+W/w9Wr5IZmkCq2JaN86AC
        Wi3TnqhZd6gAMWRZuzXBVoVveboBtaI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-5FnhgUVNNfet1_nOsFS5xg-1; Wed, 17 May 2023 01:24:46 -0400
X-MC-Unique: 5FnhgUVNNfet1_nOsFS5xg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ac79d95000so1034471fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301085; x=1686893085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld8tmuZ729IEP2VIgrvdSghTu7kmfTWaYV5mzTpbirM=;
        b=MBBFsgfa8oYyKw7Czs2BiiR1h/tmoIaytuP7tTFwKSyagCjdXjCl0ZX0IfiVllgNie
         uZ4PMqdkTNwUX45Ra7eaNvWiJwP/YkCWZD+Nd0n/J/q2fyyMkFparc7mrcSYeg3KKkGT
         9VsFu8TioCgPCgtZJUEKs4IO6U6+3yC0+gKqdzo3rhM0+B2La4LlIRpuZVkgmNtiOV8S
         VZFAwmDotzHF8M+kMtGaM6NQaHtb5u49RrZd8iacvwRrMiP2rWM0XBj8Tw93pwWGVnc+
         neTowkwEmy7DIuV51HWphRdOiE/XmFI8K0qQm2YYndJH1wlZ72QrX0HFqaDY+5XblM8B
         aOnA==
X-Gm-Message-State: AC+VfDxUa3ld5ggX6ogu9gYJA7puLgevFChvxMWByVyMc0nO3kzP7zZx
        7ZGmCXbwtERuG+JUN2brviRfaEXtupYNu5YAImslyfHLlIgd3oqVeFru6OsMoG6Cce+vS2WgkY5
        PICbFXSy/CXv+AuqbDg2xDytJTVQqQcMUki0Qy+JW
X-Received: by 2002:a2e:3808:0:b0:2ae:fee9:a810 with SMTP id f8-20020a2e3808000000b002aefee9a810mr1239973lja.51.1684301085091;
        Tue, 16 May 2023 22:24:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59rFW7HF/JG6U0/d+y3LDNIVqhrWaclO8AcXy6Uwk1agT7OM69OQsqAM4t1kZ9cE0wYr2qX2iGWXCKPbv/XYE=
X-Received: by 2002:a2e:3808:0:b0:2ae:fee9:a810 with SMTP id
 f8-20020a2e3808000000b002aefee9a810mr1239966lja.51.1684301084781; Tue, 16 May
 2023 22:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230516095800.3549932-1-dtatulea@nvidia.com>
In-Reply-To: <20230516095800.3549932-1-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 17 May 2023 13:24:33 +0800
Message-ID: <CACGkMEv7yFgaGHx_W_JE55ou=2orv+jH-wY4id14bhYARKTUkw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix hang when cvq commands are triggered
 during device unregister
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eli Cohen <elic@nvidia.com>, gal@nvidia.com, tariqt@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:58=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Currently the vdpa device is unregistered after the workqueue that
> processes vq commands is disabled. However, the device unregister
> process can still send commands to the cvq (a vlan delete for example)
> which leads to a hang because the handing workqueue has been disabled
> and the command never finishes:
>
>  [ 2263.095764] rcu: INFO: rcu_sched self-detected stall on CPU
>  [ 2263.096307] rcu:        9-....: (5250 ticks this GP) idle=3Ddac4/1/0x=
4000000000000000 softirq=3D111009/111009 fqs=3D2544
>  [ 2263.097154] rcu:        (t=3D5251 jiffies g=3D393549 q=3D347 ncpus=3D=
10)
>  [ 2263.097648] CPU: 9 PID: 94300 Comm: kworker/u20:2 Not tainted 6.3.0-r=
c6_for_upstream_min_debug_2023_04_14_00_02 #1
>  [ 2263.098535] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  [ 2263.099481] Workqueue: mlx5_events mlx5_vhca_state_work_handler [mlx5=
_core]
>  [ 2263.100143] RIP: 0010:virtnet_send_command+0x109/0x170
>  [ 2263.100621] Code: 1d df f5 ff 85 c0 78 5c 48 8b 7b 08 e8 d0 c5 f5 ff =
84 c0 75 11 eb 22 48 8b 7b 08 e8 01 b7 f5 ff 84 c0 75 15 f3 90 48 8b 7b 08 =
<48> 8d 74 24 04 e8 8d c5 f5 ff 48 85 c0 74 de 48 8b 83 f8 00 00 00
>  [ 2263.102148] RSP: 0018:ffff888139cf36e8 EFLAGS: 00000246
>  [ 2263.102624] RAX: 0000000000000000 RBX: ffff888166bea940 RCX: 00000000=
00000001
>  [ 2263.103244] RDX: 0000000000000000 RSI: ffff888139cf36ec RDI: ffff8881=
46763800
>  [ 2263.103864] RBP: ffff888139cf3710 R08: ffff88810d201000 R09: 00000000=
00000000
>  [ 2263.104473] R10: 0000000000000002 R11: 0000000000000003 R12: 00000000=
00000002
>  [ 2263.105082] R13: 0000000000000002 R14: ffff888114528400 R15: ffff8881=
66bea000
>  [ 2263.105689] FS:  0000000000000000(0000) GS:ffff88852cc80000(0000) knl=
GS:0000000000000000
>  [ 2263.106404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  [ 2263.106925] CR2: 00007f31f394b000 CR3: 000000010615b006 CR4: 00000000=
00370ea0
>  [ 2263.107542] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
>  [ 2263.108163] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
>  [ 2263.108769] Call Trace:
>  [ 2263.109059]  <TASK>
>  [ 2263.109320]  ? check_preempt_wakeup+0x11f/0x230
>  [ 2263.109750]  virtnet_vlan_rx_kill_vid+0x5a/0xa0
>  [ 2263.110180]  vlan_vid_del+0x9c/0x170
>  [ 2263.110546]  vlan_device_event+0x351/0x760 [8021q]
>  [ 2263.111004]  raw_notifier_call_chain+0x41/0x60
>  [ 2263.111426]  dev_close_many+0xcb/0x120
>  [ 2263.111808]  unregister_netdevice_many_notify+0x130/0x770
>  [ 2263.112297]  ? wq_worker_running+0xa/0x30
>  [ 2263.112688]  unregister_netdevice_queue+0x89/0xc0
>  [ 2263.113128]  unregister_netdev+0x18/0x20
>  [ 2263.113512]  virtnet_remove+0x4f/0x230
>  [ 2263.113885]  virtio_dev_remove+0x31/0x70
>  [ 2263.114273]  device_release_driver_internal+0x18f/0x1f0
>  [ 2263.114746]  bus_remove_device+0xc6/0x130
>  [ 2263.115146]  device_del+0x173/0x3c0
>  [ 2263.115502]  ? kernfs_find_ns+0x35/0xd0
>  [ 2263.115895]  device_unregister+0x1a/0x60
>  [ 2263.116279]  unregister_virtio_device+0x11/0x20
>  [ 2263.116706]  device_release_driver_internal+0x18f/0x1f0
>  [ 2263.117182]  bus_remove_device+0xc6/0x130
>  [ 2263.117576]  device_del+0x173/0x3c0
>  [ 2263.117929]  ? vdpa_dev_remove+0x20/0x20 [vdpa]
>  [ 2263.118364]  device_unregister+0x1a/0x60
>  [ 2263.118752]  mlx5_vdpa_dev_del+0x4c/0x80 [mlx5_vdpa]
>  [ 2263.119232]  vdpa_match_remove+0x21/0x30 [vdpa]
>  [ 2263.119663]  bus_for_each_dev+0x71/0xc0
>  [ 2263.120054]  vdpa_mgmtdev_unregister+0x57/0x70 [vdpa]
>  [ 2263.120520]  mlx5v_remove+0x12/0x20 [mlx5_vdpa]
>  [ 2263.120953]  auxiliary_bus_remove+0x18/0x30
>  [ 2263.121356]  device_release_driver_internal+0x18f/0x1f0
>  [ 2263.121830]  bus_remove_device+0xc6/0x130
>  [ 2263.122223]  device_del+0x173/0x3c0
>  [ 2263.122581]  ? devl_param_driverinit_value_get+0x29/0x90
>  [ 2263.123070]  mlx5_rescan_drivers_locked+0xc4/0x2d0 [mlx5_core]
>  [ 2263.123633]  mlx5_unregister_device+0x54/0x80 [mlx5_core]
>  [ 2263.124169]  mlx5_uninit_one+0x54/0x150 [mlx5_core]
>  [ 2263.124656]  mlx5_sf_dev_remove+0x45/0x90 [mlx5_core]
>  [ 2263.125153]  auxiliary_bus_remove+0x18/0x30
>  [ 2263.125560]  device_release_driver_internal+0x18f/0x1f0
>  [ 2263.126052]  bus_remove_device+0xc6/0x130
>  [ 2263.126451]  device_del+0x173/0x3c0
>  [ 2263.126815]  mlx5_sf_dev_remove+0x39/0xf0 [mlx5_core]
>  [ 2263.127318]  mlx5_sf_dev_state_change_handler+0x178/0x270 [mlx5_core]
>  [ 2263.127920]  blocking_notifier_call_chain+0x5a/0x80
>  [ 2263.128379]  mlx5_vhca_state_work_handler+0x151/0x200 [mlx5_core]
>  [ 2263.128951]  process_one_work+0x1bb/0x3c0
>  [ 2263.129355]  ? process_one_work+0x3c0/0x3c0
>  [ 2263.129766]  worker_thread+0x4d/0x3c0
>  [ 2263.130140]  ? process_one_work+0x3c0/0x3c0
>  [ 2263.130548]  kthread+0xb9/0xe0
>  [ 2263.130895]  ? kthread_complete_and_exit+0x20/0x20
>  [ 2263.131349]  ret_from_fork+0x1f/0x30
>  [ 2263.131717]  </TASK>
>
> The fix is to disable and destroy the workqueue after the device
> unregister. It is expected that vhost will not trigger kicks after
> the unregister. But even if it would, the wq is disabled already by
> setting the pointer to NULL (done so in the referenced commit).
>
> Fixes: ad6dc1daaf29 ("vdpa/mlx5: Avoid processing works if workqueue was =
destroyed")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e29e32b306ad..279ac6a558d2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3349,10 +3349,10 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
>         mlx5_vdpa_remove_debugfs(ndev->debugfs);
>         ndev->debugfs =3D NULL;
>         unregister_link_notifier(ndev);
> +       _vdpa_unregister_device(dev);
>         wq =3D mvdev->wq;
>         mvdev->wq =3D NULL;
>         destroy_workqueue(wq);
> -       _vdpa_unregister_device(dev);
>         mgtdev->ndev =3D NULL;
>  }
>
> --
> 2.40.1
>

