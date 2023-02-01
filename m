Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFE3686D30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBARgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjBARgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:36:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515A43C01;
        Wed,  1 Feb 2023 09:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEBF5618BB;
        Wed,  1 Feb 2023 17:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15687C4339B;
        Wed,  1 Feb 2023 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675272999;
        bh=uWkpL9cDRo35mKlBeEusLIDzCFzScQqRd0F3LjyR0Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFHkDTSrvmHfEelGGGojvccebo/QANWc4kPKajtFUiOjbnfocnHlC/Clc56KGInJu
         Ho+DAVmODIWX6fIqWF/55tyxODCjZntKQMFXzLba/0GNA5MksrZHVJ7Gi5YWys0tHM
         J6d159DRRWYSSxkw2yFaTDpBXivi33hXBenRFMK6lDAHObsCDvYUCG4TQv/5dAr0CP
         kVC9jfQG6d88TjXJX/HKiqlyos7bJMRjOC2m3SH3+707kTWkpqHdhFsxEgfOSXMLq2
         dRMuSM3RuBw7XmYJKo07dcAi+bkrfK/O+OBDPZXfxpWidoocgEavPEGjujjj7Kp0Ww
         3LMNepAC7lfmA==
Date:   Wed, 1 Feb 2023 09:36:37 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ian Rogers <irogers@google.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Fix HOSTCC flag usage
Message-ID: <20230201173637.cyu6yzudwsuzl2vj@treble>
References: <20230126190606.40739-4-irogers@google.com>
 <167526879495.4906.2898311831401901292.tip-bot2@tip-bot2>
 <Y9qbGHDBFtGoqnKK@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9qbGHDBFtGoqnKK@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:02:16PM +0000, Mark Rutland wrote:
> Hi,
> 
> I just spotted this breaks cross-compiling; details below.

Thanks, we'll fix it up with

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 29a8cd7449bf..83b100c1e7f6 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -36,7 +36,7 @@ OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBE
 OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
-elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
+elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL_CFLAGS) -x c -E - | grep elf_getshdr)
 OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 # Always want host compilation.
