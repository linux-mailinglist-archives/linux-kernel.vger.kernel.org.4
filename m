Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76800692EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBKHHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKHHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:07:39 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9E311D0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676099233; bh=RIfix2BpIp1e0NF6h2agOCXPTL1PhRt5VacNf+Tky2s=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=FjpVlUq76bhJL/v3aoVln2M4vSQgw4Eka/+zUp6+X+Ycwji5MloFE+3Q6sPqYqeua
         /GzBw/zq1TM3/pXlTTcWv2xkjxmK/nWhDpBoql7keR1i1ICrO1EtfqTmlowNfW52xq
         k3c8R5hJZYVrrkL71l2BrPRia4RIlnpSsOz7cVk4=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 11 Feb 2023 08:07:13 +0100 (CET)
X-EA-Auth: gHMncWwrRzH3mBBPy4G5q3D2TK5uws+5aKfERZVMvxXMLR5um+/vvukcB+73UqH/MgSb1XCFOVEm3i0ZsB0fAV1nre4hqvwe
Date:   Sat, 11 Feb 2023 12:37:07 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] iio: frequency: adf4377: remove duplicate/repeating constant
Message-ID: <Y+c+mwNnlPpSH49/@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constant ADF4377_0000_SOFT_RESET_R_MSK is unnecessarily or'ed with
itself. Remove the redundant constant from the expression.
Issue identified using doublebitand.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/iio/frequency/adf4377.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 26abecbd51e0..caefd7ea6b14 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -495,8 +495,8 @@ static int adf4377_soft_reset(struct adf4377_state *st)
 		return ret;
 
 	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
-					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
-					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
+					!(read_val & ADF4377_0000_SOFT_RESET_R_MSK),
+					200, 200 * 100);
 }
 
 static int adf4377_get_freq(struct adf4377_state *st, u64 *freq)
-- 
2.34.1



