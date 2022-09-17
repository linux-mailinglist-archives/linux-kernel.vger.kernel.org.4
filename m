Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81065BB55A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIQBcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiIQBcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:32:19 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1462BD106
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:32:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u131so8158434oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BlVQwXVfr3GW5iAF6OT2YMTv6rkyyGCnSP6Ag3jREYU=;
        b=KP+HNwDETUuPHLPcIapFdjnoF2cUScO3YXyr8jfUFet6LzZxXtjL1a9d5PDo4/pRYG
         8cdGuQDun45WLXn09gwMq4miu1+Wfmgf5C10SUtvLKiJylwDvbIGKFfHpydRHY1XlmjD
         K4Snl08qVjp19NDbWD0K/wYGVVR1PRdZuW+4u8dKOKo0+G8pjFNiQTGPC2jjurepOjQF
         0h7kbUTkGqbz423D0olnF+OATvKeTZ5SJqIjxYUKnpRtOf56nC+x1rkBSPExdpc5gZJd
         6oQk/O20nbHyGdOFiiLUJZ3EifAF3rSX6cXNMFIQ59Xp/X2vjnv6yz5HBLZd4clS878g
         ZD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BlVQwXVfr3GW5iAF6OT2YMTv6rkyyGCnSP6Ag3jREYU=;
        b=F6jaB1nzv/vRsVAD1e02Y5l0LjSgLVoEOgj3jPkPP96Nl3mNmLXmAfrlmnkqBj5Khg
         MQbgD5PDLSqU9yqMBTLxXiJF+EvZOuyUZRaLUJXg8euJ1WR11pf6/L1h03H/aFvVuvOc
         rWJuWWvQYTIqby7qPZyCItIytMmMRjeyviQZezTxEV9DPk1sEdL308+slCiEjprRDIWG
         wtTGVuF/u1VZc5sQ1lUrxHFfatr+o9ptWVj3Uepugc+7Ve+2hyVgdDM94yy2Cxwmf2VR
         rmOGb8WFhdrc4VcZkciO4cnhcrmfDpKRx2Gc9+hx2clWDde8dxgbA/TfC/n82kIIYbH9
         Oeqw==
X-Gm-Message-State: ACrzQf0lOVdXffpTQAVy4xKhDu6WVlsfp/Jqm5dzULb5gsvMd9saHPuT
        HVyqg9ShB9rD5s46iyhrp5emc5mmwwIraJ6K68vpAA==
X-Google-Smtp-Source: AMsMyM4JyQBf2phyIkZLp3fghM4p+hZVmExpKQsnCaRgJb+PYCFIowVBZpaDctVfmjLRm5A0Bg40Mqp40BiGc6ovbTk=
X-Received: by 2002:a05:6808:49:b0:350:77ce:3368 with SMTP id
 v9-20020a056808004900b0035077ce3368mr956893oic.195.1663378336284; Fri, 16 Sep
 2022 18:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220916103817.9490-1-guoren@kernel.org> <20220916103817.9490-2-guoren@kernel.org>
In-Reply-To: <20220916103817.9490-2-guoren@kernel.org>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Sat, 17 Sep 2022 02:32:01 +0100
Message-ID: <CABgGipWdm+-pOrj-ROR8fsVO7JEr4m64z7+zNW1_NszW74e5SA@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: ftrace: Fixup panic by disabling preemption
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, rostedt@goodmis.org,
        greentime.hu@sifive.com, zong.li@sifive.com, jrtc27@jrtc27.com,
        mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, by disabling preemption and ensuring all sub-functions called by
the busy waiting loop of stop_machine, which happens to be true on
non-preemptive kernels, solve the problem from the original
implementation.

Andy Chiu <andy.chiu@sifive.com>
