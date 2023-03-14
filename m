Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9F6B9640
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCNNau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjCNNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:30:24 -0400
X-Greylist: delayed 850 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 06:27:23 PDT
Received: from lemon.tzafrir.org.il (lemon.tzafrir.org.il [95.142.162.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 462A759E59;
        Tue, 14 Mar 2023 06:27:23 -0700 (PDT)
Received: from malaclypse.mth.mellanox.com (sweetmorn [10.2.0.26])
        by lemon.tzafrir.org.il (Postfix) with ESMTPS id 6FF493887;
        Tue, 14 Mar 2023 14:03:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cohens.org.il;
        s=default; t=1678799037;
        bh=V4Zc2T3I1HmDBjOheKObu3JC6alpwNDFidRUo0is7MM=;
        h=From:To:Cc:Subject:Date:From;
        b=SVeDor61UJ7atvcd2h4c/dUmEbVk4ofu5RfJdKYhV0xziEKVnximg+6IEvW0PXL7C
         hElXEZLVsEr3CVAbgaP89n5W29g3llqKpAhu3LJ8/Y9SY6NOIrPJCJJ2I9O7KcMiZ8
         WwOh9OKMAKLvGZgkbq+TUbSh7yWTNDG5LhhWaPNPdZOewfrnpNXmpLtbaVcSBAhPLe
         aTRZ7krzYstDWTDgJVhoqz4wg19xGQ2+6pYpGPNnnVGt7JDigIpvkMQ53am/4/xhn4
         F8UvDhZfQaGgh7i8JJKG+N4oG1eTfAMggmXXg0ZQ1JUDRkM1oE5t/BEvq4fjl2Pfv5
         uef3mE4Ve/oFw==
Received: by malaclypse.mth.mellanox.com (Postfix, from userid 1000)
        id 280C4847D4DA; Tue, 14 Mar 2023 15:04:00 +0200 (IST)
From:   nvidia@cohens.org.il
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Makefile: fix usage of kernelrelease with M=foo
Date:   Tue, 14 Mar 2023 15:02:47 +0200
Message-Id: <20230314130248.954196-1-nvidia@cohens.org.il>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1cb86b6c3136 ("kbuild: save overridden KERNELRELEASE in
include/config/kernel.release") set the command that is used for
printing the output of kernelrelease only when KBUILD_EXTMOD is not set.

Test:

make M=$PWD -s kernelversion
make M=$PWD -s kernelrelease

Should print both. Prints only kernelversion and an empty line for
kernelrelease. Included a simple patch that fixes this test.


