Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB476D8C22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjDFApG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDFApE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:45:04 -0400
X-Greylist: delayed 300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 17:45:03 PDT
Received: from smtp.outflux.net (mta.outflux.net [IPv6:2001:19d0:2:6:c0de:0:736d:7471])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A84E5E;
        Wed,  5 Apr 2023 17:45:03 -0700 (PDT)
Received: from auth (localhost [127.0.0.1]) (authenticated bits=0)
        by vinyl.outflux.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id 3360b1rX013185
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 5 Apr 2023 17:37:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=outflux.net;
        s=2016010; t=1680741422;
        bh=cTFTsToUA6XKTJN0W+/7Qm3opsoCZjYfS1dyvnfSyQI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ZDHRbzWdN+Fqse/yl1NHXy4F76LH4E8/lZuI0ckYEjqShwk3+kzJbrP0vVxpxGtpC
         Jj0sVrFWHmV5Ycnjj9BfKtb7zWwqR6QJ7kNFiyUbl7xGPkd8s4dRdSyjKa5mLLGjUX
         uzeAKgGbMbAOGKGhHlzgM7uF6WF1sjnZXjivFyK0=
Date:   Wed, 05 Apr 2023 17:37:01 -0700
From:   Kees Cook <kees@outflux.net>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_22/32=5D_ACPICA=3A_actbl2=3A_Repla?= =?US-ASCII?Q?ce_1-element_arrays_with_flexible_arrays?=
User-Agent: K-9 Mail for Android
In-Reply-To: <642e10dfc46d8_21a829451@dwillia2-xfh.jf.intel.com.notmuch>
References: <4845957.31r3eYUQgx@kreacher> <14903668.tv2OnDr8pf@kreacher> <642e00331b335_29cc294b0@dwillia2-xfh.jf.intel.com.notmuch> <642e10dfc46d8_21a829451@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <F03AC35F-764F-45AC-A18E-F9BBBF172D4A@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: [IPv6:::1]
Envelope-To: robert.moore@intel.com
Envelope-To: linux-kernel@vger.kernel.org
Envelope-To: linux-acpi@vger.kernel.org
Envelope-To: rjw@rjwysocki.net
Envelope-To: dan.j.williams@intel.com
X-Scanned-By: MIMEDefang 2.83
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 5, 2023 5:22:55 PM PDT, Dan Williams <dan=2Ej=2Ewilliams@intel=2E=
com> wrote:
>Dan Williams wrote:
>> Rafael J=2E Wysocki wrote:
>> > From: Kees Cook <kees@outflux=2Enet>
>> >=20
>> > ACPICA commit 44f1af0664599e87bebc3a1260692baa27b2f264
>> >=20
>> > Similar to "Replace one-element array with flexible-array", replace t=
he
>> > 1-element array with a proper flexible array member as defined by C99=
=2E
>> >=20
>> > This allows the code to operate without tripping compile-time and run=
-
>> > time bounds checkers (e=2Eg=2E via __builtin_object_size(), -fsanitiz=
e=3Dbounds,
>> > and/or -fstrict-flex-arrays=3D3)=2E
>> >=20
>> > The sizeof() uses with struct acpi_nfit_flush_address and struct
>> > acpi_nfit_smbios have been adjusted to drop the open-coded subtractio=
n
>> > of the trailing single element=2E The result is no binary differences=
 in
>> > =2Etext nor =2Edata sections=2E
>> >=20
>> > Link: https://github=2Ecom/acpica/acpica/commit/44f1af06
>> > Signed-off-by: Bob Moore <robert=2Emoore@intel=2Ecom>
>> > Signed-off-by: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>>=20
>> Reviewed-by: Dan Williams <dan=2Ej=2Ewilliams@intel=2Ecom>
>
>Unit tests say NAK, though=2E
>
>This causes a regression, but I think I see where=2E Will send a fixed
>patch in a bit=2E

Ah, which tests? I must have missed something!

Thanks for digging in=2E

-Kees


--=20
Kees Cook
