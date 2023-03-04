Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD5C6AA7CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCDDXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDDXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:23:18 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C07DBF6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:23:17 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h19so5119884qtk.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677900196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KveNw6GiBJGhER0kmH1MC4Rj4WX1pTJHwoEhumUI5pE=;
        b=CiJDND9K7VRj/4+yGBzU08OB+NxZL0eF6wzIoW393ngi7NeX2NfBtbGiTkdmvO7aUr
         gTbisCenRysJ7ra0SOmltZwK/Ah1cter4814u6UPONp4Ph2j0BnEThrPr7/hta5oOW0g
         ABfKjBBlD27VxoqKYxx/zh/xa9i+ZNDlEpMFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677900196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KveNw6GiBJGhER0kmH1MC4Rj4WX1pTJHwoEhumUI5pE=;
        b=zirJpF0WxauZrqBc1oXMV61210pC3Qp6oXMFACaRLEkNwAKBqTe51NfedWrksgCjzt
         YI5nklNO+ssSUpvSrq1wtmUVfp1fq+7k60iueCMkDAFXH2Yc6fJ8R5uefTnXXh4c0niC
         1E6kR0AqPxP9TBpJPeEkRcsZkMc/qyPpcYriO1aXt3q8w9vSzjhqEO9bjJeNl9S+WnES
         0wAP2Smhlf9weGl69wzcA+7+gFdQBOb9JGIILIruL4jiQz1Le46r1Sjju2tPudaVJ/ww
         h1PGBKSX6NJhpSzHz8yaduBtSDACH/9ruL/RQnwzyyOrY6s4VxuqnJ0ZwyP77AmlqRri
         T8VA==
X-Gm-Message-State: AO0yUKV0JTZ/r01/wZBdPlUmvyKPD6ddL00RiBkRKGM0da9RyVIocHX1
        UhszlQKLlwOCiIDKmp6FtHpiAg==
X-Google-Smtp-Source: AK7set/zSM95DT7RmEh/FxXrwbMFuxCkXfG+mDWAVPtbLz10ympvDCWH3ZSRmF+KuHegF8m8fHZjzA==
X-Received: by 2002:ac8:5894:0:b0:3bf:ba7c:29ca with SMTP id t20-20020ac85894000000b003bfba7c29camr6647634qta.32.1677900196069;
        Fri, 03 Mar 2023 19:23:16 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id o8-20020ac80248000000b003c00573aaffsm3035088qtg.3.2023.03.03.19.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:23:15 -0800 (PST)
Date:   Sat, 4 Mar 2023 03:23:15 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230304032315.GC2176990@google.com>
References: <20230302152103.2618f1b7@gandalf.local.home>
 <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home>
 <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home>
 <20230303181134.GA1837196@google.com>
 <20230303133702.4d336ee9@gandalf.local.home>
 <CAEXW_YQN=zPtbd6Nr=F-0GqkHQu+ox3eBnzP30=8MxYGYyFv0Q@mail.gmail.com>
 <20230303143822.027ce50b@gandalf.local.home>
 <20230304030130.GA2176990@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304030130.GA2176990@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 03:01:30AM +0000, Joel Fernandes wrote:
[...]
> > > > > Either way, I think a comment should go on top of the "if (top_waiter !=
> > > > > waiter)" check IMO.  
> > > >
> > > > What type of comment?  
> > > 
> > > Comment explaining why "if (top_waiter != waiter)" is essential :-).
> > 
> 
> Maybe "/* Only the top waiter needs to spin. If we are no longer the
> top-waiter, no point in spinning, as we do not get the lock next anyway. */"
> 
> ?

And it could be added to that comment that, we want to continue spinning as
long as the top-waiter is still on the CPU (even if we are no longer the
top-waiter).

thanks,

 - Joel

