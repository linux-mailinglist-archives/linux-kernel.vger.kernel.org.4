Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438806BF3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCQVaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCQVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:15 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255E34F49
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:29:26 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id c19so7134920qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74hpKbybG/zGoZI9G2CYpMbOVE4AuEECFGt5DlMCgIs=;
        b=NNTAFY6l2Tjo5Ag7NMl0OaRV8etQNRA4dTa/UrsgYM10ceeCPXsT9j3uxqU1vFM8lj
         YCwvmhJk67luPjqcRmizzwYSDNNfZrYl4ufgucywBR201Q4WRc7sEqp8l/N/kXwXQLU7
         bkrC6iyLTDL7O4u0czFhNzFoTLz3D66dujRexL5iK/gGwMSfjYSbqPJdWoIjeWeQr+Bg
         NPe6+2wauDxMrJtIWFlHerDAsju2WfUGVwOIQECxknZ9o0lG/JoD4+nSA/byo7Z9irHn
         B2MlL/oEnrJLqOhbwuQdlbhPRScnKQ2F5ID1hfBI2N9VVv4LYLpGO4NJEiG+SMm8n7i7
         A5BA==
X-Gm-Message-State: AO0yUKVR+GxlaMyn00QAPoDP+sPf6f7PfU5b6GwwPLc6+RXtkeHS6VwV
        oQtTlMvKiRIJxJCSqOxFgZ/IQpSpvqgnY+8hIQ5u
X-Google-Smtp-Source: AK7set9ZLKSM6EiLDPWzjcge7jruT1aFdqM8FlQ+ab7okXXatbx/IBhdTJ9xFEiPkivpMASpdzXRwA==
X-Received: by 2002:ac8:5e51:0:b0:3d6:88a0:7a5 with SMTP id i17-20020ac85e51000000b003d688a007a5mr15348985qtx.37.1679088565343;
        Fri, 17 Mar 2023 14:29:25 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id a72-20020ae9e84b000000b00745a3b63569sm2377074qkg.107.2023.03.17.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:29:24 -0700 (PDT)
Date:   Fri, 17 Mar 2023 17:29:23 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        gyroidos@aisec.fraunhofer.de, Alasdair Kergon <agk@redhat.com>,
        "maintainer:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AUDIT SUBSYSTEM" <audit@vger.kernel.org>
Subject: Re: dm verity: log audit events for dm-verity target
Message-ID: <ZBTbsx69kGXiKMIw@redhat.com>
References: <20230301113415.47664-1-michael.weiss@aisec.fraunhofer.de>
 <CAHC9VhQ_zvTqck4A7HvqH2rcwxuato_9nVWMk_Yf=ip3q9omgA@mail.gmail.com>
 <1f58acef-1e93-ed7a-3ad8-dd0927dacddc@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f58acef-1e93-ed7a-3ad8-dd0927dacddc@aisec.fraunhofer.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17 2023 at  4:00P -0400,
Michael Weiß <michael.weiss@aisec.fraunhofer.de> wrote:

> On 02.03.23 03:25, Paul Moore wrote:
> > On Wed, Mar 1, 2023 at 6:34 AM Michael Weiß
> > <michael.weiss@aisec.fraunhofer.de> wrote:
> >>
> >> dm-verity signals integrity violations by returning I/O errors
> >> to user space. To identify integrity violations by a controlling
> >> instance, the kernel audit subsystem can be used to emit audit
> >> events to user space. Analogous to dm-integrity, we also use the
> >> dm-audit submodule allowing to emit audit events on verification
> >> failures of metadata and data blocks as well as if max corrupted
> >> errors are reached.
> >>
> >> The construction and destruction of verity device mappings are
> >> also relevant for auditing a system. Thus, those events are also
> >> logged as audit events.
> >>
> >> We tested this by starting a container with the container manager
> >> (cmld) of GyroidOS which uses a dm-verity protected rootfs image
> >> root.img mapped to /dev/mapper/<uuid>-root. We than manipulated
> >> one block in the underlying image file and reading it from the
> >> protected mapper device again and again until we reach the max
> >> corrupted errors like this:
> >>
> >>   dd if=/dev/urandom of=root.img bs=512 count=1 seek=1000
> >>   for i in range {1..101}; do \
> >>     dd if=/dev/mapper/<uuid>-root of=/dev/null bs=4096 \
> >>        count=1 skip=1000 \
> >>   done
> >>
> >> The resulting audit log looks as follows:
> >>
> >>   type=DM_CTRL msg=audit(1677618791.876:962):
> >>     module=verity op=ctr ppid=4876 pid=29102 auid=0 uid=0 gid=0
> >>     euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=44
> >>     comm="cmld" exe="/usr/sbin/cml/cmld" subj=unconfined
> >>     dev=254:3 error_msg='success' res=1
> >>
> >>   type=DM_EVENT msg=audit(1677619463.786:1074): module=verity
> >>     op=verify-data dev=7:0 sector=1000 res=0
> >>   ...
> >>   type=DM_EVENT msg=audit(1677619596.727:1162): module=verity
> >>     op=verify-data dev=7:0 sector=1000 res=0
> >>
> >>   type=DM_EVENT msg=audit(1677619596.731:1163): module=verity
> >>     op=max-corrupted-errors dev=254:3 sector=? res=0
> >>
> >> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> >> ---
> >>  drivers/md/dm-verity-target.c | 20 ++++++++++++++++++--
> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > This looks reasonable to me from an audit perspective.
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> 
> Hi Mike, since Paul already gave his ack from audit perspective,
> do you pick this up? Or is there anything which I can improve from device
> mapper side?

Looks fine, but I haven't started a 6.4 branch yet. I'll pick this up
from dm-devel's patchwork when I do.

Mike
