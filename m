Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B9612729
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ3DdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3DdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:33:15 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5813F474E7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 20:33:15 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so10491375fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 20:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5W6Aq97QKISOPaUB5ypUeFGZvkyGXNzaEgSpyCgtUE=;
        b=UgmNvnkXjMgZvOxTL2n6HVIuju6+BiL/bD5jrjEOM/pycbRL94WTrVF9zIBoXB8hOw
         OiAixyfCPzbAo7jE+0MUf7/AHv7arkssIE3qjRfO+c5pMat06mkvfTlNHpWlYAYmTsBA
         pxhX8OL6YXxaaxGX/VMyYnPmG5JO00G+p6uMSzSIP0Mzj8L64iDPTw4MMDCOIIuxEQwz
         vFd1RtrETyXxeRKO/N2nUfGJoWzh4SqSuRJj83zbeaLViBbKaj6JuwEp6ivrgxOTwJ5f
         uIhmV1edeT+IIvnl5KMtO1M1ETUudcQudbaHCy8g0cANuO5p3Fg0wdMtN9bhHGfDwCyF
         tZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5W6Aq97QKISOPaUB5ypUeFGZvkyGXNzaEgSpyCgtUE=;
        b=LlzqdH6wPMQh33cQp+MRXYPZ6OBC0g6BiK+HCGNacRzRkOvnhYsWXop8mMHBxT0IIz
         2e/QfPVSn2HzALKg+/p1A9Zof7+nJGcI3YlshLuHC12jlSMKFhTzDfdMsEFTXUOE6Gc5
         aQnOECyf0yQQJACENpkcxTn0XaBPHTb6J5+oDUW/P2oqj6p8jugEhgeOAieDqjOW27H6
         l24tJzGnHFP9NTiGGyuRd9VOxAG3DVvEirPNmQTcbnUwYKs6mCWwvx2OGYo6jkW7Ze7l
         WnRG9wBRJs6fLU4b3kbUebDqqf3YAxLtCJMKT7Ma76ztkW0SmT2ktq5/zyHrcTlaAvJS
         tjBw==
X-Gm-Message-State: ACrzQf12ddxhn9mftDnoWSunO/F/TkTaSyplEXHAAb0Jj6ggbqm3uLbQ
        hg7aCPGoopM029VhOYz0rIPW0Q==
X-Google-Smtp-Source: AMsMyM4EaYTbxNzDiR5LlN9DY6Z39+/BX6I/YrlzGGvTdmm/93MRuB0HTZGoXGYldrn20Y+HggGPwg==
X-Received: by 2002:a05:6870:1792:b0:12d:c403:80cf with SMTP id r18-20020a056870179200b0012dc40380cfmr13320880oae.68.1667100794562;
        Sat, 29 Oct 2022 20:33:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bv7-20020a0568300d8700b00661a3f4113bsm1286144otb.64.2022.10.29.20.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 20:33:14 -0700 (PDT)
Date:   Sat, 29 Oct 2022 20:33:01 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: Re: [PATCH 6.0 19/20] mm/huge_memory: do not clobber swp_entry_t
 during THP split
In-Reply-To: <Y1gHmy6g0SMFXH5k@kroah.com>
Message-ID: <11bd36e-eff1-ca79-fa48-f32ba815523@google.com>
References: <20221024112934.415391158@linuxfoundation.org> <20221024112935.173960536@linuxfoundation.org> <f6d7b68a-a5ae-2f85-49b7-f4666eb3a8c9@google.com> <Y1gHmy6g0SMFXH5k@kroah.com>
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

On Tue, 25 Oct 2022, Greg Kroah-Hartman wrote:
> On Tue, Oct 25, 2022 at 08:11:44AM -0700, Hugh Dickins wrote:
> > On Mon, 24 Oct 2022, Greg Kroah-Hartman wrote:
> > > From: Mel Gorman <mgorman@techsingularity.net>
> > > 
> > > commit 71e2d666ef85d51834d658830f823560c402b8b6 upstream.
> > >...
> > 
> > Greg, this patch from Mel is important,
> > but introduces a warning which is giving Tvrtko trouble - see linux-mm
> > https://lore.kernel.org/linux-mm/1596edbb-02ad-6bdf-51b8-15c2d2e08b76@linux.intel.com/
> > 
> > We already have the fix for the warning, it's making its way through the
> > system, and is marked for stable, but it has not reached Linus's tree yet.
> > 
> > Please drop this 19/20 from 6.0.4, then I'll reply to this to let you know
> > when the fix does reach Linus's tree - hopefully the two can go together
> > in the next 6.0-stable.
> > 
> > I apologize for not writing yesterday: gmail had gathered together
> > different threads with the same subject, I thought you and stable
> > were Cc'ed on the linux-mm mail and you would immediately drop it
> > yourself, but in fact you were not on that thread at all.
> 
> No worries, now dropped, thanks.

Thanks Greg.  Linus's tree now contains my fix
5aae9265ee1a ("mm: prep_compound_tail() clear page->private")
to Mel's fix
71e2d666ef85 ("mm/huge_memory: do not clobber swp_entry_t during THP split")
so they can now go on together into 6.0 stable.

They would also have been good in 5.19 stable: but too late now, it's EOL.

Hugh
