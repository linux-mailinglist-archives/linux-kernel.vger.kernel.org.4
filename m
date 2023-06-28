Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF97F740DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjF1JzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:55:05 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60508
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230297AbjF1Jur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:50:47 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B26E43F266
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687945844;
        bh=+3ajja7MAstA+YCVmYNOJvwhE7/9ec4gOlnHNDS3MOU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IY9PhGuAx7bsRmVsptgNaIWo/6lOnkdt6dorDkfEtAwaDf1UDygjy+z+KDofwnpP+
         /dcH1yY6ktGbA/dv6WNNNnC67Y3bmHtvOLXMsiFJDItrxyaCsr4zuI9IdWbTj4vL9o
         dd3PmIW02Dk49TANdDFQDHEs9LyIxX4ll5yLRiXPPkW/2Nu/F3h17sb2Eb8RBR58QH
         ts7jrG9qyW71FMvBHJTp/GQHzhQRKFHpkSpv+/GgbJxscIOdfpz6LVWtIfzaMaJOUB
         KcZVJQSE8IE8fws4t8rgI4K1DBPH/7GfN5UuVhODEbqdhn7AIHfYQtUEaIO9JkrHrH
         9IkR+Xr37vf8A==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f01644f62eso4658160e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945844; x=1690537844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3ajja7MAstA+YCVmYNOJvwhE7/9ec4gOlnHNDS3MOU=;
        b=eP4+QWZENhNYKdUgTor8NdM0GfNeF8/peGn8L2EJZY6jlgPhj2PPbQB3orWKAEGu6D
         hLbm/MTgmBV2gp5XFmjsKg/2V+9S0bUzjpnMV9z90sInfKWRYU/HrlSHgwx+p8CIED/r
         EWLx58EjCeeVtm9P4ICIefJZFVtFiH/4JhCTzwa8HSce3pqgJekDhrdkz/EtkDLxwvcA
         L9VKlH6juL6d1JqMNLkD8dopx8PUyf9FxumIjJZrNXfuwaF0c/rWe2W1pdqUX6JMzo6P
         fPg4FU+PTP3KWeY1Mn3POk6vl1PchAd9NEDOz/MUVdsbpjVoeGcs2MeCDYLc1RMs53FX
         DhGQ==
X-Gm-Message-State: AC+VfDwavkL9Zy+FFVbcKZX18wuZ32p6DMiJUkhzrH2qX+z5CDDZRkGg
        IflQ/9CjAKS8OGCd9gw2V3pk87vN6bcfcWsQSWDdtBWlw/pE+yqnJjDO5UUkLQkK/vwpGnRv6nz
        yikzewA6ELLA5Ctz3cxcSgDKOmlyAoOtMK2TXXd+7QA==
X-Received: by 2002:a19:380f:0:b0:4f8:4177:e087 with SMTP id f15-20020a19380f000000b004f84177e087mr18902751lfa.47.1687945844105;
        Wed, 28 Jun 2023 02:50:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cBM2grbJSWNi7mCJ5ewuTKswFCGuguC6q7nJIziby3TaAJDbD2NRFzSz6qF8ad+lor8ckng==
X-Received: by 2002:a19:380f:0:b0:4f8:4177:e087 with SMTP id f15-20020a19380f000000b004f84177e087mr18902737lfa.47.1687945843773;
        Wed, 28 Jun 2023 02:50:43 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id a25-20020a5d4579000000b003048477729asm12871090wrc.81.2023.06.28.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:50:43 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     alistair@popple.id.au, eajames@linux.ibm.com, jk@ozlabs.org,
        joel@jms.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] fsi: master-ast-cf: Add MODULE_FIRMWARE macro
Date:   Wed, 28 Jun 2023 11:50:39 +0200
Message-Id: <20230628095039.26218-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616122040.1035518-1-juerg.haefliger@canonical.com>
References: <20230616122040.1035518-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

---
v2:
  - Remove empty line
  - Add Fixes and Cc tags
---
 drivers/fsi/fsi-master-ast-cf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 5f608ef8b53c..cde281ec89d7 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1441,3 +1441,4 @@ static struct platform_driver fsi_master_acf = {
 
 module_platform_driver(fsi_master_acf);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE_NAME);
-- 
2.39.2

