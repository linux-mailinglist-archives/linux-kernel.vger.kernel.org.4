Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB268AECD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBEIGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:06:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2720D21
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 00:06:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee13so2229900edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 00:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf43ZAC9d9vV87Brf749qwDNEbTSGBab1FS9DyewXkE=;
        b=IYzxAnFf7wdql5pNk1TmzsC9UPQ7Cwt72Sz7/xF0jPG2kf2CTMAE+6qsUjmcs75YFm
         gwYr9dCg+Fvih+BixjfsA69bk5FMag3n88eqUg/QxrcTvHs1Jt8tAtuc37Ln3pk0Wg1d
         ZPkoP1Ft5Y9Q501jx7BOlqX9ZJjxGkGK3t2hxnG4rql05HsfbWRumyn0MFlbongnY4eF
         gs6FtfWbF7y1MU8jOx72EQGG59RdV0oin6Tq5Esh3jMk9z6a6rit4qFE1MFpftq1XKIb
         xO8RDtbygHZ16oLbLGgtCFUM5uzIVHq33VqfHFVGjwEZ70GQcIr8z5NInXZg2TZ9aZUw
         pBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cf43ZAC9d9vV87Brf749qwDNEbTSGBab1FS9DyewXkE=;
        b=hzeHmI3eCCnhd7XRAAF5cCKvk6eeByABGHB+AEz3JVjLUvRVYi5YBJ6SjDDwHD5pFB
         A0shlK0x3C2gRSc2yhtLoRDw8LhGfwV+zq03OKz/L/ZojbjU3QVBCETh+G2WzZ/G7sKz
         ktUMyDOotBfiDdcEEneK5AgxwewH3xcReLzff0uvyU2SHq2SO2nFlRO2i1+NxIePD2IJ
         hhsGvLu4h9BAv7nK5h4RPzMdEg0l9/+oAJ6wnSmVdpcbkRosT774idP+ve2VxzPMxujd
         nE/VoOF3h9gYBKbXB44gjM9quP6f0OYibwjgGT66oQbR4DvTCCvjK8GnJFrSr9IdW05k
         yTHg==
X-Gm-Message-State: AO0yUKUnbedd7rNAggCPm0EetdumfV+FbzmRsrZgORc6JaBgfd6sAuyX
        zs8tLjBlcP2CXaTaTGdkG+E=
X-Google-Smtp-Source: AK7set+lpuCEhSj4zOH3rTqwYf9bgUaGTOBRuaqkByOp1hB9QuOm75UJDzH5A4fNA1RTxwUlLfXXfQ==
X-Received: by 2002:a05:6402:2206:b0:4a2:1b97:228c with SMTP id cq6-20020a056402220600b004a21b97228cmr13979648edb.28.1675584370914;
        Sun, 05 Feb 2023 00:06:10 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbf9.dynamic.kabel-deutschland.de. [95.90.187.249])
        by smtp.gmail.com with ESMTPSA id q10-20020a056402518a00b00463bc1ddc76sm3441379edd.28.2023.02.05.00.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 00:06:10 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/2] staging: r8188eu: correct error logic of two functions
Date:   Sun,  5 Feb 2023 09:05:57 +0100
Message-Id: <20230205080559.8319-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts two functions away from returning _SUCCESS and
_FAIL. Another tiny step to get rid of _FAIL / _SUCCESS someday.

Tested on x86_64 with Inter-Tech DMG 02.

v2:
Removed the initialization of the variable err in _rtw_init_recv_priv()
since it's not needed.

Michael Straube (2):
  staging: r8188eu: correct error logic of rtl8188eu_init_recv_priv()
  staging: r8188eu: correct error logic of _rtw_init_recv_priv()

 drivers/staging/r8188eu/core/rtw_recv.c   | 30 +++++++++--------------
 drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
 2 files changed, 12 insertions(+), 20 deletions(-)

-- 
2.39.1

