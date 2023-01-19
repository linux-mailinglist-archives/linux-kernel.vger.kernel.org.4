Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB17674A99
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjATE26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjATE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:28:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282CB1ECF;
        Thu, 19 Jan 2023 20:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B5E8B82135;
        Thu, 19 Jan 2023 08:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A543FC433D2;
        Thu, 19 Jan 2023 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674116991;
        bh=wiIwzJ1J9iz0naLuw7+n0CgUx6j+UpqtC2oWoSfJfc0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qwUegg87DEOi/Wj+waB+iMZarjqP2Pfzov442nwZ0wm6u2wc1eQhCqdJ/9qhwbxr8
         cbtLWwv6HL4ZwZlpE6h8dQ1Q+xT22AYflOifZ6C6/L3yYWrRpFqlumuuaJxCY6PH/N
         TIjp1f+/4YkOOhCjWYuMcnWNUvmCKFb2OWsqkw9FQ7EL2PRK9EEBN1UaOJtu20gAE9
         ruTLifWMtafnXEpnXg99nGvO1DNnQboiV/2ea3VXmSQxtG29VliC5exrl/6n3/T2CJ
         xHzOHh6BE2T3DjJHKSGmxq6xisILxxMOTohSeKb/sPAifCLXkhvsCFqiZkV71ANAQp
         o2e7SC4lHpdFA==
Received: by mail-lf1-f52.google.com with SMTP id g13so2139839lfv.7;
        Thu, 19 Jan 2023 00:29:51 -0800 (PST)
X-Gm-Message-State: AFqh2kpYAT5RKgoUJAJ2h8NXNjlU714Fcmloxkg3AxbgF/QUq5C7y1EM
        CGZ+uq02eL6IXRLfRwXM99fBlfHmpKUWRz6Xeqc=
X-Google-Smtp-Source: AMrXdXtv4mp0PXcDo9ZDkHrj+7QhEher1afjbD7W9N7lNoxMQo/TrO/llB4c4E3n7IN/pxlJJ4KOeYqAnvBdr76zgrY=
X-Received: by 2002:a05:6512:308a:b0:4d1:3e32:5436 with SMTP id
 z10-20020a056512308a00b004d13e325436mr1044480lfd.215.1674116989690; Thu, 19
 Jan 2023 00:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
 <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com>
 <20230118074047.GA27385@lst.de> <CAPhsuW7zqYgLcWoG1Wr_tBBLt-yiNYq3FLVWYMpMj=6TJawQEg@mail.gmail.com>
 <20230119053545.GA16775@lst.de>
In-Reply-To: <20230119053545.GA16775@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Thu, 19 Jan 2023 00:29:36 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5WFEHfGrSW5nYRRohmLMAfWoZiOCBgCdgzOCmn+Q_vVA@mail.gmail.com>
Message-ID: <CAPhsuW5WFEHfGrSW5nYRRohmLMAfWoZiOCBgCdgzOCmn+Q_vVA@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 9:35 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 18, 2023 at 01:52:51PM -0800, Song Liu wrote:
> > In this way we can use the array in the for loops, and use mod->core_text,
> > etc. when we only need to access one of them.
>
> Just use the array please instead of making it too ugly.  If that
> is the only sensible way to iterate we have a good argument for the
> array and can live with it.

Hmm.. I think it won't be ugly outside of the struct definition...
Alternatively, how about use something like

#define core_text mod_mem[MOD_MEM_TYPE_TEXT]
...

which is similar to

struct sock {
        /*
         * Now struct inet_timewait_sock also uses sock_common, so please just
         * don't add nothing before this first member (__sk_common) --acme
         */
        struct sock_common      __sk_common;
#define sk_node                 __sk_common.skc_node
#define sk_nulls_node           __sk_common.skc_nulls_node
...
};

?

Thanks,
Song
