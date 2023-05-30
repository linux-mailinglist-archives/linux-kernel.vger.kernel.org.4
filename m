Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD44716FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjE3Vr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjE3VrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED024AA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685483199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jz0lxub2/P+kdWuniVPcOzbGpMdmwvxeH3Dntm2s8qY=;
        b=gejenc1ogw7oYVtDbmS9tRrxNk4yY4xRwgjtRwU2yq6ZL4heBOlNsPTMoy11yEvdAzjaPl
        rfrBdNYwD4NK/VPin88wIGc8+Tdleb/RYAk/F1jzqfYlE9Ha6x1fUOFd/ynqGF0FG7MDCI
        fCNTLJaT/hFlyzkPBlQUaub0L9IMU/c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-jk7uog3qPwy8Ntit3m1jTw-1; Tue, 30 May 2023 17:46:37 -0400
X-MC-Unique: jk7uog3qPwy8Ntit3m1jTw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f7f713eeb0so77143491cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483196; x=1688075196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jz0lxub2/P+kdWuniVPcOzbGpMdmwvxeH3Dntm2s8qY=;
        b=RIqApIiBNJsFt+DiYrGUpusvvLHsUwIDuf8U+snNlrpuWS9wijsQ+rr04JuFI9SONd
         OK9CLshfSozDcxB8jtQgKF7VoDPQTtZbyZ5UJlzLIH/YvoWlFV5JEt9pgU3xyZK20Dh6
         JHRH5xu7psZTve04i/Ykoo0xPjFsHBVpCUp/SyY4+YQaKl3EcVyTszIzDl0EMQb+cB0y
         PeBzLGq3DmMXcUDRHvcsAoSh0gwM9OKOccAUtpP/lYrImW4N+T5V7NWKz5b6p6AJQBGF
         Eq5X8UYRgTDh0qjkhQtOx21bZ+5eC8x0KTX6gwedduXC7hy5XDoZ1GWchX3RB7zCTC9G
         DrHg==
X-Gm-Message-State: AC+VfDxSBjp9Ox5W9ntrzXDc+LCip5Vn7smt9OTznzXgxJ9WsDpfE69R
        SOXx7qK2tT43ZDaBmRhPa2dGlQzvltHqQkYBn36+y09xRGEzp4XzhcYsbWh6SkzsumwrHMpYFzR
        ONxtF5pitu5ijyo6HPvF/Qdeoq7K6q67Q8pFlnOWF2pBSWZIMRmVOMeLuesEtqOof6tdruuaQO4
        PGbhhvvJ4=
X-Received: by 2002:a05:622a:1713:b0:3ef:3fcd:3c1c with SMTP id h19-20020a05622a171300b003ef3fcd3c1cmr3772415qtk.63.1685483196601;
        Tue, 30 May 2023 14:46:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5spxz8o30IEqG9ECwi5a2JSOl2wr8y+D+5q+v3nNFZVTsJXp/Rc6QZEx5d8/h1WE1F8kmkIg==
X-Received: by 2002:a05:622a:1713:b0:3ef:3fcd:3c1c with SMTP id h19-20020a05622a171300b003ef3fcd3c1cmr3772395qtk.63.1685483196258;
        Tue, 30 May 2023 14:46:36 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a191000b003ef13aa5b0bsm5121602qtc.82.2023.05.30.14.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:46:35 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/5] irq: sysfs interface improvements for SMP affinity control
Date:   Tue, 30 May 2023 17:45:45 -0400
Message-Id: <20230530214550.864894-1-rrendec@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set implements new sysfs interfaces that facilitate SMP
affinity control of chained interrupts. It follows the guidelines in
https://lore.kernel.org/all/87fslr7ygl.wl-maz@kernel.org/ with slight
deviations, which are explained below.

The assumption is that irqbalance must be aware of the chained interrupt
topology regardless of how it is exposed to userspace, for the following
reasons:
- Interrupt counters are not updated for the parent interrupt. Counters
  must be read separately for each of the chained interrupts and summed
  up to assess the CPU usage impact of the group as a whole.
- The affinity setting is shared by all multiplexed interrupts (and the
  parent interrupt) and cannot be changed individually.

Since irqbalance must be aware of the topology anyway, it is easier to
move parts of the problem there and reduce the complexity of the kernel
changes.
- Instead of creating a new affinity interface for chained interrupts
  that has different semantics from the existing procfs interface (and
  changes the affinity of the parent interrupt in the case of muxed
  interrupts), it is easier to let irqbalance set the affinity of the
  parent interrupt by itself (since it already knows who the parent is).
- Tracking groups of interrupts in the kernel creates additional
  synchronization challenges that are otherwise unnecessary. The kernel
  already has a (struct irq_desc).parent_irq field that can be (re)used
  for this purpose (see below).

Brief description of the patches in this set:
- Patch 1/5 makes the (struct irq_desc).parent_irq field available
  unconditionally. So far, it has been used for IRQ-resend and depended
  on CONFIG_HARDIRQS_SW_RESEND. But it can be (re)used to track chained
  interrupt parents for the general use case, without any changes to the
  existing IRQ chip drivers.
- Patch 2/5 is trivial and just exposes (struct irq_desc).parent_irq in
  debugfs.
- Patch 3/5 exposes the chained interrupt topology in sysfs in two ways:
  the muxed_irqs directory (as described in the original email thread)
  and the parent_irq symlink. From a userspace perspective, they are
  redundant. However, in the first case the synchronization is likely
  incomplete/broken and not so easy to fix.
- Patch 4/5 moves the SMP affinity write handlers from procfs code to
  generic code, with the intention to reuse them for a new sysfs
  interface.
- Patch 5/5 creates a sysfs interface for the affinity, with identical
  semantics to the existing procfs interface. The sole purpose is to
  allow userspace (irqbalance) to control the affinity of the parent
  interrupt, which is typically *not* visible in procfs.

The only required change to existing chained IRQ chip drivers in order
to support the new affinity control is to call irq_set_parent() in their
.map domain op. If they use the newer hierarchical API, they should call
irq_set_parent() in their .alloc domain op instead. This doesn't affect
the existing procfs based affinity interface in any way.

A few IRQ chip drivers already call irq_set_parent() in their .map
domain op to implement IRQ-resend. No change is required to those
drivers to support the new affinity control.

Last but not least, it turns out that hierarchical domains are entirely
out of the scope of these changes (unless chained interrupts are used
along the path). In the case of hierarchical domains, each interrupt in
the outermost domain has a *single* corresponding Linux virq (that is
mapped to each domain in the hierarchy). That makes it perfectly safe to
implement the .irq_set_affinity chip op as irq_chip_set_affinity_parent
and delegate affinity control to the parent chip/domain. This will *not*
suddenly change the affinity of a different interrupt behind anyone's
back simply because there cannot be another interrupt that shares the
same affinity setting.

Note: I still need to update the Documentation/ directory for the new
      sysfs interface, and I will address that in a future version.
      At this point, I just want to get feedback about the current
      approach.

Radu Rendec (5):
  irq: Always enable parent interrupt tracking
  irq: Show the parent chained interrupt in debugfs
  irq: Expose chained interrupt parents in sysfs
  irq: Move SMP affinity write handler out of proc.c
  irq: Add smp_affinity/list attributes to sysfs

 include/linux/irq.h     |   9 +-
 include/linux/irqdesc.h |   1 +
 kernel/irq/debugfs.c    |   1 +
 kernel/irq/internals.h  |  10 ++
 kernel/irq/irqdesc.c    | 206 +++++++++++++++++++++++++++++++++++++---
 kernel/irq/irqdomain.c  |  15 +++
 kernel/irq/manage.c     |  20 +++-
 kernel/irq/proc.c       |  72 +-------------
 8 files changed, 244 insertions(+), 90 deletions(-)

-- 
2.40.1

