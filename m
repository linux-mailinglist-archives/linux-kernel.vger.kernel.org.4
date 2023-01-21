Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4F676356
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjAUDVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:21:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EFC6AF45;
        Fri, 20 Jan 2023 19:21:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64644B82B5A;
        Sat, 21 Jan 2023 03:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75AEC433EF;
        Sat, 21 Jan 2023 03:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674271290;
        bh=7HKttIoLxU4yocuSM9Y6EYthAcaeTcSiA9+df6JTQ3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvUX9QogTssy33Q3bnSUBLs2qoyUoPXmcSbmY4rNVxHl5FKoZ7JaO92WJnvVkUtji
         RNUVywxMKObnWvFMugNnX2wC6swGBb9rXYeqqRpB/Xr3ClK3M7AWyzgds/gd3a2TiJ
         oR84pWAjHkO7LpoYkcayBIsS+jWjBZl6FMjC7yJXlVpwoUdd++/QMMpEF+XOaL/nZa
         Lrw8ONilyf+GV86bUwSL2KA7gSMAwseWMuKCMrLRHVcuujvIOQhi5p7uPIGvnRqm4N
         ZCXwX72ar7vQmTsSqLuGF9GoJhi1BWkO6lEXhVbOJd9yC+GGLL/6uHl4fEfKEoVyxF
         2I6G5yDiN7p9A==
Date:   Sat, 21 Jan 2023 03:21:27 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH] certs: Reference revocation list for all keyrings
Message-ID: <Y8taNx6k/hQEeoGL@kernel.org>
References: <20230117171506.3888602-1-eric.snowberg@oracle.com>
 <Y8taCkDpji8AGCUc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8taCkDpji8AGCUc@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 03:20:46AM +0000, Jarkko Sakkinen wrote:
> On Tue, Jan 17, 2023 at 12:15:06PM -0500, Eric Snowberg wrote:
> > Systems booted with shim have a Forbidden Signature Database called mokx.
> > During boot, hashes and certs contained within the mokx are loaded into the
> > blacklist keyring.  When calling verify_pkcs7_message_sig the contents of
> > the blacklist keyring (or revocation list) are referenced when validating
> > keys on the platform keyring. Currently, when validating against the
> > secondary or builtin keyrings, the revocation list is not referenced.  Move
> > up the check to allow the revocation list to be used with all keyrings,
> > including the secondary and builtin, allowing the system owner to take
> > corrective action should a vulnerability be found within keys contained
> > within either keyring.
> > 
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > ---
> >  certs/system_keyring.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > index 5042cc54fa5e..865a0510fdeb 100644
> > --- a/certs/system_keyring.c
> > +++ b/certs/system_keyring.c
> > @@ -243,6 +243,12 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
> >  	if (ret < 0)
> >  		goto error;
> >  
> > +	ret = is_key_on_revocation_list(pkcs7);
> > +	if (ret != -ENOKEY) {
> > +		pr_devel("PKCS#7 key is on revocation list\n");
> > +		goto error;
> > +	}
> > +
> >  	if (!trusted_keys) {
> >  		trusted_keys = builtin_trusted_keys;
> >  	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
> > @@ -262,12 +268,6 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
> >  			pr_devel("PKCS#7 platform keyring is not available\n");
> >  			goto error;
> >  		}
> > -
> > -		ret = is_key_on_revocation_list(pkcs7);
> > -		if (ret != -ENOKEY) {
> > -			pr_devel("PKCS#7 platform key is on revocation list\n");
> > -			goto error;
> > -		}
> >  	}
> >  	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
> >  	if (ret < 0) {
> > -- 
> > 2.27.0
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Should I pick this?

BR, Jarkko
