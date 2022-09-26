Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC525EB20D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIZU1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIZU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:27:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F279048CB2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:27:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g23so4882984qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Pv5o0TZDNeMSmawH17qKug3meL3WXlOBL4IBJGeG49U=;
        b=UQlvvWuczzs8yMB6KJ+ZljBN9ggCx4G2t3ZTV/A4bUN9+n48zAXu+mOVF15HggPjnl
         XGDMDrigHgz1teUmP0SgEtVbkqSvHMqzsfMib3MIt2CGPsqFyk7je5c3SrB5bF68x3c9
         hOLme/WPVtibnauDZDMSIKwT+9Ao29kjUEm2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Pv5o0TZDNeMSmawH17qKug3meL3WXlOBL4IBJGeG49U=;
        b=Joj2p1DBdFXqJNbUMU7fx3LxLm0968HPpduE64NJT+TZB2YJWuLfZrkYLlggkVYQ+R
         mLjACdoi56/qbChNfIy4dbs3U3T5cI2EDgFNJ1SAsRHMwqoy8xrYHbLq0rkyJ5JqBShv
         +EHHRS6mesFK0y+PU0/6r2oeDc7iEBWItwvdDgiy8TAWw1jod3Z4AeNmpPr1LlxCp2Ne
         kPTl02HEsskcB2XkxAqzyFt6Ra77B6igXBa3svGZnhQRhuNlnpa4628p1HKnyWqBXi01
         dlA/4SeanmI43TbP8P/lJman5JL1CMTvpuJ9AAPR94WuyhLPQ+KrVHITlAU8DmiG9A36
         9FQw==
X-Gm-Message-State: ACrzQf1dIMX9oQxErcOrl4uBNElUlOE8X8TSkzP2JGUxm3J8Dwhs33hg
        qOatPMUZIZRocRomq873UA/x+zjmngGOSg==
X-Google-Smtp-Source: AMsMyM5s5Nn4p1rIbY59kGFDAfV0xOxFqTRVqA7rHH43iA/TJTf0MjmT4Ss6/vB9byxNX4wNHwlQLw==
X-Received: by 2002:ac8:5f89:0:b0:35c:eaf1:fa2c with SMTP id j9-20020ac85f89000000b0035ceaf1fa2cmr19960387qta.89.1664224032668;
        Mon, 26 Sep 2022 13:27:12 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id fg21-20020a05622a581500b00342f8d4d0basm11488427qtb.43.2022.09.26.13.27.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 13:27:12 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 198so9901108ybc.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:27:11 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr6940475ybu.101.1664224031612; Mon, 26
 Sep 2022 13:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220926123721.2a1edc734b4fc516a9a350b8@linux-foundation.org>
In-Reply-To: <20220926123721.2a1edc734b4fc516a9a350b8@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Sep 2022 13:26:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihk0cRP_ZPFPsewJQ2KOM05i87jYUxcdMpok8a+fduKw@mail.gmail.com>
Message-ID: <CAHk-=wihk0cRP_ZPFPsewJQ2KOM05i87jYUxcdMpok8a+fduKw@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.0[-rc8]
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 12:37 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> 26 hotfixes.

Ugh. It would have been very good to have gotten these (or at least
the bulk of them) a day or two ago, so that they would have made it
into -rc7.

Oh well. Pulled.

               Linus
