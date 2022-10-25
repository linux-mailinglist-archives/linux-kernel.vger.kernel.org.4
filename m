Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6060D0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiJYPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJYPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:45:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C609F35A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:45:56 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a18so8372394qko.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ImmYV/dFFzxheZ2arZHQD1BqoZetMRNq1pHAiijomwY=;
        b=QMp+lR8vOX3NhFgwAxyqtowXn9bLocQAY2ZpaFpACml6svFG0gX5R1Ha003hs/S4do
         Em71szAdEixSKP5wnkYeYeVwfGmVyDJ4a4bE/IDyjnP0bE72EjJ6IKd4Q1MfybzjyLul
         XwViqrR+iNRrKGYwudJkRinUJrAGB6QkUf+FiC/pmIRc+s76cS9iYuOUZe5hubd0M8p0
         hVPcM3IAvHjhK0/z7UHBumqMSttoLnadJWid6i1ahppAEtONX5mVgcF/BcxHnXdQv9qr
         FlEf6j+2rqlVe9Eeglk8nd4jirtWdU3r+QDM2FqJRcAsh5sQmAcVXtlTbc6ZJ4cax8GE
         6FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImmYV/dFFzxheZ2arZHQD1BqoZetMRNq1pHAiijomwY=;
        b=QW9yRPPU9pQ9rzYSaH8eclFnr7Bqm18VubgpFqLd/M5Z9X/DHoH6iJ5vrT5jqiDB+X
         MmzkZRwBnNy+G3n/PFZarvnpcF1klAWrBo7g0mxvCDSbvTS7FxTwyZYaHJmkRtpiLsdK
         +rbRNALsfFLV19hWXjXp2XFnobrepT7lTh5by3tgYJxFWY2Ck2XXEeNtmj5ZDC7HJxEj
         roOHb0x8xVruWnUqsPeL28Fro6Q+gGM15VwK8zmhlqjpaIp2WOccNFrAHZGQcxznzepZ
         aWuaUKMdIdGxtrsd0K9YIMeorieskOosyJuogKws0v4UnKXDOHB0GdGPNfMCaQtAPhNd
         NpAg==
X-Gm-Message-State: ACrzQf2er18bidgwz3vuBvQliXKa/r72yVwHJEyObEdQtZs18Afi5c2v
        nsHxW0aiXmKnE/sXhxwCl2Q7Jw==
X-Google-Smtp-Source: AMsMyM58K8GnqHVnj7Fw4Zk4RNAp1KoU7WxBkfgj7AwWtI0+LrGc640iZ/Wbo0lvwtsF7dHzsR2WKQ==
X-Received: by 2002:a05:620a:2909:b0:6ee:6c83:9769 with SMTP id m9-20020a05620a290900b006ee6c839769mr28232599qkp.732.1666712755677;
        Tue, 25 Oct 2022 08:45:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bz26-20020a05622a1e9a00b0039c7b9522ecsm1790130qtb.35.2022.10.25.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:45:54 -0700 (PDT)
Date:   Tue, 25 Oct 2022 08:45:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
In-Reply-To: <32fe01dc-dda1-2154-af8e-7e9f64d6f811@suse.cz>
Message-ID: <8773771c-5370-f9f9-8f5c-67385c3cd25f@google.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com> <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com> <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz> <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com> <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <YzkmErHFyYW3awRn@hyeyoo> <YzsVM8eToHUeTP75@casper.infradead.org> <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz> <904cc831-eb16-b1e5-10e5-9e7a171ef83@google.com>
 <32fe01dc-dda1-2154-af8e-7e9f64d6f811@suse.cz>
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

On Tue, 25 Oct 2022, Vlastimil Babka wrote:
> On 10/25/22 06:19, Hugh Dickins wrote:
> > On Mon, 24 Oct 2022, Vlastimil Babka wrote:
> 
> >> 
> >> [1] https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
> > 
> > Ignore me, don't let me distract if you're happy with Matthew's patch
> > (I know little of PageMovable, and I haven't tried to understand it);
> > but it did look to me more like 6.2 material,
> 
> Yes, it is targetted towards 6.2 now.

That's good.

> 
> > and I was surprised that
> > you dropped the simple align(4) approach for 6.1.
> > 
> > Because of Hyeonggon's rcu_leak_callback() observation?  That was a
> > good catch, but turned out to be irrelevant, because it was only for
> > an RCU debugging option, which would never be set up on a struct page
> > (well, maybe it would in a dynamically-allocated-struct-page future).
> 
> It was mainly due to David's observation:
> 
> https://lore.kernel.org/all/c1c8920a56014a179dbb82d483f2ad28@AcuMS.aculab.com/
> 
> I did also conclude that align(4) indeed overrides anything set via
> CONFIG_FUNCTION_ALIGNMENT (and passed by -falign-functions) in a way that a
> globally configured larger alignment can be made smaller by this macro, and
> it was all too risky and last minute to me, while Joel's series wasn't
> targetted to 6.1 anyway so there was no urgency.

Oh, I had thought it was heading for 6.1.  Yes, you have good reason
to drop the alignment trick there - thanks for verifying David's point.
I hadn't seen followup, and assumed that the earlier i915 example gave
assurance that alignment was usable (but maybe that's part of why the
i915 folks stopped doing it that way).

Thanks,
Hugh

> 
> And yeah it looks like a gcc bug to me.
> 
> > Hugh
