Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53608670FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjARB0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjARB0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:26:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE6818E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:26:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id y18so31493402ljk.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dl8v80xeLJqsCJQkN4tTl7+qjfWSUms7Euw/wZtq1vg=;
        b=MPsZNMKMk/Qcp+A0CQblM3eBU1JnnxWRz5bEgEO7608VlYsu2SeG5COAVM+UVFqYx9
         ByaVqhbpSb/lHI8VtftzjuOSzG8SmVfmmAkBlt3XM3Dpr29yyiM1296EVKeSwEziHe5x
         VKy9pcXzc+73bizVn+T1Mh9Geqb8KWekprbrgY5xl/8jgqt8sTbKiSMpnZp46A4P6/iA
         E2DeT6U0ykAN6t+DLKw/nC2VNbsMXgFObfXoydkrXYjWBhLMCUDzqb/FCzW7hqWkaWP4
         1eWZ+AkV2QVIfFA1PglzNzOj3NaTHvUuoUtd7edbh+UvMPIkA68cl2W/Icy4W957dFov
         0mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl8v80xeLJqsCJQkN4tTl7+qjfWSUms7Euw/wZtq1vg=;
        b=Q+fjX2TRt6/pvbyaDqh+XbfznLICTmuTRBoNiFYj8MCNvr5oaK//ITTPEBqrV9jbx3
         TB+/ucfRsmh/x4BUkpBvMguD2/IlaP7aS9NA9yM+hAHK3V4HsOujkzfmgSEI3JuqJJ1C
         oPdBmRUbf+j0cboksE37fcXERE6QZ+LNPM4ugSohZKjfbjUAe2ga9IKg6PS05NmRfRqR
         NAHO43cZf7qplSHdTpiRnOl+F78OAfdvuCzQFRDgd8AdXOn+QVxmQDBDiVpEELzbC6El
         ciGrCH7drqPkInNMgem9XmmAPQ0xgmCXd5F6/s8L3ShnWocjSR2iV6qmroV63TrprnOS
         fIUg==
X-Gm-Message-State: AFqh2kpt4ohrI/0gXpWKsZz84xbQcphW5Gye5tq8jDh1LdSS3tgb131K
        UWYpaAxwO+GqD4PZlt3BYhvcGGtV0FizauY3xZru6u2/
X-Google-Smtp-Source: AMrXdXu2PeR9CkCHeWIm1RDjetkASJNw2ICb/jWUwFjh6NOgxMaZ4M21GCfxInpedjw85DrWP+4hASNTeNQ7sdlORmc=
X-Received: by 2002:a2e:9c4a:0:b0:28b:78e6:b187 with SMTP id
 t10-20020a2e9c4a000000b0028b78e6b187mr493773ljj.392.1674005171277; Tue, 17
 Jan 2023 17:26:11 -0800 (PST)
MIME-Version: 1.0
References: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com> <20230117161731.ab69c2352a62a0693570cf70@linux-foundation.org>
In-Reply-To: <20230117161731.ab69c2352a62a0693570cf70@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 18 Jan 2023 09:25:48 +0800
Message-ID: <CAGWkznHKJF1hiVTS2gAxgywnGz4T9u8UQtDV_Oj7r3cWqM5=nA@mail.gmail.com>
Subject: Re: [PATCHv2] mm: use stack_depot_early_init for kmemleak
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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

On Wed, Jan 18, 2023 at 8:17 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 17 Jan 2023 16:11:52 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
>
> > Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> > Solve this by having stackdepot use stack_depot_early_init. Extra Kconfig also
> > done by moving kmemleak stuff to mm/Kconfig.debug.
>
> I don't understand - what was the reason for the Kconfig change?
The items related to kmemleak are moved from lib/Kconfig.debug to
mm/Kconfig.debug
