Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D666545DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLVSMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLVSMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:12:18 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE7764F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:12:17 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e141so2900239ybh.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUBAS00PRdtRG1FOxjmExMw30CS0Cv+1NUdfDxRvZlA=;
        b=rZOh1SxfDlyTmG+rxpZqcn/nWmMNEovD2C2hKgwzsUlmtHIeKPacRoEH7djiDvoTL1
         VXEw2Nla+Tb+GB+mx8G/WYvGTCHIY8wFnDBikCCrMdqzUGWZXVMDypMtNFUywEkP7pVQ
         +qy4bILGfzgcT+LFEUJBqOypGtJbJ5zNE4m3fezc6E6TmdeO4yN5DOJJW1A+7X4eyVWK
         OGb07TJTAwx58p4S+9VJZBz8mg54ttn+gI81Rn+DhH5TbUXn0C/v6XxCkU1SPpPI6Les
         ew1Huwi+8H8NacS0/pN69/a6b6ODT9XXLbpsUOw9nHEDcTwVZ06Nkbb6CB4AYgfA5hfW
         VvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUBAS00PRdtRG1FOxjmExMw30CS0Cv+1NUdfDxRvZlA=;
        b=AFOFqscHYkGDq9QCVVjLEV3d1mXodnowi1yGDSmmCWzVFC0wmwqxrUiymlkFlG6VSV
         ZH/cj+hVFdpAYvi0HSFvTpdLP28w9jk/xe6EXdW8DsqKzChh/KgcDxslyTTI5HK0iThI
         Vk0UYPGHzaiY/e0IKJkg/RL5a3Xm76HeBqPHHwv5fJ4vAhdnrCcQVCmJTGH8VnSKsRii
         EcpiQSeDoifI3wAKpvFfvQNzUCa9PW/dyA4UTgGO78oduDhpjSWcve0Y+P4ktNP1aPlj
         gRNzKK807XFxyZNzVgavY2bU1tbwZA6thTYF0CAuffdvkCE4FPg4WYtR+zcfSmBwBdaI
         6cmg==
X-Gm-Message-State: AFqh2konw5QmwqlceEBqHnKwdBb1eEevA4dYpsKwSIz0x6OSMhoFd9KF
        ZSt3hMB1p1T7s2TrxhYAXZrFtzEZm6ge5Q9Bi28RRw==
X-Google-Smtp-Source: AMrXdXvLrW2srrW3QadKtrQqseeGGov3b/HuSypqszvimruSvg23ZHlKFAjQsr6vISn3P/kFUgTgWDTEyzsR9s6ybtE=
X-Received: by 2002:a5b:b47:0:b0:6fe:1625:f1f5 with SMTP id
 b7-20020a5b0b47000000b006fe1625f1f5mr667202ybr.549.1671732736796; Thu, 22 Dec
 2022 10:12:16 -0800 (PST)
MIME-Version: 1.0
References: <BN6PR07MB3185E78473482885FE72BCF3ABE89@BN6PR07MB3185.namprd07.prod.outlook.com>
In-Reply-To: <BN6PR07MB3185E78473482885FE72BCF3ABE89@BN6PR07MB3185.namprd07.prod.outlook.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 22 Dec 2022 19:11:38 +0100
Message-ID: <CAG_fn=UZcDSqnD6+CezbdaekXqejRKm-W8V6ZHxQ+GGUwb3YdA@mail.gmail.com>
Subject: Re: Syzkaller found a bug: KASAN: use-after-free Write in put_pmu_ctx
To:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Dec 22, 2022 at 6:40 PM Sanan Hasanov
<sanan.hasanov@knights.ucf.edu> wrote:
>
> Good day, dear maintainers,

Hi Sanan,

> Config file: https://drive.google.com/file/d/1JutR21cgcf28flJVyLqDniNyrExMsSn_/view?usp=sharing
>
> Reproducer file: https://drive.google.com/file/d/1X31x8w4ULrtP_YnkD7_RCyW7FlwGewMR/view?usp=sharing

Any chance you can build with debug info enabled (CONFIG_DEBUG_INFO=y)?
Then you'll be able to generate file:line information for the report
(probably your syzkaller instance will do that for you, otherwise you
can always use scripts/decode_stacktrace.sh)

>
> Thank you!
>
