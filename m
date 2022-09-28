Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0C5EDD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiI1NXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiI1NXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:23:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F3DA1A59
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:23:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so19793116wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date;
        bh=7NfAh4IDJO5OpQPrNz1bZm64Hhig0ttigWq2pw/+PUY=;
        b=p2x+JuRi6W3dWNl/F8DS5j+Pk/6DK2VoBJOUP8I/JodSe5kDHi8Avtamecz/8ow3sw
         bYoOOVd1nLR8ZCKkiy+g+pkjstv0HZDhJxCWNNNZzIolgAed6MDAcIqb9YwAAQdxEvj6
         F62ApYAwVdw5Wrm2BqnyOIfg6N0RaezZ9QfiLDvCDEroXnoGQ3eZDNczIZ4PpfF7ZdF2
         6uhpmL9oTM8ZaMISGjxqQSL4vk4IeaurBhT8mBTcGrHOHZbb3m1yL+I+lKZ2Q9LDX7iC
         85EEHl02gTse0A4S86dEi3GpM6RLv8eFHuc6fhoUy95pkYVFJ2/VhGKGj0I3Vg1mkAb7
         JzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7NfAh4IDJO5OpQPrNz1bZm64Hhig0ttigWq2pw/+PUY=;
        b=pNI5yWT8xcSfAKLrLngDWnjg2RPUcU1PwwKZJhKNfkdWh3qQurDEUElSsQXhAd04VN
         WYbdfZXyxo3r6ujl4T/KN+KMAJeq1NAL9ePW/WNZdvv6XKAeIKL6/WZZnjb3Fd1IZQY7
         IRHfor03PWmSJa3n1IWpIxaw2dV/O/XTA6TzGFQeKqVzN8xehk1uyFa+BMIR619sQFNy
         bQrXfRDy+PTzwaMX7+yiEm3ECMUz9EiWpN+6YTkRYl/tSVoQwav2dIJlm49Hswmp9n3i
         3AdQOXaThVRqmo09BuelEJ7OIlOHqgaC6PP39pUf88hCplHxXT2l+7QXsJl2+Dyz/AWa
         iX1w==
X-Gm-Message-State: ACrzQf14eEh8gVLXe2diZeF6Xryqj7T6NdyvfIrpro1e4ahyZBjhQF2U
        COLuvbKOGY0U5T/ci5CSJkh1IeDFdA==
X-Google-Smtp-Source: AMsMyM4b1Y91VhoOy7rWb9h/HEx+gSbss6rKalCIcO7obMzfFEeAL3kXPHkYqjZQ7ousNls9iJnsVg==
X-Received: by 2002:a05:6000:547:b0:218:5f6a:f5db with SMTP id b7-20020a056000054700b002185f6af5dbmr21031288wrf.480.1664371423216;
        Wed, 28 Sep 2022 06:23:43 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id a5-20020a1cf005000000b003b4764442f0sm1739525wmb.11.2022.09.28.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:23:42 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
Date:   Wed, 28 Sep 2022 14:23:41 +0100
To:     gregkh@linuxfoundation.org
Cc:     hsweeten@visionengravers.com, abbotti@mev.co.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] comedi: Convert snprintf() to sysfs_emit()
Message-ID: <YzRK3Ye3FKTe8p4y@octinomon>
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

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf

Adding to that, there has been a slow migration from snprintf to scnprintf.
This LWN article explains the rationale for this change

https: //lwn.net/Articles/69419/
ie. snprintf() returns what *would* be the resulting length,
 while scnprintf() returns the actual length.

However following the advice on
https://www.kernel.org/doc/html/latest/filesystems/sysfs.html

For show(device *...) functions we should only use sysfs_emit() or sysfs_emit_at()
 especially when formatting the value to be returned to user space.

Hence here
We convert to sysfs_emit() that even does better and shorten the code
using the same rationale of scnprintf()

Signed-off-by: Jules Irenge <jules.irenge@postgrad.manchester.ac.uk>
---

v2: Replace scnprintf() with sysfs_emit()

 drivers/comedi/comedi_fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 55a0cae04b8d..a6017fafcb2a 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
 	mutex_unlock(&dev->mutex);
 
 	comedi_dev_put(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", size);
+	return sysfs_emit(buf, "%u\n", size);
 }
 
 static ssize_t max_read_buffer_kb_store(struct device *csdev,
-- 
2.37.3

