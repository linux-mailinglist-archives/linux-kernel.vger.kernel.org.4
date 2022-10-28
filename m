Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3806115CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJ1P1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ1P0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:26:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF881CF54B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v27so8412984eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xs7ZsRPy5xlIirExLI4FhtsVOo8y0v5L1DiHF2jWjc=;
        b=ejIs5206nbaAuK0RqxKSO3KnxVkSkSEdaZROaSn1NkiUA30D/RHsdlnhd0jDWnd0fW
         F1aRf3pkS8GG/JCEP26OE38iZvZq2x6YT+RE1QWSBpGZKm5pCusFqlf+IL3yEO6fqRyl
         jZGtzOaaXaFi7Y7lYm4CpHdcg4kCx9HA/RMz3zwj6N4FY8Ui3sSjvSfK05yMQUyOX4MC
         lTdpBRmwof+6EYtMwJdHYg3xvW3aur1WC5aMPgFmXyEQBhPe1JoofuPoFVHjTldDxeOG
         CuOiS60PlCer4GrVWNOzi7+s00wyFrU1QkY6Ig1fGewf0z0bu8NzxUjeW5qmJ3z+HdkY
         GbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Xs7ZsRPy5xlIirExLI4FhtsVOo8y0v5L1DiHF2jWjc=;
        b=mHJfgrEUkzYm4C4ylTGktwFVnKz5FAbMq7438mfEi37fQq0+VQijM22D2RxXAVqlC6
         YTr+hgYQYWooDEpaR/yWVui1YtrM1sftrVsUVp1Zaopow9skaZdAv8by85ZodhDBTj4H
         qgsFsTcHB3kioQHzeMztdZd45rEwM/W2PMru03nWbIazWahli0xWRzTmOzT7AgXDvHJq
         aALxT0nJEN+HLJ5QpX3Cqx7U+35DpNbv1FkqIMBd8qqw+kkqAv4O4wTN1z1InF6INe7a
         Xzp9O9QrxpukQP1rxk135CkkD/D4zc+ksnkQ3N12lUMQZMe16O/uZ7nQOge1wzuG6qc6
         RXog==
X-Gm-Message-State: ACrzQf1xPy72SJXrYnhUGW5bdA9Sp/h8TG1+Mwg6UlhUo/Hb8HttVwjb
        aR9qKhPW78o6SfQDx6sXU7ENng==
X-Google-Smtp-Source: AMsMyM7/ZhL91+wfPA6lrOcKKhoBGDKoL5RqFDfqXj5XpqzwoDEmxyjLAbIgLvC7FgYKRJI+nP942A==
X-Received: by 2002:a05:6402:5244:b0:461:d97e:5271 with SMTP id t4-20020a056402524400b00461d97e5271mr24382712edd.227.1666970808663;
        Fri, 28 Oct 2022 08:26:48 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906319100b00730df07629fsm2349839ejy.174.2022.10.28.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:26:48 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ASoC: adau1372: fixes after debugging custom board
Date:   Fri, 28 Oct 2022 17:26:22 +0200
Message-Id: <20221028152626.109603-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maarten Zanders (3):
  ASoC: adau1372: fix mclk
  ASoC: adau1372: add support for S24_LE mode
  ASoC: adau1372: correct PGA enable & mute bit

 sound/soc/codecs/adau1372.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)


base-commit: ef6747add3ad08a23a94b20db0b62688efb9ccd9
-- 
2.37.3

