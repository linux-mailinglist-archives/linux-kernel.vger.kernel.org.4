Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9385E5F8B2B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJIMYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIMYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:24:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5982329CBE;
        Sun,  9 Oct 2022 05:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06FEDB80D29;
        Sun,  9 Oct 2022 12:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAE4C433D6;
        Sun,  9 Oct 2022 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665318240;
        bh=iogJFBqB7jc4F+XVnYjM6BUUDezLjY2DcrEm4bPESgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ua9DhOLcJzbvLzby5YSvCSqfL3MzYlHsOag8txGEtxnvsuaE/cFFo4TYbxm3FbOSp
         PltcyLFijYDak5JsCmvxU9vespl9363ua73fZ0Gfke1arbk6VESCZqy2jpwlxaoQxa
         6+NvinTaTrx3Ot1WC2HmXxOiM6YwC9Jm7K6qpCIdUx2+qsM/qitxD2t+dbmC0XtRbv
         iVVxJs2VsI4wx6Fht0+DVdy8uSuu5pTQiPT29L9jK4viLDdPJbLqJfkVVXP2K5E8PW
         /nruWSBr4oSKyzyTY3xR3RmQEFT4NFb/wfSj+uihRtVOhvXQ5FZ3y1t/fu8J0d6+40
         so2RVUM8dTMtQ==
Date:   Sun, 9 Oct 2022 13:24:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] regulator: Add devm helpers for get and
 enable
Message-ID: <20221009132421.6e472385@jic23-huawei>
In-Reply-To: <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
        <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 6 Oct 2022 19:17:39 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Oct 06, 2022 at 05:36:52PM +0300, Matti Vaittinen wrote:
> > A few regulator consumer drivers seem to be just getting a regulator,
> > enabling it and registering a devm-action to disable the regulator at
> > the driver detach and then forget about it.
> > 
> > We can simplify this a bit by adding a devm-helper for this pattern.
> > Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()  
> 
> ...
> 
> > (cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)  
> 
> Not sure:
>  - why this is in the commit message
>  - what it points to, since
> $ git show b6058e052b842a19c8bb639798d8692cd0e7589f
>  fatal: bad object b6058e052b842a19c8bb639798d8692cd0e7589f

These are now upstream in Linus' tree and in my testing branch.
I'd not normally advocate working on top of that (because I rebase it), but
if it is useful for this series go ahead.

Jonathan
 
> 
> > Already in Mark's regulator tree. Not to be merged. Included just for
> > the sake of the completeness. Will be dropped when series is rebased on
> > top of the 6.1-rc1  
> 
> Ah, I see, but does it mean the commit has been rebased or you used wrong SHA?
> 
> ...
> 
> > +static void regulator_action_disable(void *d)
> > +{
> > +	struct regulator *r = (struct regulator *)d;  
> 
> Cast is not needed.
> 
> > +	regulator_disable(r);
> > +}  
> 

