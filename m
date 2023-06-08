Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD87284EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjFHQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjFHQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:27:44 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55332119
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:27:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bb1f7c5495dso900600276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241663; x=1688833663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JnZcUsBlmkxhPY5xDmUWB0pgxLHVrwriE0mwCLpEUnU=;
        b=S5fpT/ktB5F7mIMxiEF2EIPUYLN7a7oQPHzpd8td1D67OeqNU5Ffe2VFZKBO4N/Iff
         QXME86UCHnap82iN21I6KKla7+myR8C7Wqq2YpAduHN/ku3k/+Mf8MzyxYjd7pSvVY2b
         WLTmZpa5mGbS4e1hMpJn4lK4KffoebQg6iQHIxJB//XT8oZzIpFa9coLcw13cbm0eQ3b
         1yliqGcYnuKmWWWwQZL7vAYQM5NFhjUL1mtDqlgR8OMr3l6Chfb8n7S5QgzZbTSsONh9
         iJugnID7fhGXSSNMjbrAqLyMI0GWfE0kyUdww888vUJ0taJrQyhMu39Q6UPj7HlmPf9O
         bMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241663; x=1688833663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnZcUsBlmkxhPY5xDmUWB0pgxLHVrwriE0mwCLpEUnU=;
        b=Hh4NyJFeGdISDSWf6V2WboLjBdlHoMeDVJPYlF1wCchqO5FQqoC8MEQRLg4zyJnFJv
         IEn9SgU3jCYLvvWQ9H8IujK6XA8SaMUDenD2n3cgTd2AGP/3f66KTeymiydyy/QYLXvo
         dzKmp1lEbUQKUztIbsA2YvFFWozASG+TvX7UJMN2T1/78CTgnBKfsUQcCRVhzVD5kmu7
         EfcpLWMbV/3fkUH5PpHkiY+o5sbKgDGZjL4K41/z76aBDz31LhZOV9DlwAhoScZGcgqz
         szp7jA8jvlBzAFYrGZEQSREn2N3SPCYpIbTvM0/E+74BNAHn+pLoupYY4rDlA27wezNw
         jUXQ==
X-Gm-Message-State: AC+VfDzh7Q9wMSXQTmQ5ZtulGgvukcIjfw3NxfcvKYzjpatIqDLs/NK6
        GrOtWcFWF6pGSbhzsGugy4I1oJ0fQXMxOW4gx1Y=
X-Google-Smtp-Source: ACHHUZ6Wx4iggMZv88OaIN8lLr188aRiNGIEyyHKMKuHjEXqls0WHImnko+027dyK0y69NvnENMXZAj7gsJ1JVdd1+I=
X-Received: by 2002:a0d:ebca:0:b0:561:8fef:13ce with SMTP id
 u193-20020a0debca000000b005618fef13cemr141253ywe.37.1686241662747; Thu, 08
 Jun 2023 09:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx> <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx> <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
 <ZH86C4A4qpeAz/n4@feng-clx> <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
 <CAP-bSRZa9axG59E3knkVXy4=36irR9E7SXqT-QSikW7BoQueBw@mail.gmail.com> <41b91385-8f04-4498-9eeb-0b3a192b55cb@paulmck-laptop>
In-Reply-To: <41b91385-8f04-4498-9eeb-0b3a192b55cb@paulmck-laptop>
From:   Chris Bainbridge <chris.bainbridge@gmail.com>
Date:   Thu, 8 Jun 2023 17:27:31 +0100
Message-ID: <CAP-bSRYm7_aJH6-YwcY_pq8_igAXQR++YfQrfZJoKaD8mW=fyg@mail.gmail.com>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
To:     paulmck@kernel.org
Cc:     Feng Tang <feng.tang@intel.com>, tglx@linutronix.de,
        sboyd@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 at 17:25, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Very good, thank you!
>
> May I please apply your Tested-by?

Sure

Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
