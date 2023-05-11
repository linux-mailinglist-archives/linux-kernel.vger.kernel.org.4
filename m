Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454FF6FEE10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjEKIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEKIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:52:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849DF7;
        Thu, 11 May 2023 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683795165; x=1715331165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sA6r4ztuDtSV/drVYgGMTHrFo41zvPrwRt4BVErTnkw=;
  b=Odg5hbK/NCaQCL7DJwLRBKxkLW15+F8iC6hwrgLGCzBYgXE0WbtwmG5J
   qodAdZFo6X1Cbmvde6Zcchh9rYfjJ04nYSkzR6WpmEGOKiasz+CG1RuN5
   nvNw5adTiXq9X/yjWyLgV56GeFb2HjRJrglvk6WH57znxMeStOjnhplyf
   Q10dHGSLm4ic3jLqnEMLterbGKPJKuDYFuTEObckHN0otI2sXWSxqUzzs
   mdAtnWM9GUFgZfc4z2GJ2tg6k9LoxNQ7MINo77blNWzZ9l7hk4WXL9bGd
   Y8Pyz4j0k2GU9grN8I2jzh6ZplYqpHI6zqzd1cECtXimCT/nxYeIDn0cK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="334922135"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="334922135"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 01:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="946056206"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="946056206"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2023 01:51:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BB6A11FC; Thu, 11 May 2023 11:51:54 +0300 (EEST)
Date:   Thu, 11 May 2023 11:51:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, USB list <linux-usb@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: make localmodconfig doesn't work for thunderbolt
Message-ID: <20230511085154.GQ66750@black.fi.intel.com>
References: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 10, 2023 at 01:00:54PM +0200, Jiri Slaby wrote:
> Hi,
> 
> if I use localmodconfig for example like this:
> mkdir /tmp/tb/
> echo thunderbolt >/tmp/tb/lsmod
> make O=/tmp/tb LSMOD=/tmp/tb/lsmod localmodconfig
> 
> I get:
> using config: '.config'
> thunderbolt config not found!!
> 
> $ grep 'USB4\>' /tmp/tb/.config
> # CONFIG_USB4 is not set
> 
> I believe it's due to:
>   obj-${CONFIG_USB4} := thunderbolt.o
> in drivers/thunderbolt/Makefile. I.e. ${} used instead of more common $().
> 
> But even if I change the parser:
> 
> --- a/scripts/kconfig/streamline_config.pl
> +++ b/scripts/kconfig/streamline_config.pl
> @@ -317,7 +317,7 @@ foreach my $makefile (@makefiles) {
>         $_ = convert_vars($_, %make_vars);
> 
>         # collect objects after obj-$(CONFIG_FOO_BAR)
> -       if (/obj-\$\((CONFIG_[^\)]*)\)\s*[+:]?=\s*(.*)/) {
> +       if (/obj-\$[({](CONFIG_[^})]*)[)}]\s*[+:]?=\s*(.*)/) {
>             $var = $1;
>             $objs = $2;
> 
> 
> I see:
> module thunderbolt did not have configs CONFIG_USB4
> 
> and:
> $ grep 'USB4\>' /tmp/tb/.config
> # CONFIG_USB4 is not set
> 
> So two questions:
> 1) is ${} supported and should be the above change sent as a patch? Or
> should be drivers/thunderbolt/Makefile fixed to use $(). (And maybe other
> Makefiles too.)

The streamline_config.pl mentions use of ${} in comments itself:

# add to the configs hash all configs that are needed to enable
# a loaded module. This is a direct obj-${CONFIG_FOO} += bar.o
# where we know we need bar.o so we add FOO to the list.

So I think it should be made to support this.

> 2) how to fix that 'thunderbolt did not have configs'?

There are bunch of other symbols that generate the same (after the above
fix from you), not just Thunderbolt so figuring that out and fix would
be the way forward I think. However, my perl skills are are not up to
this task at the moment. I can take a look but cannot promise that I
figure a solution.
