Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E367A0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjAXSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjAXSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:02:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606F49438;
        Tue, 24 Jan 2023 10:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6294B8160D;
        Tue, 24 Jan 2023 18:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D9AC433A1;
        Tue, 24 Jan 2023 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674583317;
        bh=spf/9n8PYBc5VENbdPq9Cw/ybZAmVKPT6n4JbnJHRlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LZHEnW3Guq1xenMkKxmNsqR/VfAQGPKQQI/ye5wT7xCn2CQHD7rgYx7E9X1b2ajef
         kaWx0u07SQ1OquztPzKEuKF1Bm6lD35asPxLTFyJvZmLeAbwh8k5KfvQSKHcqiHfFM
         +o8dDmuaJmgxWNYItRy1cuxB4ncGhVwMlTQImoT3ckYthogWoI4v2JjCQ0LLIJ/rbe
         /OZBAnQyl4gaASc1v9vXncNG3g/8t8iyiNv1yIuGqFzODG249Lo93Q1myboixXyd9N
         Enrkss2RMcWgwUFnZaFIi4w9tg4mNUFCXHd/+IG8QfAMTdodEiEhkpLIn3YgN/qFsi
         n58/oPmhvsGEA==
Received: by mail-lj1-f181.google.com with SMTP id z7so17618110ljz.4;
        Tue, 24 Jan 2023 10:01:57 -0800 (PST)
X-Gm-Message-State: AFqh2kroFsdMLE5q4U7biaP/8j/fj1gT9JjsfDrbC0Xl/4OXkhnjUxUC
        xbYgC0wMOBsUWaoOrszmlPSvD6mBVkJSK1lAkL0=
X-Google-Smtp-Source: AMrXdXttmKLWUUpQnpMtZeQVRTCq0L/nPTajG2vTGnbQK96A2skVio1oNzH7siy/SnIdB0vzFGOjunbS/YUCSS9BsQ4=
X-Received: by 2002:a2e:2c15:0:b0:280:54b:9ed5 with SMTP id
 s21-20020a2e2c15000000b00280054b9ed5mr1295211ljs.414.1674583315508; Tue, 24
 Jan 2023 10:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
 <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com>
 <20230118074047.GA27385@lst.de> <CAPhsuW7zqYgLcWoG1Wr_tBBLt-yiNYq3FLVWYMpMj=6TJawQEg@mail.gmail.com>
 <20230119053545.GA16775@lst.de> <CAPhsuW5WFEHfGrSW5nYRRohmLMAfWoZiOCBgCdgzOCmn+Q_vVA@mail.gmail.com>
 <CAPhsuW4snf6cBYSDRbALSNM4OE36-dusir8HQQ90Li7u067ZWA@mail.gmail.com> <20230123065746.GB30529@lst.de>
In-Reply-To: <20230123065746.GB30529@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 24 Jan 2023 10:01:41 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5XA9GiQ-dtWH8hUkhpTUYAvxegdH3BZ+j7+RfEMqwZJg@mail.gmail.com>
Message-ID: <CAPhsuW5XA9GiQ-dtWH8hUkhpTUYAvxegdH3BZ+j7+RfEMqwZJg@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        songliubraving@fb.com, Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Sun, Jan 22, 2023 at 10:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jan 20, 2023 at 09:42:26AM -0800, Song Liu wrote:
> > So here are the two versions, both with secondary addr_[min|max] for
> > CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC.
> >
> > v2. Just use mod_mem array:
> > https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=remotes/song-md/new_module_alloc_build_test_v2
> >
> > v3. mod_mem array and the defines:
> > #define mod_core_text mod_mem[MOD_MEM_TYPE_TEXT]
> > #define mod_core_data mod_mem[MOD_MEM_TYPE_DATA]
> > etc.
> > https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=remotes/song-md/new_module_alloc_build_test_v3
>
> I find v2 much preferably.  Having magic layouts with different
> access methods is horribly confusing.  It might be a way changes
> things if modifying every caller would be intrusive, but starting
> out that way does not seem like a very good idea.

Thanks for the feedback! I will send a patch based on v2.

Song
