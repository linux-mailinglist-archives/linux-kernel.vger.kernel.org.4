Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB07252D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjFGE12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjFGE0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2091FD7;
        Tue,  6 Jun 2023 21:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0446463A10;
        Wed,  7 Jun 2023 04:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE47C433EF;
        Wed,  7 Jun 2023 04:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686111822;
        bh=7sP96yW6yc29Ckr2GzZEmGrtPlO4yW5CLupbhWesCjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DiIynji1RhG+2QeeyvmhHbOno6Sf1ehLKKPh4D68VDruy2w3ooysdrKASf+z6UGoU
         Ojcfzah5qzg6fTfj3JKiSHkpBgxECJS0H9XspVRQ77a+KwZVoc84jTBQP2kxI7EJdq
         8UIprPkCU5ZKZeeZ2RvJ9Nwl+R7k78kMMerb+DOyIKtJG4ugllMGFmA6XTyKIh+35W
         OO+BIePAbHh3N29muyQJwGaMCacx3VnomE3Gw+ABC5fR3F/lt8JoAg9Aeyn2sJqLC0
         9b7IQsKlGBz9cYbtOL6X+ogSl8dnU+1Eeqw3cd0bh2vjps9Z/C7CWk5k0UZOWPqDfW
         3pnOpfnstswPA==
Date:   Tue, 6 Jun 2023 21:23:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] uml: Replace strlcpy with strscpy
Message-ID: <20230607042340.GA941@sol.localdomain>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:08:27PM -0400, Azeem Shaikh wrote:
> On Tue, Jun 6, 2023 at 4:51 PM Richard Weinberger <richard@nod.at> wrote:
> >
> > ----- Ursprüngliche Mail -----
> > > Von: "Azeem Shaikh" <azeemshaikh38@gmail.com>
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > > No return values were used, so direct replacement is safe.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > > [2] https://github.com/KSPP/linux/issues/89
> > >
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
> >
> > Are you sure Reported-by and Closes make sense?
> > AFAIK the report was only on your first patch and nothing against upstream.
> > So stating this in the updated patch is in vain.
> 
> I left the metadata in only for the sake of posterity. If it's not
> helpful, I'm ok with removing it.
> 

IMO using Reported-by in cases like this is harmful, as it makes commits seem
like bug fixes when they are not.

- Eric
