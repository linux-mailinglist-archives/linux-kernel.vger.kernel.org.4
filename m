Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD260FB23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiJ0PGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiJ0PGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:06:03 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3370BD6B81
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:06:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id nl16-20020a17090b385000b002138288fd51so358332pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x43WQSDSdduVvRqUykrv5fQezd0RCHir1Z866mjqV7A=;
        b=qHJtiLSprjfCsziSAgE/n8Hv6lbaec01bI8j0JPBQwtnWR/HXzBpHPAOtz7uSNNjVG
         dflOcCPkGIzgGy+w0WnCgGI3MiNNcBEODNSWqDip39a5m3AgWA9kUW5BTQwadIjp17nS
         8hBss5xaReOi41Q4vkedXvTnG4L00S69gzhhUhdrd6WbQClqzq/Ji5qomSB/xCI24ej6
         Y2gxzLN+3SM7mg74Ic+Kq0CN8mJR0PtHOfVDrL/28s6VUJdatkZ3/uDAh5H5L8Q9lj1s
         pSr3eMn9l6oxpghMfgZhfZodlweMqWllkdSbnMJt7mgO7pON2XeP/Y4sBv+HZC6h0ZYm
         yZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x43WQSDSdduVvRqUykrv5fQezd0RCHir1Z866mjqV7A=;
        b=7jO8OfQr0TP3/UxQi75BD6CiY7YqOYmiJR5mz30IvWoRIeogGNLfvIFJSd+zkmrQMS
         FsYnvijO1OEvdnQcbBEOiiHBMv0f6vL8hxFqPpZJLrTrzmz82kNeG3kFroFBgMfm2Ahc
         zbDLqfInteqELGVu+KqSGqmLJLd2ChYrJC7Et1IwtyLz518Ol4qKvrPR3oQHkme3iDmu
         xAdAcHmP0UcZIPSD/WDXp638nIrhYsDdsJkNvpoygBvFaKlaeJYgS37/4Rz+ML1LYp6U
         hC18+5EM9Pw5cWZWbSvaz9TAU6Pp2xAmfZtHmskllVcXOytTKXUBWE5e4i1cbAhDIYdw
         BNtA==
X-Gm-Message-State: ACrzQf3ZyVlWBC6x79RehBtS32XaR7ijqulyhqf970HugB9KO4eQekMn
        iHR48Prs54vD2W1DMsOb8DM5+lzppJo=
X-Google-Smtp-Source: AMsMyM7Hs8LUGwiuRjC57fdpWxdsH1fMbe288JIdp+/zcGp2R8Hu14sqSR5Y0P7iNjnFWh0ZLqGD87lHkio=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:da0c:de35:6ecf:7c48])
 (user=pgonda job=sendgmr) by 2002:a63:6c07:0:b0:457:523c:4bd0 with SMTP id
 h7-20020a636c07000000b00457523c4bd0mr42197743pgc.101.1666883161698; Thu, 27
 Oct 2022 08:06:01 -0700 (PDT)
Date:   Thu, 27 Oct 2022 08:05:56 -0700
Message-Id: <20221027150558.722062-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH V3 0/2] Fix security issue in SNP guest AES-GCM usage
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Borislav Petkov <bp@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ASP and SNP guest use an AES-GCM bases secure channel to
communicate with each other. The IV for this encryption scheme is a
sequence that each party maintains. Currently the ASP requires the
sequence number of the request to be exactly one more than its saved
sequence number and the ASP only increments its saved sequence number
after a successful command. That means if the guest request ever fails
it can only ever retry that exact encrypted command or discontinue its
use of that VMPCK. If it were to try another command it would either
need to reuse the sequence number which is the IC. That can lead to the
encryption scheme failing with AES-GCM. Or if it incremented the
sequence number the ASP would never accept the command due to sequence
number mismatch.

https://csrc.nist.gov/csrc/media/projects/block-cipher-techniques/documents/bcm/comments/800-38-series-drafts/gcm/joux_comments.pdf

Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Marc Orr <marcorr@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org

Peter Gonda (2):
  virt: sev: Prevent IV reuse in SNP guest driver
  virt: sev: Allow for retrying SNP extended requests

 arch/x86/include/asm/svm.h              |  6 ++
 arch/x86/kernel/sev.c                   | 28 ++++++--
 drivers/virt/coco/sev-guest/sev-guest.c | 93 ++++++++++++++++---------
 3 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

