Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB5624998
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKJShw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKJShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:37:50 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABE11583B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:37:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id 13so7295148ejn.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38H4CpuHEt63sZt7E41Yfo4BeoR6TKT05dTdvft0sDo=;
        b=NrVulZjkNJR4NJT8Z8hPvxm2sMV87wf/0NySQ8fFRewUOCx6PL/FkWxon4Nx2H/P3i
         n0yU+KMLXTEK9s/SRCSmqYaeWLmy3DD4/lXwnFDNS7LmN40bPe9s5VbOulgo+x9nvJIF
         mFvaih1C9UeE2t8oFpHkA46pI4xO/9rnJwadnm4n5r2j4V61hZCu4up9mKb21bERLxJK
         SUUu3FKFwRRapcVxP5DebMOyKeXczLyk8R6ssQq6oexJ/dthPD77wfhw5uWuvmusFpeq
         eBr5WZA7tadXU8tUvfes0IDvR/7pTh8/VwcParSiXCyT232Mp7SKmAca7OorphPm8Vnq
         LxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38H4CpuHEt63sZt7E41Yfo4BeoR6TKT05dTdvft0sDo=;
        b=Uh5IWDbrrnbYBcUTqS7kpDOk2HAtyWzu8fx6bQ808Ysc+85W49hYEqxxDqUMjz/vv/
         bBrj9/JjIn2VAr45+TiJrRD51nzctdhNk93D2W+JgevU5FpGByk3df883yI9iNyLdfPo
         Hi685QqQH+mtPShXaanhWsT+8BavegTjBuFl7BP8mtr+QMs089UGZ240PjTUQjtfljfk
         /3sFIBhDC9/ZjPMRc4BNkyEixsigEmYZGgCMpBpNNrrd0Uh2uCPXBTr+nmcrRhIgpUHU
         FD45coQXs6fF8Sr4GroSTQEKuweZAEz/ywpQfuDHykFy5JL/lrfI626drN9f/gO6XKyD
         tR/g==
X-Gm-Message-State: ANoB5pnf0ofGBYqlae9p63wTydtMK7RjKsD61Nz/yfcUDbqYaKV+EsD/
        nfPAIiS3euzUfebTXmUpj2a30MToeaqQYLWyzC4=
X-Google-Smtp-Source: AA0mqf7lvMxg7nRMzk7cgCWytI736Qrq5f+DDiYOUvJ7MVVvtuXa2XMK/kUfRSgJmZWtZQJV6BjrtLQCjy09fgMOW/4=
X-Received: by 2002:a17:907:8dc8:b0:7ae:6450:c620 with SMTP id
 tg8-20020a1709078dc800b007ae6450c620mr2933710ejc.270.1668105467967; Thu, 10
 Nov 2022 10:37:47 -0800 (PST)
MIME-Version: 1.0
References: <Y2xyHM1fcCkh9AKU@xpf.sh.intel.com>
In-Reply-To: <Y2xyHM1fcCkh9AKU@xpf.sh.intel.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 10 Nov 2022 10:37:36 -0800
Message-ID: <CAJnrk1ZvWfSAsYx-cErCqjQbciKCiAKss6Kvcm_4vXP5bzFh2g@mail.gmail.com>
Subject: Re: [Syzkaller] There is inet_csk_get_port WARNING in v6.1-rc4 kernel
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 7:38 PM Pengfei Xu <pengfei.xu@intel.com> wrote:
>
> Hi Joanne Koong and net developer,
>
> Greeting!
>
> Soft remind: "WARNING inet_csk_get_port" is found in v6.1-rc4 kernel.
>
> And first bad commit is: 28044fc1d4953b07acec0da4d2fc4784c57ea6fb
> "net: Add a bhash2 table hashed by port and address"
>
> Reproduce code from syzkaller, kconfig and bisect info are in attached.
> Full information is in the link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/221108_215733_inet_csk_get_port
>
> Thanks!
> BR.

Thanks for your email. This has the same root cause (handling the
error case when connect() fails) as the issue discussed in this thread
https://lore.kernel.org/netdev/20221029001249.86337-1-kuniyu@amazon.com/.
After consensus is reached in this thread, I'll submit a follow-up
fix; I'm hoping to submit it by the end of next week at the latest.
