Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1B64F519
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLPXbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiLPXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:30:44 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62975B99;
        Fri, 16 Dec 2022 15:30:38 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id h7so3955436wrs.6;
        Fri, 16 Dec 2022 15:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2TVu+3MfQCVc1RNPZura77WekzfqEyNct5iHB345A4=;
        b=VHRPyDeuANjF1pWwuUGyak9UFnLGKSo4arR4PYfyJOFjEJ73YZeilwq4d2IowtmZAJ
         JV+cnVN/YDuIs62uqD6WPXOmjjJuacIX3orXxlzkMEBtJwKWbL6Zdf4o1NvFZIgx8zTW
         OCuIm+1+i+IgtJgsvBBZs6i3pjqAM5NXwZmGwcRvaayi9fJkLu3N7XR31ktkEySWqGbF
         MiwyA7MyQdLEQKKUJDggbFUCMx5NsJdfrba+h6rJ4FxatnSDGiQGOozmwDLmRjho2xpP
         dbKx6CG6kks2hdJp4+Isy6CP7BxDFcfv8AUd/NDfOJOq3189XUfWKacI+fDwRZvWgiOs
         Ql8w==
X-Gm-Message-State: ANoB5plNt4dS2hkGmpg1NKPFrYPyaOPtWpVnVWrNnSBZBluA8hhCtaYu
        uNMHLq+EhYoptNzKZuyyhcg=
X-Google-Smtp-Source: AA0mqf5RiOX0iqap5P26/5+nYyoEi+aVfxk3LkMwqqLbV9RwcWTpREzBEmUlTGKM5iKrwmMZGj2R2Q==
X-Received: by 2002:adf:bd93:0:b0:242:62df:9214 with SMTP id l19-20020adfbd93000000b0024262df9214mr25680980wrh.3.1671233436499;
        Fri, 16 Dec 2022 15:30:36 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y12-20020adffa4c000000b002258235bda3sm3364978wrr.61.2022.12.16.15.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:30:35 -0800 (PST)
Date:   Fri, 16 Dec 2022 23:30:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, rust-for-linux@vger.kernel.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH] rust: kernel: drop repetition in offset_of macro
Message-ID: <Y5z/msA6FWH0Bgmq@liuwe-devbox-debian-v2>
References: <20221216174927.1008629-1-wei.liu@kernel.org>
 <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
 <Y5zt9PSUD6d1MTyZ@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5zt9PSUD6d1MTyZ@boqun-archlinux>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 02:15:16PM -0800, Boqun Feng wrote:
> On Fri, Dec 16, 2022 at 06:26:57PM +0000, Wedson Almeida Filho wrote:
> > On Fri, 16 Dec 2022 at 17:49, Wei Liu <wei.liu@kernel.org> wrote:
> > >
> > > It doesn't make sense to allow multiple fields to be specified in
> > > offset_of.
> > 
> > Why do you say it doesn't make sense?
> > 
> > Here's what I had in mind:
> > ```
> >     struct Y {
> >         z: u32
> >     }
> >     struct X {
> >         y: Y
> >     }
> >     offset_of!(X, y.z)
> 
> For me, it's not very obvious that "y.z" is multiples of token trees
> rather a single token tree ;-)
> 
> Maybe some examples of the match pattern of macros can help people catch
> up faster? Like
> 
> 	"y.z" => tt [y], tt [.], tt [z]
> 
> I will defer to Gary or Bjorn for a better quick guide of Rust macros
> ;-)
> 

What will be  even better is someone please contribute such a macro to
libcore so that I don't have to replicate the code snippet everywhere.
:-)

I have a version somewhere, the second argument matches against ident,
which was definitely not as flexible as tt.

Thanks,
Wei.
