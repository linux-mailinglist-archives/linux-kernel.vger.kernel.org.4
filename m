Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62A45FA489
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJJUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:07:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3C15A3C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:07:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q9so11091125pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNCg1vG/TpDaFFOERkcuISZd2SrHkdu8vq5Ds7eoy/k=;
        b=aQSEQa8S6ut5Et5WaqN9RZRvdifpoAnGd2VM6ccY1LlCosHu7rgwJd/IYBEK98avrq
         HXQtKvpnJoAdcnSbNZfCshUCMl4Y5l5Pmqk6zxou4XyUtDjeobQpIsIwNxvAzdN1T5XK
         61UJ4niywv5iAJqDkXXjVO5z3UXvT2jrVNmFRyiAABs6dJmev0SkjH2JeEg8wh2OS+RR
         GjcjSsyJW1M8BT0uY104FbDl9sigW1+1PK/IWi/HoGKqiimR00//L/WE+Md0wSYDuDes
         eQO+FspTud1TgoaUmQDutAQoap7gd1zZ2Rz0Jtp1wktejb3av6Fak8ub6bPxusl0pWDn
         xDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNCg1vG/TpDaFFOERkcuISZd2SrHkdu8vq5Ds7eoy/k=;
        b=HOEfLjCWUm7XCgrrB7KXNpVl4By+7ccco22PAHmEz2eNze0WtKc6BBcUm9KvzSmpdY
         mxhhjaGz3hrp+BHlH08Z3L8vTjHwfNNhMd/nFhHjIIWLp/8OD6LOdOYlCm4nq1R89bFu
         TDnn8w3kNKInrQK4nQPwD7k4Kr+3BRPjqYH4phjQlT4uJ08Xw9ODxgrZ984MIfHcctW6
         eslbnQUFvFyemjiKbP95J9Swkle9jvIFdG7ng1scGHCBR6ob5Gcu8uBHJTh5xOBe4vq4
         MIx9uirk9yUF2o2tDDT/rDyGvT5VoJZuj2mxKEURU6rN8E4YO3FfrnMBdRGnQS9xN5xG
         nKqw==
X-Gm-Message-State: ACrzQf0AuL4EEXAZReOTmN/Vu0EYtCz0jpqwGwJesG8xumpPp7hvrYiI
        A2DgrDvZSQ8wY2LjmSlPIvs=
X-Google-Smtp-Source: AMsMyM5Kpb8kAiRt6qGlKs5j3y41lh4gZb032OLr+z3J5V4PNGQhCL3V4WjkFiIiMb8k2ncnKQvf3g==
X-Received: by 2002:a63:e14c:0:b0:439:2e24:e014 with SMTP id h12-20020a63e14c000000b004392e24e014mr17591574pgk.173.1665432423538;
        Mon, 10 Oct 2022 13:07:03 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h25-20020a633859000000b004351358f056sm6709343pgn.85.2022.10.10.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:07:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 10:07:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "Christian A. Ehrhardt" <lk@c--e.de>,
        Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Message-ID: <Y0R7ZZ87vROrO+XR@slm.duckdns.org>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
 <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <Y0Rn5qzP6MjayoCz@slm.duckdns.org>
 <CAJD7tka2jwPnYyCmLu0T5Oq_X-LJCx7TVqLayLPS_6fOjqf93A@mail.gmail.com>
 <Y0R31xyfivqtKb9h@slm.duckdns.org>
 <CAJD7tkaQeFYq6prHiTiGeEyC-ka8ujAFXV--BkROJbVDaOZ78Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaQeFYq6prHiTiGeEyC-ka8ujAFXV--BkROJbVDaOZ78Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 10, 2022 at 12:57:34PM -0700, Yosry Ahmed wrote:
> Any suggestions for the new names though? Given that the new ones
> would be the ones that will support both versions, I am not sure how
> to name them differently in a meaningful way. Maybe something like
> cgroup_get_all_from_[fd/file]() ?

idk, cgroup12_get_from_[fd/file]()?

> IMO, we can rename the current versions to
> cgroup_get_dfl_from_[fd/file](), and the new ones (which support both)
> as cgroup_get_from_fd/file(). In this case it's obvious that one
> version specifically works on "dfl", aka cgroup2.

It's kinda confusing because we've been assuming that these lookup functions
are all cgroup2 only.

Thanks.

-- 
tejun
