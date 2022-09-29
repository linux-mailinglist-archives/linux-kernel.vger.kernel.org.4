Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97795EEA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiI2AZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiI2AZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:25:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19D2AC70
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 17:25:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bq9so22150494wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=z1ygdZwW7ZMPvazhzZFrvbRpuwFWoXGDK8RmI0UsUoU=;
        b=S2RKLmUnQy3TXM/lvIVIW1mn9EV/n7twX1uZJvKc37XLYFxv2sgtuR+ROHPErCdN/b
         4WqpM+vb3QFtUTV0//b7DWIIgveXqFfht/GUCMFjPa8b9qps0faRHGzLFNHvJbKw2mze
         yDHfR79hQJNPiaAV+CtFpSPJloyklFoDGHCGUYMvxPGfRosb4PikdNT4+vsdH8CvGqWc
         ytD+605wZ5V+6XYpim2cGBVzjDeuqH5iTYm4M0Z78aBOTh60O7ucfm78IZ42OoCy537r
         b7oL9aU0sTmWcvUwQwyFI3wDQKy0O+lGxWLrWo+8160U0gFGrfZx0+w+5dD0NQxyGOAB
         RI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=z1ygdZwW7ZMPvazhzZFrvbRpuwFWoXGDK8RmI0UsUoU=;
        b=L6UC76S7uuES+2swt+b1vVhgrO7K3clAeeTm52kGLZl5+knZTzY9TqvGHmvBahiaAr
         pYnFDGjW8CR3xOc4aVa5nOFjmUl7EJXiFC+dZ0g53u8T3yk+6UtiV+8JAlRwo8aYXBUJ
         eYGJnziqKBoqh9kRbVLVGdzGm7CEf/v3Yu1UtaM+dhqJ+1M4VAJv9TtSFEYBgE//Atql
         c9RJo/c3oRV6SV89gFZtcUbEWt2FUb+Cv0+U41jTbvMi3qQ/7QkwFHlcAvfIeusFcL62
         n0jYBn8EtD0a4rNEgXEIY8rmyAWXKeJ9bT6beVThp3shCSfNaVfWSOt/LtS6YKFQ+dHX
         qwCw==
X-Gm-Message-State: ACrzQf1JzT0GgtN5UeOF9QiXgDhKQb7SGh5BHa0NfKYKlBU6Qwlps2HL
        CM8ndOjeF/TEdLrDrh9P+G39Bw==
X-Google-Smtp-Source: AMsMyM5bVBQYhxnCnwEuIYU6x7uuP0dVbd0IhrEs+tf4kmv5TVRCEGaAaPaUmFtog/99yUhzQf6dsg==
X-Received: by 2002:a5d:4dd1:0:b0:228:e3c3:67a with SMTP id f17-20020a5d4dd1000000b00228e3c3067amr247455wru.411.1664411103802;
        Wed, 28 Sep 2022 17:25:03 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm3033841wma.6.2022.09.28.17.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 17:25:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 1/2] get_maintainer: Describe supporters and maintainers as required email recipients
Date:   Thu, 29 Sep 2022 01:24:59 +0100
Message-Id: <20220929002500.283481-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
References: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of get_maintainer.pl doesn't make clear that a supporter is a
type of maintainer who should be mailed when generating a patch.

In various places in the documentation we make reference to the necessity
to remember to include the appropriate maintainers when sending your patch
but, we confusingly don't call out supporters as maintainers in our
automation utility.

Fix that up now by having get_maintainers.pl print 'maintainer[volunteer]'
or 'maintainer[supporter]'.

Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 scripts/get_maintainer.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9b..f1a081806bf82 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1283,9 +1283,9 @@ sub get_maintainer_role {
 
     $role = lc($role);
     if      ($role eq "supported") {
-	$role = "supporter";
+	$role = "maintainer[supporter]";
     } elsif ($role eq "maintained") {
-	$role = "maintainer";
+	$role = "maintainer[volunteer]";
     } elsif ($role eq "odd fixes") {
 	$role = "odd fixer";
     } elsif ($role eq "orphan") {
-- 
2.37.3

