Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B519572ED91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjFMVEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjFMVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:04:09 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600C19A8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:04:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39a505b901dso3396269b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686690247; x=1689282247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOx1Cb4CrkzgKdN2+7kWQPFrvO7Tgljw4Xt6t1AfgN4=;
        b=Wrgk0HFKlb86zVDE/KpwIxBXfv2OLpAmFYzNC8qwKVw4dirnXILmb3uDaY5URVddY1
         dlgkG9awQpBaW37Z/nuuojDOQo/OSOfOu6sBnDiOSpqkQf5m/vYJuHAoukeGYJmbsB5z
         8GuqxaqUtUn1ZlO/diFZ2jx26EETlfzz2934o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686690247; x=1689282247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOx1Cb4CrkzgKdN2+7kWQPFrvO7Tgljw4Xt6t1AfgN4=;
        b=g4wzxswrkxhEbY3h9NRc9qEtRiVaeH8UQYu/7BhNPc7sXnKijGKF32tWQuhLDEAsBe
         AjU8EFQhvFIKGZaQpRhevasrNVU5a6oPK/6YdWIz92UniUlX4E5gQ2PFBZqZ2QGyyj7+
         p+r8bLBTZEAI48sduAoOuVPsaNBkDPKS1KlshENgrg3c4olx7gcm3SaI1gucw4Wdzlue
         QdoSTtvPLEx4JOeIjL2NIpChQJ5zWHwju4d+TtnKDtUzRiJzX6047w9SJSTvvEAQraqk
         RK/70IfygZyHVC/SdCNhuuI72AE2BkXkXZK77Nee5fW3c4MFoo1hdWRxY3WRN5Qi+xls
         X7kA==
X-Gm-Message-State: AC+VfDySV51F7dOUWZoD8aUM8QWhIbkNQJJgjR8t2a0YzvWoOMWHQ/JB
        6JSSLXoM4pijHpvCMpcABpjvNvVEQf6QvrmZlZI=
X-Google-Smtp-Source: ACHHUZ4IAbWflqgt5qapX8OK1U5Kv3y8xxTFpTDoZKZ9c+9N5ZZhJ5eZl/IFs2wLxtx3aXss8NPufA==
X-Received: by 2002:a05:6808:284:b0:397:f82f:90a4 with SMTP id z4-20020a056808028400b00397f82f90a4mr8059633oic.3.1686690246395;
        Tue, 13 Jun 2023 14:04:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 2-20020a630b02000000b0051b7d83ff22sm9713553pgl.80.2023.06.13.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:04:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] usb: ch9: Replace 1-element array with flexible array
Date:   Tue, 13 Jun 2023 14:04:04 -0700
Message-Id: <20230613210400.never.078-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; h=from:subject:message-id; bh=JnLkH4pmZPr+c0qLV33G9jBQkGYO6fWW64bmkRy4SIY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkiNnDHBwR1Ie8fRBd7eHhD8fIQtVxLvTp5alQtuBH DWwFQ8+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZIjZwwAKCRCJcvTf3G3AJsFCD/ 4x1nXqX6El0WiD6bCA9teDACqjOpqTmk7gcwUI9PdJzVcHeJrbFFtmwxJ9gFMI26Ez67hVKTcXf1di tls62NokgUH9nDlkOUyA3GiEkC8ltgIwI0LHUxeY+Wd9rFiN/f2xceF1pQocUGQ8RdrllXpFObeXKO vq8LBMV6Vv8mnY1xjf/3uS+bNlmcb/TzoeaUGKuwUTJUryRwEnP+IhjjhiLoKq/xVLYinuUPnC3mZ0 VAekizBZYNPHWItfimEw5qQYAR+3GQU2yHhLgOCqXffbmYPIEsElbUK7zun6tPn5F/eMEbcqclBmnL uPSr7hHjqn47v/iuYyXW0XbuxyLrwmJ9BhB7rmfionI+Wo09ttk03hc7IQXzjcpR5frONcP/3DiGn0 G0syov5rKbYlVlxjgUpUZxzs4owZAWVHJdD4fz9ik+qsv6/87Rgos42x+sM+GP/tDIQNmvIxTOGtqb 2YYPNlIP97Y/9zZ9O7b+Z+H1MgJU566fTTcQS9Z2a8ucWzJcXGxnVURF3UlHs+6JP9AzQp3RBCGCpL DMMkA8C1LDWlWMuKfgiCvuBNkX03/Nz4pR7MhEZoWRdqwnOgZq9NOv3yFo4q5l1P4Z5HFlrPY6XPGJ CZxVwukYn6Hzl3Zhl0SrGCQ//moINSF/AnPh2j+2TSVHTIMnlwoLq8KD4B9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With "-fstrict-flex-arrays=3" enabled, UBSAN_BOUNDS no longer pretends
1-element arrays are unbounded. Walking wData will trigger a warning,
so make it a proper flexible array. Add a union to keep the struct size
identical for userspace in case anything was depending on the old size.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306102333.8f5a7443-oliver.sang@intel.com
Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel test robot <lkp@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Jó Ágila Bitsch" <jgilab@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/usb/ch9.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index b17e3a21b15f..82ec6af71a1d 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -376,7 +376,10 @@ struct usb_string_descriptor {
 	__u8  bLength;
 	__u8  bDescriptorType;
 
-	__le16 wData[1];		/* UTF-16LE encoded */
+	union {
+		__le16 legacy_padding;
+		__DECLARE_FLEX_ARRAY(__le16, wData);	/* UTF-16LE encoded */
+	};
 } __attribute__ ((packed));
 
 /* note that "string" zero is special, it holds language codes that
-- 
2.34.1

