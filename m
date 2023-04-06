Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC27A6D9161
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjDFIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjDFIVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF6DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680769233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BXUvMRorNZxITkqnZH1MXu0rmexe6DJRTF71KV+DIHs=;
        b=AkB/REmo+O0jXdYPrUnI8QGUEouADE7COWcfz0Hh6yPL8Me3x4rOeQx1u0g+Kma8C6TCtL
        1FCGclVqbgH0UWZ6I7A1lIigKCu5cxovaPwhZSeFcTJ6eCVe+0koYdlKCVmpOMn1eNerbT
        mMy8r0+KtW763yEU9tCDTNihwbonb8A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-E9perV-RPIeyDIxyXTXFFg-1; Thu, 06 Apr 2023 04:20:31 -0400
X-MC-Unique: E9perV-RPIeyDIxyXTXFFg-1
Received: by mail-qk1-f200.google.com with SMTP id n129-20020a374087000000b0074a2ff16363so6179698qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXUvMRorNZxITkqnZH1MXu0rmexe6DJRTF71KV+DIHs=;
        b=YRVhnAnx6BGgNwn/82Lk3V8DHwKUqwWnhVwmcfla0K8ovgGWpMaqNc5cL7YwyK47lk
         08FhlVYtT8kKSZPFqEuGWlCatUQAZaWYMtzbkTM6cmo3YYxZAG2xabfpCrUox4THdq8B
         z/zRcHCEBFAKXMugc1+FmBrLrn9TViWD2RsgcYr61dCCTBcj7LbllLVJWSdgB1GIT10/
         7hTtpIhRMLNkLGc+bvgJ8lV5QQsSZVvBmKP+4piADJC+j7TqO28aMzBR65dsIebqCM15
         nBYOU6yXTY7C83sc9W8xAIHUdEN3nIJP8fIEymuNZvHkd4X0B4YCX1RUVarynDZkPUGY
         g0kA==
X-Gm-Message-State: AAQBX9cpNzYsOozklkydrkacHVocqAmUbw7gnhgbBdV+/Bx01/XpB+It
        /RujEPSk4qdyGn2zhsMDDHVbgRk4bxafpa/JA7eK9BGywr5vDv8fVVOVoO7QZE2paNhMnla2D/Y
        0RftLlbdWT5T2CemI7v7V6tej
X-Received: by 2002:a05:622a:1310:b0:3bf:d71e:5af4 with SMTP id v16-20020a05622a131000b003bfd71e5af4mr9312446qtk.26.1680769231460;
        Thu, 06 Apr 2023 01:20:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+DqTJW8TyaitShZCgfRRIb8x6MKj1p0XWxsmV86e0OD/haDQY/5/Vgj2Uk5oyUQapd7cQDA==
X-Received: by 2002:a05:622a:1310:b0:3bf:d71e:5af4 with SMTP id v16-20020a05622a131000b003bfd71e5af4mr9312432qtk.26.1680769231218;
        Thu, 06 Apr 2023 01:20:31 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:2599:3b52:5a:179c:6ae7])
        by smtp.gmail.com with ESMTPSA id 186-20020a3705c3000000b007456c75edbbsm292776qkf.129.2023.04.06.01.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:20:30 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/2] Deduplicating RISCV cmpxchg.h macros
Date:   Thu,  6 Apr 2023 05:20:17 -0300
Message-Id: <20230406082018.70367-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While studying riscv's cmpxchg.h file, I got really interested in
understanding how RISCV asm implemented the different versions of
{cmp,}xchg.

When I understood the pattern, it made sense for me to remove the
duplications and create macros to make it easier to understand what exactly
changes between the versions: Instruction sufixes & barriers.

Thanks!
Leo

Changes since RFCv3:
- Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/

Changes since RFCv2:
- Fixed  macros that depend on having a local variable with a magic name
- Previous cast to (long) is now only applied on 4-bytes cmpxchg
https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/

Changes since RFCv1:
- Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/

Leonardo Bras (2):
  riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
  riscv/cmpxchg: Deduplicate xchg() asm functions

 arch/riscv/include/asm/cmpxchg.h | 319 +++++++------------------------
 1 file changed, 67 insertions(+), 252 deletions(-)

-- 
2.40.0

