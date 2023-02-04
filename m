Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD468ABDF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBDSfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDSft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:35:49 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5993F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:35:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m2so8366604plg.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Iggp5kqvksO/U/bhTVuafQ0FnnRUqQxs3NZ2skqWs=;
        b=YGU2UvvQE8nEH1e9k70ke2m5p/SmROFmLZu5F10bu5KeeB2DlDoMjKuuL4OeKG3600
         Qxwb+spG4ji9S/uUuG3O3dc1dtOP/eu+J9qzbHGzLs78JjaN1Y+TVx3LWLXiV+87du+U
         vhJ45u9oSq12BM9Vg/OxabaPk6UV4T9ZdHrW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Iggp5kqvksO/U/bhTVuafQ0FnnRUqQxs3NZ2skqWs=;
        b=mTniNlZpLrpQoDsg9l6g2JJzmA3lLRn6tMyJNqYrWeIINzLp7jlmjiKFVeXQvisxIs
         jFZzCakAmqb4PgV6Ktk1v6QOza10gr0eze9/stJlDpb9kIYa8gNLdQkRxCFdvqLppx3x
         t/ElSUlD0kpW84X+7+i/Tj8Yfncee90EDj+6gsvjsKrVHYYVqlzLRkh/Y9X/lilu+Qp4
         0d/qf/C1KaQr4eXSWKnXuT+IH3GlPxx4z4+051APjVRlhEAszqG6EI2Kt8kAzVZcROXB
         ZcjS1yeK5NHxU9eZzCaRaIyMyhSsHI+8U5CEeaxtoibb+ZrwhzEzNsTrsV1UQD99+Zyy
         CONA==
X-Gm-Message-State: AO0yUKUndQzjPcMbY/7UmpNOoEtHGhCkmAAffp5mOLqkj96I6J0Hig5F
        iUMBiiR5q6Mdbmsu4jK5TfakAW6aTyn5g9En
X-Google-Smtp-Source: AK7set/Ipy9LMwppXMkdEyP44q/GSHSpT7gPZAzBZWD9Xw3ds3PVWaExsNhPfU+KJdmiSqT4WTfFHw==
X-Received: by 2002:a17:903:30d4:b0:198:eaac:4643 with SMTP id s20-20020a17090330d400b00198eaac4643mr3371011plc.4.1675535748368;
        Sat, 04 Feb 2023 10:35:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b001947ba0ac8fsm1258800pla.236.2023.02.04.10.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:35:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] USB: ene_usb6250: Allocate enough memory for full object
Date:   Sat,  4 Feb 2023 10:35:46 -0800
Message-Id: <20230204183546.never.849-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; h=from:subject:message-id; bh=HZQ/N+dDa7Aj5LUGfDBEb4DGw2KcwT9Ja3nU44I+6Qw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qWCaI/XfC+dVjIlk4z3PejMwVwypoWj0t55dUNY ngLmhQmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96lggAKCRCJcvTf3G3AJrbCD/ 9/OMKzc0Ea/9XHo64RRzTHtQLOvCN4nDl6tDnY8I1zWmllZ4q7R4+dmSxpbDIlA1KsOMbqJv2uZ3j5 xU9a2RW8+9cuCUgglfThFn9yjAPn1h89UITBR6tUi66w+Grrrdqabel966IsLL4h0anfdvniLx9/Q+ 1gLIInMAeYSny+rZXufLpRHcsPV5/arwLM6+LhebZHEU0XgPYkzu78s6vN2nl7OX7oznGan2XOpyWL kImWBreBw5D9hD5Wz84Nwz0c9oTNLTzZElayos7V/uArYc5g0sjwNhZT43GlePcRiqDz5YRUCLHMUI /K63RXa6N+Ch7kLHz+Omnb0TG+PD5yo0jQ086va23SsFfob6w1eniL3YEyMwf6p2jnJor+w9yLC6Et X80luhybjh3sy7/0+kv3H/eQTqGfpwkmgOg7tbP/7oyOuoRaao84Y+7ZihUBDPjgw7QXidM/84PNsE vl3CSDyif7jEsz37rqaD+SmUhw9r61ZRPHqcC96s1IhKbEx2DHGBtrDX11Ujx4MsTsrwS9uaMClIO2 c3LeUjG/p85F6vlRU5h0rahbAFsFntLTrIVfxIf1vpscY9Z7Hkq0PmxL3BOM/GsX4Iv42pg1jjF4wi ws5dSc4t27nmVzA239IFWffYQbmVO4gbgpLtpR5L6qrz+uYyMftjEgLZdgzw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation of PageBuffer is 512 bytes in size, but the dereferencing
of struct ms_bootblock_idi (also size 512) happens at a calculated offset
within the allocation, which means the object could potentially extend
beyond the end of the allocation. Avoid this case by just allocating
enough space to catch any accesses beyond the end. Seen with GCC 13:

../drivers/usb/storage/ene_ub6250.c: In function 'ms_lib_process_bootblock':
../drivers/usb/storage/ene_ub6250.c:1050:44: warning: array subscript 'struct ms_bootblock_idi[0]' is partly outside array bounds of 'unsigned char[512]' [-Warray-bounds=]
 1050 |                         if (le16_to_cpu(idi->wIDIgeneralConfiguration) != MS_IDI_GENERAL_CONF)
      |                                            ^~
../include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
   37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
      |                                                   ^
../drivers/usb/storage/ene_ub6250.c:1050:29: note: in expansion of macro 'le16_to_cpu'
 1050 |                         if (le16_to_cpu(idi->wIDIgeneralConfiguration) != MS_IDI_GENERAL_CONF)
      |                             ^~~~~~~~~~~
In file included from ../drivers/usb/storage/ene_ub6250.c:5:
In function 'kmalloc',
    inlined from 'ms_lib_process_bootblock' at ../drivers/usb/storage/ene_ub6250.c:942:15:
../include/linux/slab.h:580:24: note: at offset [256, 512] into object of size 512 allocated by 'kmalloc_trace'
  580 |                 return kmalloc_trace(
      |                        ^~~~~~~~~~~~~~
  581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  582 |                                 flags, size);
      |                                 ~~~~~~~~~~~~

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: usb-storage@lists.one-eyed-alien.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/storage/ene_ub6250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 6012603f3630..97c66c0d91f4 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -939,7 +939,7 @@ static int ms_lib_process_bootblock(struct us_data *us, u16 PhyBlock, u8 *PageDa
 	struct ms_lib_type_extdat ExtraData;
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *) us->extra;
 
-	PageBuffer = kmalloc(MS_BYTES_PER_PAGE, GFP_KERNEL);
+	PageBuffer = kzalloc(MS_BYTES_PER_PAGE * 2, GFP_KERNEL);
 	if (PageBuffer == NULL)
 		return (u32)-1;
 
-- 
2.34.1

