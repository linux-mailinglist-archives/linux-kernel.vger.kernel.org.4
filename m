Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A51632DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiKUUNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKUUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:13:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A65133F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:13:50 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y13so12339058pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rq8a2hBX27gcIVHpejpVIZL+hRyBNLYkb+s20L9WV6w=;
        b=SqLgfLqLWXgmjXhNGZIU6mAMHlKkjWNnbCRUg8OpME4ixk3GEFZq7BLXUUt/sx7273
         Nyn6a1zF1thpfbom4ap6EMprRGQurZhAatGX3dXHNO7toAEL3nX138lfDoG5XWZeQdSb
         HvfdpU8SAyxIFn8FvQ/ZGAFJM1tWhTDOEZ2SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rq8a2hBX27gcIVHpejpVIZL+hRyBNLYkb+s20L9WV6w=;
        b=iCu+kmr96iL02xEgD5X+Zyz9y9+jmNDIzLvGf+3QkO/beCtx0Q+QqQy8ajL+yQUsy3
         rSutive+BH+fK0Kjb01Z3DfyyPbQ6NfyJJ+0CJ6Nvzl7LGlHu6N+3JiPlW4E4pscRaXo
         LIQrN8nk1LMJa326fEoXc4FxBScGX3webSqEDfni/rmRXwg7NahAGcJYJkyCkPnciiUy
         ZPHRT2W5lMGRvo4Ryod3UnIGUJrCIVDylEBQDGuoMoBuRHlntr82oOzpaELiU+2/Ti3R
         FugNcMjD0+1fBAb6prCJubUoTem3+m5bHlTdH/H9KH6T1RojCKqjYGCOREAj8kaF7rp9
         yPTA==
X-Gm-Message-State: ANoB5pnxNTPKxaciL9urkQMl8RhqdaowRs2nHcvNFvO3NS5b1WPl6ktE
        l1lfx0hexMM9OfFRwqWLTBEbLYV8iTWdqg==
X-Google-Smtp-Source: AA0mqf6bUyCGH1kkSoR2meAE+laA0AOnlYeMweAaTvvR9s2UP4evcKNKPPO3M1hYW+8vc2rBOaC90A==
X-Received: by 2002:aa7:9057:0:b0:573:1d31:2b78 with SMTP id n23-20020aa79057000000b005731d312b78mr2662956pfo.61.1669061630232;
        Mon, 21 Nov 2022 12:13:50 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f70800b001822121c45asm10178507plo.28.2022.11.21.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:13:49 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/2] platform/chrome: cros_ec_typec: Link PD object to partner
Date:   Mon, 21 Nov 2022 20:13:34 +0000
Message-Id: <20221121201337.2772216-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a short series to link a registered USB PD object to its associated
partner device. This is helpful for userspace services (the ChromeOS Type-C
daemon, for example), to identify which Type-C peripheral a PD object belongs to,
when a uevent for the PD object arrives.

The first patch adds a helper to the Type-C class code to access the device struct
for a partner. The second patch uses that helper to set the parent for the USB PD object
in the port driver code.

There was an earlier patch[1] to solve this issue, but it's been jettisoned (on advice from
GregKH) in favor of the current approach.

[1] https://lore.kernel.org/linux-usb/Y3vNZEuNI3CWzZ0L@chromium.org/T/#m7521020f64d878313d7dd79903ec0e9421aa8737

Series submission suggestions (if the approach is OK):
- Patch 1 goes throug the USB tree and Patch 2 goes in the next release cycle
  through the chrome-platform tree.
- Patch 1 and 2 both go through the USB tree.


Prashant Malani (2):
  usb: typec: Add helper to get partner device struct
  platform/chrome: cros_ec_typec: Set parent of partner PD object

 drivers/platform/chrome/cros_ec_typec.c |  2 +-
 drivers/usb/typec/class.c               | 13 +++++++++++++
 include/linux/usb/typec.h               |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

