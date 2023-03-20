Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6026C0D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCTJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCTJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:35:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750F41B572;
        Mon, 20 Mar 2023 02:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D868B80DB5;
        Mon, 20 Mar 2023 09:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F77C433D2;
        Mon, 20 Mar 2023 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679304897;
        bh=7f7xBrz/th4eNUqDR98uCTdNi7uY7ScAKlNZDYRKTts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRdYEgRjJLA0V9YqyikvA55oBQFK2hrVxrsQHsj9NHQc4KqqqCx9K7g0O1bwcQCa+
         XVlHdEAlrhOYpLRo5XK7S6hKCSOJAtReSKoXUDYR8D6PypnlDvX23K7h8u0cfQbq/d
         +0r5HkWwMVBEKHBFxWuPXqT79fRIl4mdkB8CmwfM71tuEPxJFh+m7mJAhY6I29vV9O
         +nUNjnwnZMbwKb6Nim+KHmy5lfNjWpPg+CWFO0n+7XH6i4XEJLScYvpMCIZJ0nEhLL
         jOVjmsM5DtRmHxQoXmtRFxpxscN+ISUx31nvpY8ET89zf3kaf4SOfBxQVPsTtYpfmT
         aRCR/3WpEypLg==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, vigneshr@ti.com, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: usb: snps,dwc3: Add 'snps,gadget-keep-connect-sys-sleep'
Date:   Mon, 20 Mar 2023 11:34:46 +0200
Message-Id: <20230320093447.32105-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320093447.32105-1-rogerq@kernel.org>
References: <20230320093447.32105-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current USB gadget driver behaviour is to stop the controller
and disconnect from the bus during System sleep.

The 'snps,gadget-keep-connect-sys-sleep' property can be used to
change this behaviour and keep the controller active and connected
to the bus during System sleep. This is useful for applications
that want to enter a low power state when USB is suspended but
remain connected so they can resume activity on USB resume.

This feature introduces a new constraint if Gadget driver is connected
to USB host: i.e.  the gadget must be in USB suspend state to allow
a System sleep as we cannot process any USB transactions
when in System sleep.

The system hardware is responsible to detect the end of USB suspend
and wake up the system so we can begin processing the USB transactions
as soon as possible.

Cc: devicetree@vger.kernel.org
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index be36956af53b..1ce8008e7fef 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -262,6 +262,11 @@ properties:
       asserts utmi_sleep_n.
     type: boolean
 
+  snps,gadget-keep-connect-sys-sleep:
+    description:
+      If True then gadget driver will not disconnect during system sleep.
+      System sleep will not be allowed if gadget is not already in USB suspend.
+
   snps,hird-threshold:
     description: HIRD threshold
     $ref: /schemas/types.yaml#/definitions/uint8
-- 
2.34.1

