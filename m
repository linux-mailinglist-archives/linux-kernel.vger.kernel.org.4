Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646405FC88F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJLPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJLPkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:40:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D3CD5DE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:40:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3321c2a8d4cso159267487b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivMZDopBydPz/wE+y//4HcN78R6tls33wt70oMeZZfY=;
        b=I0klZrTKxVSMv4twVpPFUgddLbVcA4lpsbbESqRG8zjXN8l9SRrK1XSkQhNmVwrAv4
         fD+LKjbjNFZJgM+1cgbLQCexiXptvB/H79dwd/KsORIFbVEMy/3yNc7B8YMZKXA1kcGQ
         A4KHjZ7Th7x9EVCveIq0qhNZSZSbj3wfrxAeL1rXyZXJEOEmRfkv7WPqjaXtX0DN6gYo
         XNDLwf7P9BJJPBjWWHstjzcfHsURbWMfzxQG1A6O1NmDmrsqWkQjtojYKrOklii0ysd5
         deOd/XT1kRWj+Telvutbv+U6MWUp59KD+12Qm/s3aJLcYPoq/RNvj9FWYTlYmQqBrNtv
         n3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivMZDopBydPz/wE+y//4HcN78R6tls33wt70oMeZZfY=;
        b=0jsmre/k6KyFkc7pBIu4cDKFKziayl9rjspt6EFbqLlOdbG+JrXezD25Xa0jCWBp3K
         NgJMW/VZOyMJWii1dZv6CP4BBIvLSgTBcKBAdxrlU5XXy4akbhbC07FWxsgJuKJcfoSr
         coLqpGzskrzI1mRUyFVImAyp1CymF91qKwQemyli5jqk0tq5xeAQniz63qgUDS5KtwMP
         noXbGeIHN2ldEPOcTWxjOapFc0ncXPsXTdx5FI2JWfsHkvhtiVpDOo9wYmKeAfFmYrxE
         kzQLMuuIMRxbcEFqA6ZVHcPoveo7hBqOHLo+H4PCYTWaXS9ZgfSXAf3GLgtr/GSNNMT3
         BRFA==
X-Gm-Message-State: ACrzQf2d4fccsTmLtrmPLMXFIjKdahRvvh2PLIAHJeIwXakuC7SPkFXF
        8h1rVPsrn2R3ZbLupp/5btlb7wCz1vK6a6rBfrLHqg==
X-Google-Smtp-Source: AMsMyM6M4G8fMIeFkk1YSGBq294rxa2P74/9tGWBLFApkQ+EPdaSBq9DI8yQ1Dp0OwvgH1s+z2BjTGNoThcrLxrKuPg=
X-Received: by 2002:a81:cd1:0:b0:356:e01d:269f with SMTP id
 200-20020a810cd1000000b00356e01d269fmr27341436ywm.263.1665589228895; Wed, 12
 Oct 2022 08:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpG=bADguJWdxV4ZhTze9fmKP2bhsbf0xzbd06Fhr4_U5w@mail.gmail.com>
 <20221012062034.486-1-hdanton@sina.com>
In-Reply-To: <20221012062034.486-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Oct 2022 08:40:17 -0700
Message-ID: <CAJuCfpFsx6C1tRnAXVPz3Nn=odqDuQwgrEr5qVWWYh7t6Tpukw@mail.gmail.com>
Subject: Re: PSI idle-shutoff
To:     Hillf Danton <hdanton@sina.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, quic_charante@quicinc.com
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

On Tue, Oct 11, 2022 at 11:20 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On 11 Oct 2022 10:11:58 -0700 Suren Baghdasaryan <surenb@google.com>
> >On Tue, Oct 11, 2022 at 4:38 AM Hillf Danton <hdanton@sina.com> wrote:
> >>
> >> Given activities on remote CPUs, can you specify what prevents psi_avgs_work
> >> from being scheduled on remote CPUs if for example the local CPU has been
> >> idle for a second?
> >
> > I'm not a scheduler expert but I can imagine some work that finished
> > running on a big core A and generated some activity since the last
> > time psi_avgs_work executed.  With no other activity the next
> > psi_avgs_work could be scheduled on a small core B to conserve power.
>
> Given core A and B, nothing prevents.
>
> > There might be other cases involving cpuset limitation changes or cpu
> > offlining but I didn't think too hard about these. The bottom line, I
> > don't think we should be designing mechanisms which rely on
> > assumptions about how tasks will be scheduled. Even if these
>
> The tasks here makes me guess that we are on different pages - scheduling
> work has little to do with how tasks are scheduled, and is no more than
> queuing work on the system_wq in the case of psi_avgs_work,

I must have misunderstood your question then. My original concern was
that in the above example your suggested patch would not reschedule
psi_avgs_work to aggregate the activity recorded from core A. Easily
fixable but looks like a simpler approach is possible.

>
> > assumptions are correct today they might change in the future and
> > things will break in unexpected places.
>
> with nothing assumed.
>
