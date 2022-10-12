Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0B5FC000
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJLEwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLEwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614869E681
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665550367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FgWbfbhMWMtoQvRE45b5B2jwxgfNrBgnpCUvv7Lscw4=;
        b=WpKMPDfbN3S0K8oWuVoJ7Lzqc+G18cOPZAswQ8Jj6bG8JN50ULSjLRCCEArkjW7q2irK+m
        UFa1LNEFu7OfggPG9MkzOHn0N86+yjiPTBpTtqVJrOdIvRBjdJypaVcVXnOMIURD0L+Fat
        EcpmXtMH9d2sX2DcGlEkpFQmxEcxQyc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-GwpQHFVnMtON6zGZK66-Pw-1; Wed, 12 Oct 2022 00:52:38 -0400
X-MC-Unique: GwpQHFVnMtON6zGZK66-Pw-1
Received: by mail-wr1-f69.google.com with SMTP id s30-20020adfa29e000000b002302b9671feso2544835wra.20
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 21:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgWbfbhMWMtoQvRE45b5B2jwxgfNrBgnpCUvv7Lscw4=;
        b=v7YeyBeCEi1itGLYZM3mndVnJrIscqu0FQJ9EW+ousVzcNbWqpbxtBqInU4+ouKGqM
         vLklLmt2uITuuPrNvmK+YZBertzRiIhGFUJ3IKlapftiN+6PrGNwOUVi718YHd/NYpke
         zYGsmkMmQ6XZMEkWcka0n7AOSZVRUgZnq7YF/HoQQgSkxTe80HjGYxjfFIjBYEKvy52C
         eYkllpyf+1Qr4vGsLnI0Ht5qAJp46h3ULEQcVfrQWSGUa0S1RBJ+BAIdhXBFpYnsAMu+
         ogJ+acMRKNyz7XwhgIyPRVCdecqKtKcRGDGoZELgHpXhbm7hYTepjzO+GBBZe/TMvQfB
         PkiQ==
X-Gm-Message-State: ACrzQf09K3vJFnZcIdd0ups7F5vewSKWS4CGPRpg+Zd0WjirIz63zfD1
        fEMwXWXhs/NPSQiGtzfRe/fA2d4SJ5+p1GttmnHShjqocSbAr/u7uTTQH23ozhNu9DroalfrBK0
        h5sQUb7ROZU5Dl4L3Bk9ciRNPN5v4KD56hF+0RHwot2U78fwISuD3LXjahzEnvD75tzof4w==
X-Received: by 2002:a05:600c:4e4d:b0:3b4:7659:38c with SMTP id e13-20020a05600c4e4d00b003b47659038cmr1373723wmq.176.1665550356844;
        Tue, 11 Oct 2022 21:52:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4iZDeridtCKmzd9gDftPmBS44o5wzn0jyUgtvdhGtzuaiYLNEPiBhn3L8OdGNYm+6sDG3IeA==
X-Received: by 2002:a05:600c:4e4d:b0:3b4:7659:38c with SMTP id e13-20020a05600c4e4d00b003b47659038cmr1373712wmq.176.1665550356556;
        Tue, 11 Oct 2022 21:52:36 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id q128-20020a1c4386000000b003a6a3595edasm718732wma.27.2022.10.11.21.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 21:52:35 -0700 (PDT)
Date:   Wed, 12 Oct 2022 00:52:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] vdpa/ifcvf: add reviewer
Message-ID: <20221012045152.223274-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhu Lingshan has been writing and reviewing ifcvf patches for
a while now, add as reviewer.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d960ca4e969..531bbb0a507a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21736,6 +21736,10 @@ F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 F:	tools/virtio/
 
+IFCVF VIRTIO DATA PATH ACCELERATOR
+R:	Zhu Lingshan <lingshan.zhu@intel.com>
+F:	drivers/vdpa/ifcvf/
+
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	David Hildenbrand <david@redhat.com>
-- 
MST

