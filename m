Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB164053C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiLBKvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiLBKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE8D0391
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669978233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01EVu86F03ZVkaisaIA8aOhxapK6bD5iJUUbcQRNmys=;
        b=gRBpVn4XFihIn5sMWZ7vHPj7PrTqcPk7f3MON2lpeIUdwZDH/iz1Zp1x2Rx6qagylD8apH
        jj/4jxKXIM+n0hu4onVD7EoxT0wcrykZ2IOaLze5fo44iNwf4gLwW6ziBSjZpN/MB/+yz7
        gi/YUlstB6B/dNnINKtWBpK/A9f8Bvk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-221-RHzUfQalMWCr7IQNpp64HQ-1; Fri, 02 Dec 2022 05:50:32 -0500
X-MC-Unique: RHzUfQalMWCr7IQNpp64HQ-1
Received: by mail-wr1-f71.google.com with SMTP id d6-20020adfa346000000b0024211c0f988so972651wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01EVu86F03ZVkaisaIA8aOhxapK6bD5iJUUbcQRNmys=;
        b=Kagl/86lgZyTjuVJiPq13W4Fj/2iNdBQxby9IOt/Nmv5568v118ym8jlrbMt1WMfYa
         Uxel41PANXqvLiPY+W1x8DiItSPJIZqnIUShV0oeh08dxz+ljXQSKXvxxrETpy9G5WVr
         w237G8zDeWg1aRIXHbSORAZY8+GLQKLQCBIlrux/6Yjf1nyaf7IHd3YDeHaHC/qfpaOF
         U03OjhTACydC8L7sZo6reTXJUhocbYmzgftXECfaw46HkA07H5UdocEuZ/sTD481o9YP
         nuICUYC4veYeHYCcZXhJUV4Bcq9fbjpEiM3DKBw6MLRcFKL/wHcD9QvfYvM4RV6zyz0Y
         n9Ag==
X-Gm-Message-State: ANoB5pnw1I3yKUMLqpvsEAqzZ0u88XqDwfNpK7xRP7dFm5ghlEGBN+i2
        rr56EpC6NQ/7ThX9NA5FkGBDK2BR8FjCl3VQ6Voscj/EiqYwgVvEksmjugAOmzN+5cjMcAe3Nui
        e4MsAT0ecYQWLb4jb36rBU5reiW5sYBDJbbKCdh3VgALaaLjojlF+3Rpe73qGvt6+MlbxTOK1aH
        g=
X-Received: by 2002:adf:e105:0:b0:236:73af:f9ad with SMTP id t5-20020adfe105000000b0023673aff9admr42046594wrz.225.1669978230908;
        Fri, 02 Dec 2022 02:50:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5gKhowvqyk/ROz6Tub/sMJPyTW0HCi4czVL2HWfKAPTpnGRqZYvsKYMG8CpBMMwJo8CzalVg==
X-Received: by 2002:adf:e105:0:b0:236:73af:f9ad with SMTP id t5-20020adfe105000000b0023673aff9admr42046575wrz.225.1669978230635;
        Fri, 02 Dec 2022 02:50:30 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003a3170a7af9sm9728818wmb.4.2022.12.02.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:50:29 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 4/4] KVM: Add missing arch for KVM_CREATE_DEVICE and KVM_{SET,GET}_DEVICE_ATTR
Date:   Fri,  2 Dec 2022 11:50:11 +0100
Message-Id: <20221202105011.185147-5-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202105011.185147-1-javierm@redhat.com>
References: <20221202105011.185147-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

(no changes since v1)

 Documentation/virt/kvm/api.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b15ea129f9cf..1db60cd9e1ba 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3266,6 +3266,7 @@ valid entries found.
 ----------------------
 
 :Capability: KVM_CAP_DEVICE_CTRL
+:Architectures: all
 :Type: vm ioctl
 :Parameters: struct kvm_create_device (in/out)
 :Returns: 0 on success, -1 on error
@@ -3306,6 +3307,7 @@ number.
 :Capability: KVM_CAP_DEVICE_CTRL, KVM_CAP_VM_ATTRIBUTES for vm device,
              KVM_CAP_VCPU_ATTRIBUTES for vcpu device
              KVM_CAP_SYS_ATTRIBUTES for system (/dev/kvm) device (no set)
+:Architectures: x86, arm64, s390
 :Type: device ioctl, vm ioctl, vcpu ioctl
 :Parameters: struct kvm_device_attr
 :Returns: 0 on success, -1 on error
-- 
2.38.1

