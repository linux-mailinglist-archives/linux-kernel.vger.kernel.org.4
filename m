Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90EF5FDDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJMQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJMQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:04:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D11119DD;
        Thu, 13 Oct 2022 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665677061; x=1697213061;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=a+oiXu31xDKr0EHzuX8XBFCyIAi3YCeRXLjNSYeRdhM=;
  b=Y3baiJRV5BmcSqxklWhQxU8FqYkTUyQLffcOe2b0etJVhxvy3+JT2qRi
   JT5eSK1HzZgmE6y3XPKQBIXkv5wVaW+JHIZY1OLIZEhYUryVUKYfY+in3
   Jr5rPhHnad9t3SvO9cF8iDN3eUKcLRENf9KR+jqcw/IajSlb7i91xJlTy
   TDzYye7T19Tls/pclcbD5KkicfNHCTWUBwGM5pkT/5XLyyLdJ6R5ZrsTr
   MalwdMIbjy3EHhKk8UFJ/MFvOFDZ8pBcZvaI1S/pnbfQEh3vBmXgbT+Tn
   QGKKDflBKuAfxh3zJkVtodH2n/1pGVqY2ycJkjqSNei7bHehlvVLKxMBh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="305112177"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="305112177"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 09:03:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="872386514"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="872386514"
Received: from shahidmo-mobl1.amr.corp.intel.com (HELO [10.251.5.146]) ([10.251.5.146])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 09:03:15 -0700
Message-ID: <26cfc85cf1beebc600428e24f12f49c961540071.camel@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Date:   Thu, 13 Oct 2022 09:03:01 -0700
In-Reply-To: <Y0biN3/JsZMa0yUr@kernel.org>
References: <20220929160647.362798-1-kristen@linux.intel.com>
         <Y0BEV+Xgkrln8xoh@iweiny-desk3> <Y0ZphugZZBhlv/vT@kernel.org>
         <711f8036-787a-571e-1c0d-1a258175ebb2@intel.com>
         <Y0bUK6krEQdnFlOg@kernel.org> <Y0biN3/JsZMa0yUr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.module_f36+15386+a24ad1a3) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-12 at 18:50 +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 12, 2022 at 05:50:19PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 12, 2022 at 07:13:26AM -0700, Dave Hansen wrote:
> > > On 10/12/22 00:15, Jarkko Sakkinen wrote:
> > > > There's no data to show that this change would be useful to do.
> > >=20
> > > Jarkko, I think the overall transition to kmap_local_page() is a
> > > good
> > > one.=C2=A0 It is a superior API and having it around will pave the wa=
y
> > > for
> > > new features.=C2=A0 I don't think we should demand 'data' for each an=
d
> > > every
> > > one of these.
> > >=20
> > > Please take a look around the tree and see how other maintainers
> > > are
> > > handling these patches.=C2=A0 They're not limited to SGX.
> >=20
> > Sure, I'll take a look for comparison.
>=20
> Yeah, I think it is pretty solid idea.
>=20
> Looking at the decription:
>=20
> "It is not necessary to disable page faults or preemption when
> using kmap calls, so replace kmap_atomic() and kunmap_atomic()
> calls with more the more appropriate kmap_local_page() and
> kunmap_local() calls."
>=20
> We did not pick kmap_atomic() because it disables preeemption,
> i.e. it was not a "design choice". I'd rather phrase this as
> along the lines:
>=20
> "Migrate to the newer kmap_local_page() interface from kmap_atomic()
> in order to move away from per-CPU maps to pre-task_struct maps.
> This in effect removes the need to disable preemption in the
> local CPU while kmap is active, and thus vastly reduces overall
> system latency."
>=20
> Can be improved or written completely otherwise. I just wrote it
> in the way that I had understood the whole deal in the first place.
>=20
> BR, Jarkko

Thanks for looking into this Jarkko - I will update the commit log for
the next version.

Kristen


