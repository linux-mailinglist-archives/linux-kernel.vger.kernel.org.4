Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C8630D9F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiKSI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiKSI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60A9DBA7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668848204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTnMAWMcXOaxFIQpcfG6YUPgYRs3mGJmNnh2pJlkTaQ=;
        b=UHqgSfWYgXt0U/3I4CYydlCLHA2FE7ysirZGwCVv5r7+GFuhlEe4RbZiYo38MnUIxBi6UH
        djIVKZ6AUNbHQ2swQnx9qqjK7zHVv9/aOPMYAYWdMzoXBjqF55Ol6G9ngpVajax2LkKG7p
        3idMQUT3YrSqBAWslwBYa+uCIKQRutk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-HfEpyvEFMKikKxKQiwj_wA-1; Sat, 19 Nov 2022 03:56:43 -0500
X-MC-Unique: HfEpyvEFMKikKxKQiwj_wA-1
Received: by mail-wm1-f71.google.com with SMTP id m14-20020a7bcb8e000000b003cfcff0057eso1740200wmi.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTnMAWMcXOaxFIQpcfG6YUPgYRs3mGJmNnh2pJlkTaQ=;
        b=tymil5qa6cbDS7tW0YHh9i/s3yHAL6JDz99O51VfpA3shtO4E7MFsDtcyfLDDD22EC
         QojFl/9tBCvYjjo9liMWV+BmtrRzPse/s1jX68tF1+OgTy9QQyfPFeiwBmGaRq0B7T1H
         3cHA/4ZJ8+rJMrUcbbpIIJWakFR8JIbzvK8mpM+ifKgKx9EEpAtwKhyX3L4HQWSusoWm
         LGfLN6LN7HzoXJn0Bdicx2L0wg5p2hnTzc3F9hujsmQuYKMajyMLU+us6PhPhVpdLmS7
         ZCLIiG4IRP5a19cnTyvd5ZGI4FmRBJAjZynCrXutmTOdIcx6nS8EjjZpBY3obM7wEBbY
         H5pA==
X-Gm-Message-State: ANoB5pkElCnNmHeQMj56DacmQE0krYBe8f01gjhWFkNsOLX/lUcxdqgD
        EG6eF4y6STH1/AqakAPcoEfvCLISd54+1eVx8mdcJ/2L7bIrGiGnv2rZ5e+2G5SvtMA2JV28Cm7
        tgjjMYkgBoFVsUKSID6gL2j5/ueUw085spGih3QCLZmNc9CBCtC/O+njsKjnN6wu/oX21uNx7RX
        A=
X-Received: by 2002:a05:6000:1148:b0:236:71cd:1a71 with SMTP id d8-20020a056000114800b0023671cd1a71mr6301106wrx.712.1668848201860;
        Sat, 19 Nov 2022 00:56:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4iKlUjoSLuaU2OKOfUuMzVhcXhG2yCg6tTKCVerM+oZOqj7tj2WHCkqX1bb1HYERiD2HMfAA==
X-Received: by 2002:a05:6000:1148:b0:236:71cd:1a71 with SMTP id d8-20020a056000114800b0023671cd1a71mr6301094wrx.712.1668848201599;
        Sat, 19 Nov 2022 00:56:41 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b003cf9bf5208esm12708160wmb.19.2022.11.19.00.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 00:56:41 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sergio Lopez Pascual <slp@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/2] KVM: Add missing arch for KVM_CREATE_DEVICE and KVM_{SET,GET}_DEVICE_ATTR
Date:   Sat, 19 Nov 2022 09:56:32 +0100
Message-Id: <20221119085632.1018994-2-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119085632.1018994-1-javierm@redhat.com>
References: <20221119085632.1018994-1-javierm@redhat.com>
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

The ioctls are missing an architecture property that is present in others.

Suggested-by: Sergio Lopez Pascual <slp@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 Documentation/virt/kvm/api.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index c17bac32d25c..0a99858d6d03 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3293,6 +3293,7 @@ valid entries found.
 ----------------------
 
 :Capability: KVM_CAP_DEVICE_CTRL
+:Architectures: all
 :Type: vm ioctl
 :Parameters: struct kvm_create_device (in/out)
 :Returns: 0 on success, -1 on error
@@ -3333,6 +3334,7 @@ number.
 :Capability: KVM_CAP_DEVICE_CTRL, KVM_CAP_VM_ATTRIBUTES for vm device,
              KVM_CAP_VCPU_ATTRIBUTES for vcpu device
              KVM_CAP_SYS_ATTRIBUTES for system (/dev/kvm) device (no set)
+:Architectures: x86, arm64, s390
 :Type: device ioctl, vm ioctl, vcpu ioctl
 :Parameters: struct kvm_device_attr
 :Returns: 0 on success, -1 on error
-- 
2.38.1

