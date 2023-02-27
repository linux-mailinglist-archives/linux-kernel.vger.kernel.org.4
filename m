Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D16A46C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjB0QLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0QLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:11:47 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014121A02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:11:46 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id cf14so7167931qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8TPkPUsFS7szPVJljLB5yud5sEW4Uac8hRXAQn/Ddo=;
        b=SK3xNZxE2g2niOzJB9fbis3o+Fcc7quy/XqdNUiVPT+WF6cpjR11nIQiW3W6+61b12
         krN9mfxVoITkb79fKWddq0B5uqBc6Ni5pjUIVn9xXhd9uS36ElErskA3TRSJPJEqsGeh
         hW0kZ+dEwDTFNsJO21In+/1ZAB7i7PsjiTKH5CqkHwEsrwZamDHovpBhJqJquHYsMYny
         CZctQL+a1bzULiWoEFKGkNlcnfIq3MLpxbnBorxOqTXd9LGiAt97HeKyyX/+az91tSej
         1v2tApa1TmPjm9AnB1C+jGxSsoFgKbR55eF8zmfgJpax+M8fy2oBrP5WQC6iziCHLmT2
         0kdg==
X-Gm-Message-State: AO0yUKWW/rISOm1NOZ4GYyHadMvYisIl8Zc4vuYvQhYVnrKiuA9UJ3Ta
        a18A/NbVzO7LuguOUFNHhBA=
X-Google-Smtp-Source: AK7set+hYWnLLUFMOlBvKfN71mjbk9buTaayE82mbrCyB548HhCX7Mru7MQ5hFLkYf5u0VynyG56RA==
X-Received: by 2002:a05:622a:1713:b0:3bf:a15e:a898 with SMTP id h19-20020a05622a171300b003bfa15ea898mr39249058qtk.18.1677514305888;
        Mon, 27 Feb 2023 08:11:45 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id q9-20020ac84109000000b003bfa52112f9sm4925813qtl.4.2023.02.27.08.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:11:45 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:11:42 -0600
From:   David Vernet <void@manifault.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
Message-ID: <Y/zWPoCjQ6gLSNGU@maniforge>
References: <20230215233033.889644-1-void@manifault.com>
 <20230216080459.GA5200@redhat.com>
 <Y+54c0YvXcMIFva4@maniforge>
 <20230217102521.GA27682@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217102521.GA27682@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 11:25:21AM +0100, Oleg Nesterov wrote:
> On 02/16, David Vernet wrote:
> >
> > On Thu, Feb 16, 2023 at 09:04:59AM +0100, Oleg Nesterov wrote:
> > >
> > > >    a task that's successfully looked
> > > >    up in e.g. the pid_list with find_task_by_pid_ns(), can always have a
> > > >    'usage' reference acquired on them, as it's guaranteed to be >
> > > >    0 until after the next gp.
> > >
> > > Yes. So it seems you need another key-to-task_struct map with rcu-safe
> > > lookup/get and thus the add() method needs inc_not_zero(task->rcu_users) ?
> >
> > Yes, exactly.
> 
> OK, in this case I agree, inc_not_zero(rcu_users) makes sense and thus we need
> this patch.

Thanks again for taking a look.

> 
> Just I was confused by the previous part of the changelog due to my bad English.

No worries at all -- the commit summary definitely could have been more
clear.

Does anyone else have any thoughts? Is there anything else we need to do
for this patch to land?

Thanks,
David
