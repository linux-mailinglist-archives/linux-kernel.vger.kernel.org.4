Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE6747516
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGDPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:15:57 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C010D3;
        Tue,  4 Jul 2023 08:15:55 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so4800491f8f.0;
        Tue, 04 Jul 2023 08:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483753; x=1691075753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkzypDGj2A5FVZ9E2X25tiUJtXvKLv7wklLWlSOs6/Y=;
        b=lCHwu+boHmDyRegv3ZvtjTxjHK0da7PesYvh4tgbRfy535z24oixxf8GSt8TDOVDCN
         Iw7cRkVKpIxDFgPUKUfxv0xXOen0ALUu564ePOIkvH5O2PWXzWBIa7gck+oeFzXF0zQT
         V7znB54nOy9tMwjxkM8TtJ4Sw2qfBX2w2vtc8b9FNjQyBUk9j/4hBTjWMjXAPLLFgfV2
         qPmGMTCk9T6tZivj43t2tNFhi3Lfzt5rf+CUvzIb5wXq9tVCVr7SBgnq/9/QLO36u9vr
         OaHlAgBQQeHfyojGeynGSiOuu8KcLI4Z9guoYB7xP4lacWA2zQWDHmO0SVjgDmB33ygB
         gv+w==
X-Gm-Message-State: ABy/qLbFYXMtelI0rDSb/FFjVrhd61sb4nZ+tzu6pVHM0Lpile2yCKQi
        AJ5OA3CuA4QZmz38ctQ9L6E=
X-Google-Smtp-Source: APBJJlGc8Gtz9RojVi6/Rs2aRkw1Cb40swPcRdlk2fj57pxfjU+9Z/dLucoP3xXZ+d04VxYwt9EaLg==
X-Received: by 2002:a5d:4303:0:b0:314:2e77:afec with SMTP id h3-20020a5d4303000000b003142e77afecmr8497305wrq.57.1688483753358;
        Tue, 04 Jul 2023 08:15:53 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b0031438257aa9sm5201954wrm.36.2023.07.04.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:15:52 -0700 (PDT)
Date:   Tue, 4 Jul 2023 08:15:47 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.or,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <ZKQ3o6byAaJfxHK+@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
 <20230703113410.6352411d@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703113410.6352411d@hermes.local>
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

Hello Stephen,

On Mon, Jul 03, 2023 at 11:34:10AM -0700, Stephen Hemminger wrote:
> On Mon,  3 Jul 2023 08:41:54 -0700
> leitao@debian.org wrote:
> 
> > +config NETCONSOLE_UNAME
> > +	bool "Add the kernel version to netconsole lines"
> > +	depends on NETCONSOLE
> > +	default n
> > +	help
> > +	  This option causes extended netcons messages to be prepended with
> > +	  kernel uname version. This can be useful for monitoring a large
> > +	  deployment of servers, so, you can easily map outputs to kernel
> > +	  versions.
> 
> This should be runtime configured like other netconsole options.
> Not enabled at compile time.

Do you mean I should add a new option to netconsole line? This is the
current line format today:

	[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]

If that is the case, I suppose I want to add something at the beginning
of format, that specify that uname should be sent. What about something
as?

	[u][+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]

Thanks!
