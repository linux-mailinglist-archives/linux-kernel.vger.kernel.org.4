Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50746D7B86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbjDELjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbjDELji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:39:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C61BDB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:39:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n19so20711462wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680694776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2hWNekXwwQWJJ+NlOEAYfKoaX45zd3ggmTXoKM+vz8=;
        b=chyCCw/eIQGuCmKphWG/Y3zuoUCiicN1nk7TQCEZhvTDl2HwZPihYzafdW+9r8W5me
         vW1zRGkhTycH1dPobpPN6rW1ShN8nGP+2pKSMCgfOdBeasOEbB7m3KU7Wycs7UMiUQKr
         Y1pnvUWr/Xv+QZVPJubcJ//oNXgBl4FZU5fGAOnJkbZM6RkePOAA0f/Pxu4zY0d0y9NC
         WfHpNfzBDCgsWqytrSa7OY6Xn140GJGOXWuUQFiauk07IUzaJRAeet7ImNmS4w3G2Tiy
         zsMYMlgKUHKsjQhlh2sP2VfWMfi20ZKfgrT9wVPRWWPzHe1f/fgZuh9jfNC3cecnP2ux
         vh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2hWNekXwwQWJJ+NlOEAYfKoaX45zd3ggmTXoKM+vz8=;
        b=NxOqj1xID6LUL0R6pUdTWlnw6sjyAjC44a0MaAiNLy+Dz082jPIDaCctt5jEc9wFHS
         c6G9xsv7iAxh3JQerOjC+69n7+UEtvqwIRe6bInRvDJwPyf4YDGJfnTl854LB0167/tA
         IWx9Ihk/KXYnCxAzR3BzH48mGSv9mDDCG0xRDmjiEzPVAA55IMrwM7MpmE9h/+gTwnNF
         l7YS4SHyRyIGtSF7AgUvzRh2RwMVR6qrtNyIhB3CAMm5DfZU7a+9bpY0Ij9VcjMwL+MF
         0X2XTEs873AA3Y2hZd57sj6MadKM3iYITdgtquewluGWfCHn+PNcHMocrvyIVBFpJtsd
         QMEA==
X-Gm-Message-State: AAQBX9dVU6xfiZt9I2OzUWGnXOoP+0EV6QicqGGRo3KCWcKcfTLL3Apw
        RR0Dk1gGlwLYNh3/TbN5SXbV5Q+1eQ==
X-Google-Smtp-Source: AKy350bkhc189c6i57CdmljY6abHfTWYTca6OtUebYnS0/NbwGnCInFL7Y2WarEidTRSPnd5feYBjA==
X-Received: by 2002:a1c:720e:0:b0:3f0:39ab:347c with SMTP id n14-20020a1c720e000000b003f039ab347cmr4601134wmc.23.1680694775753;
        Wed, 05 Apr 2023 04:39:35 -0700 (PDT)
Received: from p183 ([46.53.254.249])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003ee6aa4e6a9sm2004185wmp.5.2023.04.05.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:39:35 -0700 (PDT)
Date:   Wed, 5 Apr 2023 14:39:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] string: implement streq()
Message-ID: <c68b346e-107f-4864-b13a-25a25acdb80d@p183>
References: <4b595ab9-238c-43a5-aba0-be5d6afc0f87@p183>
 <20230403141641.6ace0d85fd48fbed5c02d7ef@linux-foundation.org>
 <db6ce106-a5fc-4742-a59e-ccbd39dfd69d@p183>
 <64f79f9610284091863ec8ce54660b85@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64f79f9610284091863ec8ce54660b85@AcuMS.aculab.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 10:45:36AM +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 04 April 2023 15:55
> > 
> > On Mon, Apr 03, 2023 at 02:16:41PM -0700, Andrew Morton wrote:
> > > On Sat, 1 Apr 2023 20:48:05 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > > Most of the time strcmp() is being used, strings are checked for equality.
> > > > Add wrapper to relay such intent (it is shorter to type, too).
> > > >
> > > > Use
> > > > 	if (streq(s, "s")) {
> > > > 	}
> > > > or
> > > > 	if (!streq(s, "s")) {
> > > > 	}
> > >
> > > Gee, do we really want this?  I mean, we all know how strcmp() works,
> > > don't we?
> > >
> > > I'm thinking it would be better to remove the various cute little
> > > streq() macros and open-code strcmp(...)==0.
> > 
> > No! It's cool, trust me. Try it out, you'll like it.
> > We "know" how strcmp() works because C didn't have streq() from
> > the very beginning.
> > 
> > strcmp() is only for insertion into trees. Half of the time you need
> > to read to the end of the expression to know if it is check for equality
> > or inequality. With streq(), you don't.
> 
> Instead you have to go away and look up what a function
> you've never heard of does.
> 
> Live with strcmp()...

It is obvious what it does.
