Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A66DABDA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDGK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjDGK5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE4B752
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680864897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=k0rU9qN6OXQn9VhfokzgjZmLQQ8B6AgUhbS5Fy6LXPg=;
        b=dNmWxebckJ2Wz3yzoCHTHVvZhJJSMWDvm9AO6xlBKt0t8PMr/udzAVDY4nfocrvK1LOBba
        dfGpiFg43IcR3Vi3vRawUSNRWHG87Wba1Pe/BRsFXBaqd4HWG5c5GRFAWoOkVDhJKuscQ5
        89a/jHcWVwFBPOx/d+t2z5DTSzcQKxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-9EvhxzGcNRiZxncQPdGlMA-1; Fri, 07 Apr 2023 06:54:56 -0400
X-MC-Unique: 9EvhxzGcNRiZxncQPdGlMA-1
Received: by mail-wm1-f71.google.com with SMTP id n11-20020a05600c3b8b00b003f04739b77aso9381363wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 03:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680864894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0rU9qN6OXQn9VhfokzgjZmLQQ8B6AgUhbS5Fy6LXPg=;
        b=oPLMoWkDfYHm6ilTnoLAzBCrukSNpPXRGbGMpv3r88WGcF08KtFwiMVxwUfZOfqW5O
         XNBEuOe72XXcu6O45dWbbU3vnLqBYi9qSlZeQTWI7ArRZKf25s7pRaiz8DEi5S2gwFfG
         T0nDy1ZWtMziikQG8xxoPPrIFvQOTTwEXMCZNcLiNEcjC545KdUAIePZtWpceGYYl5nk
         LYzLlWiPI8VHLkZSHfFZHn+h7mxDhi8i/HvMUJ//Fk/dsOATPJIzH45t8y+ILwiIQHwx
         YX/TuutWjytSpvpflLo/1coyUg41Epo6FJHnkUhtUlBg04corfmWg7YGjOdRQfNVCTej
         a9jA==
X-Gm-Message-State: AAQBX9dY6/+LKPa1DciGGId6qtA1KV6LwF55Orx2BXYGCbb+pEc7SFJW
        P1gL6k4im1jCQSYEIj6b7ZFtyJCxAAxKlnhiUiD3eWZ68hDJCJZRsepEexUZiQcyG0paG6EXaJQ
        zh/W9Xy4wU6u5tcPl8ROHWPFkOoRmITenrO6ctH/nU/S+hAhg6/3qf7B1h8+WsTvviQE9G4dz7H
        zIaA==
X-Received: by 2002:a5d:4311:0:b0:2ce:9fb8:b560 with SMTP id h17-20020a5d4311000000b002ce9fb8b560mr1214138wrq.8.1680864894772;
        Fri, 07 Apr 2023 03:54:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zz1WAl1pBgluIyvHAQ7Jass36PS67oNBouOPMJdAbw2ewAZH/Tiop2wAnpCorp5JLSJO7M/A==
X-Received: by 2002:a5d:4311:0:b0:2ce:9fb8:b560 with SMTP id h17-20020a5d4311000000b002ce9fb8b560mr1214127wrq.8.1680864894384;
        Fri, 07 Apr 2023 03:54:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742d:fd00:c847:221d:9254:f7ce])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c451000b003ef66c89af0sm11411742wmo.0.2023.04.07.03.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:54:53 -0700 (PDT)
Date:   Fri, 7 Apr 2023 06:54:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] dma-api-howto: typo fix
Message-ID: <af1505348a67981f63ccff4e3c3d45b686cda43f.1680864874.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stumbled upon a typo while reading the doc, here's a fix.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-api-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 828846804e25..72f6cdb6be1c 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -185,7 +185,7 @@ device struct of your device is embedded in the bus-specific device struct of
 your device.  For example, &pdev->dev is a pointer to the device struct of a
 PCI device (pdev is a pointer to the PCI device struct of your device).
 
-These calls usually return zero to indicated your device can perform DMA
+These calls usually return zero to indicate your device can perform DMA
 properly on the machine given the address mask you provided, but they might
 return an error if the mask is too small to be supportable on the given
 system.  If it returns non-zero, your device cannot perform DMA properly on
-- 
MST

