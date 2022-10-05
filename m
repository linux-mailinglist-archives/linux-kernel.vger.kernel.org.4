Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555575F4FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJEF7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJEF7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3D726B2;
        Tue,  4 Oct 2022 22:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AF35B81C99;
        Wed,  5 Oct 2022 05:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596D8C433C1;
        Wed,  5 Oct 2022 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664949555;
        bh=rdcGeYveXrfLSgxC/Q9etaEDZo7DlwNvqTXa8Mdp5Tw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N8Q21cLqtl3BSjRJsjsAbi0DBOCH18PFtSTPAlNC8N8YX2EyWuwE/u01rSlwThXmg
         DERA0yS/y14H+ABW/wGhVDW84tAY2u+jflE7QPplqc0DsrOlDLUgB8JsPpeiw/7CE8
         Ey7nyuNUGKm8Yu4tso2is38ZBopPTpPam7TAeg34raw7hkTa7+QpKqKVfSk7/fy5iU
         aIttJGBxomJ+Cn2F6pyoSJSKXJW7JRCU4ZcymAUrm1mw4B1ryq39CrpSli78dMvEpV
         0Mx23guKY7RjvP9pZAzNpbYFqaktYtJMYaWvYr3JJWHf0DESPczs7rVpbao9D13CYY
         /Fx7Q8KdxHKMg==
Date:   Wed, 5 Oct 2022 06:59:09 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 5/5] docs: improve the HTML formatting of kerneldoc
 comments
Message-ID: <20221005065909.33ba2523@sal.lan>
In-Reply-To: <20221004201222.281845-6-corbet@lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
        <20221004201222.281845-6-corbet@lwn.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue,  4 Oct 2022 14:12:22 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Make a few changes to cause functions documented by kerneldoc to stand out
> better in the rendered documentation.  Specifically, change kernel-doc to
> put the description section into a ".. container::" section, then add a bit
> of CSS to indent that section relative to the function prototype (or struct
> or enum definition).  Tweak a few other CSS parameters while in the
> neighborhood to improve the formatting.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/sphinx-static/custom.css | 13 +++++++
>  scripts/kernel-doc                     | 52 ++++++++++++++++----------
>  2 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
> index c465251e840a..d8823fbbd27b 100644
> --- a/Documentation/sphinx-static/custom.css
> +++ b/Documentation/sphinx-static/custom.css
> @@ -10,3 +10,16 @@ div.body h3 { font-size: 130%; }
>  
>  /* Tighten up the layout slightly */
>  div.body { padding: 0 15px 0 10px; }
> +
> +/* Don't force the document width */
> +div.document { width: auto; max-width: 60em; }
> +
> +/*
> + * Parameters for the display of function prototypes and such included
> + * from C source files.
> + */
> +dl.function, dl.struct, dl.enum { margin-top: 2em; background-color: #ecf0f3; }
> +/* indent lines 2+ of multi-line function prototypes */
> +dl.function dt { margin-left: 10em; text-indent: -10em; }
> +dt.sig-object { font-size: larger; }
> +div.kernelindent { margin-left: 2em; margin-right: 4em; }
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index aea04365bc69..13d42857bce2 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -866,48 +866,53 @@ sub output_function_rst(%) {
>  	print "\n";
>      }
>  
> -    print "**Parameters**\n\n";
> +    #
> +    # Put our descriptive text into a container (thus an HTML <div> to help
> +    # set the function prototypes apart.

Nitpick: you forgot to close the parenthesis on your comment ;-)

> +    #
> +    print ".. container:: kernelindent\n\n";

I liked the new alignment: it makes easier to identify what belongs
to each definition block.

As I didn't test the patches, it sounds worth mentioning that it makes
sense to check if this won't badly affect epub and/or LaTeX/PDF outputs.

The LaTeX output generator in particular has a problem with long
lines with fixed-width lines: if the text doesn't fit into one line, it
either truncates it or makes the text go outside the margins.

If the container affects the PDF outputs, we need to double-check if
this would break its output.

Also, when the container directive was introduced? Does it affect
the minimal Sphinx version we support? It seems that this was old
enough to not require any changes at the minimal version, but,
from https://www.sphinx-doc.org/en/master/changes.html, it seems
that LaTeX support for it was added only at Sphinx v4.1 on this PR:

	https://github.com/sphinx-doc/sphinx/pull/9166

So, we need to double-check if are there any changes before and after
such version at the places container is used - or change the kerneldoc
to only emit such tags on PDF depending on the Sphinx version.

Regards,
Mauro
