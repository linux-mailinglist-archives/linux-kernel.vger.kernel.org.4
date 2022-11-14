Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D453362812B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbiKNNT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiKNNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:19:35 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14802BB18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:19:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t25so28189747ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xM+YcVXCVdAbnW4OE/73urNUlHdnFwO79q+gmDoDsr0=;
        b=EplnvrtGfiqw30Q7kLRL4IlET5brTvihBzdcPhwFcU52tuqzxiV8RsfpYLC6eqaRkT
         0ygTR4IJES+0HuyXNrkvaMUB4MzL5aCtMFq4qLGCD5L9OSbFTnoOgXgJY3djH9ps5yNX
         adcAmozFjGsMnYIU8phDFbXr3kRqbQSN4JnIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM+YcVXCVdAbnW4OE/73urNUlHdnFwO79q+gmDoDsr0=;
        b=zt8Z5FumYezLhMecp+WZKURcPJ5YkTRpiRgEE0wYxP2uuEZFRkal7k6VjYqKVDm4+g
         +dBgMtlTPtw7vsSaECygz3frwHNA4yDNVlFOZ9LNnbcihSgNm3oJctQQAyvtmRo4RQ5e
         JNctSEgtKiVdou5y8nfLrumAEnKS1zhxSQ9WZT18pit9T94wi/RnfkYeFjMMamSUI/gL
         znHeyT+yiB4URbe201kyYxT3IMAQJf+AAkRvig9+7t4VWlOj2E8p1cjBhIrLTFnkXCkI
         n9aKT1xd3pcTy+g2indacjnal1/y3WZZJ2nShou22YgLkY5+uWZXNVgqoB3q2tOfT7F+
         FULA==
X-Gm-Message-State: ANoB5pnKIytJvfOhSNSHRBhPE9DPKf0Q9xzuP6HZGDBT0GNoUgVe92tC
        V5KjlexZPc4iO2g7DlrHQ3DYJg==
X-Google-Smtp-Source: AA0mqf4Ktnl0YrpUJ/zQ2j/nhucRmcyReeUSMGK8cfPoN0Q4ChIekjUj0rl3RtmuKDuhQbti/TNdjw==
X-Received: by 2002:a17:906:cd0f:b0:78d:99ee:4e68 with SMTP id oz15-20020a170906cd0f00b0078d99ee4e68mr9829642ejb.302.1668431946244;
        Mon, 14 Nov 2022 05:19:06 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c205:5c4e:7456:c8cc])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm4802061edr.51.2022.11.14.05.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:19:05 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 14 Nov 2022 14:18:38 +0100
Subject: [PATCH v1 1/2] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-disable-kexec-reset-v1-1-fb51d20cf871@chromium.org>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=zDOuQm9cQhkd/nA1jGZR3he7xVJj/YKQQUhyS/khFbk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjckBEjyJCQEx200s9vD/3tqll0nVOqpN6FKcWu+uj
 NvYvTuSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3JARAAKCRDRN9E+zzrEiDnOD/
 9Ks9b+Ued+KyoeV7ygpZz76D9Q0XfAFOq0DMdz7krQNEYRNokkHIz2X1PLcF5UKgyWl3iu1ZY/OV4M
 YReDtofadyOBt+kFuZY1ziV9Ocyja87uU3rlZ5fcWJQfd/+8D0vBVgFL33ydaSHLhcvbrDqD2TCsuB
 kM9doysF+DrfnmS58H7WRPuNZd6ZOLnknvMvAG8vTJWx0iDkvnSfB7d5Xo0WT0bGZvIPLZE960yehp
 B9RePEIQ6nDcKNnD1azJDKCw/8XXlrYuzzLpXk4+sqUwQrbL88xnKMx39NWg3Xm4G3kIQtX3igfENS
 VomHElAGKHt3JpqVL50wJXWOHEa3Itlh+GBERvYeSsMTuH5Wa9V1JsQFLgurc3zrgWvV5c6hHrXm/4
 rS8BR1x63yULYU4nA+1CRFS3wiv1hiMa/XNC85qbpxhSiYdT75dX7zOasM3pbuOGNtxzxvZVEVOpi6
 D4uPlxgxKXvHOn69jKwVxMoSIL3+GTYT1ZCsIR65O3oIZpmyWdBEgrx+MGnagCP7ZHheb6ZHOqquHT
 m2euzpVJmeNS1Ity9c5+aVrkfHy7QPHTEcjrZ0MO5/jgsy6AFVWDT1bRqrRfO53GpsqvHWlgFwVjCK
 G7Pxt3W2v/SOThv+B7SYuaZU9foBvShbrFcw58wDACKF78S1+QVsLpFd7Feg==
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
b4 0.11.0-dev-d93f8
