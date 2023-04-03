Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED66D4FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjDCSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjDCSBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EDD128
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680544790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WlvpCHWMmiZdlbkC384yczmvM52H5PXcaJ7qF3TTD/w=;
        b=CeC03JbiKUFO0kWdPZ1lEw6exgPagtVAvsc1jGLqW+N9TgtyZ6PIDyeb9MC4Ja8G2lP4k8
        2+cTda1EXxAUAgpyOCBt0LkJMTdBFgEjgk5Q5BsIAEs4qIPb2FSWyW4/wQm3lP2vN1pbn8
        3FaEpS2WYQYn4WzJBfsL6Ce08/JXlZE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-GjVcFpb4M-GD_6Snvv_wkA-1; Mon, 03 Apr 2023 13:59:49 -0400
X-MC-Unique: GjVcFpb4M-GD_6Snvv_wkA-1
Received: by mail-wm1-f69.google.com with SMTP id k1-20020a05600c1c8100b003ee6dbceb81so15105826wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlvpCHWMmiZdlbkC384yczmvM52H5PXcaJ7qF3TTD/w=;
        b=dTOqxICQvOgvzMasQPtLIHPhqkniokL5jWJQ9PewViz/1bQ9BOprpvUZpF92swWgOC
         IR1Bdx7aiADFYvF8xdGsLfMN/4O4qlTe+wBSY9wkMcaEn8SfyU5L95EbsDVo8jouWFM6
         5/UtPPn7Gv4Sw3QAAFv+KV7vLoRK1FiOuYqWwYY6w8uGY4rTwuDOgSYLy1DgcVyZnaEB
         lXeopG3+x7OaCtTz2m2cua0vNOpG490zBMMI5p11/u2YbVVv5teIFoe87QPi4iA5sS/i
         3/B5jo8fhempb/xxaW4FYmdzVLRUVJm2n9wBJ6CiOETYWMYoaiEfyuY2T1D53IVwgWZQ
         z1hg==
X-Gm-Message-State: AAQBX9eS8QLw8YeRJ6g+93Rf7ZFsVlug0kAxkjLDEmGjtUA5tE0P8zw8
        whzICD2kBUDW4Gilrzn9k0FiB7jOm9fA+vn8+Fgn7lX9BAK/vye5jKh+W3UnulZaVr6WdNol/50
        qOTa5wSSi47fy0tyrKB68sb5/fMlhrQhEky1iUNPiYK2CDz4OTlcsFzE+sUwDeY+IeFRyR5TKse
        zvLrs94FU=
X-Received: by 2002:a05:6000:6:b0:2d4:a1c1:d1a2 with SMTP id h6-20020a056000000600b002d4a1c1d1a2mr28010989wrx.63.1680544788135;
        Mon, 03 Apr 2023 10:59:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZVhLfsp00dFS4OanJ+69SLvb6/rmvbMxDG1wlE2yhnABSUEGPFBZ+MotkgKKbOd+iYsvqjyw==
X-Received: by 2002:a05:6000:6:b0:2d4:a1c1:d1a2 with SMTP id h6-20020a056000000600b002d4a1c1d1a2mr28010964wrx.63.1680544787794;
        Mon, 03 Apr 2023 10:59:47 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d4e8b000000b002cde626cd96sm10222763wru.65.2023.04.03.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:59:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: Change serial baud rate for Pinephone Pro to 1.5 MB
Date:   Mon,  3 Apr 2023 19:59:37 +0200
Message-Id: <20230403175937.2842085-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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

This baud rate is set for the device by mainline u-boot and is also what
is set in the Pinebook Pro Device Tree, which is a device similar to the
PinePhone Pro but with a different form factor.

Otherwise, the baud rate of the firmware and Linux don't match by default
and a 'console=ttyS2,1500000n8' kernel command line parameter is required
to have proper output for both.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

I tried to instead get rid of the baud rate altogether, as suggested by
Peter Robinson. AFAIU that should just pick whatever bad rate has been
using by the early console.

But neither using 'stdout-path = "serial2" nor 'stdout-path = &uart2'
worked for me.

In both cases I didn't have any output unless setting a baud rate using
the 'console='param.

 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index a0795a2b1cb1..6bbe65bd5bd4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -26,7 +26,7 @@ aliases {
 	};
 
 	chosen {
-		stdout-path = "serial2:115200n8";
+		stdout-path = "serial2:1500000n8";
 	};
 
 	gpio-keys {

base-commit: 3adf89324a2b2a9dbc2c12d8895021e7e34e3346
-- 
2.40.0

