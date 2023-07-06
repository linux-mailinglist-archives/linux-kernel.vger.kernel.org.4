Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107C3749E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjGFOCH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjGFOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:02:00 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C61FC6;
        Thu,  6 Jul 2023 07:01:56 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qHPYI-000OJj-If; Thu, 06 Jul 2023 16:01:46 +0200
Received: from p57bd990e.dip0.t-ipconnect.de ([87.189.153.14] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qHPYI-000JBU-BM; Thu, 06 Jul 2023 16:01:46 +0200
Message-ID: <544f02b696a0a1554efe63f799754f3e5fbfecdc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 16:01:45 +0200
In-Reply-To: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.14
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter!

On Thu, 2023-07-06 at 06:57 -0700, Guenter Roeck wrote:
> On Thu, Jun 01, 2023 at 11:22:17PM +0300, Sergey Shtylyov wrote:
> > IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
> > return -EINVAL instead.  However, the kernel code supporting SH3/4-based
> > SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
> > IRQ #s from 16 instead.
> > 
> > The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> > indeed are using IRQ0 for the SMSC911x compatible Ethernet chip.
> > 
> 
> Unfortunately it also affects all sh4 emulations in qemu, and results in
> boot stalls with those. There isn't a relevant log to attach because there
> is no error message - booting just stalls until the emulation is aborted.
> 
> Reverting this patch fixes the problem.
> 
> Bisect log is attached for reference. Note that bisect requires applying
> commit 7497840d462c ("sh: Provide unxlate_dev_mem_ptr() in asm/io.h"),
> which is also the reason why the problem was not observed earlier since
> it was hiding behind a build failure.

Interesting. My naive understanding was that IRQ0 is no longer usable in the
kernel as Sergey claimed. Was that not correct?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
