Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3259623106
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiKIRFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiKIRE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:04:56 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7B2A277
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:04:11 -0800 (PST)
Date:   Wed, 09 Nov 2022 17:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skothe.de;
        s=protonmail; t=1668013448; x=1668272648;
        bh=XedvgB1po9ayTY4ox9EA0HdN+W+EAwbhCury97jYShU=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=cRqMj1thG607FtQz4kSbRmrrOx+Rn91jHa29eD6KyI47xALpzxLwsY5eKOBCOO0L1
         Gj3C3xBiN8QKu30scFJ4HJGgNn4DNjrhuCso3NWx/z1UNNMl4iPvaD3MVtOVFH+tQO
         OIetxpI7IUdXMSt5GwqogQX2rRwfAfBEPFS+V0cN2Xi7KM6+JKX0xmrI3y2iQUmjkQ
         JZ1GYdV1zEyG77ovLy2oHInlb+3xsiOW82vgOc6NdAeqB4YOZMmX5skng5XRxsLlDR
         hKsKIxwKb3OXOIjZmhvqKh3t7gPPIUXk06eaxrRG3BPZo5on6+U2PLQcCdr4UxkAMw
         hTz48g77W4LgA==
To:     saravanak@google.com
From:   Steffen Kothe <steffen.kothe@skothe.de>
Cc:     linux-kernel@vger.kernel.org,
        Steffen Kothe <steffen.kothe@skothe.de>
Subject: [PATCH] scripts: dev-needs.sh: Enforce bash usage
Message-ID: <20221109170341.36785-1-steffen.kothe@skothe.de>
Feedback-ID: 55345914:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling the script from a system which does not invoke bash
by default causes a return with a syntax error like:

=09./dev-needs.sh: 6: Syntax error: "(" unexpected

/bin/sh invokes on most distributions a symbolic link to a
default shell like dash (Debian) or bash (Ubuntu).

Since the script depends on bash syntax, enforce the same by
default to prevent syntax errors caused by wrong shell type usage.

Signed-off-by: Steffen Kothe <steffen.kothe@skothe.de>
---
 scripts/dev-needs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
index 454cc304fb448..46537859727bc 100755
--- a/scripts/dev-needs.sh
+++ b/scripts/dev-needs.sh
@@ -1,4 +1,4 @@
-#! /bin/sh
+#! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2020, Google LLC. All rights reserved.
 # Author: Saravana Kannan <saravanak@google.com>
--
2.30.2


