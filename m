Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB565F5D64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJEXzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJEXzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:55:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE50474F8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:55:03 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cj27so163186qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XThhC9U9uKIxJQZ665eKAgfnugmApozs76ScmLZwBk=;
        b=KSYASXbbQEnw9dIt1qkDOuDA0+QasmExuyaVSAsBd91F6GmYOyH0wPFBbWUd2SDuPt
         Kd3u4wpivOfmtt4sWJlNrFFkqqvV8f0DLJWsedYyEQOqFKG+4wYoNjmU7UYmwonJVgba
         UcykNav6fHuYOn2yHnk2YZrMx+dCZo4vkbYcBCbl5DKSGnKd0K3+enoOoQAZ5rYJdP8F
         Eialm1q0BgCKh4h3pSS8fGqJqacuW9K5WknGiJPDgtOre9+AO9L9f09d5iCjyJTo5rlg
         xCxAG2+koKTtIHDpzRUMp5XtfSIe8foYuVUlkWUe0f/R5mxhDmn31CETqJUaSCXCWqAX
         7OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XThhC9U9uKIxJQZ665eKAgfnugmApozs76ScmLZwBk=;
        b=Ab+FSP0HaeiqJfe59gpiqQYvBG8Uj5OTBLWeUOxhj5psmMT0vHBSb4PI8J6roe13AQ
         jTP2+bPMDqv6NkLU3GwSja/AWywsQijWG5/SvH6NSUycGlcZ5ohLp8o1vqoessya2q56
         YJasZoWWV399Sy2dP5Yg4UG9LOCeT8eDjxrGZLo/X/oY/Jxg93iDD6PY4wfUE4WrFYYl
         9lelmESdJzyRARdpVQ2LxM+Apaz12qr3EboC/ftQh1LJ8MqYLZDqEdiggwr3Lo5o3hhY
         OJwsJj71Q1qA6xBs1HtpCUWAKtGRofDqdsPMsmBumVGZu+9J7XUmoSOaoWAVwx8HUlwQ
         o6bw==
X-Gm-Message-State: ACrzQf1RHM37Eiu+GNqhI7/cLZRgRo8L0HLI5tbGRULFAGWSqzzP+CMu
        jNP6p1dm0/861lynFJf9BQ==
X-Google-Smtp-Source: AMsMyM4eROnmK5/Ehiq7Es0N/CNTVAElIT81oT1dQCstYathZwqVIbJlW0dOv1IpRAIF68hTPKC4ZA==
X-Received: by 2002:ac8:7d13:0:b0:35c:e54e:9c8 with SMTP id g19-20020ac87d13000000b0035ce54e09c8mr1590034qtb.320.1665014102301;
        Wed, 05 Oct 2022 16:55:02 -0700 (PDT)
Received: from serve.minyard.net ([47.184.185.126])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05620a319b00b006ce611aef61sm19661018qkb.95.2022.10.05.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 16:55:02 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2d13:71e3:7ea0:219])
        by serve.minyard.net (Postfix) with ESMTPSA id 22E3F180015;
        Wed,  5 Oct 2022 23:55:01 +0000 (UTC)
Date:   Wed, 5 Oct 2022 18:54:59 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ipmi: kcs: Poll OBF briefly to reduce OBE latency
Message-ID: <Yz4ZU8Ron/b9GV6p@minyard.net>
Reply-To: minyard@acm.org
References: <20220812144741.240315-1-andrew@aj.id.au>
 <08c20621-e75d-4a72-82e6-b1980304e20a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c20621-e75d-4a72-82e6-b1980304e20a@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 09:42:57AM +1030, Andrew Jeffery wrote:
> Hi Corey,
> 
> On Sat, 13 Aug 2022, at 00:17, Andrew Jeffery wrote:
> > The ASPEED KCS devices don't provide a BMC-side interrupt for the host
> > reading the output data register (ODR). The act of the host reading ODR
> > clears the output buffer full (OBF) flag in the status register (STR),
> > informing the BMC it can transmit a subsequent byte.
> >
> > On the BMC side the KCS client must enable the OBE event *and* perform a
> > subsequent read of STR anyway to avoid races - the polling provides a
> > window for the host to read ODR if data was freshly written while
> > minimising BMC-side latency.
> 
> Just wondering whether you're happy to pick this one up? I haven't seen 
> it hit the IPMI tree yet.

Sorry.  It's in my tree for 6.2 right now.

I can't push it up to for-next until 6.1-rc1 comes out.

-corey

> 
> Cheers,
> 
> Andrew
