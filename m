Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3432963A6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiK1LOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK1LOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D16172
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669634029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cWseajU1uHRD8WD/jBJN0zTTv3jrVL60LfzIXX5DzQE=;
        b=MoLexcotAvjIjTw+ym/bCSKu4yn9i95RUx1xbkCArNeomLY2eiwL2JYlGQQSSLX0PKn3B7
        9du5kDTK8jhhAHf/hjLSaV7n4QwvXzTkRx1LHQj53khwyknX1773liFLzj62Mt1IXvKm33
        OuYDnbHTI5cqsqQdSmJQio3SSw1nll8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-XOqvcphLN7OXWYd8nrEDiA-1; Mon, 28 Nov 2022 06:13:48 -0500
X-MC-Unique: XOqvcphLN7OXWYd8nrEDiA-1
Received: by mail-lf1-f69.google.com with SMTP id q2-20020ac24a62000000b004b4ec7b83f3so3644847lfp.19
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWseajU1uHRD8WD/jBJN0zTTv3jrVL60LfzIXX5DzQE=;
        b=Wbedf4+0wI/RVDHpXA3M7+6EOmRMUwYPVDrj+wTcV83age6HAeH6+NBeZeem/7l6mn
         aPF37uLgaLXyP8t8DJDVUy1vWLk2cdBDF1PM9dZaYmuOFRt1G8/ACQEq36p8D56EmEg/
         lyugvYFQBZ2JMUCqB4ofOMHwGRAnm9CYrriWV2wztMXFkHkpA81DY+OgvULtYLS/cWO2
         OYeOmOK6ejaj9GvgeaZGOk+0Yh1kDhtNZ0tsPya2uKXhYl3pvSSy7ijyIWg9afslkmQG
         VBZBEN/UTwQaOnt8jiorBq7owQjS526gYDi1+ATSGXdXZ+vfIZrBv4JI3A3UQ6StT5za
         oRqw==
X-Gm-Message-State: ANoB5pmWh7D1GPGyEHNUt0w8Wh2DeaS74vi98B8n076OwYI9Ak8syZBl
        Zu3fwJcKaPlZJBhiFzStwQGaHzEXZzitOX0N+fwvlxWyI09AZ8ld8BzlIQRPANIJbt/SPlBGpsQ
        JK3aB3F2yj5/f7kO+xA84FwEx
X-Received: by 2002:ac2:430e:0:b0:4b4:9c0b:f4d3 with SMTP id l14-20020ac2430e000000b004b49c0bf4d3mr16448209lfh.349.1669634027374;
        Mon, 28 Nov 2022 03:13:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6D8Ws/YxQs1ZwIgV/j2KmeApUF/SVLWIDJ5Zj1WSOSqT+ngp8Fjz+wLmjWYpGSFFJmrBXumw==
X-Received: by 2002:ac2:430e:0:b0:4b4:9c0b:f4d3 with SMTP id l14-20020ac2430e000000b004b49c0bf4d3mr16448200lfh.349.1669634027211;
        Mon, 28 Nov 2022 03:13:47 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id q22-20020a2e8756000000b0027703e09b71sm1141250ljj.64.2022.11.28.03.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:13:46 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com, alexl@redhat.com
Subject: [PATCH 1/6] fsverity: Export fsverity_get_digest
Date:   Mon, 28 Nov 2022 12:13:32 +0100
Message-Id: <c07eae3c278f36b8772bead49ff2894204c713a4.1669631086.git.alexl@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669631086.git.alexl@redhat.com>
References: <cover.1669631086.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Composefs needs to call this when built in module form, so
we need to export the symbol. This uses EXPORT_SYMBOL_GPL
like the other fsverity functions do.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 fs/verity/measure.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index e99c00350c28..2f0f7e369bf2 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -100,3 +100,4 @@ int fsverity_get_digest(struct inode *inode,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(fsverity_get_digest);
-- 
2.38.1

