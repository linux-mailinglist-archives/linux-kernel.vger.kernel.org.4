Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF0261D9AD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKEL0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKEL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:26:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91981C93B;
        Sat,  5 Nov 2022 04:26:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt23so19234464ejc.7;
        Sat, 05 Nov 2022 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY/KtbX3jbDptuIQjnvBjdpzPDQrxT9VwpfdqZ2aZ5E=;
        b=ZrBOJSZdWcoOe/+txsHOjwOKetptUDuyt1nUoaadwRBvRuAbtmiWaj6KHx/5ANEjp+
         t74IW2t/9TOPPwCaldVcnaH8RorDnE2cDOkwQp4RqF8eCGTgAxnvuS7CW7B/liW/en6h
         cU7wtVs6o6GZORidhqzaQAbh7jTqTMnX+G/wXpEDOplfSROVvqxG1Cq4AORo+fXZFvL6
         ogmNDq0XR95Aj9fevfiRKdo8s15R+2I+0DInjxK8v1IGAvmrC9qfOIjpB9eVCgv3hGAL
         AZOT/lqFA3Ne2VJEm3E/evkU8nd5y8RLJOXn9bztnA0DZxbxXNWKgs3TfZvt9FgrT1nE
         beMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY/KtbX3jbDptuIQjnvBjdpzPDQrxT9VwpfdqZ2aZ5E=;
        b=mUawxLBdXrcIulZN3LT4gzeJ1d2nblsqFFVh/6F3+FjiLbcb5DFc1h+13Zmo2WM0L7
         UqpB+F54CuYfvXK16q8qXLR2uaw0n2xSCzHRpT5ufeXQnC4RxTHTIqIjZerje03WP5TI
         vsJqR881oG1VvR/0awYZf7InwKD1TgYiTK6myMd85aE7F6MYdFzkZYPoSYFpoUfuMn0N
         1VsDIfd9XjH+43OGEW3RozPlpAOBzOh8q3cjY2i1JToWV7rMF4BPJujaOP01dxPF6tiu
         Ru49dQU/S+HJcRDRPZYcxaVjYCAQrliQqdm2r0jW1YG6VkaFh7i/slmsjG2DJImeMNkI
         IyAw==
X-Gm-Message-State: ACrzQf09vhvx3Qv/GgTxL/bjr6+G9GnSXJr/HSgAy+juLsGRLs4Jc8TI
        FIrmBD2Qcn8UBT/m3/lqdajorAOW0nGTfw==
X-Google-Smtp-Source: AMsMyM6Hi76abSC7XtLo543s3U1W1fxckam5NsSx+Bjtod7RieJ7/tw9LbUPS3KmBYZesLMRAPlN8Q==
X-Received: by 2002:a17:906:5a63:b0:7ad:ac42:150 with SMTP id my35-20020a1709065a6300b007adac420150mr38787217ejc.583.1667647574314;
        Sat, 05 Nov 2022 04:26:14 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id u18-20020a509512000000b004611c230bd0sm1050069eda.37.2022.11.05.04.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Nov 2022 04:26:13 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
Subject: [PATCH v2 0/3] power: supply: cpcap-battery improvements
Date:   Sat,  5 Nov 2022 13:25:41 +0200
Message-Id: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements few improvememts in cpcap-battery driver

Changes compared to v1:
[PATCH 1/3] power: cpcap-battery: Do not issue low signal too

use delayed_work instead of timer as enable_irq() should not be called in
atomic context (timer function).

[PATCH 2/3] power: supply: cpcap-battery: Fix battery identification

no changes

[PATCH 3/3] power: supply: cpcap_battery: Read battery parameters

no changes
