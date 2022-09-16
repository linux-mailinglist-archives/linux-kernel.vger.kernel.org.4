Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5403B5BA636
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 07:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIPFBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 01:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIPFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:01:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE3A2202
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:00:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v1so20366582plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=31XOOMkK9Oc4Uo5iDewTNx7+m2Ge2remVbyneSdNiqs=;
        b=Hmm5yiNsVxRjoNLbhYCrNffoZeu8xASTISX5YJYrjcmHfXVNB3B+3gZFJsYLzy/IP2
         HsyvN6Q4I8ZzzSLovqlWoGHjKCMxj8kIvTelNtXB2EGt+apm913ac+DIuRtvYH+FFCO+
         iinKcmoGTIpUdDohBExFZ4syFxeGhjVcaCTGPa3+JLN4WfXHYxMEe4YHenQsFoVcmn+w
         4hu2iJ2hAwNYHOtM1nvloCtfwLV+3V360517SXGybz9bwTL4+s6hu/Hu+KkHUwPsZYAY
         ILBvPPGXiEmxgCegwANNnfz0GYibgRCf+NXuOF1FmB1k8kCsd+iVoJk6WeEak9wRYCoQ
         p64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=31XOOMkK9Oc4Uo5iDewTNx7+m2Ge2remVbyneSdNiqs=;
        b=nJZTBBAoMG0jJNL813tKXI7WkMi8TYl3MtaH9+EbXpOBJUhH1H2upeJEqQmtzQVapP
         03uXIoy+BpLhw68PBW0TtrgEZm5de04Yw75MGLFRE6VBzzNuiUB1oFvlIj+2/TMDi4zN
         HnRxnD5LFBKj3BglEAKu5oh2LTS18v1uFXAlL5IwOtoXjyb+mLLiOH72LCSTzAPqcih0
         y+wjxXUgcUEcDeqCHDum0IIv+zhBSMS1R6nAndgOvSpAS3+7zSy7ii9D+4SbQewVUdci
         c8GXmxwQnl5Nb0fEt5UwJ1sK+V9NCxwLLnBp378x9qgWnteCG5yZViUsKBbJfjWaCOKl
         pwoA==
X-Gm-Message-State: ACrzQf2nbfJscbp0GI2QK3p4FXIHB/VxtbpUxIN/AR/4+A8vrImVLK/k
        Kl3eb15l4+O+SfCEX6S5/GM=
X-Google-Smtp-Source: AMsMyM5B3GjPKekR728nUwjMmk4Pq6XzpRYdrPGI69Lgrd4czGo7cskfirUTp7GzSJBZ7uzCm6554w==
X-Received: by 2002:a17:902:e405:b0:176:8bc1:b09c with SMTP id m5-20020a170902e40500b001768bc1b09cmr2842804ple.1.1663304410943;
        Thu, 15 Sep 2022 22:00:10 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7982e000000b00540dbae569bsm13392598pfl.109.2022.09.15.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 22:00:10 -0700 (PDT)
Date:   Thu, 15 Sep 2022 22:00:06 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     lkundrak@v3.sk, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] char: pcmcia: scr24x_cs: Fix use-after-free in scr24x_fops
Message-ID: <20220916050006.GA188273@ubuntu>
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

A race condition may occur if the user physically removes the
pcmcia device while calling open() for this char device node.

This is a race condition between the scr24x_open() function and
the scr24x_remove() function, which may eventually result in UAF.

So, add a mutex to the scr24x_open() and scr24x_remove() functions
to avoid race contidion of krefs.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/char/pcmcia/scr24x_cs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 1bdce08fae3d..319e8d79048e 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -76,8 +76,10 @@ static int scr24x_open(struct inode *inode, struct file *filp)
 	struct scr24x_dev *dev = container_of(inode->i_cdev,
 				struct scr24x_dev, c_dev);
 
+	mutex_lock(&dev->lock);
 	kref_get(&dev->refcnt);
 	filp->private_data = dev;
+	mutex_unlock(&dev->lock);
 
 	return stream_open(inode, filp);
 }
@@ -298,9 +300,10 @@ static void scr24x_remove(struct pcmcia_device *link)
 	cdev_del(&dev->c_dev);
 	clear_bit(dev->devno, scr24x_minors);
 	dev->dev = NULL;
-	mutex_unlock(&dev->lock);
 
 	kref_put(&dev->refcnt, scr24x_delete);
+
+	mutex_unlock(&dev->lock);
 }
 
 static const struct pcmcia_device_id scr24x_ids[] = {
-- 
2.25.1

