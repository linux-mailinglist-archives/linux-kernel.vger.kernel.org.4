Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B335747814
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGDR6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDR6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:58:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94D10C9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:58:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b52875b8d9so545725ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688493489; x=1691085489;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtDTa/zSYu1BtyXYBgWZdAlFvHTcMeojuniPxpUE6tA=;
        b=HMkq/TKthPMoIlp8Xt1Kp+9IvRlxP2uVxW94fU1Rs1XeFolcrAwGpkhoHBhuROkt2x
         twdybnJM+tOmScV6iQRFKO8oZj992lBbu6CxZQuUyR+hDvab/6a5DsIxVbBjG2FUnCG/
         29UyYReZ9+xaUpv1bdXU7bM9eCLonxHp8wWgFzm+Vz3PHZ9pMKj1lXwp7KI5kTxO7hoI
         K2EXoPEIM1nuKW9pAss/7qb9RvajvevvxIBQAFqfNUALVdhY/W9P/lIaG4PlifV4l99l
         FX0lh+GMpIqKXra2FJt0BIF8lK2qX++XFi+55Q+5sOr0KFmhcrI6HrqsU0bUemx2xTJh
         x6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688493489; x=1691085489;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtDTa/zSYu1BtyXYBgWZdAlFvHTcMeojuniPxpUE6tA=;
        b=hxtxOGGjkr6Cen8ox/QlAUQYImsFFZL6/WCmKcn539vPdB4QeT0nRW2B+WHQrHbLTp
         jHDFgED1Nd1TqNTHLLEh+kXZ7CBWfvnIn31exiwDDXZFNXMDiXSsY/ojj1abuzL24vJU
         S4UP5VBqNXeDx3UZmhklOZHZdl66XNsAIZSDyJEPX+flzlUxC/q3T9fCd0I07NG10zRy
         6oPUasUzgVB1Kvo988+J+hSE1rzIbm3mHDSBcZyOby32ZZhBfYzA1xFxQ2KahPIivOAV
         2h0m9dKHqWu+LFQGYjKFkfSBeRnVzMLWTCo9yG53HHGAJIc+w2a9+7rbiK1C+j3oIbEq
         ZPQw==
X-Gm-Message-State: ABy/qLbCVjw1pNPOtogOP2fe5ttWShx8XEwOjzqtqtWmz4jnMxGIqANW
        jKOS1J/E7xltJ1nOfwS6FLP1Bw==
X-Google-Smtp-Source: APBJJlFk3YR1aUikjR6v2zDx4YgeL6uaf8BWmv4x9KrRM1f1S1Efo4GNieq5PMBdgBHMg75l4o73Yg==
X-Received: by 2002:a17:902:fb8e:b0:1b0:cea:2956 with SMTP id lg14-20020a170902fb8e00b001b00cea2956mr1117plb.29.1688493489455;
        Tue, 04 Jul 2023 10:58:09 -0700 (PDT)
Received: from [2620:0:1008:15:17fc:1b56:71df:89b7] ([2620:0:1008:15:17fc:1b56:71df:89b7])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b001b8a7e1b116sm1502829plc.191.2023.07.04.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 10:58:08 -0700 (PDT)
Date:   Tue, 4 Jul 2023 10:58:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Matteo Rizzo <matteorizzo@google.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, jannh@google.com
Subject: Re: [PATCH v2] mm/slub: refactor freelist to use custom type
In-Reply-To: <20230704135834.3884421-1-matteorizzo@google.com>
Message-ID: <f4f0e0b8-e04f-132b-7dbd-8bf1fc717544@google.com>
References: <20230704135834.3884421-1-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023, Matteo Rizzo wrote:

> From: Jann Horn <jannh@google.com>
> 
> Currently the SLUB code represents encoded freelist entries as "void*".
> That's misleading, those things are encoded under
> CONFIG_SLAB_FREELIST_HARDENED so that they're not actually dereferencable.
> 
> Give them their own type, and split freelist_ptr() into one function per
> direction (one for encoding, one for decoding).
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>

Acked-by: David Rientjes <rientjes@google.com>
