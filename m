Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC516CEF27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjC2QUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjC2QUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE3A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680106801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WhrreSkv0vZH0WLUdB+/3ln6MeZlFYYMu2CO+omtwhg=;
        b=Jqn3DS9eJgueAkYapzKwmrLFfwRl0UyJCm81EsOuJv3W3d8hzVxUt1tv+lmFUiuQ0hKPAo
        DqJxRG5nXOsJDANN7isEBmbgo6U16xHeuLjSVT/HSGL51cbJ9lDtBAmfPlD6Ud7ht58g1a
        SPFQDVM/C9ucT5sW0yKsYIrL5laWumE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-kzIRubjmMW2NbTqoE9cOMQ-1; Wed, 29 Mar 2023 12:03:25 -0400
X-MC-Unique: kzIRubjmMW2NbTqoE9cOMQ-1
Received: by mail-qt1-f199.google.com with SMTP id y10-20020a05622a164a00b003e38e0a3cc3so10506808qtj.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhrreSkv0vZH0WLUdB+/3ln6MeZlFYYMu2CO+omtwhg=;
        b=z2bYWwZWE08HtUwK5dPm++jsA+tHjLrK1Zs0EJLdKunXiPV/WvMXCVvy+pQ9kVOhUJ
         8Fyl0T4RDCY+I+SQ6rF7ZhVEJljDIVI/Cb6mLRyyGapQ3od5lFMXujGRUTj8+aCPuljj
         Ak4QashARWZEObWIisQEseycwysfRznVLFMTIuy7lmtAo5drt3Rj7ZXJBA6NNuh2/QhG
         9T+ONYdqqEGOoYACOlUlgZxjW4IRPKsL8/8H86jfPvD+I96q2GFvyz1njiJBlfTxSshe
         qSm637PQZGojmdxR5FKR1428M/v9g08tQdz/WdhtF6zzVumpCRjUw0EyrnyUBAtdWDsK
         i+NQ==
X-Gm-Message-State: AO0yUKVIFGGalhMEZX89YhxgxTzyLcav8Mz3k7YhT2Ipmnaa7B3HG54c
        EbmagCKaLq8vyH2/pTfxXyOviewUgm8S/6InYheW8/1oyy2EkuU0Ro62W4wV8OfI/s3oUdTG1qP
        fJMkcl/kQumIPZWweXyvVmrTM
X-Received: by 2002:ac8:58c3:0:b0:3e4:6329:448e with SMTP id u3-20020ac858c3000000b003e46329448emr35810481qta.16.1680105805161;
        Wed, 29 Mar 2023 09:03:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set/FoJCjgeNDT4rElGSF+Zl8YAW9TnymsfzUzUHuClJUBQwdLVEZBocjmA0YXTyxGB7KC7JO9Q==
X-Received: by 2002:ac8:58c3:0:b0:3e4:6329:448e with SMTP id u3-20020ac858c3000000b003e46329448emr35810447qta.16.1680105804906;
        Wed, 29 Mar 2023 09:03:24 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-130.retail.telecomitalia.it. [82.57.51.130])
        by smtp.gmail.com with ESMTPSA id d184-20020a3768c1000000b0074688c36facsm13206442qkc.56.2023.03.29.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:03:24 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vdpa_sim_net: complete the initialization before register the device
Date:   Wed, 29 Mar 2023 18:03:21 +0200
Message-Id: <20230329160321.187176-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization must be completed before calling _vdpa_register_device()
since it can connect the device to the vDPA bus, so requests can arrive
after that call.

So for example vdpasim_net_work(), which uses the net->*_stats variables,
can be scheduled before they are initialized.

Let's move _vdpa_register_device() to the end of vdpasim_net_dev_add()
and add a comment to avoid future issues.

Fixes: 0899774cb360 ("vdpa_sim_net: vendor satistics")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    I don't have a reproducer, but I became aware of this problem while
    I was changing the buffer allocation.
    
    In the block device, as soon as the device is registered, the driver
    sends several requests, and I guess this might happen for the net
    device as well.
    
    Thanks,
    Stefano

 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 862f405362de..dfe2ce341803 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -466,16 +466,21 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	vdpasim_net_setup_config(simdev, config);
 
-	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
-	if (ret)
-		goto reg_err;
-
 	net = sim_to_net(simdev);
 
 	u64_stats_init(&net->tx_stats.syncp);
 	u64_stats_init(&net->rx_stats.syncp);
 	u64_stats_init(&net->cq_stats.syncp);
 
+	/*
+	 * Initialization must be completed before this call, since it can
+	 * connect the device to the vDPA bus, so requests can arrive after
+	 * this call.
+	 */
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
+	if (ret)
+		goto reg_err;
+
 	return 0;
 
 reg_err:
-- 
2.39.2

