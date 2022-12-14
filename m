Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEE964C565
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiLNI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiLNI7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:59:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDED1FCC4;
        Wed, 14 Dec 2022 00:58:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so3541316pjb.0;
        Wed, 14 Dec 2022 00:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJpPmTe/XBClfxdnG0INFkwd4DEdd16k8DnX9kH12Oo=;
        b=nDsigzCB1W7unRbCm/62QVdANiKye41IPr668xqAA/mAmbC5qg+yVVhU3Rq9BCSfr8
         vZ1Kljwnw7W0Saf6246IeTK3MFXLQtrk67qxycMVU1luzfjhPkC39F6FRskX2IxhdfMJ
         4QYcjiQ91bNvBbafQwqk2dsjV0CVjZd3HR9JYjz0YdrUe7hEvTAyiujPZxJSlHKscixR
         tpD5uRf1c7/GidwqXdFBUx5IS7HRpe6IVxSD+2qg4k7Bd0n2I+CLOwzbIOA+Qn+b07Kd
         DXTa/HFQtMAb0wDq9cUclcQOSzTPxAlj6tcZSEj5IhTO6gNZngH0Vszu64SfpxesjDSm
         TsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJpPmTe/XBClfxdnG0INFkwd4DEdd16k8DnX9kH12Oo=;
        b=4T2pId9gMb1sdUmeWrHLGokL9524SalcGyBqJXCr+pckmhWpgbEJhcQdXoV2DvKeKX
         rFW3eg8JYJBhXFCTMcaoqSoj/Hx9DPFHvplwyH1SRDyS8VhCv8hFxQF50ZIPuURJcGDs
         lNM2r3hqIqe+GiI9nNS/ogBfsc6vbiIHY7Z7KneVKI+6uY267JFespddfRz189HrhhQM
         kT1Bvr9LALsZrub+FTli4kI2EjvIWepMvPHIOD3RvIf7tHhirXu5OPIiJq7zK0MT1rk9
         sfQLTd7B0/vhdFZF0CJeqICrmUN9vqyN2sU/fhUXj2fdIM/swkcjq5jngNIrW39smAZh
         Aj+g==
X-Gm-Message-State: ANoB5pkzxdcUYhSgWHJllD6WSOKoMI8iAmOAutJyl/e8nk/2oLVp4lLa
        6lDIoEHbL8T/Xv1qNVoBcZ0=
X-Google-Smtp-Source: AA0mqf4jHLLcFiPuJmR9AvYsVGZxYSKqcp1xdj0nTpCk4d4X5bTvCxT/+wXnw7Fmpm2x/Im3UKD4Tw==
X-Received: by 2002:a17:902:6b08:b0:186:639f:6338 with SMTP id o8-20020a1709026b0800b00186639f6338mr5984814plk.6.1671008338906;
        Wed, 14 Dec 2022 00:58:58 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902b18f00b00189393ab02csm1327487plr.99.2022.12.14.00.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:58:58 -0800 (PST)
Date:   Wed, 14 Dec 2022 21:58:52 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v2] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <Y5mQTOqFOGbJMerV@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5mMWEtHWKOiPVU+@mail.google.com>
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
flexible-array member in struct RXBUF. No changes were required
within the source code because of the existing padding in RXBUF struct

It's worth mentioning that doing a build before/after this patch
results in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

- v2: removed changes to how the size of RXBUF was calculated. I
  changed my mind after thinking about the existing padding in the
  struct. Happy to discuss it if anyone sees it differently.

- v1: https://lore.kernel.org/lkml/Y5mMWEtHWKOiPVU+@mail.google.com/
---
 drivers/char/pcmcia/synclink_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index b2735be81ab2..0b03c6d13d59 100644
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
-- 
2.38.1

