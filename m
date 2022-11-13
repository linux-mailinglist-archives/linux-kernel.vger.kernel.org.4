Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5986A626DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 06:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiKMF3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 00:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMF3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 00:29:15 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE9EE1B;
        Sat, 12 Nov 2022 21:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668317305; bh=EeFml0IaVh7+u5qnzQtagdJSc1KAvZBsWOHbyeOYNx4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=KOZBBF8ZzyP8+Adcy+qOLOZzOlkxrcXlV/1gn5tau/R9wVfOoUJwBjMBw4dgrF8Xy
         FNBEvwDrkBjBBI5ROCWMnrzzG0hUM/5ObBfQIBD1sRz7bUIX+qmBm+77nacecf3XSG
         s5xjE/VaNHnLq42LOGys6eFaIvs9F6g+emXjAzkc=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 13 Nov 2022 06:28:25 +0100 (CET)
X-EA-Auth: V2uAWhgOqEgUOklpFT9QYQ6PeJWA+huKz/8ufkfSmKApy7VUb1qN+/MMT5P9VdXiAkkpb7O+rZRnkB5ETyQ03u9943HdS/7G
Date:   Sun, 13 Nov 2022 10:58:20 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: meter: replace ternary operator by if
 condition
Message-ID: <Y3CAdCa17WdWDYUa@qemulion>
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

Replace ternary operator by simple if based evaluation of the return
value. Issue identified using coccicheck.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Use if based evaluation instead of using min macro
      suggested by Joe Perches.


 drivers/staging/iio/meter/ade7854-i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index a9a06e8dda51..71b67dd3c8e9 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -61,7 +61,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
 unlock:
 	mutex_unlock(&st->buf_lock);

-	return ret < 0 ? ret : 0;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }

 static int ade7854_i2c_read_reg(struct device *dev,
--
2.34.1



