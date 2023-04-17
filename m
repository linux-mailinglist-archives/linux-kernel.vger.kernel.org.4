Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283896E3D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDQCU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDQCU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:20:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08B26A8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:20:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id lh8so11131131plb.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681698051; x=1684290051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPGr4aLtxvia+ORk+JW6CZQQWfXiix2/yFnvH7YElHY=;
        b=W+kitkj4748KMfkxzVGrcTOmUMYc6GuI5qwaIjw/ez2iMpOp3wzBgCqUNRZMK+qjcb
         BbIY8QEASuYUGBfa9DpedYy0I7LxVeD+MKQbRFXsWwAhKpKwx8eUqTexwbc5mYPFMPD4
         /72izdGZyYzRwKmRN8y1YLdoSVJkog1r86CNCqveOWQ1yyvY4G5NR4++PNGU8wMrnFSC
         Bqh2/3spNiN8seFwQHVoqDVLvWU5WbnBxF8IqDm0FgitAbKfx7VdoGsJ94L4wFrfNr2K
         5hlbiSRFGOGpgBkf7FicQFZAwwbkFMlADZNrmHhAd8T+Tw8A6B+EWt3Yy4RE7QBsN8mg
         z51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681698051; x=1684290051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPGr4aLtxvia+ORk+JW6CZQQWfXiix2/yFnvH7YElHY=;
        b=Jm4fp6XXKJlGtAn4tfVZDtshXXbLkQx9E7iynXF5wZT66STgb8B7LU/whUjV33giHG
         dC1kK7jexNeT+GP0O8l+68Bvtnkwu/m42uunjQ+HTmISlOj6tbjIupUDhsjPpIfsM4Iy
         EMEoFYjMXyob44oCIIXqPAeNuszcY5XhPZPXsOS/ycyv0/LIGksav7dxzk6uiWIqZUw1
         NEBB+znOkBzPvkTgtDuv3eyUXi2l9WXlXjENTOuem9Ef3zZ49iiYy/bfhEvFvjOZP1MW
         oO6R5R0eN60uCSqfu5d5vfmYw2cGwBn1jF/I90ZjXv/IZDcQGyO9fJK7nY28J+oxvLcm
         yrwg==
X-Gm-Message-State: AAQBX9fmQpEm68ZcpiAIZRLdjncPwuLDwoBSYI8dh/65Jc5Hj7W6Isgl
        QmyAHq4r3lCtlAkTNQnfvS39mA==
X-Google-Smtp-Source: AKy350bs2v5u3uc7g/iYBOl/6g6nM1K60PDxVnsFlqWctrcBKq1BsqKUpM0oxvj+C1lEWPBFV4KybA==
X-Received: by 2002:a17:902:e305:b0:1a6:370c:ce79 with SMTP id q5-20020a170902e30500b001a6370cce79mr9051838plc.22.1681698050696;
        Sun, 16 Apr 2023 19:20:50 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001a68986a3d8sm6195243plb.24.2023.04.16.19.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 19:20:50 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Stefano Garzarella <sgarzare@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 RESEND 1/2] virtio_ring: add a struct device forward declaration
Date:   Mon, 17 Apr 2023 11:20:36 +0900
Message-Id: <20230417022037.917668-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio_ring header file uses the struct device without a forward
declaration.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes from v2: https://lore.kernel.org/virtualization/20230410074929-mutt-send-email-mst@kernel.org/
- Fix a typo of commit title


 include/linux/virtio_ring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8b95b69ef694..77a9c2f52919 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -58,6 +58,7 @@ do { \
 
 struct virtio_device;
 struct virtqueue;
+struct device;
 
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
-- 
2.25.1

