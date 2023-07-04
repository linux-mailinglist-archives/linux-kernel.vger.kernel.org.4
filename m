Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5117475AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGDPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGDPyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:54:01 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C8E76;
        Tue,  4 Jul 2023 08:54:00 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3094910b150so6553988f8f.0;
        Tue, 04 Jul 2023 08:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688486039; x=1691078039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU5Ch7ZyFPAWmV2R4i+//IDVV+8rAbsYSxN4PN94SKo=;
        b=KGVkCWZEIfkiANksVsSTWgoF+RjRl1BInStoOm76wz4Tyvgwo1jQ6rYMhZVofTpwyt
         k72Fd+GVx3POSvxhDyqTr048lZywYJ3rrAGxinYeqngYZDDc/lUjNRoboZl4s5GqpBk/
         MGabKjulr9mz3b503FHf4lrwFcnIAzZ7Clm2GQ+PbBbc9bDTGC7z9TpkqgV4ld3qX94S
         zjYp+Zh+JA5sDIL7vxxOjBcdb9wAI48oFPu72jDbS4I7IpnoOOxDbMzAcQ5k+ipvEdvj
         S0bMW1+wIzXjqPUe0SYJPi3BKT0/ockcSNIRULCaim5V7BKCDS/02hWA7HZ5ejgglHQu
         aJJg==
X-Gm-Message-State: ABy/qLbBM/R56adU2D7XBDX9eBCb5Pdf6puv5IrluZxhYVBUFVIowkxy
        XF0sWBdFQKIm5CuLuJHJiMk=
X-Google-Smtp-Source: APBJJlHzl4vBL3Mzs/GqCSL4TXjsKgUc3WR8xPFH6e+bK9+ldHDZQ/QxFVje1zjYxjFoQ7rPAkB94g==
X-Received: by 2002:adf:e806:0:b0:314:1e99:32fd with SMTP id o6-20020adfe806000000b003141e9932fdmr10582861wrm.58.1688486038924;
        Tue, 04 Jul 2023 08:53:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000104800b003143ba62cf4sm3738843wrx.86.2023.07.04.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:53:58 -0700 (PDT)
Date:   Tue, 4 Jul 2023 08:53:56 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <ZKRAlJMi3tjOSrXD@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
 <4b2746ad-1835-43e6-a2fc-7063735daa46@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2746ad-1835-43e6-a2fc-7063735daa46@lunn.ch>
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

On Mon, Jul 03, 2023 at 06:46:25PM +0200, Andrew Lunn wrote:
> Hi Breno

Hello,

> Why not just send the message without uname appended. You probably
> want to see the OOM messages...
> 
> Also, what context are we in here? Should that be GFP_ATOMIC, which
> net/core/netpoll.c is using to allocate the skbs?

Maybe this is not necessary anymore, since I might be using the buffer
already allocated.

> > +static inline void send_msg_udp(struct netconsole_target *nt,
> > +				const char *msg, unsigned int len)
> > +{
> > +#ifdef CONFIG_NETCONSOLE_UNAME
> > +	send_ext_msg_udp_uname(nt, msg, len);
> > +#else
> > +	send_ext_msg_udp(nt, msg, len);
> > +#endif
> 
> Please use
> 
> if (IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {} else {}
> 
> so the code is compiled and then thrown away. That nakes build testing
> more efficient.

Makes total sense, I am incorporating it into v2 now.

Thanks!
