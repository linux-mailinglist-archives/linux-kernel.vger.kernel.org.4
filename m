Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803366C8530
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCXSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjCXSdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:33:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A00021974;
        Fri, 24 Mar 2023 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=02cnyqnaBRGJYxnh7ZSFXvWj6btW47f9AiZCeVuZ/Rk=; b=R26mIW3QoIbL53bM2/5dxMFu6y
        j2NgQUpK0QcAJPYCSRVn97Ez9pu5YnSwUPZK/Npk0aFiAl8Fr/nbymDIEFPH0sHf2VrRGy6bmzOiE
        CXrWCJo2psL1IwTIPymLY4huLxYTzS9ZerytelYcgx3cUux/QteJoOn0F3ToD2llHMiyuCVgpFL1H
        EiDggCINc77IwZKqxN6r5d4C16KhT62J3Pdqc3qRfYCLTiYRsW6HDCoOumWeUttxAMbFm9M9FGzbe
        ZUmvzNzJJrfHg6l4Bax54yCfm+t0w0T/87p9nzUzLOfZZKR+djBSpN8AvS6ZVzW9ccxapBQb4Bquy
        2AhLNENg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfmEC-005KSB-2H;
        Fri, 24 Mar 2023 18:33:28 +0000
Date:   Fri, 24 Mar 2023 11:33:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     christophe.leroy@csgroup.eu, song@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, prarit@redhat.com
Subject: Re: [PATCH 04/12] module: move early sanity checks into a helper
Message-ID: <ZB3s+Hn2j6HMIe+m@bombadil.infradead.org>
References: <20230319212746.1783033-1-mcgrof@kernel.org>
 <20230319212746.1783033-5-mcgrof@kernel.org>
 <71176c99-cacb-9a7a-0b4a-9e2c5cb1c3b5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71176c99-cacb-9a7a-0b4a-9e2c5cb1c3b5@suse.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:02:06PM +0100, Petr Pavlu wrote:
> On 3/19/23 22:27, Luis Chamberlain wrote:
> > Move early sanity checkers for the module into a helper.
> > This let's us make it clear when we are working with the
> > local copy of the module prior to allocation.
> > 
> > This produces no functional changes, it just makes subsequent
> > changes easier to read.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  kernel/module/main.c | 43 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 427284ab31f1..933cef72ae13 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2668,6 +2668,31 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
> >  	return 0;
> >  }
> >  
> > +/* Module within temporary copy, this doesn't do any allocation  */
> > +static int early_mod_check(struct load_info *info, int flags)
> > +{
> > +	int err;
> > +
> > +	/*
> > +	 * Now that we know we have the correct module name, check
> > +	 * if it's blacklisted.
> > +	 */
> > +	if (blacklisted(info->name)) {
> > +		pr_err("Module %s is blacklisted\n", info->name);
> > +		return -EPERM;
> > +	}
> > +
> > +	err = rewrite_section_headers(info, flags);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Check module struct version now, before we try to use module. */
> > +	if (!check_modstruct_version(info, info->mod))
> > +		return ENOEXEC;
> 
> The error value when check_modstruct_version() fails is changed in this patch
> from -ENOEXEC to ENOEXEC and updated back again in the next patch. It would be
> good to avoid introducing this temporary problem and keep the value throughout
> as -ENOEXEC.

Fixed, thanks.

  Luis
