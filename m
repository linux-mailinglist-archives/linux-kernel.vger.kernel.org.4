Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A136EAD4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjDUOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjDUOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:41:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A50B15613
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:40:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f191c1a8a7so5550235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1682087922; x=1684679922;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wywWnhOuE+0DcIU4ueBcvpTkOXGVmA0wp8sn1mo73kY=;
        b=JHPN1tlNTN2wco5YysAMlww7I2VPprMyPlat9vVd5y9RjtQAthg5h62tLTT48gidC0
         wG4QYINpbTbiiVWd0SHKroZk73Hrqb02/w69C4zKa8rcSbtP77Blz0mts+h4eyy+z5ZG
         a9WXf4A3zroXWeKuMPvILGbWw7J+L9vIwBGBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087922; x=1684679922;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wywWnhOuE+0DcIU4ueBcvpTkOXGVmA0wp8sn1mo73kY=;
        b=hKCpZnEl8jHEf218rshnfbwYSKxbmAcqwA2S9jIoU4f3eNyaRMw2AjUOfg54O2CYBU
         DBbZb7Psu7NjeXgQQZB0jfzPESPFP04bC/bO8dtkcTo5Is/g0qZT005iUFHo2qWO6k7z
         TUvZGz5qBqo05gyn9KZ82HI4ZkCsoflYQpOIYXmiJc/Jk6JwWCeDguqg116K3Y0wCKXw
         C+diMKN9169shs9KRTTiK70D/avJjtG7S2BqWWprdg1xKFkh83dG5q+Z34GOJE2dZKPU
         wqmgThQkV5F752iJiNBXkOWvhLLbACW1M/3oS2wXjpHnw0uSApHDQbDq0cZLX4sbCYpS
         YY+A==
X-Gm-Message-State: AAQBX9endR/1yW7fwM5ujZcv3JChHmvTpAwvdxXv5VXFb8R8s4x6Woy2
        ywh+W2pg6ac4k8BOnGqcie3zsHXvu6l1Dv0A5LU=
X-Google-Smtp-Source: AKy350aEqS8sC+wbkiEZM0CsknXZhhHf/KGNghGClrvOUjU+3SvBSQx8CZUQt8Z/tSJP4fi0KG1ACg==
X-Received: by 2002:a7b:cbd9:0:b0:3f1:94fe:65e0 with SMTP id n25-20020a7bcbd9000000b003f194fe65e0mr1484021wmi.26.1682087922446;
        Fri, 21 Apr 2023 07:38:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id y32-20020a05600c342000b003f173956a82sm8268375wmp.21.2023.04.21.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:38:41 -0700 (PDT)
Date:   Fri, 21 Apr 2023 15:38:41 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] usb-audio: Rate limit usb_set_interface error reporting
Message-ID: <ZEKf8UYBYa1h4JWR@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an error occurs during USB disconnection sometimes things can go
wrong as endpoint_set_interface may end up being called repeatedly. For
example:

% dmesg --notime | grep 'usb 3-7.1.4' | sort | uniq -c | head -2
   3069 usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
    908 usb 3-7.1.4: 1:1: usb_set_interface failed (-71)

In my case, there sometimes are hundreds of these usb_set_interface
failure messages a second when I disconnect the hub that has my USB
audio device.

These messages can take a huge amount of the kmsg ringbuffer and don't
provide any extra information over the previous ones, so ratelimit them.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 sound/usb/endpoint.c | 5 +++--
 sound/usb/usbaudio.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 647fa054d8b1..2cd99cc8c360 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -916,8 +916,9 @@ static int endpoint_set_interface(struct snd_usb_audio *chip,
 		      ep->iface, altset, ep->ep_num);
 	err = usb_set_interface(chip->dev, ep->iface, altset);
 	if (err < 0) {
-		usb_audio_err(chip, "%d:%d: usb_set_interface failed (%d)\n",
-			      ep->iface, altset, err);
+		usb_audio_err_ratelimited(
+			chip, "%d:%d: usb_set_interface failed (%d)\n",
+			ep->iface, altset, err);
 		return err;
 	}
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index f5a8dca66457..38a85b2c9a73 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -67,6 +67,8 @@ struct snd_usb_audio {
 
 #define usb_audio_err(chip, fmt, args...) \
 	dev_err(&(chip)->dev->dev, fmt, ##args)
+#define usb_audio_err_ratelimited(chip, fmt, args...) \
+	dev_err_ratelimited(&(chip)->dev->dev, fmt, ##args)
 #define usb_audio_warn(chip, fmt, args...) \
 	dev_warn(&(chip)->dev->dev, fmt, ##args)
 #define usb_audio_info(chip, fmt, args...) \
-- 
2.40.0

