Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC47480AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGEJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGEJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:18:09 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04072A0;
        Wed,  5 Jul 2023 02:18:08 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso1748415e9.2;
        Wed, 05 Jul 2023 02:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548686; x=1691140686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnniEHM75ybllnlQqbnzdBbhL9bJMHbs9XKrfqFwjY8=;
        b=fjhWXSyj17Eo/rzZLfQHQHcJqBmmgFFrAlRq6XYUbNJ+sehFeBhnz+DcU5xmA/FRbc
         2cyLMQAX5hjFFovlWmA4NG5MYzTTVHd+gzsZUbmEDpeLWOxwuCUvMfjTjh2729J1ZrJz
         C5hNOpDhprPtTwb9EZdF5Ck9Un85r0A1cZ/uD2mu7H6m+1Jbba43GU47IGsQa39l0+59
         oWcVAXo99YiRbzUoECTknuIXodjjy71ubJtVa15n4NrkAUTdw+63X1murgLjC5+CpSGN
         eKiQdWBEBHCiiP0q/dzaNJoy7hF9xWiCst+pLPsklD1iM2/ZIZdSU9UnhVxxbdU4HxWY
         ntQw==
X-Gm-Message-State: AC+VfDwWLJNbVn3eFkCvKuT3/f88w5crFFK8UaLmGcmjBudUGEhCU61N
        7pDjKkzDrPPdn1A8GiDds2ns08QN3gwpzg==
X-Google-Smtp-Source: ACHHUZ6k0t48ll7+BP1YenYCMLiGGWN+aD1YZ1fDBLiQQZ4qSbE0qiUjrjnyHWSz3ascddy0oql3YA==
X-Received: by 2002:a05:600c:2290:b0:3fb:4165:9deb with SMTP id 16-20020a05600c229000b003fb41659debmr12674492wmf.18.1688548686265;
        Wed, 05 Jul 2023 02:18:06 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c225500b003fbc681c8d1sm1547389wmm.36.2023.07.05.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:18:05 -0700 (PDT)
Date:   Wed, 5 Jul 2023 02:18:03 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.org,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <ZKU1Sy7dk8yESm4d@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
 <20230703113410.6352411d@hermes.local>
 <ZKQ3o6byAaJfxHK+@gmail.com>
 <20230704085800.38f05b56@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704085800.38f05b56@hermes.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:58:00AM -0700, Stephen Hemminger wrote:
> > > This should be runtime configured like other netconsole options.
> > > Not enabled at compile time.  
> > 
> > Do you mean I should add a new option to netconsole line? This is the
> > current line format today:
> > 
> > 	[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
> > 
> > If that is the case, I suppose I want to add something at the beginning
> > of format, that specify that uname should be sent. What about something
> > as?
> > 
> > 	[u][+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
> > 
> > Thanks!
> 
> Keep it as simple as possible.
> What ever program is reading udp socket knows where it is coming from.

Right, the server knows from where the package is coming, so, the source
address is known at receive time, and that is good. I want to do the
same with uname.

> The uname is really not needed.

The uname is useful if the receiver side is looking (grepping) for
specific messages (warnings, oops, etc) affecting specific kernel
versions. If the uname is not available, the receiver needs to read boot
message and keep a map for source IP to kernel version. This is far from
ideal at a hyperscale level.

Things get worse when you have VMs using different kernels, and both
host and guests are sending traffic to the same receiver. In this case, you
have two different kernels versions mapped to the same IP.

Thanks!
