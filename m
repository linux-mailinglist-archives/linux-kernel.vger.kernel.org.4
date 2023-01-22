Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B0676D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjAVOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjAVOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:14:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A6FF0A;
        Sun, 22 Jan 2023 06:14:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC2F6CE0EC5;
        Sun, 22 Jan 2023 14:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCC5C4339E;
        Sun, 22 Jan 2023 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674396875;
        bh=AmzoAcLy4rVEa77Srrddz7lY2JGQMKi8x97/XkEnqeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLLlojZsj6x7FqINSenhdIbYC7OHbmRHXOcA6JV2STTfF+QnTgBZL8qNlP573q0yU
         O+dSLE/V2X+z44PpM+BLmNKSOUEcShsLCbRgvq4mQ8qs/TOEv0gkOaLs8I1hsxdVt4
         ezvO91yNvNgxD0iK5FhpnmCD+DNdLnRG4mNggGmZUJTn5QpSo51kSDdZbddndZxN+C
         hlFc3pU8oMygG2hJWE2XDpDxg6pA84Gd+gC7yItazOmZR/NEUhJK2EcwnynLjGXvpn
         4XUlHe5NCCwsNjQAlV6taU3h7Yv6oSykSi3v9cETu+g1dxiBzzR/sR8VVofDfltGWS
         iym6csGpqZOWg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/7] setlocalversion: simplify the construction of the short version
Date:   Sun, 22 Jan 2023 23:14:22 +0900
Message-Id: <20230122141428.115372-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
References: <20230122141428.115372-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the --short option given, scm_version() prints "+".
Just append it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 3b31702b4a4a..5cdf409204aa 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -121,8 +121,7 @@ elif [ "${LOCALVERSION+set}" != "set" ]; then
 	#
 	# If the variable LOCALVERSION is set (including being set
 	# to an empty string), we don't want to append a plus sign.
-	scm=$(scm_version --short)
-	res="$res${scm:++}"
+	res="$res$(scm_version --short)"
 fi
 
 echo "$res"
-- 
2.34.1

