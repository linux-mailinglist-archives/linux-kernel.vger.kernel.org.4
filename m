Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C65730629
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjFNRjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjFNRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A220E43
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D1B964526
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA630C433CA;
        Wed, 14 Jun 2023 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686764334;
        bh=yR02GLqLTyIWX9U99iZ0NmxdvKpsBgaVyJ69Zs8coD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E+mqqpXDrfi0M5vMnMyDyCaP4VXNq5VjGypXXs4eNB/nF3EBHBxrSKnACgKw8tACV
         bGSmC9YtfOeKezRJYRBHDUKFAI6MKLNrN38mpmDFp6LmrrdAhs6OWK8wNGVGqzPDww
         jXnY5RwyBy3XLNuPl4CO+ktqjzVcBgjK+0Npg47EtHpKPTzNUmpEGJ8uT7bmUaDlK3
         Kj949YVplhBwd95vrgIdkkdU/NxOLOJ/FoZlPuNz3GX+CHJ8Lt4AjilkqAOVJDncjt
         KelZFaQwoq8sXgj9hQj4Hf7G2O87JSpnb4Lb1A6pjz+fIdV7/lDVxwf0nUYRkiB/Ow
         MPj9kyHLTPo7A==
Date:   Wed, 14 Jun 2023 10:38:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH net-next] tools: ynl-gen: generate docs for
 <name>_max/_mask enums
Message-ID: <20230614103852.3eb7fd02@kernel.org>
In-Reply-To: <DM6PR11MB46570AEF7E10089E70CC1D019B5AA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230613231709.150622-1-arkadiusz.kubalewski@intel.com>
        <20230613231709.150622-3-arkadiusz.kubalewski@intel.com>
        <20230613175928.4ea56833@kernel.org>
        <DM6PR11MB46570AEF7E10089E70CC1D019B5AA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 12:48:14 +0000 Kubalewski, Arkadiusz wrote:
> >From: Jakub Kicinski <kuba@kernel.org>
> >Sent: Wednesday, June 14, 2023 2:59 AM
> >
> >On Wed, 14 Jun 2023 01:17:09 +0200 Arkadiusz Kubalewski wrote:  
> >> Including ynl generated uapi header files into source kerneldocs
> >> (rst files in Documentation/) produces warnings during documentation
> >> builds (i.e. make htmldocs)
> >>
> >> Prevent warnings by generating also description for enums where
> >> rander_max was selected.  
> >
> >Do you reckon that documenting the meta-values makes sense, or should
> >we throw a:
> >
> >/* private: */
> >  
> 
> Most probably it doesn't..
> Tried this:
> /*
>  [ other values description ]
>  * private:
>  * @__<NAME>_MAX
>  */
> and this:
> /*
>  [ other values description ]
>  * private: @__<NAME>_MAX
>  */
> 
> Both are not working as we would expect.
> 
> Do you mean to have double comments for enums? like:
> /*
>  [ other values description ]
>  */
> /*
>  * private:
>  * @__<NAME>_MAX
>  */
>
> >comment in front of them so that kdoc ignores them? Does user space
> >have any use for those? If we want to document them...
> 
> Hmm, do you recall where I can find proper format of such ignore enum comment
> for kdoc generation?
> Or maybe we need to also submit patch to some kdoc build process to actually
> change the current behavior?

It's explained in the kdoc documentation :(
https://docs.kernel.org/doc-guide/kernel-doc.html#members
