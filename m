Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD85BB8B2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIQOMD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 17 Sep 2022 10:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIQOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:11:59 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84C32BAF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:11:56 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 2CC67A098E;
        Sat, 17 Sep 2022 14:11:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id CBF4520029;
        Sat, 17 Sep 2022 14:11:52 +0000 (UTC)
Message-ID: <d52110471b332b047777616c762b086ee662225e.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Extend matched name characters in
 maintainers_in_file()
From:   Joe Perches <joe@perches.com>
To:     Janne Grunau <j@jannau.net>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 17 Sep 2022 07:11:52 -0700
In-Reply-To: <20220916084712.84411-1-j@jannau.net>
References: <20220916084712.84411-1-j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: a3wde81h37fa11brnunp4cuarrmyiwtx
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: CBF4520029
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+qnfjlUuy4feuD6GX19kec/WEMt4lpGCs=
X-HE-Tag: 1663423912-80121
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-16 at 10:47 +0200, Janne Grunau wrote:
> Extend the regexp matching name characters to cover Unicode blocks Latin
> Extended-A and Extended-B.
> Fixes 'scripts/get_maintainer.pl -f' for
> 'Documentation/devicetree/bindings/clock/apple,nco.yaml'.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> This still excludes Greek and Cyrilic characters which should be
> expected in names as well. I tried to use '\p{L}' to match all Unicode
> letters but couldn't get it to work. Feel free understand this as bug
> report with an incomplete fix.

Maybe use \p{XPosixAlpha} ?

but I don't know what version of perl introduced this.

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -442,7 +442,7 @@ sub maintainers_in_file {
>  	my $text = do { local($/) ; <$f> };
>  	close($f);
>  
> -	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> +	my @poss_addr = $text =~ m$[A-Za-zÀ-ɏ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;

	my @poss_addr = $text =~ m$[\p{XPosixAlpha}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;

?

>  	push(@file_emails, clean_file_emails(@poss_addr));
>      }
>  }
> @@ -2460,7 +2460,7 @@ sub clean_file_emails {
>  	    $name = "";
>  	}
>  
> -	my @nw = split(/[^A-Za-zÀ-ÿ\'\,\.\+-]/, $name);
> +	my @nw = split(/[^A-Za-zÀ-ɏ\'\,\.\+-]/, $name);

Maybe here too

> +	my @nw = split(/[^\p{XPosixAlpha}\'\,\.\+-]/, $name);

Dunno haven't tested.  Maybe you care to test?

