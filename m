Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE16E1BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDNFpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDNFpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:45:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A612729
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:44:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 39-20020a9d04aa000000b006a1370e214aso6512575otm.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681451099; x=1684043099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZiBy+s4nbaVz7xQUBVrE3MueZ5kT0/0OhDxQkzGvLM=;
        b=cRdKXHm2Iu7ZAHJaECDtu7Gkz6V6IpGrHIZvR56cIO2yGB2b0kFl2GQuPXZfvkw11+
         NggdM2nIQxGsFcPhowN8BBT5nQrhm0WAGLsMGcWsFbIz/FLdGt+JSkLyK1+8jXgt95WV
         c2DbkBv0FGrDJZpNL10DWkmkPd2wiRsTpX0R0FnD/Wi8MVxVKejVDBmtCwUIDlIXQDck
         OekcaqkZQfI2y9hj4/tAc5AmtO+yEA5DhUgkDVn63rnj+IIZUJYSRZEupnaSGuRITtk4
         yeuO3MsjLc3Bil/D/7DsHEofqi1X7pz/xsgeAshNalpNOfoDPEBwTUPibTDdGt7gd2UA
         BKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681451099; x=1684043099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZiBy+s4nbaVz7xQUBVrE3MueZ5kT0/0OhDxQkzGvLM=;
        b=EaYRPTroq0gF3LFIo/19XmgUG9f2Jr6WPdC6kuMa6/eIUsAud6QqYvPQet04CrBqII
         ZF9ipxyIsaLR287ymqzyK6UsK3ZHKO/dubH2PNuaGOzMLI4b0kXf7Jp5kxeSHKB9Tp9l
         evtbMKDbj57mt60oI4cGJVW+l1QYjTvkW2QW8uH7a1LfIPYKxtoLPkqCp0Dopkm+fhli
         /TMBcnB4FE9rA1fR4hIh2Kj0B3jhXaTcpz0qUQOocNw4HRFvZB/ihTAn7utJ9Y+ESUPz
         3r3VO1g2AKZJeFe269ik725YyDrsmPr5sp5IFnNLGWs1ckg7ZlFDjwb54qREPiolN++U
         xKQA==
X-Gm-Message-State: AAQBX9dZaJ3tvwY9ZK1FaPSqsGDctyO33v7ptm0ed4LPNoaEkUjpLibk
        wDcQesB/ePGHFkmBWuzmX918r11NyOkhm1VXk5w=
X-Google-Smtp-Source: AKy350bQAy2QKoumLC+mND63DDJJRSOD4a6K1PX7cJk152u+bCa7CRVsAq8WQXO+qSu+B16s2CI9ta3oOsk5ajmnRSU=
X-Received: by 2002:a05:6830:1bdc:b0:6a1:1b5c:c6db with SMTP id
 v28-20020a0568301bdc00b006a11b5cc6dbmr1159487ota.7.1681451099092; Thu, 13 Apr
 2023 22:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200424222740.16259-1-afd@ti.com> <CAL_Jsq+4mf6QHX27knoHTXA4vnsC3swuvAH7zK1DpyaV-p_qbw@mail.gmail.com>
 <f46c097a-b2a6-6368-a8a4-e30995a54d17@ti.com> <CAH9NwWeZnDEkundm98=KL6xB9bVO3nOkk48xMF-eQnztP4DD4g@mail.gmail.com>
 <99f1da4f-810e-986d-388a-af136ade745e@ti.com> <CAH9NwWcafkmcZd=5WN_hoJmfkwUJJrewaPnSmCK-izrC3hwKnA@mail.gmail.com>
In-Reply-To: <CAH9NwWcafkmcZd=5WN_hoJmfkwUJJrewaPnSmCK-izrC3hwKnA@mail.gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 14 Apr 2023 07:44:47 +0200
Message-ID: <CAH9NwWfkWTXMVOY-7USgYJnBtUOYd8=TFVcPxiTgVd9AJAQH=Q@mail.gmail.com>
Subject: Re: [PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

Am Di., 4. Apr. 2023 um 17:02 Uhr schrieb Christian Gmeiner
<christian.gmeiner@gmail.com>:
>
> > > Hi Andrew
> > >
> > >>
> > >>
> > >> Okay, will split for v2.
> > >>
> > >>
> > >
> > > Was there a follow-up v2 of this patchset? AFAICT this series did not
> > > make it into the mainline kernel.
> > > Do you have any plans to work on it? If not I would like to help out
> > > as we have a use case where we want to
> > > use a dma-buf sram exporter.
> > >
> > >
> >
> > Sure, I've been keeping it alive in our evil vendor tree, but if
> > there is interest upstream now I'll post a v2 and CC you.
>
> That would be great!
>

Did you find time to prepare a v2? If not, can you point me to the
evil vendor tree?


-- 
thanks
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
