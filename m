Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20643608166
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJUWSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJUWS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:28 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566992AB11C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:25 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d142so3476416iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkcAxJz5UaV/gOoKQ5YqYMglqfBBTV2T6cx36FG5wQc=;
        b=Sz88s7fjekFj/AV26xOLEymhM3uxOHkIsuexheI2cWmJmITgqMJnr6heCXWUiUcafn
         Ye40LPs16A7SZaXogZy8xm3jQrBbJ7luV2Gwgkb+sU69uFDtQ9J+RRd24pBz5vUFkRM8
         G+NDC+UTbDtvoKMqcdLyT9Y8VfzY9cVRIaWYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkcAxJz5UaV/gOoKQ5YqYMglqfBBTV2T6cx36FG5wQc=;
        b=N5/G1wpSUmYClBLM+xoM575nw8vIjw677yPZRTuW3HJ4yxnxLrMCNla9IKA7+zWX5k
         F1taag67h/E0NZiUvA5G20ZJb98bw+2jRiiHllxcrzsq+1ggWy+kHk+awcvrMmil+Y52
         hTt/iMw3IHSmrFv422Swj4SRuCyIGYOZfaIZNqhYF5RlWtYqY7oo4Hs7Z326aTScaIRq
         ZcX+GfNun7jyiqu9GwXZxzs09LATXNKM+8K9wjldhBw0ZxfsSPFd5ckzhCg4BJ/s5a8M
         lJIciMe6mdeHw7tL054ROhQ65Q5KMQi4/SYQmABk++5OeeU3JBZIedKNqPADKMUz3WJw
         pVRg==
X-Gm-Message-State: ACrzQf1eyx1aOPwX0BT8rLluddqSinpC6LN0ILZjvxtQTsJEK0Yu0z2k
        CqVlYWNN0Ay/Gcl2Dg6lZ3ZS6qLv3qvh6Q==
X-Google-Smtp-Source: AMsMyM6eMy/U/vUFn+jdgCTz9ehgGzteVfkAgj4cBxe9txPKSPslSBTaqNbPVq3i/pS9NEnlFqxmDw==
X-Received: by 2002:a6b:671e:0:b0:6bb:f05a:fb11 with SMTP id b30-20020a6b671e000000b006bbf05afb11mr14278642ioc.74.1666390704312;
        Fri, 21 Oct 2022 15:18:24 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056638480600b0036cc14af7adsm430740jab.149.2022.10.21.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:18:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests/watchdog: print watchdog_info option strings
Date:   Fri, 21 Oct 2022 16:18:18 -0600
Message-Id: <2fb04f40e3d3a35fd2b30896202931cf5b9a1311.1666390362.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666390362.git.skhan@linuxfoundation.org>
References: <cover.1666390362.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change show watchdog_info output to print option strings instead
of hex values to make it user friendly and human readable.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index e6af6e327eb3..03103eaa946c 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -6,7 +6,6 @@
 * - Could be tested against softdog driver on systems that
 *   don't have watchdog hadrware.
 * - TODO:
-* - Enhance coverage of ioctl return values - flags and status.
 * - Enhance test to add coverage for WDIOC_GETTEMP.
 *
 * Reference: Documentation/watchdog/watchdog-api.rst
@@ -314,7 +313,7 @@ int main(int argc, char *argv[])
 			printf(" identity:\t\t%s\n", info.identity);
 			printf(" firmware_version:\t%u\n",
 			       info.firmware_version);
-			printf(" options:\t\t%08x\n", info.options);
+			print_status(info.options);
 			break;
 
 		default:
-- 
2.34.1

