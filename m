Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4486B7A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjCMOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCMOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:18:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E141755BD;
        Mon, 13 Mar 2023 07:17:59 -0700 (PDT)
From:   Bastian Germann <bage@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678717077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MauftBkeob0zziilDqiXW4F7v15t6qhlHlvGrl8a2MU=;
        b=kseP6zPAnwBh47DtKUuKl+5xs9MITxjYgPYoESVBYAm5eEbh4FG0RIx1TP99pWIj5zMu55
        AQHG6fDeK1ekx5lR6O6JktCGlztQAwSPNAJAuH/Avb4efuug5D2chcpueYXf7H/FmF2QEm
        I5m1P0jgmqMZUOs/HezqvfwjuVn/aMCMFwbn3lKzcsgnlEqmO5PdB0YcABMJzAJmcnirhY
        xrPm35x3ES0Bko9Boq8OujbXWMKBtLAP+rikNsDNK/BcK2i3ygof74ryFEVYEhzGsxOTWU
        D/C1tiIhx6wTMBCwOBL86/3OwmPDCHaNPxuKlOh60Z0Ud7Kd+P29pmMM39aWpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678717077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MauftBkeob0zziilDqiXW4F7v15t6qhlHlvGrl8a2MU=;
        b=i9tKtrFIUTl7lvk4rqR7kHbEUucJpnx+R7pgVYrXac8tI+TKoIlWop+lnUoBQcqPUPNzyd
        GO3LuXdHPCvBDcBA==
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] builddeb: introduce profile excluding the dbg pkg
Date:   Mon, 13 Mar 2023 15:17:50 +0100
Message-Id: <20230313141751.186903-1-bage@linutronix.de>
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
v4:
 * Prevent the creation of the dbg package when profile is set

Bastian Germann (1):
  builddeb: introduce profile excluding the dbg pkg

 scripts/package/builddeb | 4 +++-
 scripts/package/mkdebian | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.39.2

