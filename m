Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15E6B6B07
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjCLUYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCLUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:24:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0A30E83;
        Sun, 12 Mar 2023 13:24:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6187F378;
        Sun, 12 Mar 2023 20:24:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6187F378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678652667; bh=V/KWNgEZs2vPskiUhuNTMjyJGSUiW+kmy4dOXU4hLaA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GYWa/O3oPYnLQQEORcSIiOwUHjqSygk0BM4koR4rkPZe8mh3d3aGDfjMaG30/zNpv
         bwUiZ2REvlP+V5FRwAbHY+fPfpqD2mSlokCiN9c5MFR4ONHHuHxebOO1+5Tu7Hsc5q
         axPiSeHCXKOGAQKNdSvP2/PlzSJlwKzBlEFuzvOmgIOxdQEbIyHd11F7EfQjNFjojQ
         k370p8nWOiTK4DcJHjlu8btrVNzsufFk4qu616K9XtimR1ShJvdxp2gzpe8PLObyFW
         1y9/VXzgc+M5hgPWv19ygSF1OPXY4A1kxiIhNZPa6/oz1txwQj2rMRFI1htuhtxGg5
         Y4miuLKjDvnoA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Stringer <joe@isovalent.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-doc] docs/doc-guide: Clarify how to write tables
In-Reply-To: <20230312201712.367545-1-joe@isovalent.com>
References: <20230312201712.367545-1-joe@isovalent.com>
Date:   Sun, 12 Mar 2023 14:24:26 -0600
Message-ID: <875yb5wwed.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Stringer <joe@isovalent.com> writes:

Thanks for working to improve the docs...I have a couple of questions,
though.

> Prior to this commit, the kernel docs writing guide spent over a page
> describing exactly how *not* to write tables into the kernel docs,
> without providing a example about the desired format.
>
> This patch provides a positive example first in the guide so that it's
> harder to miss, then leaves the existing less desirable approach below
> for contributors to follow if they have some stronger justification for
> why to use that approach.

There's all kinds of things you can do in RST, but we've deliberately
not tried to create a new RST guide in the kernel docs.  I'm not sure
that tables merit an exception to that?  If people really need help,
perhaps a link to (say)

  https://docutils.sourceforge.io/docs/user/rst/quickref.html#tables

would suffice?

> Signed-off-by: Joe Stringer <joe@isovalent.com>
> ---
>  Documentation/doc-guide/sphinx.rst | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 23edb427e76f..9c2210b6ea3f 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -313,9 +313,25 @@ the documentation build system will automatically turn a reference to
>  function name exists.  If you see ``c:func:`` use in a kernel document,
>  please feel free to remove it.
>  
> +Tables
> +------
> +
> +Tables should be written in cell grid form unless there is a strong
> +justification for using an alternate format:
> +
> +.. code-block:: rst
> +
> +   +------------------------+------------+----------+----------+
> +   | Header row, column 1   | Header 2   | Header 3 | Header 4 |
> +   | (header rows optional) |            |          |          |
> +   +========================+============+==========+==========+
> +   | body row 1, column 1   | column 2   | column 3 | column 4 |
> +   +------------------------+------------+----------+----------+
> +   | body row 2             | ...        | ...      |          |
> +   +------------------------+------------+----------+----------+

...and if they do merit an exception, why would we prefer the full grid
format (which is harder to create and maintain) than the simple table
format?  Most of the time, the simple format can do what's needed, and I
don't think it's less readable.

Thanks,

jon
