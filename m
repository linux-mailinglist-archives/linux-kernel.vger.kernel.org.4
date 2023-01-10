Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A689664D94
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjAJUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjAJUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:42:06 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296238AE8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:42:05 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o13so6993608ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuOs6iuIO7Us5iOzt5B29T50jrxP7WgT+yyY8eV6uCY=;
        b=hKB9nqYgCefZ3yWbShUJHzgCGHsyYHbuE2g3vJSKhLmIC8Dd2p+Mwk39NbfXlCAYCt
         FasM773iAAHDl8CJo55fNZP5dGqPTYBD8y8GHE/WA5NF895uI/f5J1By8iVhOU6DzpCS
         szFDdi8UGgRSul7BTsvRJOa0iT4JSz9V5yWGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuOs6iuIO7Us5iOzt5B29T50jrxP7WgT+yyY8eV6uCY=;
        b=6PI6s6wqctLA9a8bPL4CHjgE+RGRqLNcfCzM2Z3sDk1iW1wiUxr8DwuzHHfLpJFBUi
         K5dNsCaLzADqzp0jePB3NKA8h5IZSbQFqxb8ctk28jycHkNTHCuwyHtyeh/Pkf2JG7VF
         QgTrH/a5PZqbpail86t3ep0hHfjK+X8GAsN6chYi253jyx+UqY5XM8d0xd7upQycYLFH
         dSa0ckAHHih4iQXfvRKkeKDkzE4t8CN95o/dI5Ynpc8uQOnYRsufl7K1/9gHBKXcm0LT
         M5Gx1EkyjxMKCAwp7gDdinXyGKjjQK/dJMTu8UhUBCiV+IqVh6UaRyQdZlxTxxPwGM3J
         HXIw==
X-Gm-Message-State: AFqh2koOEDI+0jNQ6hfBGPG6u+BDrP0IJ+7rBAtEKKfJoC/zy7E/TXWR
        HbiapgGnIh9QhpKCHdRUxsQh+UjmpEl6HFeB
X-Google-Smtp-Source: AMrXdXsqrwbtQaPH6kC483ctEz/kwVWe35c7+/3z+5ZuIC6x2nfC98/JFUw84sGnhM4gvoKpq+/Krw==
X-Received: by 2002:a92:c151:0:b0:303:9c30:7eff with SMTP id b17-20020a92c151000000b003039c307effmr10645991ilh.2.1673383324042;
        Tue, 10 Jan 2023 12:42:04 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y16-20020a920910000000b0030bfd384821sm35311ilg.81.2023.01.10.12.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 12:42:03 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] tools:leds: add support for platform acpi led devices
Date:   Tue, 10 Jan 2023 13:42:01 -0700
Message-Id: <20230110204201.35482-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to parse platform acpi led devices. Use modalias
to extract product and driver name as defined in:

Documentation/ABI/testing/sysfs-bus-platform

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/leds/get_led_device_info.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/leds/get_led_device_info.sh b/tools/leds/get_led_device_info.sh
index ccfa442db5fe..a085a8ffe7c9 100755
--- a/tools/leds/get_led_device_info.sh
+++ b/tools/leds/get_led_device_info.sh
@@ -72,8 +72,13 @@ elif [ $of_node_missing -eq 0 ]; then
 		manufacturer=`echo $compatible | awk -F, '{print $1}'`
 		product=`echo $compatible | awk -F, '{print $2}'`
 	fi
+elif [ "$bus" = "platform" ]; then
+	cd $led_cdev_path
+	product=`cat device/modalias | awk -F: '{print $2}'`
+	driver=`cat device/modalias | awk -F: '{print $2}'`
+	expected_devname=`cat device/modalias | awk -F: '{print $1}'`
 else
-	echo "Unknown device type."
+	echo "Unknown/unsupported device type." $bus
 	exit 1
 fi
 
@@ -112,7 +117,6 @@ printf "# LED class device name validation #\n"
 printf "####################################\n\n"
 
 led_name=`echo $led_cdev_path | sed s'/.*\///'`
-
 num_sections=`echo $led_name | awk -F: '{print NF}'`
 
 if [ $num_sections -eq 1 ]; then
@@ -161,6 +165,8 @@ if [ ! -z "$devicename" ]; then
 	if [ ! -z "$expected_devname" ]; then
 		if [ "$devicename" = "$expected_devname" ]; then
 			print_msg_ok "$S_DEV" "$devicename"
+		elif [ "$bus" = "platform" ]; then
+			print_msg_ok "$S_DEV" "$devicename"
 		else
 			print_msg_failed "$S_DEV" "$devicename" "Expected: $expected_devname"
 		fi
-- 
2.34.1

