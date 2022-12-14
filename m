Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590C464C536
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiLNImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbiLNImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:42:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58116580;
        Wed, 14 Dec 2022 00:42:08 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so6339794pjm.2;
        Wed, 14 Dec 2022 00:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKIXxnGp5Qeh1H1kOjUA7WrQEgWAzUUtfWKKqj9aC5A=;
        b=RUKS8+/pkEoTD8k0JJKHv8nza/xwr2KJsRoJ713qLCRtM5TldRtS0CrAdQWHN15/T5
         7ccfexgetApOumRV8EN13507YFLVeL2s8O9PjsVi2TS8qI8exUMro2LR/A2QzL4n8oii
         XEsXw+zgiiX54cwxIn7/n9O9xOs3pWxw4G38lW2bV4H3w/ymJ1MdIWUdS2IVvObxEjjy
         RLbqgR0Uj30QoSQH0A8y75S29JO6e1cXEpjsFy8Jh3rhsqqC2dp34FcaWoMMrxLTKAUz
         +qjdg3exntCjFNlOAIWjZQr40KeOkJ6I6RNgEtcmkcyPxzouYG8ydU1G8gz0wb9Zox+b
         kOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKIXxnGp5Qeh1H1kOjUA7WrQEgWAzUUtfWKKqj9aC5A=;
        b=lDn9mgjptMrHFIRf9xsLH5iU+KsTPdFoJ+6UkrPmasY1qW1JDQVjsVMjjy0lZkjD6F
         K/np1i7CUIYmLpJv2YQpcF5bQ2jYIWftKDfLhQdAlSYaRW4WgN1PfncD86SXpgr04bNz
         m79T1XfiNDn13c7GhmPuUP6gO7YKnn99JXer+MPndZxo/CzQhdjK+6jQBluREiojtQyX
         TEq+yZCWiD00xGIT5wC+XHokwWArsGG4XamHhjsrutQ/xR+JvcbeJtP28rov1tDczdf2
         HQf5vhKc7M0OdbxB/4KZDE4qr9ITcOfGQN4YbmdllpPDdDxbsqjWneTcIvNOYBekT/65
         aMwg==
X-Gm-Message-State: ANoB5pl8qr5EHeyniwib+nDjMJtMwrW3W1MZEy2GIt0bj4heUG0C7XJp
        j6yIQ7y9WmDCTzIPyCd8Xug=
X-Google-Smtp-Source: AA0mqf6Hba9NrxKs9cSo+ap0YeChuE8DZR0BYER9d526tatQdUrWAarN8isTG7rAZnMWfnuHLGBR1g==
X-Received: by 2002:a17:902:7fcb:b0:18b:cea3:645 with SMTP id t11-20020a1709027fcb00b0018bcea30645mr5353251plb.0.1671007327631;
        Wed, 14 Dec 2022 00:42:07 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b00189988a1a9esm1278650plh.135.2022.12.14.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:42:07 -0800 (PST)
Date:   Wed, 14 Dec 2022 21:42:00 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <Y5mMWEtHWKOiPVU+@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in struct RXBUF and refactor the rest of the code
accordingly.

It's worth mentioning that doing a build before/after this patch
results in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/char/pcmcia/synclink_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index b2735be81ab2..1ab2d552f498 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -105,7 +105,7 @@ static MGSL_PARAMS default_params = {
 typedef struct {
 	int count;
 	unsigned char status;
-	char data[1];
+	char data[];
 } RXBUF;
 
 /* The queue of BH actions to be performed */
@@ -2611,7 +2611,8 @@ static int mgslpc_proc_show(struct seq_file *m, void *v)
 static int rx_alloc_buffers(MGSLPC_INFO *info)
 {
 	/* each buffer has header and data */
-	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
+	info->rx_buf_size = max(offsetof(typeof(RXBUF), data) + 1, sizeof(RXBUF))
+		+ info->max_frame_size;
 
 	/* calculate total allocation size for 8 buffers */
 	info->rx_buf_total_size = info->rx_buf_size * 8;
-- 
2.38.1

