Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BCF5B7CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIMWPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIMWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E913D65
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663107316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsWBexLFDVqUOZMqbhy+SL8q312glCS9Mla/+vP6MEc=;
        b=QMmpv40E7FJO4P7QJ/C9BJQWLnS9/r3YCDlgmFBPmiBaJkAul4rGaXpSJ7qXW9fX8GYMQu
        iG5SXVEl2SxyMcyjQGEA3Ve8w+Pfp9ZJCEZB8WYDbZHBehE/xiOgGPfrnVMClVD5YdA0b5
        iihcHh5tN+f/10JyKkFMg8ZAiiaUXn0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-Zi2kAvXiM2eNNOaj6-n4-w-1; Tue, 13 Sep 2022 18:15:15 -0400
X-MC-Unique: Zi2kAvXiM2eNNOaj6-n4-w-1
Received: by mail-ej1-f69.google.com with SMTP id hs4-20020a1709073e8400b0073d66965277so5144661ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hsWBexLFDVqUOZMqbhy+SL8q312glCS9Mla/+vP6MEc=;
        b=w0Gz46jIwZOJKSAqEuiQJEmm/bsezvkRd7nMzGtaUmbAzmObcJO0lSE6BUv+gZPdCt
         onbJFuGuBDiTBuLjjm1u+87zw30OxP7ToB82OEhb9T7NuPtIBnVkNJMb40toZ402ZCgX
         l/jmbyyJrimxkjn2hoHU18i33zTvmO2MIOkkhyj/TVZSB7Pw09od1LsVUree+nfsbzim
         asMu5xuIkZ95GJQC0zgJ36f1SvdF5cyAPfeeMJLSeDygmOo+TXvInap9/ke0UwQjgD1h
         BAXLKMI+OFV/z1+R4Q2HJqL87UFVUQpjOqKpys4G/xT/z2OoaaVHrSY0Fx2tuVHIDMX5
         V0ZA==
X-Gm-Message-State: ACgBeo1oW7UQNOL/MqAxqfHcsUzVIeCdKMBmhAChp1HiUBiJNibJdVQY
        fl5lSFwJk25bsgo9HbltNI5MgWFfsOQ6LKunvXS5BuqehPqytRBJ/SHVGmcJHWEAcWurQZR5AB9
        ULdcntw8doNKthFqwDG06Yr1n
X-Received: by 2002:aa7:da97:0:b0:452:bea2:5200 with SMTP id q23-20020aa7da97000000b00452bea25200mr68250eds.341.1663107314141;
        Tue, 13 Sep 2022 15:15:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ZKIyEtvn0ZdttQsylhb4+4lRtAhpLE6jDAvGHN/+GdIEgTPcQEnfQ2XrRN4o9j3qVCy3eiw==
X-Received: by 2002:aa7:da97:0:b0:452:bea2:5200 with SMTP id q23-20020aa7da97000000b00452bea25200mr68238eds.341.1663107314001;
        Tue, 13 Sep 2022 15:15:14 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x24-20020a50d618000000b0044e01e2533asm8720076edi.43.2022.09.13.15.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:15:13 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 4/6] drm/arm/hdlcd: use drm_dev_unplug()
Date:   Wed, 14 Sep 2022 00:14:54 +0200
Message-Id: <20220913221456.147937-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913221456.147937-1-dakr@redhat.com>
References: <20220913221456.147937-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is unbound, there might still be users in userspace
having an open fd and are calling into the driver.

While this is fine for drm managed resources, it is not for resources
bound to the device/driver lifecycle, e.g. clocks or MMIO mappings.

To prevent use-after-free issues we need to protect those resources with
drm_dev_enter() and drm_dev_exit(). This does only work if we indicate
that the drm device was unplugged, hence use drm_dev_unplug() instead of
drm_dev_unregister().

Protecting the particular resources with drm_dev_enter()/drm_dev_exit()
is handled by subsequent patches.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 120c87934a91..e41def6d47cc 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -325,7 +325,7 @@ static void hdlcd_drm_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	drm_kms_helper_poll_fini(drm);
 	component_unbind_all(dev, drm);
 	of_node_put(hdlcd->crtc.port);
-- 
2.37.3

