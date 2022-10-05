Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE985F5A79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJETOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiJETOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:14:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916732BE14;
        Wed,  5 Oct 2022 12:14:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id fb18so1087068qtb.12;
        Wed, 05 Oct 2022 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4u5zSFTTl6Tg6+Epgw/QLqRJlkHZ4tOE8mrGAtQf1eY=;
        b=cpGj3Cza5JvNQBhL0EVzvVTrKhKEYvy+l7m+dr2otRPeMkyorX1Jw1ioNGiLPNu9/X
         CDEvhAKzat7UAEipq9oWyJLcPDP3cvn6FZHTaW2h7QYYCG0cyyfhkxBlkwvUfyjjcycf
         m/reUAf7f5gjK6286JekPFDFF2VLtFRgXh07EDHWBLmVnKyUXVb7nyTBLTH7L8o8ozW2
         4BOIxk0OjQ58k1BiU2rZPDFhCb/tFbFwFXR3d3VQoAxF4UXvvZAPgZksVVHlAdNtNhcx
         xseDDRWeDg3kVqClxPVdh4t5kCR511BlLHyTWzzSwjhZGbpPeu/LCri2NzOG5/NpiafS
         Fujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4u5zSFTTl6Tg6+Epgw/QLqRJlkHZ4tOE8mrGAtQf1eY=;
        b=QiHGO8KaW73Ad8whProK/pYDXgR7VnLltSFWLfIJxczinrX1p+bAH3NCt8+o1DLXJG
         Dj835Qm1gMhlLM0N761U2ndrBW5LaqrCtZlk+JzhQjTq2taKqno+CRST3JLE9MbmtSWQ
         XlvpY1AlLBkJacC3FZlNoc5N6VMn3uC2pTjdz92s+dGhyMvvokO+BhQWpZt1VVZ9HrYs
         kVIyIUiT5v1sugjp6ug7qq/EnITHatGhJ8ev+RP2KMrYn9mUxvSzhMKuGISZXk+EKbki
         k8t5zpGw6IoDYa3O5i2y4U0dHmrmjTDIe7eVrP/LnOtw3Se7IRjyiE+TAMrnXF/VKfM+
         weOA==
X-Gm-Message-State: ACrzQf08O8Oo9LV/bUocj6XJCFmZd6MpD0irvpiFupOFTRbBC/4xW25W
        WSZKWzOyM6uFQiZOl7BDJnQ=
X-Google-Smtp-Source: AMsMyM6iK6DI8Fft0Ka/XQlSjKqUKGVFdRhEQ8KKAOASw/5M5QGL8JUwAOkbkYGMwwXsg8IYqT2gQg==
X-Received: by 2002:ac8:5c4c:0:b0:35c:1373:5afc with SMTP id j12-20020ac85c4c000000b0035c13735afcmr873155qtj.86.1664997247536;
        Wed, 05 Oct 2022 12:14:07 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l20-20020ac81494000000b0035d27b254f3sm14436500qtj.40.2022.10.05.12.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 12:14:07 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     alcooperx@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com,
        f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] usb: bdc: change state when port disconnected
Date:   Wed,  5 Oct 2022 12:13:55 -0700
Message-Id: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

When port is connected and then disconnected, the state stays as
configured. Which is incorrect as the port is no longer configured,
but in a not attached state.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_udc.c b/drivers/usb/gadget/udc/bdc/bdc_udc.c
index 5ac0ef8..53ffaf4 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_udc.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_udc.c
@@ -151,6 +151,7 @@ static void bdc_uspc_disconnected(struct bdc *bdc, bool reinit)
 	bdc->delayed_status = false;
 	bdc->reinit = reinit;
 	bdc->test_mode = false;
+	usb_gadget_set_state(&bdc->gadget, USB_STATE_NOTATTACHED);
 }
 
 /* TNotify wkaeup timer */
-- 
2.7.4

