Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA7687708
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBBIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjBBIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:11:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6D83046
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675325469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=koplqrntkLjPB1KzIcxFp5x+kj7R11BTgw7ju3ozL2Y=;
        b=dKtOJ3jP0rofD8a/Ma9Ms93d0+XWIo1h37qgCNd7zE4/hgdCQqcgsdzpHI29Lfu5x1hTRK
        20z2qojd/QvPJrCcNn24EVeqOWnEtOyKzkL5fA9p+IcTdcc82M273lS3V8qYibnq5cm+3N
        +oB8kOpvZxtHEfsI6PfHLF5Ab6QaFnc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-sOZbGrbgOr-3KPbhWcNWYw-1; Thu, 02 Feb 2023 03:11:07 -0500
X-MC-Unique: sOZbGrbgOr-3KPbhWcNWYw-1
Received: by mail-ej1-f70.google.com with SMTP id ud13-20020a170907c60d00b0088d773d11d6so999907ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koplqrntkLjPB1KzIcxFp5x+kj7R11BTgw7ju3ozL2Y=;
        b=bv60tRhM8KrADlUGGgChISM96WuxTxiqIR+hyEwtwP0dfoBatcfewuWylHlBWcwSzj
         F9frobGeozXsFrhvkr92l8tAYu6fW9Py+vxLi4FVm9vVWLbvIyA46MW8R2zZZ9e/nfHm
         U6bpsW+M/L3n2a8+DtZdNTn4ieLbNTBXLbnjeqM3KrHYllUwp5X5QWk2EOJT7iWXWCEv
         MAACUtxJ+G7zngwvZkSpFkaMgdAy+3Spg07LKPUXYdUuLEm5+2uhRDJGPFCKGk/yl6gD
         S5+8SmpF55aY8QfUbA5MXF7qWF4M2t3vb+ep/4EbZjEIADg3HzWMFOefKllvpZhCq2hX
         xKSA==
X-Gm-Message-State: AO0yUKVVl1jMzRWl544pg2xlGT6yJQGnnkAuBoB6w2QVaLRjjtp7LeUG
        JrpDITV1wfaDnlYCH9ah+0gRPpSgjA2vxNfo3N06M1gFKxKwOMz95pDoUh4c/3bHY0jMFY9LCuL
        uHMZfZYsBfo+WJ3D6bVK5Vqj+
X-Received: by 2002:a17:906:b15:b0:889:daeb:5532 with SMTP id u21-20020a1709060b1500b00889daeb5532mr5861899ejg.47.1675325466506;
        Thu, 02 Feb 2023 00:11:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+t28mj6ticykjlaxK4mIeRoJ02yP1EXe2P+SWqmDUic31bRqGhk7gyjp5QejY4L/7ns4xBOw==
X-Received: by 2002:a17:906:b15:b0:889:daeb:5532 with SMTP id u21-20020a1709060b1500b00889daeb5532mr5861885ejg.47.1675325466243;
        Thu, 02 Feb 2023 00:11:06 -0800 (PST)
Received: from [10.39.192.164] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b0087223b8d6efsm11416613ejj.16.2023.02.02.00.11.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:11:05 -0800 (PST)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: openvswitch: fix flow memory leak in
 ovs_flow_cmd_new
Date:   Thu, 02 Feb 2023 09:11:04 +0100
X-Mailer: MailMate (1.14r5939)
Message-ID: <4331E34B-4237-48D0-B4E0-016E45176FD1@redhat.com>
In-Reply-To: <20230201210218.361970-1-pchelkin@ispras.ru>
References: <20230201210218.361970-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 Feb 2023, at 22:02, Fedor Pchelkin wrote:

> Syzkaller reports a memory leak of new_flow in ovs_flow_cmd_new() as it=
 is
> not freed when an allocation of a key fails.
>
> BUG: memory leak
> unreferenced object 0xffff888116668000 (size 632):
>   comm "syz-executor231", pid 1090, jiffies 4294844701 (age 18.871s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000defa3494>] kmem_cache_zalloc include/linux/slab.h:654 [in=
line]
>     [<00000000defa3494>] ovs_flow_alloc+0x19/0x180 net/openvswitch/flow=
_table.c:77
>     [<00000000c67d8873>] ovs_flow_cmd_new+0x1de/0xd40 net/openvswitch/d=
atapath.c:957
>     [<0000000010a539a8>] genl_family_rcv_msg_doit+0x22d/0x330 net/netli=
nk/genetlink.c:739
>     [<00000000dff3302d>] genl_family_rcv_msg net/netlink/genetlink.c:78=
3 [inline]
>     [<00000000dff3302d>] genl_rcv_msg+0x328/0x590 net/netlink/genetlink=
=2Ec:800
>     [<000000000286dd87>] netlink_rcv_skb+0x153/0x430 net/netlink/af_net=
link.c:2515
>     [<0000000061fed410>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:811=

>     [<000000009dc0f111>] netlink_unicast_kernel net/netlink/af_netlink.=
c:1313 [inline]
>     [<000000009dc0f111>] netlink_unicast+0x545/0x7f0 net/netlink/af_net=
link.c:1339
>     [<000000004a5ee816>] netlink_sendmsg+0x8e7/0xde0 net/netlink/af_net=
link.c:1934
>     [<00000000482b476f>] sock_sendmsg_nosec net/socket.c:651 [inline]
>     [<00000000482b476f>] sock_sendmsg+0x152/0x190 net/socket.c:671
>     [<00000000698574ba>] ____sys_sendmsg+0x70a/0x870 net/socket.c:2356
>     [<00000000d28d9e11>] ___sys_sendmsg+0xf3/0x170 net/socket.c:2410
>     [<0000000083ba9120>] __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
>     [<00000000c00628f8>] do_syscall_64+0x30/0x40 arch/x86/entry/common.=
c:46
>     [<000000004abfdcf4>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>
> To fix this the patch rearranges the goto labels to reflect the order o=
f
> object allocations and adds appropriate goto statements on the error
> paths.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: 68bb10101e6b ("openvswitch: Fix flow lookup to use unmasked key"=
)
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
> v1->v2: make goto statements structured

Thanks for fixing this, the changes look good.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


>  net/openvswitch/datapath.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index a71795355aec..fcee6012293b 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -1004,14 +1004,14 @@ static int ovs_flow_cmd_new(struct sk_buff *skb=
, struct genl_info *info)
>  	key =3D kzalloc(sizeof(*key), GFP_KERNEL);
>  	if (!key) {
>  		error =3D -ENOMEM;
> -		goto err_kfree_key;
> +		goto err_kfree_flow;
>  	}
>
>  	ovs_match_init(&match, key, false, &mask);
>  	error =3D ovs_nla_get_match(net, &match, a[OVS_FLOW_ATTR_KEY],
>  				  a[OVS_FLOW_ATTR_MASK], log);
>  	if (error)
> -		goto err_kfree_flow;
> +		goto err_kfree_key;
>
>  	ovs_flow_mask_key(&new_flow->key, key, true, &mask);
>
> @@ -1019,14 +1019,14 @@ static int ovs_flow_cmd_new(struct sk_buff *skb=
, struct genl_info *info)
>  	error =3D ovs_nla_get_identifier(&new_flow->id, a[OVS_FLOW_ATTR_UFID]=
,
>  				       key, log);
>  	if (error)
> -		goto err_kfree_flow;
> +		goto err_kfree_key;
>
>  	/* Validate actions. */
>  	error =3D ovs_nla_copy_actions(net, a[OVS_FLOW_ATTR_ACTIONS],
>  				     &new_flow->key, &acts, log);
>  	if (error) {
>  		OVS_NLERR(log, "Flow actions may not be safe on all matching packets=
=2E");
> -		goto err_kfree_flow;
> +		goto err_kfree_key;
>  	}
>
>  	reply =3D ovs_flow_cmd_alloc_info(acts, &new_flow->id, info, false,
> @@ -1126,10 +1126,10 @@ static int ovs_flow_cmd_new(struct sk_buff *skb=
, struct genl_info *info)
>  	kfree_skb(reply);
>  err_kfree_acts:
>  	ovs_nla_free_flow_actions(acts);
> -err_kfree_flow:
> -	ovs_flow_free(new_flow, false);
>  err_kfree_key:
>  	kfree(key);
> +err_kfree_flow:
> +	ovs_flow_free(new_flow, false);
>  error:
>  	return error;
>  }
> -- =

> 2.30.2

