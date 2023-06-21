Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6020738D02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjFURZC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFURY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:24:59 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579C132
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:24:58 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bcd0226607bso10678856276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368297; x=1689960297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYmz1Ufw9l3M6d5FJ34PcwBBcsm9zxpv99cVs9LsnS4=;
        b=gU8n9IrgajTsnuiLq3L5kB7Oj1zfUfluiiHbk1kacOuWIVK7PffMTkMYhwxI/fyu+p
         dG7A8lFApGi1yxSTLIAwwcs0TKaYPRJMXs0/rzwnI414BUrmPFB4JXnFMHLVsMK6kus0
         srY3+OPgE/Tautxi5Iu1d8kn2YcNeVZJox3oK+YL1GTWtmvn/Zu+tlFTn1efBtbDbvSc
         ZiKVImUvKO4Zl/6ixAlgyY+nUACvvabkRl6wok3/XROixZg2DZ4hewDTdJ6Rd5XxL3tg
         Lgkffrl6el+K0+PAmLxfzjAFD5p76qiRPxTb1iaqIEyL9jVzmZdbNaBMvOsv6K9by4Tz
         ERWQ==
X-Gm-Message-State: AC+VfDwBoY5xr2aYtp5V2f/4xdxDe7bEWS+YpqjZWD8Gqsyd8tAABJmF
        KtEVi5XIx74XOBtgpOg8hp7vUDvhgWhUcfHIMok=
X-Google-Smtp-Source: ACHHUZ4rILDf2nTuWn8MMVutYJGIQg0WQmwRzwLadXCpY9ygMrlThlax1ikjZleHXwzc3sv+sFrf46GHYYnBFQa4Gpc=
X-Received: by 2002:a5b:88e:0:b0:bd5:dc2d:9d84 with SMTP id
 e14-20020a5b088e000000b00bd5dc2d9d84mr14893207ybq.16.1687368297292; Wed, 21
 Jun 2023 10:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230614150118.115208-1-cymi20@fudan.edu.cn> <CAP-5=fWQq9MM-NXL75_a_JoTVEwvS1oy8oKRefsLxU1kyjWKZg@mail.gmail.com>
In-Reply-To: <CAP-5=fWQq9MM-NXL75_a_JoTVEwvS1oy8oKRefsLxU1kyjWKZg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:24:46 -0700
Message-ID: <CAM9d7chh0vhpGqYRhaxeiQmbk9tr75wkVZfjEbfZrgwbYNHtng@mail.gmail.com>
Subject: Re: [PATCH] perf subcmd: Fix missing check for return value of
 malloc() in add_cmdname()
To:     Ian Rogers <irogers@google.com>
Cc:     Chenyuan Mi <cymi20@fudan.edu.cn>, acme@redhat.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 9:21 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jun 14, 2023 at 8:01 AM Chenyuan Mi <cymi20@fudan.edu.cn> wrote:
> >
> > The malloc() function may return NULL when it fails,
> > which may cause null pointer deference in add_cmdname(),
> > add Null check for return value of malloc().
> >
> > Found by our static analysis tool.
> >
> > Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
>
> Acked-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
