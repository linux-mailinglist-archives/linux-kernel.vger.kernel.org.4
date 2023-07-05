Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A51747D20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGEGd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGEGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:33:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B41712
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:33:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-557790487feso4429653a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688538799; x=1691130799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDvL7ekfNs3bVJSGPqpDAjABE5c0UvJWFUFVDP7OcnI=;
        b=HCLhgdyCq90YfTQMjaZdIjt+ewIGHr1WoJsIV+nau37DwSwAOxCl2fjO89N/8iyvzE
         H7nphOWHQcnoXDeIAAzONINmvw/9M+OF7ptZ2nYwtk03J6Xr1VIAXJFgzI89yGveGEEn
         GqQXrdDg26hwQ58jRQ8CVFGH4yq7UNJvF82E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538799; x=1691130799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDvL7ekfNs3bVJSGPqpDAjABE5c0UvJWFUFVDP7OcnI=;
        b=kCE0y56NsLaiPX+t9PtFnNKr5hY+vNhFl+9zLw7bNqm1V/laBJphhayF+GKLRShqyn
         S+PraWWvNYQwEPqifcl1yCr5DeHmR+aJacGkiwK6DdsKhSi4qNLXW0OhdDvoAx741ea1
         ng6F31QNQDMuzzDKrhntgEcBtxuwvdCFsLngqk/Ahf5wTWPAODItz/WEZuxb1z3abWCg
         bYL9PZEdP+Zttfb35B7Lnr71E7rahG/oaRkEmkS1Lq3VEPbczKXu0p8OAPWkeUrexckz
         FpR2xYQEf3KP10yT/9iJF6saHPYipogxeHbcmMlhseC0wgr5TZts0vv8gkY1vO50dY3v
         t63g==
X-Gm-Message-State: ABy/qLZpvYi1FWFdg7a7mhokATVZBG6TV23E6Qv8JR0PFsk4LUcCs40R
        RmtJkGBjThUbhKT4S5RDUtjGqw==
X-Google-Smtp-Source: APBJJlFpuOviESDRC+8Eczf993gvvtLCwtBHrHyO+U2M+unQGYqacus88aSVN0CInn963UVCfuJ9qA==
X-Received: by 2002:a05:6a20:8408:b0:12f:6500:8504 with SMTP id c8-20020a056a20840800b0012f65008504mr3750180pzd.46.1688538799000;
        Tue, 04 Jul 2023 23:33:19 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id u23-20020aa78497000000b0067aa2a70179sm13271590pfn.46.2023.07.04.23.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:33:18 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] mm/memfd: fix sysctl MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Wed,  5 Jul 2023 06:33:13 +0000
Message-ID: <20230705063315.3680666-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

When sysctl vm.memfd_noexec is 2 (MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED),
memfd_create(.., MFD_EXEC) should fail.

This complies with how MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED is
defined - "memfd_create() without MFD_NOEXEC_SEAL will be rejected"

Thanks to Dominique Martinet <asmadeus@codewreck.org> who reported the bug.
see [1] for context.

[1] https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/

History:
V2: fix build error when CONFIG_SYSCTL is not defined. 

V1: initial version
https://lore.kernel.org/linux-mm/20230630031721.623955-3-jeffxu@google.com/T/

Jeff Xu (2):
  mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
  selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

 mm/memfd.c                                 | 57 +++++++++++++---------
 tools/testing/selftests/memfd/memfd_test.c |  5 ++
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

