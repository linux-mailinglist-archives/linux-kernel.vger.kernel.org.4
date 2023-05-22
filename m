Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B270BEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjEVMww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEVMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:52:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28916C2;
        Mon, 22 May 2023 05:52:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-62388997422so24785356d6.1;
        Mon, 22 May 2023 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684759968; x=1687351968;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU74XbU3XqgQcDL72yfyuelPPnr/aGY7qMXCjNTHdYc=;
        b=JnAXMN2+pMFtm86dG8XbAjAbw50ydvglaJQXuHwz6BLWS5R/eU5C/9KBiwsGkYB5Lo
         n6SEVKv58bGarWgeZsDs6c/MMZbbbvpCK4N3vZhZTB93QhE/UJ/lY8ZI6AQWlls/U1X9
         T4/kNbLceLYTMZeKQekmFOhncGiIOtCXzPZZMkbWrG9lVEg9VCdrwl4vNjI3MAiIH3/9
         nkL9lPwjMliEC6P/9ckktAh2qp3DzvFKO76JiljQgBFC68s05Stu/I648Bk1U4+GcYUj
         1jx7KkgQN7Tlv8wyF+6bHXrKZeT/a90fgENgrh2gH3u8Z2yYL9B/TwnegZAcL+ZICXtu
         RDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684759968; x=1687351968;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yU74XbU3XqgQcDL72yfyuelPPnr/aGY7qMXCjNTHdYc=;
        b=DrpWSwDAvb7f+CIC3B5Z646aek9VhCNgnzm/3SFBelruhgO0DGMxAdQFZUuy1FhZo8
         pOhc0ozxc4uPZDScMJexsT00C2KtyKgB2QB+nXHjezG6kciMhzWmmmalPXSfgp1NzKYa
         Qm4vklqlLdSfBXeHSXBVyHT6EE2gYHnInxfvy7u44rpVhjG9S2t9vuiW4shrhZQaNiaO
         aWhr505pJ9qxub8WDzcIixN1xRcY7yYjyfTuBhNsPC9otGx9xl7ZI/lMFHMo7uYoDrl3
         wtyubMuWMg456n8zoz+dTdMenLo4w7yI8lDKiwbi+UbfWuP6qBRjsYVZgl5UgvgvbnTE
         +2BQ==
X-Gm-Message-State: AC+VfDyFpLGD8wSg8lBqtuQCM8JBLjgjf2xEwQ+ye2BDHuR+QyE8wa04
        8aZtcXtXeJRP+tkRLDRe1GBLmfGITA==
X-Google-Smtp-Source: ACHHUZ47YjCyBH7ognn1ilTZsBQ6Asyl27Q0wH1tHFIdPozseiwciWDWSxgQWKI/eOeuF/iH4l3kkA==
X-Received: by 2002:ad4:5ca5:0:b0:61b:6906:f275 with SMTP id q5-20020ad45ca5000000b0061b6906f275mr21742178qvh.7.1684759968173;
        Mon, 22 May 2023 05:52:48 -0700 (PDT)
Received: from serve.minyard.net ([47.189.94.26])
        by smtp.gmail.com with ESMTPSA id v14-20020ac873ce000000b003e3860f12f7sm2007613qtp.56.2023.05.22.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:52:47 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:25a0:8715:27d8:e606])
        by serve.minyard.net (Postfix) with ESMTPSA id B1CCC1800BA;
        Mon, 22 May 2023 12:52:46 +0000 (UTC)
Date:   Mon, 22 May 2023 07:52:45 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZGtlnWGSc31Wdhxa@mail.minyard.net>
Reply-To: minyard@acm.org
References: <ZEmDs0ASdnEAnpsL@minyard.net>
 <ZGtZKCvo71woGf9T@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGtZKCvo71woGf9T@hovoldconsulting.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:59:36PM +0200, Johan Hovold wrote:
> Hi Corey,
> 
> and sorry about the late reply on this.

Not a problem, thanks for replying.

> 
> On Wed, Apr 26, 2023 at 03:04:03PM -0500, Corey Minyard wrote:
> > I have a development board with a CP2105 on it, and I was trying to send
> > a break to it to do a sysrq.  And it wasn't working.
> > 
> > I have verified that the target driver works by setting a really slow
> > baud rate and sending something with a lot of zero bits.  It got breaks
> > just fine.
> > 
> > If I use TCSBRK, it seems to just send a short time with zeros, not
> > even a full character's worth.  It receives a valid character with the
> > top few bits set.  If I use TCSBRKP with a longer time, like 2.5
> > seconds, it waits the whole time, then at the very end it gets the
> > character as with the shorter break.
> > 
> > I can't find a programming manual for the chip, and I'm not sure what's
> > going on.
> 
> I just verified that break works on the first port of my cp2105 but not
> on the second one (I seem to receive the last characters sent instead).
> 
> Apparently this is expected as the datasheet (AN571) says the following
> about the SET_BREAK command:
> 
> 	This command is not supported on the second CP2105 interface.
> 
> Which port are you seeing this behaviour with?

I'm guessing this is it.  From the schematic I think this is the
TXD_ECI pin, though I'm not 100% sure.  I'd have to dig through the
device tree and SOC manual to be sure which port is which.

Would it be possible to return an error in this situation instead of it
silently not working?  Just to avoid others having the same issue.

Thank you,

-corey
