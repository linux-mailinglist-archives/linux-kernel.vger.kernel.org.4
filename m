Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088B640E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiLBT1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiLBT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:27:42 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02505FF4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:27:36 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n186so6298323oih.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5q/tBqThw6AWXMId6SgoPvHoUcO6QLAKm07NqFxrw4=;
        b=LusdGO7Dj6AFev/zQVdoYTVgvaq54hkRLO51uIgSoqDJjooqG+MN3cSuNWYVnq0GHU
         PZeCfp54NhYYuVEoIbA+WbBKClLAwsjunbMiVWdaafW6zhhIVD12UY2h2bmlGJN1+TcX
         Rb4XypGLCH7Hgv2xqqxX4i+VwzP4V/EGaPIZNSIzQdMl+4JboSsEf09zmGUBMnWfgE4j
         d2Bp2r39lJyyd0TfshIzdCQO4gLoW2zfBcUo0fV8cE94nkksytnhL1BP0AvHrRkx9sEQ
         CxAVYsLYl8DGSRWfdAksZuLl744FXHcG1Vla9a5hi4Rx57jNtcmWWJLqXRB6NwmrSGhi
         TgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5q/tBqThw6AWXMId6SgoPvHoUcO6QLAKm07NqFxrw4=;
        b=GwOWsnedO3/1eajqhwqtZARGim8kY1dLIetBl0TXVtiSFuKLkQWLJhdhRt9gXEdy4j
         ktf+QsTcVpfkMUWIXepUVm+SOrqCK6SaJwmqiRRISSTRm2TXVz6lxDEArUkIrYWuuEpG
         F5wI9HY/yiPrC2IWD33QXSLNin/nEzlV1h58iywA6hVU6Jc6WS+9+7UhKcgROodi8AgG
         Uu/IvLUlOvN+Ip8ZLp7CTKvXb0HCtcBaEi7iIDdHYPS83e+k6J4UubUMwzf09VWw1hzt
         /1/+37k6x9N8uIrG8tl4J4tebMF+cFT4gXByQdCD5f26X24+r79nWmX7Gnq7V2B2KArO
         PMIw==
X-Gm-Message-State: ANoB5plnl19kVF2Yc2JNZRNBG+zBkKNdqBrWxXOH6t4CZ/L6Y4pjUcUV
        og/6kHo7gW1tJaA+EjvbX8m/fg==
X-Google-Smtp-Source: AA0mqf454Y64RgTQtrlT9AisqrhV8xuHRcPC25aF40kRqRCWBATiZF1tIq7bTIsAYkJuee/3umxQJA==
X-Received: by 2002:a05:6808:3ce:b0:35b:d2b1:d678 with SMTP id o14-20020a05680803ce00b0035bd2b1d678mr6928038oie.207.1670009256037;
        Fri, 02 Dec 2022 11:27:36 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g14-20020a544f8e000000b0035437f4deefsm3423362oiy.26.2022.12.02.11.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:27:33 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:27:23 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Rientjes <rientjes@google.com>
cc:     Matthew Wilcox <willy@infradead.org>, ye.xingchen@zte.com.cn,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: add TRANSPARENT_HUGEPAGE_NEVER for THP
In-Reply-To: <4a78abbc-4c07-2208-1072-af6d342c3f1a@google.com>
Message-ID: <16b44431-5f9d-bfe4-049-4fd6a66e989a@google.com>
References: <202211301651462590168@zte.com.cn> <Y4kN9UAte0OQ6sGi@casper.infradead.org> <4a78abbc-4c07-2208-1072-af6d342c3f1a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 2 Dec 2022, David Rientjes wrote:
> On Thu, 1 Dec 2022, Matthew Wilcox wrote:
> > On Wed, Nov 30, 2022 at 04:51:46PM +0800, ye.xingchen@zte.com.cn wrote:
> > > From: ye xingchen <ye.xingchen@zte.com.cn>
> > > 
> > > Sometimes we may need the /sys/kernel/mm/transparent_hugepage/enabled to
> > > default as [never] at the first time.
> > 
> > What is going wrong with THP enabled that you need to disable it?
> > 
> 
> That would be useful to know in addition to why this needs to be part of 
> .config and not simply using the kernel command line option.

There is also the puzzle of what new feature gets added by

#ifdef CONFIG_TRANSPARENT_HUGEPAGE_NEVER
#endif

Hugh
