Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573871F85A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjFBCZJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 22:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFBCZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:25:06 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D413E;
        Thu,  1 Jun 2023 19:25:04 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 48B904055F;
        Fri,  2 Jun 2023 02:25:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id BD85320025;
        Fri,  2 Jun 2023 02:25:00 +0000 (UTC)
Message-ID: <04c4e064a44589d39361b7c7b849ee7f41ef76b5.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: Check for 0-length and 1-element arrays
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 01 Jun 2023 19:24:59 -0700
In-Reply-To: <20230601151500.b9937b28946c38ef186c1ce5@linux-foundation.org>
References: <20230601160746.up.948-kees@kernel.org>
         <20230601151500.b9937b28946c38ef186c1ce5@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: BD85320025
X-Stat-Signature: fpph5a1tsuwptutbeyw6bhnbhdphjb1w
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+kj9qyfofcS3O1/kiFamIfd62XD8Xtluc=
X-HE-Tag: 1685672700-922390
X-HE-Meta: U2FsdGVkX18NXNfMGJdLb0580H0pOuYl2CICqyBc//f7M027sSy2brHjY1WM1joVcNHnI5bsy5oulKPBEItj49emXsrBLB0vp62CTaqO72B2kEcHH+NMSSIVDnYm5CMrYhpbF9w0F+92dKwsQpXxwEL4FPZ6Cm/syQBQTwOSlu+a1tKqTNtc0r3Fy9QrsudN6tQtMhFFGKY/nz4HUx6XwP2eKrm+DNJb68SV1852zr0/5rtiD8E38xuYoeGhapeC611G1l8l6MjYzkUkjm9VpvhOYdWPCGPRA41aUQ0mwJFHQphuJJarFCT94q1+DQbhTL4y6dFffaiZLc1rvgj5erHl2JxAi4+nnQ9WLz2XgEfWWzeWf/rh3fgt+0/0z/2u2ZywuviEKHGi1NQz4/+rZeJVNCnajWf4Mtn2YxToeaXX6zppDPMEMwx5qxGa9JO/MeUM7CP7T9u9PjtKlWadls9VeypeTkj10XrhNtNnuOtPUbMnImFBHEMhEcrPDevwCADDWLg0+S4=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-01 at 15:15 -0700, Andrew Morton wrote:
> On Thu,  1 Jun 2023 09:07:46 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > Fake flexible arrays have been deprecated since last millennium. Proper
> > C99 flexible arrays must be used throughout the kernel so
> > CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> > bounds checking.
> > 
> > Cc: Andy Whitcroft <apw@canonical.com>
> > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Fixed-by: Joe Perches <joe@perches.com>
> 
> You didn't checkpatch your checkpatch patch!
> 
> WARNING: Non-standard signature: Fixed-by:
> #248: 
> Fixed-by: Joe Perches <joe@perches.com>
> 
> I'll do my usual
> 
> [joe@perches.com: handle __packed for srtucts]

With that spelling?

Anyway, I went back and forth a few times with Kees
giving suggestions and corrections before sending it
on to you for more than just __packed.

I didn't (and still don't) care much about anything
other than the code.

cheers, Joe
