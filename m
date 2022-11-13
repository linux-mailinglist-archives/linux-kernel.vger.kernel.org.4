Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11FB626CFF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 01:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiKMAeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 19:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 19:34:11 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4581007A;
        Sat, 12 Nov 2022 16:34:10 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A05569215DA;
        Sun, 13 Nov 2022 00:34:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0846A921761;
        Sun, 13 Nov 2022 00:34:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668299649; a=rsa-sha256;
        cv=none;
        b=ma6lrhkUf8uCtUEDpKvXhfDmjsb0M7paiCO9kYoOYYjDHQFjAvgqWAwrfaz5K7PtqNNZnr
        ZmvUhnDA6X2TctZ0wSFAzAdNigOdzjslsxugEPDZm3W5DvNNWdhJf2ogk9f+dHd9sm3mkX
        MyjPK8DVFs5PSo2wZtJgumrMix9liBrFe7H8S1rLQ4ch2sqKSyMfFvc6ENlrAtuNeOWJal
        NcbMrMwGaqmbyuOwRxraammsXzU7LHf1CyoGuIRj3bisCpzrqySaauTHV8nK1Q41nd4xgh
        R/BqSkAH8KTWb2H54DQ6yQuHhfm9JulQDEv9YSeBhb9GfEmEIny8DOvGtn9EXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668299649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=M6IIwBOYgKSoXfGxRWMpbbBoj288YwgeCsZzd5ssM7s=;
        b=bx+hCdQy3I+qVnNPAUXMQoUn8fh6NLRd9oCN8al5r0n+8fuSCvQuw8pWTyowc0OLcc4ENS
        lZ00fRPC4VCChxDxhriFHeIo8Yo+H+q/nepDt25lYmO/B51dJSXzKu0DW9Jb9c4w3k5Rja
        in+9cHXcLQ/hjVer0SSQrdbOdPv+1wtdza2I4Es6R2xav6X5myEPlTqouTretONCVnke9q
        OT7L5rnm0C2ZxSVWpVTj8izaK+EoNgkimziLQdvEeFr53c3U5IMgfJ8piiNcu/VHnvmJy+
        1jAmIgUaBq4bRmhSTJMsKelldOeJUM1VAuspHNEEd8MUPZWEfnbjhPU7GcAWRw==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-nvvnz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Average-Stop: 2ad6ad9a7b319d8f_1668299649314_839199821
X-MC-Loop-Signature: 1668299649314:468532582
X-MC-Ingress-Time: 1668299649314
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.213 (trex/6.7.1);
        Sun, 13 Nov 2022 00:34:09 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4N8tjX16x8z6K;
        Sat, 12 Nov 2022 16:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668299648;
        bh=M6IIwBOYgKSoXfGxRWMpbbBoj288YwgeCsZzd5ssM7s=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=1B+3ESfXdFqSFffHJ0KTxzzT7VgWLrlb5MQBFmSWc9oVNpDiF41PWTjB/HFhHAIcJ
         GEU9Dpa0JBDa2i1Yr5B4Kw+MBF8vAy0Q/S5uWyCfghD1NYIhiBgDi2g4isJLL5mOpv
         k3Lto8KmVqfp+CP6kpDGDrznL5Hb2eBFICzm1oOciyLEMeXftgeMhzDGmz5MFpfSdC
         /3ZzHDRmAaU54a2MbPiaeg8HuVrW4nk/K7pCzdsuxnb4WOjyAlnxl+/ImQFfpWEE2R
         EGavIcc/pIeupobvv6/yRUDiruY0NI5y/PDnj4Cp8KBpmNHXi7hg0xwgmSxFyFvfY+
         Oh89HaR3TF08w==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH] staging: media: omap4iss: correct cacheflush import
Date:   Sat, 12 Nov 2022 19:33:47 -0500
Message-Id: <20221113003347.93483-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the import for cacheflush from the asm directory to the linux
directory.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/media/omap4iss/iss_video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
index 842509dcfedf..9f08dd976a24 100644
--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -7,6 +7,7 @@
  * Author: Sergio Aguirre <sergio.a.aguirre@gmail.com>
  */
 
+#include <linux/cacheflush.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -19,8 +20,6 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-mc.h>
 
-#include <asm/cacheflush.h>
-
 #include "iss_video.h"
 #include "iss.h"
 
-- 
2.38.1

