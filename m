Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A63866426D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbjAJNwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjAJNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:03 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCA6267;
        Tue, 10 Jan 2023 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358659;
  x=1704894659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fcYKp/hSCbvm2T2T8NQjOikt8LYmhEuOniPEBy7bp60=;
  b=Jl3nETbG0uNtdqXoqPCJ4qE5e0P4P0dCxVEi8NQqpOPTQL4V5lKjZ7zo
   PLFMx0TWDNWjpuyM8K0JAY5tAq58MUbXoqLbu1omxV/3qfg9K2ts2kvpr
   zkP/E8ITUdHhVamHEvFR4GzKvNaSJbYrmXYQE1rZVqF9CS4u9rhimq/Mz
   3UmYoDQHzn0s1cdKQGC6i/Mj+qVHN50jJGn8g0NIcfdSGt/uWWszK1/fR
   sEO2kl9Ccku+IcRA5BXCHTDu+GbFJihhfcWE6JqwlvRfbY7cVUT2t17VY
   7e5AOncNAtdku5keXf0yn3k92am04GlEwIipa1JhOm4PdxCRMzsmoIAXj
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/12] crypto: axis - make tests pass
Date:   Tue, 10 Jan 2023 14:50:30 +0100
Message-ID: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some problems in the ARTPEC-6 crypto driver.  After this
series both the self tests and several dozen rounds of the random tests enabled
with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS pass.  There are also a couple of fixes
for problems seen when using this driver along with CIFS.

Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Lars Persson (1):
  crypto: axis - do not DMA to ahash_request.result

Vincent Whitchurch (11):
  crypto: axis - do not DMA to IV
  crypto: axis - fix CTR output IV
  crypto: axis - fix in-place CBC output IV
  crypto: axis - validate AEAD authsize
  crypto: axis - reject invalid sizes
  crypto: axis - fix XTS blocksize
  crypto: axis - add skcipher fallback
  crypto: axis - add fallback for AEAD
  crypto: axis - fix XTS unaligned block size handling
  crypto: axis - handle zero cryptlen
  crypto: axis - allow small size for AEAD

 drivers/crypto/Kconfig               |   4 +
 drivers/crypto/axis/artpec6_crypto.c | 288 ++++++++++++++++++++++-----
 2 files changed, 239 insertions(+), 53 deletions(-)

-- 
2.34.1

