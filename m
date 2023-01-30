Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E5681CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjA3VaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjA3VaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:30:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9D7A81
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:30:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id jp14-20020a17090ae44e00b0022a03158ec6so5081271pjb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ks4GVEUR6PT1089FpiWUNbhf7r3jxSIVo2HXW9yiGc=;
        b=AyWfK8ZP3f9NXvlS/ej80Q75u28ntZwmpIbPlH89Bvi6y+rP+oiMGsRqFXQvS+4iQM
         JGDXtIm4n8abYWDQqx9LF8V6mXy4R+PWOeXpe3FeV4IWic3G+yhS7lMROIAP9HD4qDbL
         aozIzrRQ9sZEydcP+0a+RzQZNSq764XOKNgszkL37OKAt3Nl1er2pLnvav1Ya4hxhhO5
         NlsvSIShuTaZhETkxziHndZjY6fc344Lm8V/y0lEINWSrRDfyWJr92nLMULuExALOP9o
         K9HQri43U/bfjeVZ9rQifHlHX17igWqWgAmQrDvjwWWNpbv3rorbwO1Oy5R/rBoRlnmx
         EdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ks4GVEUR6PT1089FpiWUNbhf7r3jxSIVo2HXW9yiGc=;
        b=kZF2C94pud5KwI1r/Gmhzwp0isXUC1h0L5L+yRBtMeL65eCUtbJgscP3x7DWBkh6xO
         dp5yb2DVl5TkRNRKNEjmo1VKwzpYsr+2Qygwvv7RMP/9QXAbuyTnh+oiz5E9E8GU4dLW
         99OUYhXNZi4nzN0hG3UIysgluYU1gvKG8Ep+1uv/lbtScuT1L4lb4gbDo51vMmrUturD
         0+0Gb/Bp9OeJDBrQVFvumdm9r3ozLKKTWedpA05ttEMSCBzmnNrIYhR0GkwKt3WsHC3F
         mMabUo/sK9FmebqppEQs436z/wKEwhl+WMmLt7fgOhOnC+RODYEW08+3Sxzu9E8+Y0NE
         IXwA==
X-Gm-Message-State: AFqh2kqgCMNSe+AICYL1lKOoXY6sU5rJzsH3mt+9uZaRTEXBWKC3bQxM
        TKS7bfcDCKZy4bUX8/m3uZqqpICCRXo=
X-Google-Smtp-Source: AMrXdXsCr+HOyKPh/c0urHNsticErkuB3IaiKNAB3BkKly7Dg8NhUF3Rieqh2fjB3WGczQmgwQsnlQJ5cm0=
X-Received: from xz2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d01])
 (user=xnzhao job=sendgmr) by 2002:a17:902:b20c:b0:194:7cb3:2527 with SMTP id
 t12-20020a170902b20c00b001947cb32527mr6452658plr.4.1675114205168; Mon, 30 Jan
 2023 13:30:05 -0800 (PST)
Date:   Mon, 30 Jan 2023 21:29:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230130212947.1315941-1-xnzhao@google.com>
Subject: [PATCH] HID: core: Fix deadloop in hid_apply_multiplier.
From:   Xin Zhao <xnzhao@google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xin Zhao <xnzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial value of hid->collection[].parent_idx if 0. When
Report descriptor doesn't contain "HID Collection", the value
remains as 0.

In the meanwhile, when the Report descriptor fullfill
all following conditions, it will trigger hid_apply_multiplier
function call.
1. Usage page is Generic Desktop Ctrls (0x01)
2. Usage is RESOLUTION_MULTIPLIER (0x48)
3. Contain any FEATURE items

The while loop in hid_apply_multiplier will search the top-most
collection by searching parent_idx == -1. Because all parent_idx
is 0. The loop will run forever.

There is a Report Descriptor triggerring the deadloop
0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
0x09, 0x48,        // Usage (0x48)
0x95, 0x01,        // Report Count (1)
0x75, 0x08,        // Report Size (8)
0xB1, 0x01,        // Feature

Signed-off-by: Xin Zhao <xnzhao@google.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3e1803592bd4..5c72aef3d3dd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1202,6 +1202,7 @@ int hid_open_report(struct hid_device *device)
 	__u8 *end;
 	__u8 *next;
 	int ret;
+	int i;
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
 		hid_parser_main,
@@ -1252,6 +1253,8 @@ int hid_open_report(struct hid_device *device)
 		goto err;
 	}
 	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
+	for (i = 0; i < HID_DEFAULT_NUM_COLLECTIONS; i++)
+		device->collection[i].parent_idx = -1;
 
 	ret = -EINVAL;
 	while ((next = fetch_item(start, end, &item)) != NULL) {
-- 
2.39.1.456.gfc5497dd1b-goog

