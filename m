Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C056CD80E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjC2LDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjC2LDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:03:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D940E3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:03:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ew6so61468243edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680087819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WhbbiJ4e+b5CD8Cc7IUFUuG1LQyA1ZawH0b3mjKbWjA=;
        b=vIEbQUp1Ae1jSXkVEksl8NuRvjoOt/9zkLTtgCkEpxxDzQegdJ6sRYmpyDQsyOQpk/
         SxZ/6NzDfeTsITBSra50Q1GEllSE/70WyOok7lctCG4OWasrSdqPjCxR2R4IJZ/EKUV8
         HH4vUqBrzllszumb8VEzoIoz6+1HugUuXidHjUGK5oCDd3SCHT26rw7PHUmE/EiAgjqt
         kHzBdQYkxQZZu/lgXTtaY15NCMUNeq3RTf52lxMJsMNNP0X1+gg3te9bdAD4aZ9IPVuU
         5hk55w+RGDCUgzWPejeCLvldTSeb2VZFqME0DTh8AK2FDmutq8rNoL8qXoCTBvPFOFMV
         FDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680087819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhbbiJ4e+b5CD8Cc7IUFUuG1LQyA1ZawH0b3mjKbWjA=;
        b=W1eVeYUAo0fHW5RBvlU3z8MXlT3/cu0B69CiPC+IKddwmXDTSxn+6Bi6z/8uP9i7E/
         +GC/ap0HpYym32W7/4uJk32D4fJfzVtILOwftLhqLY3VhY5aI5kOD5cqPOnMEQJKkchI
         PDD/QCPeXSJg1zQo13gdzzusLKLlK+G/ordA5ZeYiyhzwb0UxalYsJhq2lANmKqeehnr
         qz5kk3AVXRiyj8LL3O2uxUUrSBdcsoREXWveUkgiv7Rach2WITf2RKgFP+Kb992gjN5E
         NL70vu9w3S651t3Tq/bEOxzIaAkcLohtFLED7DSEzJRurCnY5G2z+qE2JcNQN+4BNKlO
         yrSw==
X-Gm-Message-State: AAQBX9eRcA+78rGAiFpa+eLJFD6z//63UPWhGnZHK/gljrsAVLoVx5Iz
        bZe6LmDDBDzmZFQesM9jBWzDCw==
X-Google-Smtp-Source: AKy350ak9VgusBtqHfKGCN3XpdT6OBjA2Hz6hJLq7hk/S/hf34pTotdEBWM714i92+XHxNyq6WYrPw==
X-Received: by 2002:a17:906:9485:b0:933:c052:a277 with SMTP id t5-20020a170906948500b00933c052a277mr19912705ejx.12.1680087819244;
        Wed, 29 Mar 2023 04:03:39 -0700 (PDT)
Received: from localhost.localdomain (178-133-100-41.mobile.vf-ua.net. [178.133.100.41])
        by smtp.gmail.com with ESMTPSA id md12-20020a170906ae8c00b008e68d2c11d8sm16406975ejb.218.2023.03.29.04.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 04:03:38 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [RFC PATCH 0/4] eBPF RSS through QMP support.
Date:   Wed, 29 Mar 2023 13:45:41 +0300
Message-Id: <20230329104546.108016-1-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches provides the ability to retrieve eBPF program
through qmp, so management application may load bpf blob with proper capabilities.
Now, virtio-net devices can accept eBPF programs and maps through properties
as external file descriptors. Access to the eBPF map is direct through mmap()
call, so it should not require additional capabilities to bpf* calls.
eBPF file descriptors can be passed to QEMU from parent process or by unix
socket with sendfd() qmp command.

Overall, the basic scenario of using the helper looks like this:
 * Libvirt checks for ebpf_fds property.
 * Libvirt requests eBPF blob through QMP.
 * Libvirt loads blob for virtio-net.
 * Libvirt launches the QEMU with eBPF fds passed.
 
Andrew Melnychenko (4):
  ebpf: Added eBPF initialization by fds and map update.
  virtio-net: Added property to load eBPF RSS with fds.
  ebpf: Added declaration/initialization routines.
  qmp: Added new command to retrieve eBPF blob.

 ebpf/ebpf.c                    |  48 +++++++++++++
 ebpf/ebpf.h                    |  25 +++++++
 ebpf/ebpf_rss-stub.c           |   6 ++
 ebpf/ebpf_rss.c                | 124 +++++++++++++++++++++++++++------
 ebpf/ebpf_rss.h                |  10 +++
 ebpf/meson.build               |   1 +
 hw/net/virtio-net.c            |  77 ++++++++++++++++++--
 include/hw/virtio/virtio-net.h |   1 +
 monitor/qmp-cmds.c             |  17 +++++
 qapi/misc.json                 |  25 +++++++
 10 files changed, 307 insertions(+), 27 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h

-- 
2.39.1

