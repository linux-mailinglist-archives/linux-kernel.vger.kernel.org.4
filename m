Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F07475C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGDP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGDP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:58:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD7710C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:58:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89cb535afso9730115ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688486283; x=1691078283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ob5s66nJUuWrzVmIgcpj6gX1pVOIG43sjp0smeuqRk=;
        b=yTV0wkqS1/NR8efXnnWnTnPtMe05KXibp8pqQ7qrGhZHkRhc5dFDtTt1lCQQEQyuUW
         I0U/A19V8OfYLMIIBS4YaW0/2gFPbGU0BJVz0OvlUm9rVRLOoIjQp7b8Q43bJwYYZRBc
         4hlWlUDaF9uwG4nhXY1tcNXBM3ej6HAmBHkzUF0GfdyCZZksWEWNn5RK+53t6VS285dn
         xr6/wwYpfmDmkhzKyF/+rSnYOIhQ03zjUB+xLHxqihh+28KlRcg7flHvem2BLVKidv4X
         Rjif9fxwkS/VpS/NqXpaxy7SEOw/EIk2EWGItbyf6GCiUbw1wM+LDRgUTrJcMYOpEWkU
         HcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688486283; x=1691078283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ob5s66nJUuWrzVmIgcpj6gX1pVOIG43sjp0smeuqRk=;
        b=cvslM1d8R+FUBJ1aqKVMMgQHfFEsFFvBmCTV4kvvnuWg7POc7kjTcDFiT3GRfOLavK
         VNJoCEflMYDW8SWxfa0NQbgGDYwyN982yn3XtS9M3LigFjfELFiR+0Qn+oRd3gIm3bJs
         EWbOZ+GgIaGe01F+fnXoKQ9znUFbbU/vPUlQVkDkthZEQGyCm+pgaqMnSUJWarCYxNEL
         eGX/89tVB/LPSOHNVkwYVbHUP1Qu4CuuOybFCkKlDklstkGiVj5YCD4oWZgDRyE1mXvZ
         hkUcVqntmi7kFamTYoeI0qjixElWPQSmRwO0EaciKOmIz3OB+cD1Uzb8FmVPKdSLf0AT
         zhkA==
X-Gm-Message-State: ABy/qLY0Pk8vz8sR0+wrqgHZQvR42ry7VrnnaTYFpMBB0Udn8W0iRULa
        yUzDs24wVxbNBVpkslWn3s1syA==
X-Google-Smtp-Source: APBJJlETTmVVFs8YtNneUBEorttJnAIPN63N7o/Y7mFVilt6D8loeh6FMTP8QxF/HYxSqOZo7StQ2Q==
X-Received: by 2002:a17:902:9696:b0:1b8:971c:b7b8 with SMTP id n22-20020a170902969600b001b8971cb7b8mr4827989plp.47.1688486283606;
        Tue, 04 Jul 2023 08:58:03 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b001ab2b4105ddsm9344591plb.60.2023.07.04.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:58:03 -0700 (PDT)
Date:   Tue, 4 Jul 2023 08:58:00 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.or,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230704085800.38f05b56@hermes.local>
In-Reply-To: <ZKQ3o6byAaJfxHK+@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
        <20230703113410.6352411d@hermes.local>
        <ZKQ3o6byAaJfxHK+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 08:15:47 -0700
Breno Leitao <leitao@debian.org> wrote:

> Hello Stephen,
> 
> On Mon, Jul 03, 2023 at 11:34:10AM -0700, Stephen Hemminger wrote:
> > On Mon,  3 Jul 2023 08:41:54 -0700
> > leitao@debian.org wrote:
> >   
> > > +config NETCONSOLE_UNAME
> > > +	bool "Add the kernel version to netconsole lines"
> > > +	depends on NETCONSOLE
> > > +	default n
> > > +	help
> > > +	  This option causes extended netcons messages to be prepended with
> > > +	  kernel uname version. This can be useful for monitoring a large
> > > +	  deployment of servers, so, you can easily map outputs to kernel
> > > +	  versions.  
> > 
> > This should be runtime configured like other netconsole options.
> > Not enabled at compile time.  
> 
> Do you mean I should add a new option to netconsole line? This is the
> current line format today:
> 
> 	[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
> 
> If that is the case, I suppose I want to add something at the beginning
> of format, that specify that uname should be sent. What about something
> as?
> 
> 	[u][+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
> 
> Thanks!

Keep it as simple as possible.
What ever program is reading udp socket knows where it is coming from.
The uname is really not needed.
