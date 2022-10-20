Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A476060F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJTNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJTNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:06:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CA15203A;
        Thu, 20 Oct 2022 06:06:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v11so4869687wmd.1;
        Thu, 20 Oct 2022 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V16xoQI1tSvYN6IGg2SDhKuuEiPSYX/4oIZVHGpPsQk=;
        b=XxJGPF6oWoNUx1PrHhLIitquoV5XTR+5mfEp8ZNQ96RoiboZJ0HQdPTHCS8mJKlhq3
         dlHi0SVvYpeB83SCjONZYQhCvj4t1ifLdaHa2/p2gZs2tCiOtSww1MKKWCzBbBPncjO5
         6ZKD2pekBBu/ISXZI99q63h943NNphej+86cRrSxrG/UVXVv5clpC5eCptFspOmbIyHD
         Q19K/CR995gjFd6+v47YpKG/iedrfARYXaSbQHLAmAqUJw8KH5sOJsoKvuJbMZcBgBUd
         lUrj6Ksq6Z9elLHDX0jBy2s/WI2UQ/dTso+AEqFu369DsJSk4v0NifTlX3eb0r2c44vW
         CYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V16xoQI1tSvYN6IGg2SDhKuuEiPSYX/4oIZVHGpPsQk=;
        b=OlTjwFbwzWUrIzWXj92jFuQoEQqdX6mcCRU5XLeRQD1aDqXJxCyAouQquUmjO4sphV
         elJ5S13TsqafA3Oq0D3s+Bl15asDR4yxqmEkvNQ4R6vz4LjjBKOkxf0FOPLt0bqcxDl9
         ojhwnMcR3/C5/qfwx6a70L9Exx6+hXINTHlLZ1CAWb+qrTr8lPtfI4b80YivihIOCjpH
         duA++bZjnAPrmoCYdfyacsfE82aOTMRZTN+j6dBhdpaZWS5ymqsW97Z7CLx+sJz082nC
         loTUIUNN9huG4XZZcBbBjquo0FfVlAvvkmXzhAMznxGAf+DKqAVpTICdIHFBKLvjPzKn
         mJiA==
X-Gm-Message-State: ACrzQf0iZNAebKt8XvttYInmr39AWi/SkIsB/9EJtZH93zhSNO3561qF
        yl24ix2qPlO8kI0v6Z3MuJY=
X-Google-Smtp-Source: AMsMyM7povvYGvKNerEps/8u/UNbrMtviHbs5BXU3wiXZLvxfGxznWrL3AsaVuIuopdqk+ZEVbNf1Q==
X-Received: by 2002:a05:600c:4e50:b0:3c6:faaa:1e7d with SMTP id e16-20020a05600c4e5000b003c6faaa1e7dmr9595076wmq.9.1666271211158;
        Thu, 20 Oct 2022 06:06:51 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r1-20020adfdc81000000b0022e3538d305sm18741769wrj.117.2022.10.20.06.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:06:50 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ftdi-elan: remove variable err_count
Date:   Thu, 20 Oct 2022 14:06:49 +0100
Message-Id: <20221020130649.1546112-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable err_count is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/misc/ftdi-elan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index b2f980409d0b..33b35788bd0b 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -1956,7 +1956,6 @@ static int ftdi_elan_synchronize(struct usb_ftdi *ftdi)
 	int long_stop = 10;
 	int retry_on_timeout = 5;
 	int retry_on_empty = 10;
-	int err_count = 0;
 	retval = ftdi_elan_flush_input_fifo(ftdi);
 	if (retval)
 		return retval;
@@ -2051,7 +2050,6 @@ static int ftdi_elan_synchronize(struct usb_ftdi *ftdi)
 					continue;
 				}
 			} else {
-				err_count += 1;
 				dev_err(&ftdi->udev->dev, "error = %d\n",
 					retval);
 				if (read_stop-- > 0) {
-- 
2.37.3

