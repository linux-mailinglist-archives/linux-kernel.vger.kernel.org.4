Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA76571BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiL1BrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiL1Bqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:46:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E8F8FF9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:46:42 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id e21so283632pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VAg9I6sGgystoJ3TQ/I1KhSIRtbmfENt04grq0O1eU=;
        b=ka7NTMQ0c8GwGaYNC4TLnUyVjpW/DOHmjrxHXinFVEpU9D9Duc65ev4L/I5G73dWFo
         chfrWJakpcYJmHmRro4TIZeN1yLCHJb/DDm2nSOO4GLssDl7OCu1793DakqfQqVt/GN0
         6mmm3+zJsoTSrWcARVMJNzTS6JnSpgk966ZpD+Vw5s7TTxvX0gV5PkvRUGT+1x75lnaR
         jSuEiVKum/kJ6BHwWnMwYKo40m+jhgnT4J48TJ06rTkYD/+fjnvOWcvA9thKZIIEnikH
         ndI2b7DduJ3WmXKQobI2rErE52wlocqfmB77yUXPlOIX7HoGskdAKk83uK5OMHrB6WJm
         Bt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VAg9I6sGgystoJ3TQ/I1KhSIRtbmfENt04grq0O1eU=;
        b=Cr1S7Tq2gTRDI2OPK98GfROZC3gcIN3ce1bN7sdnV9T1Eu/if0P9QJm0taDgkoaZPm
         UobRTuGTsPHBeruK/qdvuO9846drWU3jeOE/8+sM1gpzCaDGMUM40sJxgOxzKAYb+o3+
         yz/f5p3/kJw5VKhot4ezPC0KqH4skE/zo4Rt7h1Ymuz9QM1jwqd6I8VDdUKa/3LquW2G
         YMXUSaZyUe6DvaBcTNqe9wGNJbS7lRM50bkUok5KGgC20/RVtZrvQLcBrlXu2fFywGn5
         prhZB6zQ4VK+VQKkdAHqG0rS6vBOGQQ/bkOPZcR/2xTeKgDs0zadbzTMxjQSoQgK/CFa
         nG0g==
X-Gm-Message-State: AFqh2kqvykC2EhrcIEoLa5aRzkSYcTrdelNR0n3gHprhSJ5oqRCxmiyL
        RI4FBHYSdXLs2ASkT8ZK6COhhQ==
X-Google-Smtp-Source: AMrXdXs5gFho3jeOXwhmodws3dxxhHKTouLxX4u+ck0jgPmPtTo/nc3FPPXMYElaqZB+vWfHJzxyyg==
X-Received: by 2002:a62:6486:0:b0:576:22d7:fd9e with SMTP id y128-20020a626486000000b0057622d7fd9emr1989207pfb.0.1672192001796;
        Tue, 27 Dec 2022 17:46:41 -0800 (PST)
Received: from [2620:15c:29:203:93f7:84:3b7b:8294] ([2620:15c:29:203:93f7:84:3b7b:8294])
        by smtp.gmail.com with ESMTPSA id h135-20020a62838d000000b005754106e364sm9060069pfe.199.2022.12.27.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:46:41 -0800 (PST)
Date:   Tue, 27 Dec 2022 17:46:40 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Gou Hao <gouhao@uniontech.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        mingo@elte.hu
Subject: Re: [PATCH V2] mm/slab: remove unused slab_early_init
In-Reply-To: <20221218123127.23810-1-gouhao@uniontech.com>
Message-ID: <544c9bd1-c262-1915-de79-d6e00109eff4@google.com>
References: <20221218123127.23810-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2022, gouhao@uniontech.com wrote:

> From: Gou Hao <gouhao@uniontech.com>
> 
> 'slab_early_init' was introduced by 'commit e0a42726794f
> ("[PATCH] mm/slab.c: fix early init assumption")', this
> flag was used to prevent off-slab caches being created
> so early during bootup.
> 
> The only user of 'slab_early_init' was removed in 'commit
>  3217fd9bdf00 ("mm/slab: make criteria for off slab
> determination robust and simple")'.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
