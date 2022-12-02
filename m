Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B0963FEDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiLBDcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiLBDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:32:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69ADA20C;
        Thu,  1 Dec 2022 19:32:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A100B8201F;
        Fri,  2 Dec 2022 03:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9403DC433D7;
        Fri,  2 Dec 2022 03:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669951933;
        bh=TzW6W5n83OUhOwvDj7dVuruK703j88Q3wD8ZFJxahUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BovuxiCSMtogBUe/MBKnqXMCKjOId+m+hb2B14Zl610M6z2RiDdX4toN2rh2Iwj3f
         lqeChZsy+c9sUV5DwxxTyK9DyDnEvRetLxLLNZ4ZsA/L6zl+adZpKMoR1RC5kvRau7
         cIxP3XY0fd0zXLDGok2JqSfL4iM9YVtRghip3a+RXFZbqh4smOnMujM4xsRmjipt9D
         mbffXasJG4a/UuK4tE1XH3BVUuo3zdgL+cwHs2zk//m2J7R/W12+47kdLucPJpvoms
         58CDyTEZAMJ6S8dDriryA7wL/9nhRh3JfdzfO40YJzhswslBa2R28PBOz5l6h1MtoY
         xrCW5/fmUSYZw==
Date:   Thu, 1 Dec 2022 19:32:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] crypto/caam: Avoid GCC constprop bug warning
Message-ID: <Y4lxu+6BQJ5uVhCg@sol.localdomain>
References: <20221202010410.gonna.444-kees@kernel.org>
 <Y4ludwin631WFhcG@sol.localdomain>
 <202212011920.A6648E9B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212011920.A6648E9B@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 07:23:49PM -0800, Kees Cook wrote:
> I think it's a dumb
> limitation, given that "zero size to/from NULL" is perfectly valid.

No, that is undefined behavior.  Which is presumably the reason for the nonnull
annotation.  Anyway, it is silly, which is why I'd hope that someone would have
added an option to disable this C standard bug by now...

- Eric
