Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE716D55A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjDDAp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDDApy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A04410FF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680569106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aYUqj0WEO/+t8WQOwTQ6jFSvWovdgaLHCs5zUkIn40o=;
        b=Esbh4SH4RN3FjGT5/759VFWRUWLYP9zSgJQBBjgICiEzurgrYVEHnf20vHBV/29Vqw3iYI
        Kl5IFpl+Yjkn5zvWNOvV2+5RoSW5mDlZj2MeG1FdjKEiExf27FvrpcT7IXBgw+1pL+3FQE
        x/ge1yJZTiFrliRkCgATBAMGIl2vzo0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-U_Wc_b7IOwaJzRX50Pp7vg-1; Mon, 03 Apr 2023 20:45:05 -0400
X-MC-Unique: U_Wc_b7IOwaJzRX50Pp7vg-1
Received: by mail-qv1-f69.google.com with SMTP id e1-20020a0cd641000000b005b47df84f6eso14004063qvj.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 17:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680569104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYUqj0WEO/+t8WQOwTQ6jFSvWovdgaLHCs5zUkIn40o=;
        b=E2erXVlvY/CdS8cmYwKCliaibrcerJrP7YFQwH0q/QvvkCE6eNcwdjU5UgVU0WY9m3
         bSUPD/zh4YmLebcyJxdnAaDdspHTy33ZA4f29ko/d8pgUF17NwaHf3KjN5w9IhByiqjO
         FHIl5MnflOuTqQrAMpb+sHKmVomBRc7BBG39qPhl4QFTU4Nl1Z72BUej26pY7nNxRCS/
         xjVH6jTsZyhZACVRRgBRwAoSwJR7ErEQOcMbhoJxuzOB7SKnhxRhXD115JZBeyEMvE4L
         N81HzBPTS0TB3JRqA587ouByllGkFABo075Rq/W4HtwfiBpjZdYyL822Dwf+VhKmZ9WV
         +IQw==
X-Gm-Message-State: AAQBX9dFSKHcsH7klm/Om9+F/0HtgTodt114iCMjPF0eK+qWYkuOU5aV
        xsHUHeNLRMcXzHQGVtV+Lz6uAdwAoiamCXFyYLkKSEhWxTOkUIKg0RRXv7OVeoIiwXh7elY21kt
        M7QRSH/uSnI2Da3UkzVpHMqOtYHHgOqEj
X-Received: by 2002:a05:622a:199f:b0:3bf:e4da:2367 with SMTP id u31-20020a05622a199f00b003bfe4da2367mr852175qtc.3.1680569104582;
        Mon, 03 Apr 2023 17:45:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350a9PFso1zg83MNenFNB+OtbEohAAKjW2hu0gf7aXs/D7CoTeb87qGRoa22fHVShZm85hSn5Uw==
X-Received: by 2002:a05:622a:199f:b0:3bf:e4da:2367 with SMTP id u31-20020a05622a199f00b003bfe4da2367mr852160qtc.3.1680569104334;
        Mon, 03 Apr 2023 17:45:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c7-20020ac84e07000000b003e3921077d9sm2898823qtw.38.2023.04.03.17.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:45:04 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] pinctrl: mlxbf3: set varaiable mlxbf3_pmx_funcs storage-class-specifier to static
Date:   Mon,  3 Apr 2023 20:45:01 -0400
Message-Id: <20230404004501.1913144-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/pinctrl/pinctrl-mlxbf3.c:162:20: warning: symbol
  'mlxbf3_pmx_funcs' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/pinctrl/pinctrl-mlxbf3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-mlxbf3.c
index 3698f7bbd88d..d9944e6a0af9 100644
--- a/drivers/pinctrl/pinctrl-mlxbf3.c
+++ b/drivers/pinctrl/pinctrl-mlxbf3.c
@@ -159,7 +159,7 @@ static const struct pinctrl_ops mlxbf3_pinctrl_group_ops = {
 static const char * const mlxbf3_gpiofunc_group_names[] = { "swctrl" };
 static const char * const mlxbf3_hwfunc_group_names[]   = { "hwctrl" };
 
-struct pinfunction mlxbf3_pmx_funcs[] = {
+static struct pinfunction mlxbf3_pmx_funcs[] = {
 	PINCTRL_PINFUNCTION("hwfunc", mlxbf3_hwfunc_group_names, 1),
 	PINCTRL_PINFUNCTION("gpiofunc", mlxbf3_gpiofunc_group_names, 1),
 };
-- 
2.27.0

