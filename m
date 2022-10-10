Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A042B5FA39D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJJStT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJJSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:48:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24B753A1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:48:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d24so11158906pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YgEsyw1oPncWuVxvOwqKuezQ0g/Bo0t0qbIS9RYEDE=;
        b=GPVQID31wrawZK7RErKIZ47VII3yTLH8TTwfo72cNxiEw57BIIAyHAwW/LVQREdvlk
         bIXVCq51X7hmKqQWMQjTwBaz4Hrurd6n0mGfmqRGZ1bERGCQQDMue5Om06hpS+B8jQtE
         4gh0u1AJuTmHbxUldKgPgPSfjG34PIOPMaPmEJih7IaJzGpPgogNpsz/Y7lT6fWEFGVo
         e5FqXXr5SEYdh+U+TSbDKq3ua5/EEaniEIq/LeKtpQ0VoKtYLLVlV0hgCTSfw7qZpo6Q
         MYd3SmQfLMUaSuRu7btBcAzxDe2QIiU/w7ob9n0bA6SlUO3LqF/Su+/aBQ2roFBK1tmW
         XrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YgEsyw1oPncWuVxvOwqKuezQ0g/Bo0t0qbIS9RYEDE=;
        b=3kf0zJZXfrdEdbab6ykeDOOkK39g2CgVRDkhSDwPCPvq8ofksHfwKixhuD+vMFVR8z
         QvNTzQHON1ZZijS5SdBgWUk5AHa0HZmH11myOWzzf4eqtuwxVkNQpDSe9Evx+MEpT3d1
         CCZ2Zd7V404IX/DKUALuYM749COgl+MItAtrVmoTo1M/DOpuK4x+bR7NLefSKaer5Hq4
         HzfTCM76iUJyd5XLUS9lYZJtmtnEOld+4mFzsZ5NMqEM1nlEdmnPqonckq8r9ia7yjoc
         OeplVWY+VXYmSpfczB3aDkhbAcsTXRRaCWLOzIVlJtA4Dki45COpOE0Wtu/R4JIdmmL4
         nyKQ==
X-Gm-Message-State: ACrzQf0MBzRiEqYfdhg2BHVP0byRTtblkXjFhDwdrG2mWGidNBKfzHu/
        +8LKKJe+5mxhXBNy4VSpTsQ=
X-Google-Smtp-Source: AMsMyM6mxcSAYL2s/of9ProC065v+t6RuONmSy/KftMtYWR4r7bNSJsx4JhyK7Yf4X2pTRoDwVPCsw==
X-Received: by 2002:a17:902:c412:b0:180:6445:8894 with SMTP id k18-20020a170902c41200b0018064458894mr16625307plk.133.1665427730443;
        Mon, 10 Oct 2022 11:48:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709027e8c00b0016dbaf3ff2esm7011128pla.22.2022.10.10.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:48:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 08:48:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Christian A. Ehrhardt" <lk@c--e.de>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Message-ID: <Y0RpEGo+FZrA80mI@slm.duckdns.org>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
 <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <20221009173519.jwuissylg5haicie@wittgenstein>
 <Y0MP/errn3nJ+9WQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0MP/errn3nJ+9WQ@kroah.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 08:16:29PM +0200, Greg KH wrote:
> On Sun, Oct 09, 2022 at 07:35:19PM +0200, Christian Brauner wrote:
> > On Sun, Oct 09, 2022 at 03:10:36PM +0200, Christian A. Ehrhardt wrote:
> > > 
> > > Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
> > > error when used with CLONE_INTO_CGROUP. However, the permission
> > > checks performed during clone assume a Version 2 cgroup.
> > > 
> > > Restore the error check for V1 cgroups in the clone() path.
> > > 
> > > Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> > > Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
> > > Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
> > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > ---
> > 
> > Thanks for fixing this,
> > Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> No cc: stable?  :(

This got merged this cycle, so no need for -stable.

Thanks.

-- 
tejun
