Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C5A5F118B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiI3SXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiI3SXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:23:08 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730311F7F1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:23:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id d64so5547055oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=C5CghR29yj45o3eN9hrrm+lM05BpwaaPuSm3KGiUITo=;
        b=fNU4rSQA2vj6V+gJ/dhWhpyTFmcqHILkTTPnXbBshD9eiu3fV0kEVolVwME5iDw8dr
         PDjPipHf8DsBR/Zbi57Gm7JoZAeafdKDhpuEUyVzxl85r/2r+NY1I+iCezRX6vBZxeak
         yKqPwc8dK9gkr6SS3CtgGePvGfV2tfkiy7HZkNiFZL1oIiPLJovIdN8SvP8c0alqHrCv
         SF3kRgVTeXn27y5z11JnftlQErVba8+Dh1Aj2f8nihCfaD8iddMme6XMwj43mWJscfa8
         5pUxUb+XpjU3USgQvDGztXVks2Tv8gINCyHRyUWFcazS+DmDO96TKcCL7NVXKObDh0ET
         HbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C5CghR29yj45o3eN9hrrm+lM05BpwaaPuSm3KGiUITo=;
        b=5941Brs4meFQEJcPvhh7mGZdkEIVAHgPikX+JWrPngdCGAySVAi84y1OZ9qWgpWDSf
         resWG7TVtJXGOn3UbenrQcirUmScQ/LnGsFlj3tn1HKmmh10H2fb2DrwwDQchdAJJIgL
         GqUmfVTKBYAm1J8RmNBzlqvZCOe/hn5Wi8XBnZ64HFaE7CcEgXYL0+2H7P3rA4bIo42e
         bCFi80ZYcZdDIHfnx/FfodSKs0RYA1txr291tLq1uyUwqkGFF/DHsYmPfTUoe/9H6JTe
         G4Chdo9nuzIvIV00hCF6cOi/S8bHAoi/jkP57umEnjkzyA0xKrUhrK5Yw8v8x3aVxkpR
         1A0Q==
X-Gm-Message-State: ACrzQf2b305hVbzNrwrLCSJgtQ905NcxwY5A7zmaMWt+YvueiOUEokXw
        EiTIr5ubgzQpgXADYhOBTwi/FFwdznsr5nuxrCEF67hmNw==
X-Google-Smtp-Source: AMsMyM5IepoYWFnSCH4BjrDLynXvGCto0GdO0Q4mqJt53q4dk6TJuFaPuzZ6jxIe2SxOqHZtzxg71FpVPLbADzteVf0=
X-Received: by 2002:aca:1c13:0:b0:350:ce21:a022 with SMTP id
 c19-20020aca1c13000000b00350ce21a022mr4493024oic.172.1664562184553; Fri, 30
 Sep 2022 11:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
 <20220927225944.2254360-2-ankur.a.arora@oracle.com> <8171459.NyiUUSuA9g@x2>
In-Reply-To: <8171459.NyiUUSuA9g@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Sep 2022 14:22:53 -0400
Message-ID: <CAHC9VhR2AL9o6SKXW9xNJo5PW6T0CdTxbh8sy5OgE0ifY29RAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] audit: cache ctx->major in audit_filter_syscall()
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        konrad.wilk@oracle.com, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 1:45 PM Steve Grubb <sgrubb@redhat.com> wrote:
> Hello,
>
> Thanks for the detailed notes on this investigation. It really is  a lot of
> good information backing this up. However, there will come a day when someone
> sees this "major = ctx->major" and they will send a patch to "fix" this
> unnecessary assignment. If you are sending a V2 of this set, I would suggest
> adding some comment in the code that this is for a performance improvement
> and to see the commit message for additional info.

Please do not send a v2 with the changes Steve is suggesting, I think
this patch is fine as-is.

-- 
paul-moore.com
