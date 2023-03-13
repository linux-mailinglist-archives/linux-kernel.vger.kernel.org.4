Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF316B72D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCMJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCMJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:41:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF812E;
        Mon, 13 Mar 2023 02:41:17 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678700475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q9CKaZh4szJMAvMtK0X/GWpgV//q3NDYlXAW/WCtFpA=;
        b=pKxI1RUqa1QN9RGcMBbah8OKkKyCxWoUm3Zrktkcrb0WGHf6MdriVW7BkPkuGCI+NNuMTV
        9k/ZdZotwsmELCST3B1t/ZM0zpHOhYw2M7twAdUTAPEH2zcJXjJZXHefwPkqCkGmcFtKVE
        zkqgXfvkZWwxxAjocm+hzxAVd95Hn2Lu0OjXJXqalAWyWJalUz9tosZJVwoZqq6XSiOYYu
        N/pHfIj++phUodV24K6zjzldHvxPJZY6znB0fPEEApNiVyzfg/jvOGH46jW5hRiWXIeN4l
        yj+9GoMT6ONrjM9y+29rfjqR4z2HqWBSVjkG56xrKlX20YaCUVXGIwEuql+yTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678700475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q9CKaZh4szJMAvMtK0X/GWpgV//q3NDYlXAW/WCtFpA=;
        b=VqYSWqZ0v6vNDhq63Y2OWgggwIs3/BSvo6iu8lVjALnmL+GQ7bspGenbsHxM/cGJm5ZCXc
        rfyewpGk7kJrSVDg==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] builddeb: introduce profile excluding the dbg pkg
Date:   Mon, 13 Mar 2023 10:41:05 +0100
Message-Id: <20230313094106.46770-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a Debian build profile to exclude the massive debug package
during build. This was sent the first time as part of a patch series:
<20210411101422.7092-6-bage@linutronix.de>

Most of the patch series is included in the current work on mkdebian
but this is still missing.

A basic test showing better timing.
It is expected that the relative diff will be greater with more symbols:

make tinyconfig
# Enable CONFIG_DEBUG_INFO
time make deb-pkg
real    5m31,104s
user    4m30,960s
sys     0m46,296s

make clean
time make DPKG_FLAGS=--build-profiles=pkg.linux-upstream.nokerneldbg deb-pkg
real    5m28,076s
user    4m25,129s
sys     0m45,489s

Changelog:
v2:
 * Align the profile name with the one that ended up in Debian.
v3:
 * Prevent the creation of the dbg package when profile is set

Bastian Germann (1):
  builddeb: introduce profile excluding the dbg pkg

 scripts/package/builddeb | 4 +++-
 scripts/package/mkdebian | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.39.2

