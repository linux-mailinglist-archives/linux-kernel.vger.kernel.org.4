Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505CA6CFFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjC3Jch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjC3Jca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:32:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24AD7687
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:32:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er13so32972701edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680168726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dhY9/3aNsTwYD8JARE0vudUjZ+1QcHbCGg2fnRM4sRI=;
        b=vc4nJO23T2Q2lm2HKPBkW1KZABzY9+vE8sCq1qfaQlT9LzrfpSEHyhy/fblPbrusvi
         5ljMIY9ieK6OqfgZk9k31oF8z11eSj3mLin6FflkRZPD91D7euhQdWvbhBF2kNU9paEm
         EEUw9SRQy1MrHtrfb12j5CE1ElgR/ONERAchYFL1H/hMTAyYkOodcbvjut+H0Gt1yVTG
         ++/e2sNL9VSlMmfrCRFE5e3GT+zR1Dv20Kq5ZwQZ/sTOOR9IsqnFOD8Z2F9n2VBuwrsZ
         1m31fck8eJr9WqAg9xYNfCyv+/rXVkQZsaGeEeFh+VjMriQKGe31laXefWKbC5BA+oOn
         vvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680168726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhY9/3aNsTwYD8JARE0vudUjZ+1QcHbCGg2fnRM4sRI=;
        b=iTJVWZBfQIxBQlajB9IsckEUd3BbVkeurMGfatosqhuG60sBUqT/e2cb788R0j+yAy
         iAFX8U4PMK6+W3TfJxFKdCmu84Pw1B+/Tu7w9JRwugG8XdfFqzDNB0YMBPefuvy9bJuA
         15uG9n/La/kLEz0zfsmLqLiAFxU00MDgiQ2UBJTEMaij+RoAwxL6PD+zrEjmZO7Izhpt
         FXaFeb6xrnDoqHhmN2MbQjpbpIKuK39rZxjob7TEYgzihSzKmKyOnL5xA2N3Sq8n0xNo
         VlGXb91EwfPCqaJI/QmB4BEL+RK5feFSieziHCkxD6WiGPt/0kRxMcmF5e9tYsG+qEOZ
         Hh2g==
X-Gm-Message-State: AAQBX9csm7P2ra8ATmutiy56QqRi/X4PIJjvmgJirhW1ff7mFpe4rorA
        B5DTaL20c8btVbolumELaFBfRg==
X-Google-Smtp-Source: AKy350alAnOUxE/5fQm9gWe+KOGNktqREfVXP71vAIxmMmmyVwTNOpQG2cmV3p42xTFkgZJDZEhUKg==
X-Received: by 2002:a17:907:25cb:b0:946:f79b:e785 with SMTP id ae11-20020a17090725cb00b00946f79be785mr6532593ejc.2.1680168726200;
        Thu, 30 Mar 2023 02:32:06 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id lt11-20020a170906fa8b00b008e54ac90de1sm17437256ejb.74.2023.03.30.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 02:32:06 -0700 (PDT)
Date:   Thu, 30 Mar 2023 05:32:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: mark folio as workingset in lru_deactivate_fn
Message-ID: <ZCVXFLA+sarzGG18@cmpxchg.org>
References: <1680086855-7989-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZCRRaHHKVt7fpvmD@cmpxchg.org>
 <CAGWkznFRHbYv2ev3FU10zapka_6MDQ+g_-b0jufzqcAEAKUqFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznFRHbYv2ev3FU10zapka_6MDQ+g_-b0jufzqcAEAKUqFA@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:38:48AM +0800, Zhaoyang Huang wrote:
> On Wed, Mar 29, 2023 at 10:55 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Mar 29, 2023 at 06:47:35PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > folio will skip of being set as workingset in lru_deactivate_fn.
> >
> > Can you please elaborate why that's undesirable? What's the problem
> > you're fixing?
> If I am correct, folio will skip being set as workingset when moving
> from active lru to inactive lru, which is performed on every folio in
> shrink_active_list during normal reclaim.

shrink_active_list directly calls folio_set_workingset(). The function
you're editing is used for things like MADV_COLD and truncate().

It sounds like there is just a misunderstanding of the code, not an
actual problem.
