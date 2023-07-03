Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB6C745758
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjGCIbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGCIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:31:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F69DD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:31:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbca6a9ae4so120685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688373099; x=1690965099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvMSLmEp/jCrf5+fXJYCHSi75wHSFHMyA26Vf0+e2Ew=;
        b=ncYEWyB42+EGNRtnmuTbaDTFcdc5HwR/u/GwI6uAvYNyIiben7j4gFA8VJF8bygJHG
         pu+6Oh8yLsrV5W/CmfBfwgmO4eTYvEyvomLjN9azkjr9xZUy7CfpclmWGpC8xxK+Y35o
         s6aNTTcqSYYkygcqT+fsWz3vazmR9Xb3RVuTBG3V7OVmDn/XD/uprFfyEj40Kw/kYb4V
         TeFhX84TR6JFmF143cOYWfEVKeHMjJVGQOlvKilYd8F6V3M0Hw8LwVQPr73O/ihCD2IK
         oIkbMj7tbQI/TDuH0n7xIjp0NcwAe2KtksdmkyF1/l8WGZBihueSA0aBJtqm+QxNJIvT
         5Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688373099; x=1690965099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvMSLmEp/jCrf5+fXJYCHSi75wHSFHMyA26Vf0+e2Ew=;
        b=ixxuamIJqNkCa3a80AvsorxFSQjAZol9l4IZ0grDF/RyV8W3/Is74qmzFp2mBj+rA1
         bPpUi4aDjpH2V61BwFNR1TqePclAVp7XgHjqGZx/rRGtw6pQF2X6zpJNf/CFqK3537lo
         7m2T89YiTP1RrDUpWrvTbo5vYQvLadQT0OUYRTOp7fwFp0b6Ncei6Fb02H7BGsGGGOpu
         /oDBs1JAQWk6XqdoFcwv5qtFP8mCERUsieiIslb0wZlN/Lms1BmsYtHiNeMpDeLyr9qD
         hnrBQc7pc1OOAThTHQUMl5jMlv3X+skTQvmvmCQKGUs4+AuEK7spIrDZ5tGZFZFp1baO
         D/1A==
X-Gm-Message-State: ABy/qLaq0C52X7j6S7bGaQNfNVIrnwIpc2/vzkJ8aK9hpu4SVH+70eaC
        T7VpJNoJopHmjb3zNm6mn8DwZIYaT0hRuQTKqFSlJnueP1NNNjrCTaU=
X-Google-Smtp-Source: APBJJlENpIpyWgCH9Y60BUirnq+/MtqiHOwLZijSMXbL6iIdYGH1Ln3fbXNObVUgo+uGipISqjN2SULM1jmNhgRylb8=
X-Received: by 2002:a05:600c:1d29:b0:3f7:ba55:d038 with SMTP id
 l41-20020a05600c1d2900b003f7ba55d038mr146968wms.6.1688373099531; Mon, 03 Jul
 2023 01:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e6068305ff68b9c5@google.com> <87edlry1cn.ffs@tglx>
In-Reply-To: <87edlry1cn.ffs@tglx>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 3 Jul 2023 10:31:27 +0200
Message-ID: <CANp29Y6X7fiw6y74Br6HXyyDuQUJMqQk3suzFvwrkg0W36ob5Q@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] linux-next boot error: BUG: sleeping function
 called from invalid context in cpu_bugs_smt_update
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+bdc9ec9be68959140dbf@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        peterz@infradead.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 7:43=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Sat, Jul 01 2023 at 01:29, syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    53cdf865f90b Add linux-next specific files for 20230627
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12a6f567280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D83c17849d18=
e7a86
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbdc9ec9be6895=
9140dbf
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
>
> That was a temporary hickup in next.

Thanks for your reply.

Let's invalidate the report then:
#syz invalid
