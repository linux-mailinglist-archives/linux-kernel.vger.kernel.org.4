Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A37127D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbjEZN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:56:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB5187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:56:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75ca95c4272so54479185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685109379; x=1687701379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zQIVOVK9K5N12JOPQK9cZ6VstYGEEtnt+WZ4R5PlTpk=;
        b=AXdjZQ9LEZqRgWdysoO62Dv5Jouqvf2vQsmRkfBYLT4J1bdSWX+8uVS4JaRrPln5qr
         x4G/28k4M5BGIb6rU/g6iuPw2IGQhrWzhmvlHEAKp7Uxr2CYhKgciFUsocMolg31ytds
         3PN7K+AkSXfwsgAf7pcYpF3P92HODPZUA7mmGWtJp+4rwtTWesg5520gijlCgB6HejqS
         M5tF6bMCq3as2bspt6d+ICGvjVPh/A7xJg/ctY+iDnDJp9h470ygDE57z9uN1eRBy9fu
         KEyfjdSse4QogIu4/Eu8F3YPnt666wSVuiSImzJsRdP0SlWTkmuObzB9l0BGJfNbBadN
         bLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685109379; x=1687701379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQIVOVK9K5N12JOPQK9cZ6VstYGEEtnt+WZ4R5PlTpk=;
        b=bMSw/1pHliHrDCNH8qlgJmtvLub2vXxzWIYkKppzM5CeiYevpmfcVpW92zB0kprMdw
         FQWvicEXc1gKVfH6pjJ237jM7phCX2/B+XA2FUtNOjJXo/4oqPN6ri8gQj4twvLg4XWY
         Iwy243u/yhGg0ogtE+IiHBDUbBUrbHbfhZDYs+vZXkb/zNgw2OVI/MMXBlHXyc7KrTC6
         znsiLFTOolq8oLI45vqr5uokNkS4J2DD/HsyaeU+5d0UdSgNF914LLvmz/If4m4/jawa
         M5ONV/z9oXtrxVFY25Hy1n4EEVF3v+jZWevplu9ULAC90gGBQSC5Kl1AnX5rV2bknCSP
         D0ng==
X-Gm-Message-State: AC+VfDzpgQINA7NQbG8Bf0JHKWEr3r3m02TTUUqDGQSfJABm2AqhsPcD
        qrx371ZNyxM4NnTGKY/AwRDAOw==
X-Google-Smtp-Source: ACHHUZ4gdQh29zUVAFMruhmhHTn/Sm+mhUUpS+je9800rAkdD1NefGJWUClptbI7O9M3D3wUwyLauA==
X-Received: by 2002:a05:6214:5184:b0:5ef:8c79:fe88 with SMTP id kl4-20020a056214518400b005ef8c79fe88mr1960398qvb.2.1685109378926;
        Fri, 26 May 2023 06:56:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id s13-20020ad4438d000000b005f2dba7a5b0sm1216977qvr.132.2023.05.26.06.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 06:56:18 -0700 (PDT)
Date:   Fri, 26 May 2023 09:56:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, yosryahmed@google.com,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: zswap: shrink until can accept
Message-ID: <20230526135617.GA44890@cmpxchg.org>
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <CAM4kBBLA_DfAENfRD3QwfTOfvcDuyrkCwKHiuiZFVkt0c4ZR2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM4kBBLA_DfAENfRD3QwfTOfvcDuyrkCwKHiuiZFVkt0c4ZR2Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:18:21PM +0200, Vitaly Wool wrote:
> On Wed, May 24, 2023 at 8:50 AM Domenico Cerasuolo
> > @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
> >  {
> >         struct zswap_pool *pool = container_of(w, typeof(*pool),
> >                                                 shrink_work);
> > +       int ret;
> >
> > -       if (zpool_shrink(pool->zpool, 1, NULL))
> > -               zswap_reject_reclaim_fail++;
> > +       do {
> > +               ret = zpool_shrink(pool->zpool, 1, NULL);
> > +               if (ret)
> > +                       zswap_reject_reclaim_fail++;
> > +       } while (!zswap_can_accept() && ret != -EINVAL);
> >         zswap_pool_put(pool);
> >  }
> 
> while I do agree with your points, I have a concern about this
> shrinker logic change. The reason for not doing this as you do was
> possible real time/responsiveness characteristics degrade. Have you
> checked that it's not really the case?

Good point. Adding a cond_resched() to the loop would be a good idea.
