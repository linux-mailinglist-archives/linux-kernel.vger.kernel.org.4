Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608366528B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiLTWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLTWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:06:10 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1661838A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:06:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id x22so32494715ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=QZyYvSYS/5R/0vxSGWLo/6TrG71If7NC5DtCubDinMXdIvsAOTSsTYPjceSC5lhJec
         BXd6ndGzKfOPGsXk7IAnWkD2+Jg9cIRiiS2AMo0PWk/H6f73e5vb/qkVYFuzoPnK9/Es
         mlmynVTyGNzumcJRS3bL1ypHkrfyanKKrHzs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=hGjsjC6xg6lZNgohp9i6N2NEmxch3FN7ST/+3K9GV45PHrqBbWn43WqP2oRRu8pcox
         LBQ9dnwZHBy4nxb3WPnEeSbNwBc13nfXm3Pt6MqOjWXSZUIdvwKNOyaN1rlGrJbSEnvf
         pRbD+EOU/cp6QU317yGeUG6yEwKmBX2/nhJRITpHg5mFsXsieve68EBIVAkhSHODDybh
         fPi45qp2ynJ8WV7hTeZC3ZcK3ordYZiiLoztsCOz/R1/vuV0eVOZAE8+vKW44XsNxO6g
         z9pXuUGYHnYCP3aG7l9rO2OjxWVJCXGToDWWWvdXMQU1MZUeguKivkIqvQxe5Ov2PoJF
         7ppw==
X-Gm-Message-State: ANoB5plRMbm5MOhGGmaEIz4PYlRknZpNYyPApBDQ6PsM8z7CvwyXDUVR
        MNpxbEC3Tk4v/hrc1EI4NQY/4w==
X-Google-Smtp-Source: AA0mqf6zzWn0WikLfWEQwe6zkmxGlwUAYlamwtrtvXIvvVUd2sMlv7GgspWqSrhcUGkNHsLlZZPwFA==
X-Received: by 2002:a17:906:f6d7:b0:7c0:bf7c:19f4 with SMTP id jo23-20020a170906f6d700b007c0bf7c19f4mr40561370ejb.74.1671573966509;
        Tue, 20 Dec 2022 14:06:06 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00837ac146a53sm1175492ejc.23.2022.12.20.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:06:06 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 23:05:43 +0100
Subject: [PATCH v3 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v3-1-4ef4e929adf6@chromium.org>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=U6cVA0f3MVv7jTHbprLKEENRfx9C5MeH7N8/eIFjhzo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojHIpdmcVeMVxZ7UQR/ZxrK0wjocsFOqbUXV1Pzf
 kKjKvmWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IxyAAKCRDRN9E+zzrEiFfID/
 9z8ZdKo6lWAEJ3T0FZH9P5dUY7+G8f57r2NUYkbXfSZyBnKZrzNJO/zzg6qs0zVpVhq0Q6tya9Lr5n
 i9pKqqZzciEhZ5dxXjxdUSdA+bnNgCHYoV19PtdKclGJWT3ZlunTNW6b+m2ecsEEwry0nzYTY8tfmX
 0Z2upPGKphHkKHuehW+ZatYoiD9ryoeqcsUa/ISkFK3J2H5tlKeqTK2uJwxEAyYJewvSydZUCPvHAv
 8ZUh4us+RWedvK9hUg+79yijwSID58bKxu7aAsRdhMef+vRkERdD4hYDEHoCFVoO0BytlMagDtbC55
 7p2OA6GEjZ2rjT41K6fO1h9gZcScdk3oYi4mdeAFZz81BpO237UWXl3ONMimGUS8nOhYkULDJ/gL+i
 PRRgDg3X/pcbA/EwQCjr0sjvCIFH7+kUYsG5ugtmyoWYS3v6xyIsgwkcN1vapyrWDtiwqQvZgZAnO+
 zaiPo0WMlJ8U16DM2A0hxHsvqQVtUq4/3ZOti2PXiwSjbF9Hkcs+huWx6+r9ZIpDU4cS6DRcpi6JWj
 GXAjtzK3OYQmK4Tfy91pBoGNKL15xLeJ7zbR+t9Llz1b4P5Yr7pbW0Niku63bJ8EhyWZqUSwSEUey1
 Z8QP37ORLoJzuJVT/YNbvtLZOzvKP3bWpLxPZ6Ax6fx4bMYhgraJntD8MAJA==
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
