Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E90711C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjEZBJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjEZBJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:09:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C8E4C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:09:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3491609fso306276b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685063349; x=1687655349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=FObbQtu4GFbmQuTgf6aAqO5O2uXBGL8UuGGP7kXn2zsY1ISyVb8PdD6gG4GoJko1+1
         DDiuo7mckH+RAh9/vYKFaq90VuUX/Fb6/BWPdRsk6x10KDb+oGvr4cysiU6Ursi0r/4X
         57l8o3oyYju0dXoXe1HJMhfPJqQrsos5g/YFIBbziGmBmneuFXjq8Ha26+cZIN3rdYtM
         cMeRiEeOoUyRIwpvUzcGoDK9cIphqxjmP2byAk789hLiM5dW14KTZ/89Imwajat5BVI/
         UBzeWFFiu18YqLINKSRPIcZBZJIhuSYZGH5Uke78EdOYGGQ4eJP/RriIaHM8C+uX6qE5
         0cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685063349; x=1687655349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgIxbu2uvm9mgOSVuiyfjypP1XHmKEsmGNcKt5EwTHk=;
        b=cNAKwSBZZA/C1xdch5zz8Ap6AH9c/ld1exnnBvTejNSOJtCh23NmrlWCPGAT0JqmsD
         TWNdzqW1Rg+d/oOrJ7TPVq/wy+Veir/ubDE20+dh9/e34AU6PgRUiRvwfnvbuyB3RhjM
         z4neM5pgOJNLAuQnZMZutsnnlGjhgDm5oriyRE5FanRE+bwleb26YVIboy86kEnmGNlL
         FjPXt8pFHXyVsym+QyKWFUFmAR6YlTuX4XAOy8wTh6NnLeWR+PP1w9nhxNHGOwEW0MGB
         z2RAPbKzLkMRXMSFFOPAPAHhjaIRxB+KDmnT0ZcWg1gF4buxErMJ4fx0M9ZpGv0TOC7I
         UzDA==
X-Gm-Message-State: AC+VfDxLKUGYrn7BGVaYjyKgXN4p6X1aa2+2p7BDcrPFPeVbzACXEiUE
        wjg1ZVrs/h6Yqag0NNF8mwKH8w==
X-Google-Smtp-Source: ACHHUZ73h7AvNfYSrL000FfhE5TFz9qtPzLZShVBDhPWXfxmPXt4P/y+jMX8/rJ9W3y0q1NgU6d+tQ==
X-Received: by 2002:a17:903:48a:b0:1a1:c7b2:e7c7 with SMTP id jj10-20020a170903048a00b001a1c7b2e7c7mr554460plb.49.1685063349368;
        Thu, 25 May 2023 18:09:09 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b001a687c505e6sm1981016plb.232.2023.05.25.18.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:09:08 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [PATCH v5 2/3] efi: Add EFI_ACCESS_DENIED status code
Date:   Fri, 26 May 2023 10:07:46 +0900
Message-Id: <20230526010748.1222-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230526010748.1222-1-masahisa.kojima@linaro.org>
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the EFI_ACCESS_DENIED status code.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index b8ba9c5adc7a..657f7e203374 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.30.2

