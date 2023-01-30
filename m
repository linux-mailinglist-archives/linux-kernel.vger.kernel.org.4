Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F84680993
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjA3Jed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjA3JeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:34:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64CF7AA4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:32:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so6009116pjt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7Rfwt1I+uGLH2WvGyjGS4z4+0W1oBU0PyN8+ybwBQM=;
        b=hCnLQngH722sIEXN1Gho9Wj1ujABjTtK8JX/cG3wwwGaTKdAB+ey7HkETd6oZpO8tv
         vLdoPzqJLerf49cPLSpjOorHVag3ybhXhpYr/77qmDgvjgzmFdT/0d3bxHOZj/e7n+bY
         t8uSp9ikhaT89Y8/DDu/f6YmDsbqbCtH9SHKNmJGAis1CHdAD2Vg/Us25RsC2Vxm6SGm
         6peI7uPrZelCCu4EcstZZseRCRQsCrohoNKVVIoWxmA+RdjN7nMbH43Kb9cIzmBoXo3D
         OU6oU5ZwPVpKtUhF3UDUADSHTLP/R+4DWP3Ll5ImHlmOricvo99OaP/0pQI1SvA4a9R8
         yMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7Rfwt1I+uGLH2WvGyjGS4z4+0W1oBU0PyN8+ybwBQM=;
        b=kF3/2x48tRPBiHiK+fBXHf2/AJIAMtB1mDZ/0pzXwRxLR9QOnvyHN//R9FM1T3IF++
         UuEzGEUFs8vraPaeyl4/xebl3sOIxCNaa9xNET89KX9zuagE1FC/6rTxH0di4bh/+w1Y
         VeTzF8bPh5IcUVrZ+DQaqknLsk/Es8MNH9+Jn8eI3joYm6YDje65cj6EBoWuZeTQ44ga
         fD1YnFlBa4LKPaP2dbteWhlI+05jbVmdiyMBBwgQggwrkuk/uNQRVUsJSx9Fdwy76EPn
         Zewgtnla0y/xQPETImRPcIM3yC5UdsNo5v87t3E8pwGk8Ba361hGwp2LOk4UOnQ9alNu
         qXbQ==
X-Gm-Message-State: AO0yUKWDeCTgRytIPrPl42PRfjVRMr5RaMMt3ennOCCd5k3uZewa5gwk
        lSvU57nkJlfHFTznEFCoDj0GXA==
X-Google-Smtp-Source: AK7set9QLGZ+95SoqxDpz0fnhu2C6Btygt/5TP7yC/t6bY6mZyLjmV3rrULbqSgdQtIJkwB74RFyog==
X-Received: by 2002:a17:902:c406:b0:196:e8e:cd28 with SMTP id k6-20020a170902c40600b001960e8ecd28mr30471930plk.15.1675071155816;
        Mon, 30 Jan 2023 01:32:35 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id t13-20020a6564cd000000b004db2b310f95sm6245704pgv.16.2023.01.30.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:32:35 -0800 (PST)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nylon.chen@sifive.com, nylon7717@gmail.com, zong.li@sifive.com,
        greentime.hu@sifive.com, vincent.chen@sifive.com
Subject: [PATCH v2 0/2] Change PWM-controlled LED pin active mode and algorithm
Date:   Mon, 30 Jan 2023 17:32:27 +0800
Message-Id: <20230130093229.27489-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the circuit diagram of User LEDs - RGB described in the
manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].
The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual[2].
The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period.
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to the driver.

[0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
[1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
[2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.

Nylon Chen (2):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties
  pwm: sifive: change the PWM controlled LED algorithm

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 4 ----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
 drivers/pwm/pwm-sifive.c                            | 1 +
 3 files changed, 1 insertion(+), 8 deletions(-)

-- 
2.36.1

