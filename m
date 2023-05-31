Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC17175CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjEaElc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEaEla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A79D;
        Tue, 30 May 2023 21:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4483960F08;
        Wed, 31 May 2023 04:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7EBC433EF;
        Wed, 31 May 2023 04:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685508086;
        bh=X8DzOtFm5APJJSt0+uSAaCUWMDRz0NNoyEHRZnPXbLg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=sjFf/DrmDfOeiFUCGHnSSSEe7+oPXj6nFGtGpi+KZpxDPoRvcePXtlx3f2wo1Oj6q
         jg9F/QJsRufCCiGIiPNSugaaBgGxQLUMUNnBCW33vuRySPsVugKnd9WULNGwLF18t2
         lCRRv0iYflYSCyKT2uR71JNlTrRUrc7sIUxNiHum7CVprq0idDPmjeuuWafT9CzRvf
         7wDU5aZzcR+gss5za+wvczpmOHLgYQvRGggIwgqIpMNBl89h/i36d9J2w63de/pwAh
         YiIF+rJA5vtXEH80wyrWKIve83+JwHTGrkNvDK3bNZfNxddv9euIm1JlQBoBmNsb8d
         9EOtKn3cHGlNg==
Date:   Tue, 30 May 2023 21:41:25 -0700
From:   Kees Cook <kees@kernel.org>
To:     kernel test robot <lkp@intel.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>
CC:     oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
User-Agent: K-9 Mail for Android
In-Reply-To: <202305311135.zGMT1gYR-lkp@intel.com>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com>
Message-ID: <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2023 8:18:42 PM PDT, kernel test robot <lkp@intel=2Ecom> wrote:
>Hi Azeem,
>
>kernel test robot noticed the following build errors:
>
>[auto build test ERROR on uml/next]
>[also build test ERROR on uml/fixes wireless-next/main wireless/main linu=
s/master v6=2E4-rc4 next-20230530]
>[If your patch is applied to the wrong git tree, kindly drop us a note=2E
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm=2Ecom/docs/git-format-patch#_base_tree_information]
>
>url:    https://github=2Ecom/intel-lab-lkp/linux/commits/Azeem-Shaikh/uml=
-Replace-all-non-returning-strlcpy-with-strscpy/20230531-004115
>base:   git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/uml/linux next
>patch link:    https://lore=2Ekernel=2Eorg/r/20230530164004=2E986750-1-az=
eemshaikh38%40gmail=2Ecom
>patch subject: [PATCH] uml: Replace all non-returning strlcpy with strscp=
y
>config: um-i386_defconfig (https://download=2E01=2Eorg/0day-ci/archive/20=
230531/202305311135=2EzGMT1gYR-lkp@intel=2Ecom/config)
>compiler: gcc-12 (Debian 12=2E2=2E0-14) 12=2E2=2E0
>reproduce (this is a W=3D1 build):
>        # https://github=2Ecom/intel-lab-lkp/linux/commit/c51d7beb37cfbda=
321feb3811bbe0e381f804899
>        git remote add linux-review https://github=2Ecom/intel-lab-lkp/li=
nux
>        git fetch --no-tags linux-review Azeem-Shaikh/uml-Replace-all-non=
-returning-strlcpy-with-strscpy/20230531-004115
>        git checkout c51d7beb37cfbda321feb3811bbe0e381f804899
>        # save the config file
>        mkdir build_dir && cp config build_dir/=2Econfig
>        make W=3D1 O=3Dbuild_dir ARCH=3Dum SUBARCH=3Di386 olddefconfig
>        make W=3D1 O=3Dbuild_dir ARCH=3Dum SUBARCH=3Di386 SHELL=3D/bin/ba=
sh
>
>If you fix the issue, kindly add following tag where applicable
>| Reported-by: kernel test robot <lkp@intel=2Ecom>
>| Closes: https://lore=2Ekernel=2Eorg/oe-kbuild-all/202305311135=2EzGMT1g=
YR-lkp@intel=2Ecom/
>
>All errors (new ones prefixed by >>):
>
>   arch/um/os-Linux/drivers/tuntap_user=2Ec: In function 'tuntap_open':
>>> arch/um/os-Linux/drivers/tuntap_user=2Ec:149:17: error: implicit decla=
ration of function 'strscpy'; did you mean 'strncpy'? [-Werror=3Dimplicit-f=
unction-declaration]
>     149 |                 strscpy(ifr=2Eifr_name, pri->dev_name, sizeof(=
ifr=2Eifr_name));
>         |                 ^~~~~~~
>         |                 strncpy
>   cc1: some warnings being treated as errors

Ah, yeah, this is another "not actually in the kernel" cases=2E Let's igno=
re this strlcpy for now=2E

-Keed




--=20
Kees Cook
