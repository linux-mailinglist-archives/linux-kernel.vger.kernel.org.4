Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C091C64B869
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiLMP3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiLMP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:29:24 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA30C1F2DB;
        Tue, 13 Dec 2022 07:29:22 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id w4-20020a4aaf04000000b004a1ab217cecso2409837oon.13;
        Tue, 13 Dec 2022 07:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksqSWoZG4XNv4Y4DMVsiT2rFuQBSb9BU/xJ4iKDBrqI=;
        b=KU88n0HeSrdXC2gHoj1hYWBNeBhQq8CbdcyQKFCKng3ICZuPt49DzG738qvj49C0cV
         D8OoA94mniCsj4MfFGfi69a1Js0ZkzPXXNi9gf8nIg3J20IBDAugxeD1t+h96vL/QQ/1
         HTvYEInktmm7TStmyHX/QQ5o1oJFZa3a8py1fiHSgIQ1CiDybM+4R6JFV5QRNkhcWqBh
         BFHM+5cbk7KL3fnmevJxaGR63FRAcMOx0cXdXrk5CaoZddx4CaPHfpACOiZQUcF38Tcd
         nfSs+2EhDmnJ43tt8YrK2DYj4hAjF6cqF40qe40MLUG4I6mZV0I6oYywdFfHl2fOUSe9
         5hLw==
X-Gm-Message-State: ANoB5pleYiSlNgkNpTmld/3QJ6Bp9DG9RhEMJEeVv1cTZpYiT4C2IKQt
        Aq+U+JcU3VxJVngnHq0hDQ==
X-Google-Smtp-Source: AA0mqf6Yhc/BTB0SRA3fmharfFvjQf/P90liAwZMUszdAYs1jDftlTQhLVqzYsRzWi0ez1w6QBC/fQ==
X-Received: by 2002:a4a:4f89:0:b0:4a3:51a2:f8ba with SMTP id c131-20020a4a4f89000000b004a351a2f8bamr9897765oob.6.1670945361110;
        Tue, 13 Dec 2022 07:29:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k15-20020a4ad10f000000b0049bfbf7c5a8sm1219110oor.38.2022.12.13.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:29:20 -0800 (PST)
Received: (nullmailer pid 1312070 invoked by uid 1000);
        Tue, 13 Dec 2022 15:29:20 -0000
Date:   Tue, 13 Dec 2022 09:29:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node
Message-ID: <20221213152920.GA1025576-robh@kernel.org>
References: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
 <CACRpkdaXxPE3XhPnprhJ7GGjn9X_GMsCJ3mn26P90GcHzhsQDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaXxPE3XhPnprhJ7GGjn9X_GMsCJ3mn26P90GcHzhsQDg@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 09:51:33AM +0100, Linus Walleij wrote:
> On Mon, Dec 12, 2022 at 7:01 AM Alexander Sverdlin
> <alexander.sverdlin@gmail.com> wrote:
> 
> > I do not read a strict requirement on /chosen node in either ePAPR or in
> > Documentation/devicetree. Help text for CONFIG_CMDLINE and
> > CONFIG_CMDLINE_EXTEND doesn't make their behavior explicitly dependent on
> > the presence of /chosen or the presense of /chosen/bootargs.
> >
> > However the early check for /chosen and bailing out in
> > early_init_dt_scan_chosen() skips CONFIG_CMDLINE handling which is not
> > really related to /chosen node or the particular method of passing cmdline
> > from bootloader.
> >
> > This leads to counterintuitive combinations (assuming
> > CONFIG_CMDLINE_EXTEND=y):
> >
> > a) bootargs="foo", CONFIG_CMDLINE="bar" => cmdline=="foo bar"
> > b) /chosen missing, CONFIG_CMDLINE="bar" => cmdline==""
> > c) bootargs="", CONFIG_CMDLINE="bar" => cmdline==" bar"
> >
> > Move CONFIG_CMDLINE handling outside of early_init_dt_scan_chosen() so that
> > cases b and c above result in the same cmdline.
> >
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> 
> Excellent debugging Alexander!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I also think this should go to stable.

We have to be careful there. This could change behavior on a working 
system. A system taking the cmdline entirely from a built kernel and 
no initrd is going to be pretty customized already, I think they can 
carry a patch. What platform is this anyways?

This has actually been known for some time[1][2]. My concern in the past 
(besides wanting all the cmdline manipulation being common) was MIPS. 
MIPS in particular has lots of sources for cmdline and ways to combine 
it. However, MIPS has since stopped using this code and does their own 
parsing (not great either IMO).

Rob

[1] https://lore.kernel.org/all/CAL_Jsq+CgxWbCMz_qwLbMJS3fYwKyCMBGVS501-5ShXywyDAXA@mail.gmail.com/
[2] https://lore.kernel.org/all/CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com/
