Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25465D605
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbjADOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbjADOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:39:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E26167
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:39:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id tz12so83091307ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYYQgh/lv3T9poZ9Kbn1xfKKla/OcUPaY2NVZr8/1wI=;
        b=TPhzP6VDMUU3QtDkGKBz2ODkHY5IHPZJLk2AHghZRhDppkwIzHLh+ClSZSi7dOkdEO
         djNbFLbX/qbVhko5HtmYgh+KwUPHIj6YbIq8IfqKDrqPxZwEVo1ZnOcnm84WOikjUIXN
         84Nn49z3bmZGZyGjFWM0g31CC5lEjul+7e7vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYYQgh/lv3T9poZ9Kbn1xfKKla/OcUPaY2NVZr8/1wI=;
        b=4/5lzIax1ZRT/pm98zsO57kdRzz3uKB+Kw0fsLGOHHZa6PrPJgXAHLbyCDyiJNErm8
         jkcrpB3f+BBJj8psFa6uRFB1yO08D3NhucCofMEBXG7+Qz6zonOB9aoWSk/j7mcseVLm
         65r0rApw+ad4u5YprQLl+haiky1M5CVdaB/K1h0XsQIozLh+IZysYFie6c/iiTIPoKUb
         d5Cz2D6aEZUOafKgVDo+2jK3SGKEXCkJeh3t9SLnpiwfkrKYDTn092tCzBOwcVvFoMBo
         cLme7dItgzeJr0/ZdaUW9cJnNmwoLPPcD7rQD1I0WplsTawxy9G3Qbv2zc7H2myl5iQe
         vRyQ==
X-Gm-Message-State: AFqh2kq0DjqVSqT5nshLilaCboBojsa3q+kXd/VlhmkonPlTGybpuV/M
        aTlJtfSAUOhafVNgx+m3AWo2HQ==
X-Google-Smtp-Source: AMrXdXtBlcdrPW/OtLMuhlJIa8ITHBl4FnGqRj+b7buGekdJ2R0dm4D0Mgxm/adGoMtGVV+TmZF0UA==
X-Received: by 2002:a17:906:5dd2:b0:7c1:7010:f413 with SMTP id p18-20020a1709065dd200b007c17010f413mr44805532ejv.19.1672843148794;
        Wed, 04 Jan 2023 06:39:08 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:a438:c7da:62e0:36f4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0078de26f66b9sm15386659ejx.114.2023.01.04.06.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:39:08 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 15:38:46 +0100
Subject: [PATCH v6 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v6-1-6a8531a09b9a@chromium.org>
References: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Baoquan He <bhe@redhat.com>, Petr Tesarik <petr@tesarici.cz>,
        kexec@lists.infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=2pZFS+1BHtUlFuNmvm1mTYxkgU9yharonO0OzNd1vYM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtY+EP67lwRrCO5L5k4Dp6xvXVoYkuhFXhgRbt/kG
 8bQ+rx2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7WPhAAKCRDRN9E+zzrEiEwYD/
 4usIWKfOuuGi8xYMQsTa952RC/Gqq3NLfoSqb13IPaxmQxqWWUjQ9uDtxl6QD90QnBoAjD/tSFebtK
 EapNZosQxrdc+t7axxND9uY17FhOJIKscuu90wrCExbOXav9p2pBlZVk1U8k/WwDAJrH5qMpt7pUvw
 pGRdxVE80sFSCeFSJCcuNrY0XeAYjO2cxzIuLxLSx7O9za8wFCZF4BMRohyc7tsSyl2EVdZYcemr0R
 4z2XLsWYVQRXjtccMgFRkfCGOOmNW/hXVuV11qDDGyf5CSjfO9R7+6laH01SA3fF0Uk/E8Q+3LCu59
 6F5RMHfOoXh38K58UOC8w/U2l5RjiRF2XC4yfmrobAdgnYqmutRHi+Lug8kNkWndLNlewOVKt3Cd63
 wlBc/bMdd6ccRlzZ1pU8IMBsdVp1LCIUWq+IttQU61DODNb9Eatwj6wxBX8Qnhg0PvGrK8Cvsaamfp
 bYOMgQZU49QK2hsbc/aWhMe4mAt26NsDxp87ifiQjgWtpCkBYvj6Su8gg8VEAehX3Nl/1FxQA05HsT
 xSHhehNI5G5pHHslJ5HupPSSbvcOEZO5knYX2C0pCmWn3Gji43SAmKZSHJ3DE3zeUe5bJZlTJLZHBw
 XTSGECyozGv6ERamTopSA8x3YabJeqxtU79aXb9q9mYqfk5MxwYuXUKki4aw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec_load_disabled affects both ``kexec_load`` and ``kexec_file_load``
syscalls. Make it explicit.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 98d1b198b2b4..97394bd9d065 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -450,9 +450,10 @@ this allows system administrators to override the
 kexec_load_disabled
 ===================
 
-A toggle indicating if the ``kexec_load`` syscall has been disabled.
-This value defaults to 0 (false: ``kexec_load`` enabled), but can be
-set to 1 (true: ``kexec_load`` disabled).
+A toggle indicating if the syscalls ``kexec_load`` and
+``kexec_file_load`` have been disabled.
+This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
+set to 1 (true: ``kexec_*load`` disabled).
 Once true, kexec can no longer be used, and the toggle cannot be set
 back to false.
 This allows a kexec image to be loaded before disabling the syscall,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
