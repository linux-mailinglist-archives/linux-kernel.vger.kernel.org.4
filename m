Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1566DEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjAQNT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjAQNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:19:25 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98838EAD;
        Tue, 17 Jan 2023 05:19:24 -0800 (PST)
Date:   Tue, 17 Jan 2023 13:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1673961562; bh=pZa+dtTdSMjanJ9Lbe1aX8Frcq6MgE+SaT/yIDljxS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6JM5KZKuej1lrKNVnqFhfw7VDRd32K69KLc8fG49arUzQ/O4nPfmcTYqjgs/iYGD
         RrVnSPlJNlc8axsI1XrDoE0S4/l5AMuD/lyQDDuAhpIVIBl5TomQYmrQs8nBGb/lG5
         1/Z8EHz5ib5ZzMfyTS4P3RMO3D0YRz7BoNcnoHRw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Amy Parker <apark0006@student.cerritos.edu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kheaders: explicitly validate existence of cpio command
Message-ID: <20230117131919.3ywkaptian2y242d@t-8ch.de>
References: <20230117-kernel-kheaders-cpio-v1-1-058d3e1c8621@weissschuh.net>
 <Y8ZgTgtA9oH8W17Y@buildd.core.avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8ZgTgtA9oH8W17Y@buildd.core.avm.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:46:02AM +0100, Nicolas Schier wrote:
> On Tue, Jan 17, 2023 at 05:30:43AM +0000, Thomas Weißschuh wrote:
> > If the cpio command is not available the error emitted by
> > gen_kheaders.so is not clear as all output of the call to cpio is
> > discarded:
> > 
> > GNU make 4.4:
> > 
> >   GEN     kernel/kheaders_data.tar.xz
> > find: 'standard output': Broken pipe
> > find: write error
> > make[2]: *** [kernel/Makefile:157: kernel/kheaders_data.tar.xz] Error 127
> > make[1]: *** [scripts/Makefile.build:504: kernel] Error 2
> > 
> > GNU make < 4.4:
> > 
> >   GEN     kernel/kheaders_data.tar.xz
> > make[2]: *** [kernel/Makefile:157: kernel/kheaders_data.tar.xz] Error 127
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [scripts/Makefile.build:504: kernel] Error 2
> > 
> > Add an explicit check that will trigger a clear message about the issue:
> > 
> >   CHK     kernel/kheaders_data.tar.xz
> > ./kernel/gen_kheaders.sh: line 17: type: cpio: not found
> 
> Thanks for the patch!  What would you think about an even more verbose
> message?  Perhaps something like:
> 
>     echo >&2 ' *** "cpio" is required for "CONFIG_IKHEADERS". >&2

Wouldn't hurt obviously.
The other scripts used by the kernel don't seem to try to provide this
kind of explicit message either, though.
Having a line number, some sort of "not found" and the name of the
command are enough, in my opinion.

> Reviewed-by: Nicolas Schier <n.schier@avm.de>

Thanks!

Thomas
