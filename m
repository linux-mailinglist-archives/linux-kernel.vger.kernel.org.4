Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4365454C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiLVQnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:42:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5227B0F;
        Thu, 22 Dec 2022 08:42:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so1830869wmb.3;
        Thu, 22 Dec 2022 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZLAlOhCGilIwuTmtW0IVLJRanvaBYIelqxDGN9L3mA=;
        b=ntlPTMV4mBJYN7GB1xLqSC6qEFW7/c4RVIUl7rVnZDNgEyUnIFTrW7ehcuwSjA9MOT
         roXNazIIcGsS24FHx1L0hDGQS3Z8bXmRO0K8a7JuCtbpCxERvYemdLj3Ua0F+5P3X8Js
         6+6krr8AjM5RIrp+OxufDGOxjY2Hieowj0//MgfhL0H9x7rknnumipH69NwM/Hw9X11p
         peaLgdBwcc1r1HCNdLU7G+QzpckOgMmxMzZq1aEn04PkaKZum8VZr5h/v5z0CMpwNa1w
         EefqCy5z9v4qYICYsn3Qf9hH91DI57OppL3On7C7ra5J+d/YImz3xvg16yTkqmmOGHxI
         5q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZLAlOhCGilIwuTmtW0IVLJRanvaBYIelqxDGN9L3mA=;
        b=Jwkc08Ugqo7++opMPsfC+9JfzLoqgu2ouvyVncv0Tju0zbLIjKAeItD/32IWSzClAz
         hCK6X/qetjYvGIo7JQe7zzzu8Hz7d/hOuzDLdTaypT5GE9oVfQ9ufxNfCkVnIskT5uYv
         mOcrs+pkT12kOsIaWn5MvI/UW+Z//kQA6Balb+NvVQqjH+SE7sVUO+FPwzPuK+IizkpK
         NcAepCfnCVuOPrWuAlVl2d6Oya9mqnUM5uq8F3vT5mnEDVE3psm+xFILhMha/aSDa/p/
         J+RwpCvumVWvJaSNwolHDj/2BoBG0ixPNN8FgiBZzBq5NIElpS3INghVtizvRFxslmk6
         nSbQ==
X-Gm-Message-State: AFqh2kqbItKmIqwS2r3PG/DFksAVLfwSgLZRKbJahtUQBVGQF6EyL/L/
        QoiqA9wZQA/6DKeXkKDu8Q==
X-Google-Smtp-Source: AMrXdXuzs4kMZk+HWNO62x7FIJsgu18TkyZ58z9KExzlVdu/eNpacftlA06q5G9uWJDVMBdBRmQvoQ==
X-Received: by 2002:a05:600c:4d25:b0:3d2:27ba:dde0 with SMTP id u37-20020a05600c4d2500b003d227badde0mr4876976wmp.33.1671727375391;
        Thu, 22 Dec 2022 08:42:55 -0800 (PST)
Received: from p183 ([46.53.253.211])
        by smtp.gmail.com with ESMTPSA id t184-20020a1c46c1000000b003b4a699ce8esm6333221wma.6.2022.12.22.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:42:54 -0800 (PST)
Date:   Thu, 22 Dec 2022 19:42:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        oss-security@lists.openwall.com
Subject: [patch] proc.5: tell how to parse /proc/*/stat correctly
Message-ID: <Y6SJDbKBk471KE4k@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

/proc/*/stat can't be parsed with split() or split(" ") or split(' ')
or sscanf("%d (%s) ...") or equivalents because "comm" can contain
whitespace and parenthesis and is not escaped by the kernel.

BTW escaping would not help with naive split() anyway.

Mention strrchr(')') so people can at least stop adding new bugs.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 man5/proc.5 |    5 +++++
 1 file changed, 5 insertions(+)

--- a/man5/proc.5
+++ b/man5/proc.5
@@ -2092,6 +2092,11 @@ Strings longer than
 .B TASK_COMM_LEN
 (16) characters (including the terminating null byte) are silently truncated.
 This is visible whether or not the executable is swapped out.
+
+Note that \fIcomm\fP can contain space and closing parenthesis characters. 
+Parsing /proc/${pid}/stat with split() or equivalent, or scanf(3) isn't
+reliable. The correct way is to locate closing parenthesis with strrchr(')')
+from the end of the buffer and parse integers from there.
 .TP
 (3) \fIstate\fP \ %c
 One of the following characters, indicating process state:
