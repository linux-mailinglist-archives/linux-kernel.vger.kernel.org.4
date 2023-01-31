Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2426821EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjAaCLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjAaCLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:11:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92D32E60
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:11:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so5783305edw.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Jb+MSes6fGmewF1s3qNmS+/O55QAvEL9+JjECno9v0=;
        b=VoTQ2CwZGG8oPU/F8Phav0VrFlmZ/fJg8fKU3MW20abfWERbbX8Oc3+A9UPBgCUBxg
         kdOYHcSuhn/RJjcgJuCxYJJ59ayX0OiIR5I8OqUhPjnW3Ek4Q+bPS3s5/tn2SvB5k6tE
         eDaMhY1xOyl8e0AwhWGQC35l1eV+QoEhf/UeRTNMLez/fReIoPxAJ2af7lHQu/687zko
         o3rzOLgtyQpKM5+ACw14xY23P9iMOf1qv1LbyOnMb8zOlVZtHKdIVEhYnCPMxClTu7ON
         liZwEpPDK9EuHCBh5hDb5+SXnR/fQ4YiJOPgNwtSw0AWeexGuYa0ghnb9CAyEf2itTER
         TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Jb+MSes6fGmewF1s3qNmS+/O55QAvEL9+JjECno9v0=;
        b=0skjieE8L9CTmsyeShaPfLQqfwK7DQ0B2lOJxmC0JlpzJtABqV0k0q3dAXO+mzjcLX
         YZ67hfcXWNTDSVFzXYyGy6TOilGqDtE5Qz5jjMNlS/zbbfmKw7qovci2QssL05dbZ+QH
         xRRsAfbVnV6RBYrH/HzmROOxU6BeooC7V0NlXgEswhmGwCgrz88DJiykf7LjM4Bh9fG0
         f44IRUoqJ/Muc8sXdChHAzlvFlQUALwCxUWd/zwfH3vB/BFyeDi/ZRCTTrA4XoliBscP
         VlQ2BIvmfpmdASDrOE5XzzuzxX8EVLFSHB1iOJb+CIANx3xBXuyBrqoqWyMUdjhypRdG
         ARCg==
X-Gm-Message-State: AO0yUKUSMDOElvJC8zF4a4P4R8oGY99NxQiLjyJgkD4HSSs0wO/b9Osf
        vdPRUuMt5JV4owQK9myQTMV4yGsqins=
X-Google-Smtp-Source: AK7set+asRJM3XP9InXpn/F110xfk8v8lKMszcdFQymjgrbiA1VfQJ0D8NqDMwS9SeQ/lIH5dpOBoQ==
X-Received: by 2002:a05:6402:1d89:b0:4a2:6660:8fbc with SMTP id dk9-20020a0564021d8900b004a266608fbcmr859285edb.40.1675131101134;
        Mon, 30 Jan 2023 18:11:41 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id l3-20020a056402230300b0049f29a7c0d6sm7697966eda.34.2023.01.30.18.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:11:40 -0800 (PST)
Date:   Tue, 31 Jan 2023 03:11:38 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Message-ID: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
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

(struct pi433_tx_cfg)->bit_rate is modified from u16 to u32 to
support bit rates up to 300kbps per the spec

Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
---
 drivers/staging/pi433/pi433_if.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 25ee0b77a32c..1f8ffaf02d99 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -51,7 +51,7 @@ enum option_on_off {
 #define PI433_TX_CFG_IOCTL_NR	0
 struct pi433_tx_cfg {
 	__u32			frequency;
-	__u16			bit_rate;
+	__u32			bit_rate;
 	__u32			dev_frequency;
 	enum modulation		modulation;
 	enum mod_shaping	mod_shaping;
-- 
2.34.1

