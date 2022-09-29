Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8575A5EEC76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiI2D3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiI2D33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:29:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1494E10C7A4;
        Wed, 28 Sep 2022 20:29:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28T3TBwC018263
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 23:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664422153; bh=TRSL2t4DwLkaCnpc4HSshjbsEcacNr1HHbEImcnj6YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=mbu/LqXAS9v+wyQBaICa6onb7HRnsq9Nanc9fD6PAHFNu+SvvWMsD30yQzK2SkE+z
         OPWFeUYOb9bBjwqwFVMCk4gk9lEa5i4+QQhBWwwJzIRNdtCS8ZzaCE09wsd4oH3zDz
         pkk1wicmzP5CxjoiRB2jQB2R0wVvDK+9x2qvfmGUVfAGGj/4FLMUZxmI70QN0uRKWU
         Kc6ORlKXtGbitoEKMj8T7qlqCucNpmltOh0P3B+rKUNdqeNKQQ9YN4eh4T2koC6Rki
         1/ASrIu8C39tZtaFlmh0AdbFydftHz4j1h7PxWzWWpsrit+cXDb5rqlIfszlNIxGgD
         gnPYSU1pAoHxw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0663F15C00C9; Wed, 28 Sep 2022 23:29:11 -0400 (EDT)
Date:   Wed, 28 Sep 2022 23:29:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] get_maintainer: Describe supporters and
 maintainers as required email recipients
Message-ID: <YzURBpkWU1hHM7rN@mit.edu>
References: <20220929002500.283481-1-bryan.odonoghue@linaro.org>
 <20220929002500.283481-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929002500.283481-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:24:59AM +0100, Bryan O'Donoghue wrote:
> The output of get_maintainer.pl doesn't make clear that a supporter is a
> type of maintainer who should be mailed when generating a patch.
> 
> In various places in the documentation we make reference to the necessity
> to remember to include the appropriate maintainers when sending your patch
> but, we confusingly don't call out supporters as maintainers in our
> automation utility.
> 
> Fix that up now by having get_maintainers.pl print 'maintainer[volunteer]'
> or 'maintainer[supporter]'.

I really don't think this is correct.  Or at least, I don't think it's
consistent with how we've historically understood the S: term in the
MAINTAINERS file.  First of all, the Status field is a property of the
*subsystem*, not of the *maintainer*.

	S: *Status*, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.
	   Odd Fixes:	It has a maintainer but they don't have time to do
			much other than throw the odd patch in. See below..
	   Orphan:	No current maintainer [but maybe you could take the
			role as you write your new code].
	   Obsolete:	Old code. Something tagged obsolete generally means
			it has been replaced by a better system and you
			should be using that.

There are also plenty of projects which are marked "Maintained" where
one or more the maintainers are paid to support that subsystem (while
others might be volunteers).

So to have get_maintainers.pl print that someone is a
maintainer[volunteer] versus maintainer[supporter] is going to be
highly misleading.  What if one of the maintainers is paid by some
larger company (say, Google or Facebook or Red Hat), while the other
maintainer is a hobbists?  And what for the maintainer who is paid by
a large company, there are multiple levels of "supported".  They might
be allowed to spend up to 50% of the paid time working on upstream
work.  Does that make them a "supported" or a "volunteer"?  And how
should the subsystem's S: be marked?

I understand that get_maintinaer.pl has had this get_maintainer_role
function for a long time; it's not been introduced by this patch.  But
I'd suggest that we not try to make a distinction between a subsystem
which is "Supported" versus "Maintained", and certainly we should not
be treating an attribute of the subsystem as being attached to all of
the entities listed under M:.  That is really a category error, IMHO.

    	     	    	       	       - Ted
