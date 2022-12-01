Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD963FA56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLAWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiLAWMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:12:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2195C4619
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:12:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id td2so7540406ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xS2P4l3h67FXA/VaxZNf4GYyU7HMjaYo9LN5Y0vNp+c=;
        b=4j5NUQ9QdJc57qk824L+vXNEARliSp3Y2YM09ia9uXfX+4XV1Y3dOzHw+peBOIsPfw
         oqFKaK35oDA1QKOIS8ON/8sZHuQNyec1tsHa8sjWvizzo7OOA83WPtK8WX3lRt3sU+mv
         4ELV0XJuB3DVbDsmeQAJRkxQKOO5yIUxYThPpQH+kGvkf7wB0MEMrwHthDE1FC38VE14
         pF/cc7T2DxJ34QccGCvIaaJxm4pqWdQTCEguW5j86I1nuF/7AubfyTV0Pa3wMYAkb78+
         adEXWqVpLrlGYlK8fSqehtZLAYHhrrN0LDwzyLZJmgQ3xWT43Jb4/dO0SroCLGoFCtnk
         wLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xS2P4l3h67FXA/VaxZNf4GYyU7HMjaYo9LN5Y0vNp+c=;
        b=qjbuMO2N6PQd9Ud+s7qP4D6IJj+s0PgsH88YEG2NnZcRpewbYyC9xyhzwEbBe8866+
         Zx5umS3abpkWH03n8Z3csfF7MDSE/0FAnBGtiwgMOq8JiNp0j/3xxisenzwpaInOPXhR
         5NafrzVGGTE1vX53x0J2xR328qQjjJUVi7G40mk3AZ2HIwALkgk0ogKZ2eVeJgtM0DRG
         v/KHAAtFOUV/Qq6qBtVV3ZGXHh8Cey/h9Gxut6mDb3LyZOS4kVIErPuzsBssiKvXFkqe
         HaL3JH1oASqnl+jqv0+aFh28pxfxEy0cMjovbcznzCemaZGE07OrOHoBXxI4VMvZIGNu
         D61w==
X-Gm-Message-State: ANoB5pkJpZCUyaBVHoPJkNm6WzD5I49yWG47RZUOSVLwILJBlXFkCjtN
        NgllhmGCLMHqskwylmW7eMKH3Q==
X-Google-Smtp-Source: AA0mqf6UzOvVeGPxnQxjxwIH4JOjFC003wnQEu5aMFSrUpWtBcU4R6aGxTPaBPL2zLpN5i1c9/Hk2g==
X-Received: by 2002:a17:906:ce4d:b0:7be:1b8b:21fc with SMTP id se13-20020a170906ce4d00b007be1b8b21fcmr23250111ejb.666.1669932725308;
        Thu, 01 Dec 2022 14:12:05 -0800 (PST)
Received: from localhost.localdomain (46-133-148-166.mobile.vf-ua.net. [46.133.148.166])
        by smtp.gmail.com with ESMTPSA id gf16-20020a170906e21000b007815ca7ae57sm2230726ejb.212.2022.12.01.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:12:04 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     devel@daynix.com
Subject: [PATCH v4 0/6] TUN/VirtioNet USO features support.
Date:   Thu,  1 Dec 2022 23:56:38 +0200
Message-Id: <20221201215644.246571-1-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
Technically they enable NETIF_F_GSO_UDP_L4
(and only if USO4 & USO6 are set simultaneously).
It allows the transmission of large UDP packets.

UDP Segmentation Offload (USO/GSO_UDP_L4) - ability to split UDP packets
into several segments. It's similar to UFO, except it doesn't use IP
fragmentation. The drivers may push big packets and the NIC will split
them(or assemble them in case of receive), but in the case of VirtioNet
we just pass big UDP to the host. So we are freeing the driver from doing
the unnecessary job of splitting. The same thing for several guests
on one host, we can pass big packets between guests.

Different features USO4 and USO6 are required for qemu where Windows
guests can enable disable USO receives for IPv4 and IPv6 separately.
On the other side, Linux can't really differentiate USO4 and USO6, for now.
For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
In the future, there would be a mechanism to control UDP_L4 GSO separately.

New types for virtio-net already in virtio-net specification:
https://github.com/oasis-tcs/virtio-spec/issues/120

Test it WIP Qemu https://github.com/daynix/qemu/tree/USOv3

Andrew (5):
  uapi/linux/if_tun.h: Added new offload types for USO4/6.
  driver/net/tun: Added features for USO.
  uapi/linux/virtio_net.h: Added USO types.
  linux/virtio_net.h: Support USO offload in vnet header.
  drivers/net/virtio_net.c: Added USO support.

Andrew Melnychenko (1):
  udp: allow header check for dodgy GSO_UDP_L4 packets.

 drivers/net/tap.c               | 10 ++++++++--
 drivers/net/tun.c               |  8 +++++++-
 drivers/net/virtio_net.c        | 24 +++++++++++++++++++++---
 include/linux/virtio_net.h      |  9 +++++++++
 include/uapi/linux/if_tun.h     |  2 ++
 include/uapi/linux/virtio_net.h |  5 +++++
 net/ipv4/udp_offload.c          |  3 ++-
 net/ipv6/udp_offload.c          |  3 ++-
 8 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.38.1

