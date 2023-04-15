Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E86E3489
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDOX66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDOX64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:58:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A707D273A;
        Sat, 15 Apr 2023 16:58:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h8so6890556ljf.3;
        Sat, 15 Apr 2023 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681603131; x=1684195131;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b+C3hpxh6J5QHRhe2FhivGyaZVbPUYTSyJSfx8ZF9I0=;
        b=ftibuOcO2eyKfjdohso1p2WvUiTN7ffYQvWKmo0Kc+JuytnUVU9RG3LTvx3X/8Io1e
         9G3vVdNu+tZ/Cflv/adCYceDmcmoGjnM/wkGyOFnWwuIRzHBa+MHES6HEG5cI9Tf9mUA
         K0H/+/5/R6vqnfqVkbbr2R7m6oQsiGW2dF6+RpPgFcU8pjh2JODi5KL4eDDWHxMqsYsb
         Vv9u2KZv8rcPQKKE6PF4vv8CqvrYPw6znWonWfQ+/lLFlGEHVxy2S+KFMNR1nJjmwZvQ
         vu469H/gnVNAu3TvhIlvezNxSQ0aQ2ZOirkoVV6/xdiLmpE2e1atG68laE+CmBiEmi2y
         Xfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681603131; x=1684195131;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+C3hpxh6J5QHRhe2FhivGyaZVbPUYTSyJSfx8ZF9I0=;
        b=LpFgdxPsPmDMILE9dhbSYZRal33amlgfCJX85Ug5FoT8epJj3ML0kNiBgKubCaCCCc
         corVIxMHyTYqF81NdALVqDfm7DypdB6S9DLu6W+50JLWKAxgyq2PBqmC3GOjm6v+VhyY
         GullbttXvsey5rz+NyCUJsEIBWEv3YcTMLdRiScpZQzOfOcUo7ek5ryaLfEMPDvQRWMt
         +k40YXUkCdYRtY+LutHau4eb1wOOta1FqEYaiCFxRo6HlVs+vEtThBmuU4hB2bc1HVPf
         A2L7siydOHPHOIQP3f16B2ij6Rbvb2rEnUUKaBgjsRxjLhGj5ihMXEi4O5vUsDdtFPWJ
         dUqA==
X-Gm-Message-State: AAQBX9e29pOKsLN0oid+j1nzLpOfUB3+iku6bgEzFBdfbLG+/3OT4cOL
        6RTB5quqKrL/L8+h7F8hMhOFMuF/NFJtkjjEs4uNo71nIhg=
X-Google-Smtp-Source: AKy350aQc7kYg/53299mq3jkm+tmv0tPDtqktToVwTOsa4A95hrqeKlC1zL+pI5jQioqzsEgXGuGhYCgAUiddYWsR+I=
X-Received: by 2002:a2e:9811:0:b0:2a7:7470:4ebc with SMTP id
 a17-20020a2e9811000000b002a774704ebcmr3251206ljj.2.1681603131354; Sat, 15 Apr
 2023 16:58:51 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 15 Apr 2023 18:58:39 -0500
Message-ID: <CAH2r5mv+eZW6RAPOqZ0FCWixdj-kKWHj2DfEDLHZvYCZh8iAzw@mail.gmail.com>
Subject: [GIT PULL] smb311 client fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git
tags/6.3-rc6-smb311-client-negcontext-fix

for you to fetch changes up to 5105a7ffce19160e7062aee67fb6b3b8a1b56d78:

  cifs: fix negotiate context parsing (2023-04-15 18:26:56 -0500)

----------------------------------------------------------------
Small client fix for better checking for smb311 negotiate context
overflows, also marked for stable

(I updated the description of this commit today to add an additional
Reviewed-by)
----------------------------------------------------------------
David Disseldorp (1):
      cifs: fix negotiate context parsing

 fs/cifs/smb2pdu.c | 41 +++++++++++++++++++++++++++++++----------


-- 
Thanks,

Steve
