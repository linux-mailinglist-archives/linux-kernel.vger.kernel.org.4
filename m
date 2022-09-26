Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC535EAFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIZSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIZSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:31:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA031356F2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:31:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso7743137pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JDnfp+dxjaa9G7LgXlHC4/m28SGyrqj6Pcl9IikPnXI=;
        b=lxZ9MhPOSGxCpI+kdXOqnI0wWGqI86mHU5307O4GzXhoWGBT7OGuY1deL991Uvsuyi
         aSE4dW59QnQi8/M/ORuzoqRGqW+clqC8lLTumjxBO5/NzMzX1F5N15vkBpOfggfaj9Tt
         eiTK0M+QmH2HdGmLn0KmCtyb8DjrOqtN5nZ1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JDnfp+dxjaa9G7LgXlHC4/m28SGyrqj6Pcl9IikPnXI=;
        b=dhR7Xdq6VNBH6wCmsS/d3szmB6DrnK1rLDmtwAmBYYCCdMyUVjNAbjZvDym5GMW/74
         Xw8Lju6PeFjUnWAKPVPBg/Mm8Ou+dtXior12bJ0nXWUAtb5VJtHS2a8nJBy47sScnPWo
         PCmHcB3hvgwpT2+tOMvWAq6fJnXpem/Q8J7NQvajFHPX45rvTYQu6Lku5aPd+liS/xId
         LLEaHGlnGU/qMEZ+y10r1skcFaCsaBYqF4HLUHBsAVmBVh4Z4UxglxeHkWfsN9QbjSkp
         SZS+k2UONpgE0dDLrs97HQzx7BSHh1CgVotyiW68BZF7+GiObbaiTcSDSPXBi7A2qs+v
         3KKg==
X-Gm-Message-State: ACrzQf3pyUkU1W/9dDSIc0wV7BzIhb+xroQxS+1OS0WQ4T0yguNbY9z/
        ZlsekwK6zOyjB3K9Y90yKslHlQ==
X-Google-Smtp-Source: AMsMyM4ZHrL/CxfzRTi4el16mgnFMEbJVuAla2+VNWr5QuRipraqPoBca8HrDrpaTwgPiGBZUHflww==
X-Received: by 2002:a17:902:c213:b0:176:cdb9:c504 with SMTP id 19-20020a170902c21300b00176cdb9c504mr23067649pll.44.1664217060224;
        Mon, 26 Sep 2022 11:31:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i10-20020a056a00004a00b00540a346477csm12599184pfk.76.2022.09.26.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:30:59 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:30:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <202209261130.2C96929E38@keescook>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com>
 <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
 <Yy7d5qWpT5Xj2WvN@zx2c4.com>
 <YzF4NrcBkR/p0cD3@smile.fi.intel.com>
 <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:23:48PM +0200, Jason A. Donenfeld wrote:
> On Mon, Sep 26, 2022 at 12:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sat, Sep 24, 2022 at 12:37:26PM +0200, Jason A. Donenfeld wrote:
> > > On Fri, Sep 23, 2022 at 03:54:12PM -0700, Andrew Morton wrote:
> > > > On Fri, 23 Sep 2022 17:40:01 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> >
> > ...
> >
> > > Worth noting, by the way, is that the input validation check already
> > > caught a bug when 0day test bot choked:
> > >
> > > https://lore.kernel.org/linux-hwmon/20220924101151.4168414-1-Jason@zx2c4.com/
> >
> > Hooray, it was a good idea! :-)
> >
> > > So, options:
> > > 1) Keep this patch as-is, because it is useful on modern compilers.
> > > 2) Add an ifdef on compiler version, so we generate the best code in
> > >    each case.
> > > 3) Go back to testing twice, but keep the checker macro because it's
> > >    apparently useful.
> > > 4) Do nothing and discard this series.
> > >
> > > Any of those are okay with me. Opinions?
> >
> > I tend to case 3) (I believe you typo'ed double 2) cases) and apply the rest
> > as a separate change with all downsides explained (kinda 1) approach).
> 
> Alright, I'll do that. v3 on its way, then.

Cool. I've dropped v2 from my -next tree.

-- 
Kees Cook
