Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2D6B803A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCMSTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCMSTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E832C6A052
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bd34so8216264pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678731545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XstmFM2GshtLwvoAEIpsc9WtbOo21zJeuCi3J74UKuM=;
        b=AXHqUvDDmZPGCCP5cgSLitbVM+kqfQ7XsQEqKZ/cR7dPzDSiBHuZVBwGz0SqcN7oxs
         DBrJEwOiLSkhmgGZjRWmYnJNgtT5wofMgGiNBCn6tT4m+bsc3Wr3rS3hc3NMX5NvAenf
         qY8IA9nPi1oR6/dNzSBx9vfCEgoC1XFtoyiCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XstmFM2GshtLwvoAEIpsc9WtbOo21zJeuCi3J74UKuM=;
        b=5eicbU2+EH/P3D2qnn26LWeQWK8CRp1HEYE2Zd5nhZoIAv0AhIRrIZu0bAjdG5LmtQ
         mKeaZtaiXoXIX0QCasMArr8CbBzNq0orhCo0V+dMj+wG9j2kRkUyq9Bjw4rni14fqpXV
         VufhMFdseKFiAMMoXYdxgEvBKaqfRzwf80ROyMFEVVfYFfPZ1zp+tB1WR0KAVbGrCNEy
         OMRnH3qwMPUHV/m/CQapwg1Xp9ew3d3X/EckNejKBlCHIUrr/ah1bDe9hFjItQWJOGaW
         omvFrQb/K/wUw8YGIhtHR6DMNdvsmRjjfZVoEIKkVd2I33bBtNQw1+eXRSz+/Agdsxb/
         1j1g==
X-Gm-Message-State: AO0yUKXi2tIZjExVZgCdXkaWTTxXUL9Yf0pblD7g7IN/3Pah2KdVZbP9
        Nc12o47qhv64rOj4xpGJgU4acQ==
X-Google-Smtp-Source: AK7set92lFBSWABiWVnMxIWnXGGdY1m9Nfc8omaQqaR2VR8eSkB4+lfFv7lhvjaDLvMIu46Oq0fLHQ==
X-Received: by 2002:aa7:9f44:0:b0:622:844e:80a8 with SMTP id h4-20020aa79f44000000b00622844e80a8mr5911107pfr.26.1678731545207;
        Mon, 13 Mar 2023 11:19:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:79c6:a848:199d:3491])
        by smtp.gmail.com with ESMTPSA id a11-20020aa780cb000000b005ac419804d3sm25169pfn.186.2023.03.13.11.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:19:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: fixed: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Mon, 13 Mar 2023 11:18:20 -0700
Message-Id: <20230313111806.2.Iee214b2dd184cb19197db8f97fad7e4adca273be@changeid>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230313181820.2482385-1-dianders@chromium.org>
References: <20230313181820.2482385-1-dianders@chromium.org>
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

As of commit 218320fec294 ("regulator: core: Fix off-on-delay-us for
always-on/boot-on regulators"), we now might have a big delay during
probe of fixed regulators. That can have a significant boot speed
impact. Let's mitigate this by preferring async probe for fixed
regulators. The regulator framework itself has no issues with
regulators probing in an asynchronous way. The fixed regulator driver
is fairly straightforward and also has no issues.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/fixed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 2a9867abba20..1927dc2d4cf8 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -334,6 +334,7 @@ static struct platform_driver regulator_fixed_voltage_driver = {
 	.probe		= reg_fixed_voltage_probe,
 	.driver		= {
 		.name		= "reg-fixed-voltage",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(fixed_of_match),
 	},
 };
-- 
2.40.0.rc1.284.g88254d51c5-goog

