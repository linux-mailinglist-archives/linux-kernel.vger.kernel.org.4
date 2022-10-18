Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D914602408
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJRFzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJRFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:55:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB7E8F944
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:55:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fw14so13012960pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RSQN0hwdZlX1y7u16DsnIwcWO7mjXUN5LAASmU8cjwM=;
        b=eG3/tYkCfaz1l0HV4b9o4Arup6zLLv2hJBbc8fVEbyDhV0zndJrwVQsMa0LvY+xrsM
         xcyOH0EuCWQVQvCacTLS94fkfmlKNDat0BQUjJUeZBjPFcdX2iUZKhj2cZradov4pmk6
         MIpd1Tt7jcFgiwcqP/Vyg0WSO73Ql2zvJ3GBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSQN0hwdZlX1y7u16DsnIwcWO7mjXUN5LAASmU8cjwM=;
        b=gdruCqRp7tW12ZJJM4CpU3pUoFXakgsY1Zg5ByNuPJvm5CyBxYZQgxf5TqK+pNhB7k
         o+Q9UR50K573wavmiikNzMC1b6JRVK30cPZF93bbMrDb8MmeEIP+4Ro3IJTBlZ42r/1l
         ZaMIh0QvTG0v7h7xG3NTyZYxnYFBvsv0y0UlvAJct9nhLRrvXDOLG+7sSLSPvgCZ+RwT
         ULTj/6QoWmYKS2UIpvwxd2Hmi/QfZ/PemDeXhqUcy8AEGKiQwK6mkcv6enq+6pWiVwLO
         uQkcOyuE4WHDpQarO62R5SE9VGxm8qfGeJe+bK7er9PLLzVqGvR/KjnH6Frixne8aDmV
         zTvQ==
X-Gm-Message-State: ACrzQf0qFzrmrTw7zv68qWVkcoa+I0YFNQzQE3treCXRI+IIuhpAhlKX
        f9EcWWYsw0BH3HeBXUEZEphzyeTFTAB7zw==
X-Google-Smtp-Source: AMsMyM4tWFDs3k8YT7Kcl2bUy6iKgC8N5CCJCcGphkhNJeVs9KBEYz/AsGbihGkjC5doqWdyfdzUrA==
X-Received: by 2002:a17:90a:3f86:b0:20a:e7dc:340a with SMTP id m6-20020a17090a3f8600b0020ae7dc340amr1746037pjc.157.1666072532868;
        Mon, 17 Oct 2022 22:55:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0017c6959724asm7613471plb.258.2022.10.17.22.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:55:31 -0700 (PDT)
Date:   Mon, 17 Oct 2022 22:55:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
Message-ID: <202210172153.C65BF23D5E@keescook>
References: <20210222150608.808146-1-mic@digikod.net>
 <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
 <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
 <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
 <202210171111.21E3983165@keescook>
 <CAHC9VhTTKpesvjnc_233x+wG1BvXyup9nM4Dv2h1953zXAvU3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTTKpesvjnc_233x+wG1BvXyup9nM4Dv2h1953zXAvU3A@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 09:45:21PM -0400, Paul Moore wrote:
> The code sorta cares about ordering, at least to the extent that the
> LSMs will behave differently depending on the ordering, e.g. a LSM

Right -- this is why I've been so uncomfortable with allowing
arbitrarily reordering of the LSM list from lsm=. There are orderings we
know work, and others may have undesirable side-effects. I'd much rather
the kernel be specific about the order.

> I personally would like to preserve the existing concept where "built"
> does *not* equate to "enabled" by default.

Yup, understood. I didn't think I was going to win over anyone on that
one, but figured I'd just point it out again. ;)

> > I *still* think there should be a way to leave ordering alone and have
> > separate enable/disable control.
> 
> My current opinion is that enabling a LSM and specifying its place in
> an ordered list are one in the same.  The way LSM stacking as
> currently done almost requires the ability to specify an order if an
> admin is trying to meet an security relevant operation visibility
> goal.

As in an admin wants to see selinux rejections instead of loadpin
rejections for a blocked module loading?

Hmmm. Is this a realistic need?

> We can have defaults, like we do know, but I'm in no hurry to remove
> the ability to allow admins to change the ordering at boot time.

My concern is with new LSMs vs the build system. A system builder will
be prompted for a new CONFIG_SECURITY_SHINY, but won't be prompted
about making changes to CONFIG_LSM to include it.

Even booting with "lsm.debug" isn't entirely helpful to helping someone
construct the "lsm=" option they actually want... I guess I can fix that
part, at least. :)

-- 
Kees Cook
