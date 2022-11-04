Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ACF61A10F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKDTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKDTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:32:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC345082
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:32:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y13so5346421pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJx5Vo13L9gX9apUbugbGq7p+vwBn4IOzk+4YVYJbZo=;
        b=PWyXmK+bN4YM6UWblyRMVutXuc2f46M8K5kj7AsPvSQYau24NgfA3c14hTpOkY/lXh
         TgZknkLqE8+M15xi09X/3zFxiyUz3OD4glTMJZRgR90wrf2JsTPhor8EbFM0YrK/rKoG
         YgSETYSHttYklZcLjRGnOLHKMpA0xM6Z8PDlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJx5Vo13L9gX9apUbugbGq7p+vwBn4IOzk+4YVYJbZo=;
        b=R9Wi7Hs5oXaradb8e0m6RD21LKVq8o01hKZigcN8SxB52Bdo4NATCjMZAvf66AK03X
         Kk6eUaq1QI1oEPwwATiDkQhWeIfT+bhzl3NVDhzRFkbL9ATuN0ZxDrylbTTU1EE+rXT+
         4leB9cpMrJlm4stYLpxd4E3roLMZI4JPLv/4X2sCILkfx3FQ8gvzFH5lq7QKG5/RV7U5
         IV0Zx8cWDIYWH3Whv8D5ATofEIE/dGY6vjGuSxmIS3dtFcz5o8QF+lKxJx2h5xkdsKe3
         FVb89sZno/IKVmG0PlSqKfIfnQRqhZmTl1UhnR6oRoav5XJWYW0vMKzuzZHwzGo//zsF
         bZ2A==
X-Gm-Message-State: ACrzQf3JU1An1EU4DtHe57J1eru4PzioVhTW19tpf3yKkOinusnllsUr
        3BzJrToOdFippg5hhT/kS0+6VA==
X-Google-Smtp-Source: AMsMyM6b3yzI6tcnLNCUvQjftaq74cgnM4/tQtryFCIdjr3n8azek7qjQaYlxgkqWKXcmSealD9oKA==
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr37351768pfl.53.1667590360362;
        Fri, 04 Nov 2022 12:32:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a684400b00212daa6f41dsm95856pjm.28.2022.11.04.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:32:39 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 4 Nov 2022 12:32:38 -0700
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Borislav Petkov <bp@suse.de>, Yujie Liu <yujie.liu@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: elf_create_prefix_symbol(): Resource leaks
Message-ID: <202211041232.6071ACE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221104 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Nov 1 13:44:09 2022 +0100
    9f2899fe36a6 ("objtool: Add option to generate prefix symbols")

Coverity reported the following:

*** CID 1527141:  Resource leaks  (RESOURCE_LEAK)
tools/objtool/elf.c:833 in elf_create_prefix_symbol()
827     	struct symbol *sym = calloc(1, sizeof(*sym));
828     	size_t namelen = strlen(orig->name) + sizeof("__pfx_");
829     	char *name = malloc(namelen);
830
831     	if (!sym || !name) {
832     		perror("malloc");
vvv     CID 1527141:  Resource leaks  (RESOURCE_LEAK)
vvv     Variable "sym" going out of scope leaks the storage it points to.
833     		return NULL;
834     	}
835
836     	snprintf(name, namelen, "__pfx_%s", orig->name);
837
838     	sym->name = name;

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527141 ("Resource leaks")
Fixes: 9f2899fe36a6 ("objtool: Add option to generate prefix symbols")

Thanks for your attention!

-- 
Coverity-bot
