Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C166865CB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjBAMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjBAMOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:14:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1810644BCF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:14:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n13so2750098plf.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFm4n20HaG+M2r4/z0Z+NDvnKF/afrZYAOuYUBEesTs=;
        b=ZtfQriYVIiCND13bDdze9B/lckCdrLcJHfpEOJ5R2AGE++s96/rZ4VAejAHv9SbR34
         4kvOpHbjguXz4ZPm8azKNHnw6XgyiPvjplyubqjv1JLQ55BDDowtXAzAB1w+Jsox1QJc
         ick0Dx0Dn3SIOGhUVvf0XMrvpGsiPHWhgzDjJuzO7HiBqRvW5NM0oFTy7K80GrVTPyFO
         iXajuTPU+XkJHqYF7bIIrgsF/2u/fMJFL2/Eo4UJZUC9bMLEd+QS2VfYWjthA7MmX4c8
         2LFOpWORNdQ+ZK3TVTcx8mLks+T58NvxAVHvSINrn5PE6qoArbbty56HxYArhXA6t2Wu
         j9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFm4n20HaG+M2r4/z0Z+NDvnKF/afrZYAOuYUBEesTs=;
        b=ixgDCaqaKfgQHjJEqjCfq8RnZR7BMaOIqRB4YafxxSWMuBzoURr0LPl/oX9uthCS+P
         VjN4ERJe7tThahi5RvfqcP41QnSc68TM1kUt7l53UDyECjt/YbcvQKD1XKY0mIU3MgFK
         tBrtTzl5bEOkk74koWC+kg/2prpnLap0IkY/sWU+m8gDpv89hMk9Ys0ytMkzIlrz8Jsh
         fIV4pqrhuwJ5AXNSmbWjkDUWoLFmUpMYYsGs0SQFmWAeJP4U26n2QT/wJSXB4sOGqCXf
         v6tx8Wz0s0PhpoFY6jGYUAxMBoRM0sshzAO/yxQq+bjI/ZSo+uiA15Rhxn/JNNVjo3VS
         Y3mg==
X-Gm-Message-State: AO0yUKVUfl6tNrU9SR0TBe5LnJVCi4Sh/CVXI6mh9XFS68iq5Vkvy5P2
        Lm6ahs4n6wK/ZfRfjlJ+mUSSWfSlxqM=
X-Google-Smtp-Source: AK7set/Dmi2zrgKngnBcD/Aod8cX8AEsuj+8QkxuPLBdTtQh8o/qbYNM9AtBw9VXgppUxxiPs+CYBA==
X-Received: by 2002:a05:6a20:b909:b0:bc:900:cbe9 with SMTP id fe9-20020a056a20b90900b000bc0900cbe9mr1973283pzb.7.1675253692558;
        Wed, 01 Feb 2023 04:14:52 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b00194bf8cef44sm11530789plb.117.2023.02.01.04.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:14:51 -0800 (PST)
Date:   Wed, 1 Feb 2023 21:14:46 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v4 1/3] mmflags.h: use less error prone
 method to define pageflag_names
Message-ID: <Y9pXttJavmaFbiW7@hyeyoo>
References: <20230130042514.2418-1-42.hyeyoo@gmail.com>
 <20230130042514.2418-2-42.hyeyoo@gmail.com>
 <Y9e5qD2whT3+xDMD@smile.fi.intel.com>
 <Y9jTahuqsqID87aU@hyeyoo>
 <20230131130940.94a7d42220857b4c75761b01@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131130940.94a7d42220857b4c75761b01@linux-foundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:09:40PM -0800, Andrew Morton wrote:
> On Tue, 31 Jan 2023 17:38:02 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> 
> > On Mon, Jan 30, 2023 at 02:35:52PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 30, 2023 at 01:25:12PM +0900, Hyeonggon Yoo wrote:
> > > > As suggested by Andy Shevchenko, use helper macro to decrease chances
> > > > of typo when defining pageflag_names.
> > > 
> > > Suggested-by: ? :-)
> > 
> > oh, yeah I only wrote in changelog forgot to add the tag.
> > I think Andrew will kindly add that when picking this series up?
> 
> Sure.

Thanks ;)

> We're at -rc6 so I'm slowing down on the features and cleanups.  I'll
> probably park this series for the next -rc cycle.

No problem!
