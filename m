Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50D7437D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjF3JAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjF3JAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:00:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1335AF;
        Fri, 30 Jun 2023 02:00:30 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 551941EC0501;
        Fri, 30 Jun 2023 11:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688115628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hZMHH8pu7rhqnk3PLU2+GsJL8/Mpq9/OnjuGLflZf1w=;
        b=QsDm3nErQmugfmCsy5k2B4iutiY5SN1hbJPQx5PADcly28eAVUo7k3bDPSeB/oMPyqbtKN
        C/Gi6kG4WeQBRCvqDFVWxoQTn6GoOkO4oXwzz7ZpwogooOYC9r0bDMk/nuTxOEgA4CgR8n
        PtqvoVUsH4b5tFEIKnqKKgqAxOlttQg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NRv18FGgyF0D; Fri, 30 Jun 2023 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688115625; bh=hZMHH8pu7rhqnk3PLU2+GsJL8/Mpq9/OnjuGLflZf1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hO3Gq70B0PN0rfcfhEqyeweecEVfEYj9MSX0MXIEMA1j3sPZ9zJs6f3bI+nTAsiW0
         WffYcGWMtbkenbmMhsVPG4uuAZH87QVfdnjwV59knvOisToZUyK0xvUntdw96dI26k
         jLPiB4ML/nv/hm4wd2Duow+uO2Ck9OFpvV1kZdQUDUujc60Bt8VccYkbewTTUgR8pp
         VOEBHc6+24MuvfeFkxaooZqXJdSRSkir46rHX84vgKmWB0PlrhhegjRZDKYD2djZ81
         +0bGh8imo6hwWpe65UDC6LlOPHRp/9E704NnqTFJmBUqaabZkwZL9S7DXQzJVQNNgK
         X05V/4Kg95m9clvPS5RtrEcKwAvT9hRiq+tcUmqYBu/aa9BqG1yceorm66W6N1e6Xy
         aSy9885RuwT5CqKKcubBI5UbkSYh09ACBL/TVn+ykErWemI+bN/oC9lfkpQGOK0Z/K
         WPWONgMiw+MXoaEccwr1VyXtAX3tb82hkZTvmqnaJAFx0OnW0aMVgdkO0gFQU+qBZH
         6ojtyxfvsiB2diYJj0d1pXw0ozzLxtkS61C+kakNs+n586lS6EFIYsAyxbH/muT+t4
         8X+Mxr3+tWpQmMEZGLlw9dfnHAnlhnHTs5EQ7OIImFhjyBcFHoZga7RChany84dhGu
         JQ65SOdA1y89x4GQndEIKvtQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0845D40E0034;
        Fri, 30 Jun 2023 09:00:20 +0000 (UTC)
Date:   Fri, 30 Jun 2023 11:00:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: clean out
 empty and unused entries
Message-ID: <20230630090014.GAZJ6ZnrWJUfPOB53N@fat_crate.local>
References: <2023062742-mouse-appease-7917@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023062742-mouse-appease-7917@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:26:43PM +0200, Greg Kroah-Hartman wrote:
> There are a few empty entries in the company/project list, which
> confuses people as to why they are there, so remove them entirely, and
> also remove an entry that doesn't wish to participate in this process.
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index df978127f2d7..81a8fb0862a4 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -244,7 +244,6 @@ disclosure of a particular issue, unless requested by a response team or by
>  an involved disclosed party. The current ambassadors list:
>  
>    ============= ========================================================
> -  AMD		Tom Lendacky <thomas.lendacky@amd.com>

Can we please not remove Tom?

We are clarifying the process offlist as both Greg and Thomas know and
AMD is very much interested in participating in and adhering to the
embargoed process.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
