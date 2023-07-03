Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2813B746370
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGCTlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCTlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:41:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA8E73
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:41:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b80b3431d2so24192925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688413262; x=1691005262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbxGFmi5PacTIKGVx0RdDORb8AM+fg+cYsrHtfuXE/g=;
        b=f+5XRsvwHLkRzx6waWRtgqDYv+m/e8ZydD10rM3PaeCe6gT40kLx1UIxGhjzH1xu/M
         4fKTEImvnikw701dvr6Z5BVuTE2prEAhFy/xlCbtj87FeNNigAbe5vTVvNA0YsFDnhYo
         7rOCStN9zxQuSPh9UkLTNVeg7oF9zJRH7/TUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688413262; x=1691005262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbxGFmi5PacTIKGVx0RdDORb8AM+fg+cYsrHtfuXE/g=;
        b=NBd7s96q6ZVhbLf8CG6g0Z1GW8/viGithM7H7ozWVPgAyvIN8pcgGoUX+ubfag//e2
         d3JcUWCYIj+wUM97Nnf8Youtub0aMHKtWGtZJOu9e41Jpory8DHvAtJTDuKg80CJj87V
         ezO1dGeMWasWpqOVlf2oAqY10E6gkvqVzCcR5TffyiF11LV+klsmUI77vrMJ4hj4Icvv
         rP90rVkID4yJagSq3GI4MDiSJl/uagCGBw9JXz6+Ab5y+csCimEuujN0quTvS3ZBm4Yc
         kQZjN1w5Kk0fRDl0sGnZPV8weNfJrjOZj9+EpQArWU1p6HqU4+InBEw3tJiinFCm7ojI
         9Tog==
X-Gm-Message-State: ABy/qLZom8kpg9EoSDEZN+Kc9pUGjnmXxOFmULxlJO6DcgUDha9AfHgX
        T7IXdR6yexX7cBfxTCEKWanipg==
X-Google-Smtp-Source: APBJJlFEn1MfNSBmAhVn5Hvqj+sVYOXb1qwVWW9s2Pl/q5//sRVm78adTr25YIvpjAJWarzzn1DH9w==
X-Received: by 2002:a17:902:d2cd:b0:1b5:49fc:e336 with SMTP id n13-20020a170902d2cd00b001b549fce336mr11946404plc.42.1688413262628;
        Mon, 03 Jul 2023 12:41:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001b8622c1ad2sm7100044plf.130.2023.07.03.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:41:02 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:41:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <202307031240.0B8B07ECD@keescook>
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin>
 <202306271944.E80E1D0@keescook>
 <20230628060716.vvgtlgbushyjh6km@begin>
 <202306280930.8CBBB9B@keescook>
 <20230702000022.iozn7lmvy2ihygdc@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702000022.iozn7lmvy2ihygdc@begin>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 02:00:23AM +0200, Samuel Thibault wrote:
> Kees Cook, le mer. 28 juin 2023 09:32:20 -0700, a ecrit:
> > On Wed, Jun 28, 2023 at 08:07:16AM +0200, Samuel Thibault wrote:
> > > Kees Cook, le mar. 27 juin 2023 19:48:45 -0700, a ecrit:
> > > > > Really, this a serious regression for the people affected by this.
> > > > 
> > > > Can you send a patch adding a CAP_SYS_ADMIN exception?
> > > 
> > > Sure!
> > 
> > Thanks! (And be sure to use file->f_cred for the check[1], not "current",
> > that way brltty can open the tty and drop caps and still do the ioctl.)
> 
> Actually brltty re-opens the various tty[1-6] consoles when the users
> switches, so I kept just testing capable(CAP_SYS_ADMIN).

Well that's frustrating. :P

-- 
Kees Cook
