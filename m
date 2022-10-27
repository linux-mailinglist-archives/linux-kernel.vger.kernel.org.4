Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C060F94D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiJ0Ni4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiJ0Nip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:38:45 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684D181970
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:38:37 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 3359 invoked from network); 27 Oct 2022 15:38:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1666877914; bh=AiyMaUpIR3tX5cAsNQr2RN+63d1dCIMTRTaZHBEfWHM=;
          h=From:To:Cc:Subject;
          b=A4ddB9/e9xR5YNHXLbm6oGdFeCrlfJSzUwNZn9kGG6X4Na8j+65W1HHtTMIqtPXXf
           j70SbCwn6JpOQNGwahlkUwP6mXUfxMl3XV/z4eMc/qJWV3wJ5blNnZIlp4ctRffD6/
           Ow6HoSaOvVJ1BDoGCrWFVgJAJ55YtEFnZYBrd8pw=
Received: from 89-64-7-202.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.7.202])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <joe@perches.com>; 27 Oct 2022 15:38:34 +0200
Date:   Thu, 27 Oct 2022 15:38:34 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: checkpatch: allow case x: return #x macros
Message-ID: <20221027133834.GA161407@wp.pl>
References: <20221027104934.160513-1-stf_xl@wp.pl>
 <8064d49ffca92adc171f6a954ad9dea2027b8e4d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8064d49ffca92adc171f6a954ad9dea2027b8e4d.camel@perches.com>
X-WP-MailID: 6d99d22315aa28265f775ffa1ef75a40
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YXP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 04:15:53AM -0700, Joe Perches wrote:
> On Thu, 2022-10-27 at 12:49 +0200, Stanislaw Gruszka wrote:
> > Do not report errors like below:
> > 
> > ./scripts/checkpatch.pl -f drivers/net/wireless/ath/ath10k/wmi.h
> > 
> > ERROR: Macros with complex values should be enclosed in parentheses
> > +#define C2S(x) case x: return #x
> > 
> > since "case x: return #x" macros are already used by some
> > in-kernel drivers.
> > 
> > Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> > ---
> >  scripts/checkpatch.pl | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 1e5e66ae5a52..4b888b1313d5 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -5901,6 +5901,7 @@ sub process {
> >  			    $dstat !~ /$exceptions/ &&
> >  			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
> >  			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
> > +			    $dstat !~ /^case\s*$Ident:\s*return\s*#$Ident$/ &&		# case x: return #x
> 
> I think there needs to be a \s+ not \s* after return
> 
> And try this grep and see how many of these are handled
> 
> $ git grep -P -n '^\s*#\s*define.*\bcase.*#'
> 
> It may be better to just use
> 
> 			    $dstat !~ /^case\b/ &&

Make sense, I'll send v2.

Thanks
Stanislaw
