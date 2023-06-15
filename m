Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5037315E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbjFOK6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343683AbjFOK6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:58:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57767269A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so10175909e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686826712; x=1689418712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgVb0YJLMNEKVO6C16PIZb2dGiXFxsfavrt5+857HKY=;
        b=Yj0kx/mnMznFixbKd4cfvllbue4ow0vPQ2gb+hHs05qEo6g4Jz/KzZ0EHGDOTImMCh
         zHMvXOrN5dBlTFH+k4+0P3iorwv+DW9guDy5mX/Ti9JcTz4AzcAoL9X/pN9kqQNA8VrI
         JplgpIs/BHXocNT0DLT/VPqf/fiJ63TRiu0js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686826712; x=1689418712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgVb0YJLMNEKVO6C16PIZb2dGiXFxsfavrt5+857HKY=;
        b=Bm65Hb4wxXdDxTMbxdX3U7ZcL3T/NVnVsbDaOg9kFdMjqx/yN5W3SLjObif0+WwLhB
         xNdmH/qAw16F1D1kQrZlRB6Tesn8j/oqnlMV1hdXEMW7gUklAlvHmjRTcu9RElrEAyf8
         B1Qb1fblJiRA9poNf1c2HbivzWdBi84oc1gQ3LYJE7SqUOjIlw/5/6p+F+F5SmXmyHdO
         NLfEqAA/W7X0aTAAXqR7nKfzve3DTQ8gTmbFtTXPkjb2iBjlvwsDpGwnqXGhuwOSZ99z
         wjQewJzmnVKSdtlpxxzEpUpvMx5IfZoD+cviZtwXBChhs7tfnzBR0+Yzn1wGYaWEaejb
         odpw==
X-Gm-Message-State: AC+VfDwdCp0xFwIDDXIkrvqJ1hJak5//weVCK68yLvnvGi1CiOTPLJg8
        MnamjCW7d6GB/cEpDt6yFOSfnw==
X-Google-Smtp-Source: ACHHUZ7R1TJP7+lICTrGlXmck65FIWV3+MNalxpQW7+KmHqWIgonNn0yfiR966KdXWuQYILZ/lSe4Q==
X-Received: by 2002:a19:9145:0:b0:4f6:4bf6:59a1 with SMTP id y5-20020a199145000000b004f64bf659a1mr9728645lfj.34.1686826712565;
        Thu, 15 Jun 2023 03:58:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25967000000b004f13f4ec267sm165364lfp.186.2023.06.15.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:58:31 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] rtc: isl12022: remove wrong warning for low battery level
Date:   Thu, 15 Jun 2023 12:58:19 +0200
Message-Id: <20230615105826.411953-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230615105826.411953-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple problems with this warning.

First of all, it triggers way too often, in fact nearly on every boot,
because the SR_LBAT85/SR_LBAT75 bits have another meaning when in
battery backup mode. Quoting from the data sheet:

  LOW BATTERY INDICATOR 85% BIT (LBAT85)

  In Normal Mode (VDD), this bit indicates when the battery level has
  dropped below the pre-selected trip levels. [...] The LBAT85
  detection happens automatically once every minute when seconds
  register reaches 59.

  In Battery Mode (VBAT), this bit indicates the device has entered
  into battery mode by polling once every 10 minutes. The LBAT85
  detection happens automatically once when the minute register
  reaches x9h or x0h minutes.

Similar wording applies to the LBAT75 bit.

This means that if the device is powered off for more than 10 minutes,
the LBAT85 bit is guaranteed to be set. Upon power-on, unless we're
close enough to the end of a minute and/or the boot is slow enough
that the second register passes 59, the LBAT85 bit is still set when
the kernel (or early userspace) reads the RTC to set the system's
wallclock time.

Another minor problem is with the bit logic. If the 75% level is
reached, logically we're also below 85%, so both bits would most
likely be set. So even if the battery is below 75%, the warning would
still say "voltage dropped below 85%".

A third problem is that the driver and current DT binding offer no way
to indicate the nominal battery level and/or settings of the Battery
Level Monitor Trip Bits. Since the default value of the VB85TP[2:0] and
VB75TP[2:0] bits are 000, this means the actual setting of the
LBAT85/LBAT75 bits in VDD mode doesn't happen until the battery is below
2.125V/1.875V, which for a standard 3V battery is way too late.

A fourth problem is emitting this warning from ->read_time:
util-linux' hwclock will, in the absence of support for getting an
interrupt when the seconds counter is updated, issue
ioctl(RTC_RD_TIME) in a busy-loop until it sees a change in the
seconds field. In that case, if the battery low bits are set (either
genuinely, more than a minute after boot, due to the battery actually
being low, or as above, bogusly shortly after boot), the kernel log is
swamped with hundreds of identical warnings.

Subsequent patches will add such bindings and driver support, and also
proper support for RTC_VL_READ. For now, remove the broken warning.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index e68a79b5e00e..ebd66b835cef 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -141,12 +141,6 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	if (ret)
 		return ret;
 
-	if (buf[ISL12022_REG_SR] & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
-		dev_warn(dev,
-			 "voltage dropped below %u%%, date and time is not reliable.\n",
-			 buf[ISL12022_REG_SR] & ISL12022_SR_LBAT85 ? 85 : 75);
-	}
-
 	dev_dbg(dev,
 		"raw data is sec=%02x, min=%02x, hr=%02x, mday=%02x, mon=%02x, year=%02x, wday=%02x, sr=%02x, int=%02x",
 		buf[ISL12022_REG_SC],
-- 
2.37.2

