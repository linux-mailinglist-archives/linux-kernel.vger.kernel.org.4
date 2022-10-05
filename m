Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADA5F5957
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJERsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJERse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:48:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E743B0C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:48:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o21so743966ejm.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7vmkKrcbukpzojz/C0yPU7kDNmejVOGQprU/+VGjPg=;
        b=dVi25dvodr8t/gBegAqLu+rK8KzgAh4keTp2/KK7+Fje72aOUSQprjCW9gEVTRPyjx
         tAR/dx3QTfQXRA6VPY4wpM3my7uLryBptIJgQEwf488NAfjAoP8LVPe8RNH3JH2nF7sx
         aSCqpz5VQahY6uVL7dwnQMyPVmiXdxxw0KbZxftvRhnAbhmWO/tMzRIJy/UhRt5/60f2
         DCQUCakAm6HPmMzYpnTSZVSIwee3DWyUMQHfzVhPsxXN3b2Nl7nX2LF2JoXdLaGHNfxB
         H+UxR4u7ojJZ444EYA93u8Pv20FyYp56cTV856Mn9ZVwPFmHgjPuzwjeAMe7GKYfUEZZ
         da9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7vmkKrcbukpzojz/C0yPU7kDNmejVOGQprU/+VGjPg=;
        b=cTU+vrGMm5HVp0IZ9U2EwGeKTV1T8JRCg818CvuwB2ftOaiVDLPy914eWjfEYJkTfz
         mvGVyvSTkN5RiWvijqD6gnfYmKtQhK6vxGAo07NYm8MWdpDpSpnPU0DDlRkAbcrB8gnW
         Y/9A36wRtynOdiRgSk3Ft7eYBmOC5qNDV+qIEcHtxhQhdQPJvtc5McG16iBvfmhnT0hY
         44xv7Gq84tM7jhQ7kQjiQcX2Sxq1i46dZZYhKPNg3GRL9oceF7FPTA+0tOIMeUT0TQML
         hSzSG0XqOdJD/ESyTH77nNQi6fIUqO0hOPEITesg6rRtR34V9YaExhS4Ix0ZQoZEMUV5
         CIIA==
X-Gm-Message-State: ACrzQf1/eE7imRHNfC5DAp/A+5QVFmWqMQlsL7vlyQ4+j3RyFVoY8w8O
        SDTs9H8LiEjbvQlpsE2Oz1c=
X-Google-Smtp-Source: AMsMyM743WLaut2TEDuu9Otx1L5edbBgqf2bI1BtlwsFJAYPKcXauwkgwejLZrQib1lNS1Y2SACG3w==
X-Received: by 2002:a17:907:5c2:b0:77e:def7:65d8 with SMTP id wg2-20020a17090705c200b0077edef765d8mr596533ejb.487.1664992111996;
        Wed, 05 Oct 2022 10:48:31 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id ee32-20020a056402292000b0044e7862ab3fsm4320697edb.7.2022.10.05.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:48:31 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/2] Misc fixes for Xen grant DMA-mapping layer
Date:   Wed,  5 Oct 2022 20:48:21 +0300
Message-Id: <20221005174823.1800761-1-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Hello all.

These are several fixes I collected when playing with virtio-net device
using Xen grant mappings.

Tested with both virtio-blk and virtio-net devices.

Oleksandr Tyshchenko (2):
  xen/virtio: Fix n_pages calculation in xen_grant_dma_map(unmap)_page()
  xen/virtio: Fix potential deadlock when accessing
    xen_grant_dma_devices

 drivers/xen/grant-dma-ops.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.25.1

