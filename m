Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37275647471
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiLHQiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLHQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:38:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1883AC15
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:38:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r26so2527099edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhaF9GqJ13TY0Hg27yR5BzoVfdO8sTpyXYMoNgjajPA=;
        b=i9c67mj+9AQi4YP+ksbG4h840ith9rqM0BG3ZURvebcEwPzRnnOXDmFZLMiElsFjQd
         hExkE7m+ye6SWjL5pY6ftcA7YtxZGrd67eYNQnwmU3dQ9EZTxTbhTpgVZUHfydcZ2R8K
         caTkIQ9eViZXa53Dni5MTjKQFgCubYVYWAQ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhaF9GqJ13TY0Hg27yR5BzoVfdO8sTpyXYMoNgjajPA=;
        b=2ZPCdpHj3o3IX6WCY9DT31V2qriZ8IeyBthMDADiN9a3s/3OqUNxDDGDDA/Iink0Tn
         pRPLitb+lyPJ073pcXBld73MQXawb35I4OCvOKj7avBU2rKIW8ekXewGOmcAJMW9o9NA
         Cq1Vb+LohhIx5PvLlW9xweKTMDBydAT1dYjjZUlwZUQiJeSe8iR6wE+HNck1R14ezJ4t
         f0g62KOy1NaFhLcAsFuxrBJpbEDQcy5qlEF/Jag/DHCrGcqBzzQV8NIo1x4PKqJwCheC
         jOgwzUky5jFjct7xkd7G5NkEpQOq8CY92SO9IS1wAoAHkQFusir9VhCcVlqHTMoqh0W5
         zB0w==
X-Gm-Message-State: ANoB5pkFcSdZR3AQ8/HQesYmaMOxADFou3C0bfLXIor/eoGTz6W6TX5x
        yTr2w8ZsWfnIOftrkYCAdAT/hQ==
X-Google-Smtp-Source: AA0mqf6oXuPF2FcEbhr6O6icyt4v9LFB17BogW5u30C9Y2tcx020bg4gsZKP4A6NujqN7niMt7+jTw==
X-Received: by 2002:a05:6402:3908:b0:462:8a68:139f with SMTP id fe8-20020a056402390800b004628a68139fmr2240885edb.3.1670517497880;
        Thu, 08 Dec 2022 08:38:17 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:17 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 08 Dec 2022 17:38:00 +0100
Subject: [PATCH v2 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v2-1-c498313c1bb5@chromium.org>
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kexec@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=B8aDh7OSN02BJ2pf/rcRX//p3+ltOWRPCwelS9y3Ngw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhLy7d+A9Xd6db3iX02SAJV6vvpdaEGh+vrOfiGj
 6tTf/XCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS8gAKCRDRN9E+zzrEiA2dD/
 947qf3hcL5NPrOsphwYmep1sKdvBXyfRYLZc4ZAVhbXaUa1/MgZ+9DemziS4H4PuHf4HRniwQR1flY
 nPiupdyswzRyxyjw0zA0B+MP8qC5kt2csBlxYZeQkFsYP6MXmG9YJk3gxNCfGM+zoQoQuoUVuNJQ4/
 hOVs97S9gWlCLnswwemGdrLrwW7sZR7ct69r6RSnIghYgrwnMgwbeqvj+YWn5ph/mwsVNpoRn24tUl
 BZj547MmwJ46BVtmhdf329NS4uJTGRVFU5+kQEe5813/6DYloTvzW/ZDgpG1lreh6tqLdGrn2xouWu
 M/UOrJ3hqHWe8dJh5nRP7DRiDvBusEP24kLBnK9VFvM4extNvGElx6zp8EiOuLm8zumWZDuLcg1EHw
 K4236OoivuGmnO29pu07/YFV28QyVXFpPPr6rxEM9CCSBjw+NCN4lajOpa6ZX1NzEAU1oyazGV96kN
 GZ6MQRE3VS4UHc8T9mnpmM6yLjcBEuGPCXa7UKhdFckX3P5xSCKoRudBQSKxMLSlA27gkVHQb3SXDS
 WW9Ub0jfHM/wB1mC4pKeFMKsmuqoNZZdPJb/u8sfyRvTIpynWuTubGb9QhGV7m8OMVvyWnZTgTHN31
 +JVvGqQ2OhdJRm/K3bhBuajW85vpI7xTXUnb31Y95M2ZWLMoAEiSQrbKhpJg==
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
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
