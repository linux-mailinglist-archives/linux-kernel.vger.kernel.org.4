Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9668784E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBBJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBBJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:09:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6BC5FD3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675328945; x=1706864945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvQ1ErRDgv3I6gZTIV6p/uans2CYAUlZVIT84V7vf/M=;
  b=Wf6vtCmgKaEV/fjeZId1P+OAStI62peK/e6pSMRjG82gpk78N7sM/MMg
   03i2oPZoInKAxiHaIPO5K/9pF0VEkKu7HIbZLcNdb+euATTwaKEGTuyvO
   RAQO+LqzKTkJ04Zjqfl7Zkf67J/ndZ7YksvIXtdFnz32/YR+HHAcRLa9a
   VU6YaxXlBS4vgUufUu16z11D7lr90MV8KHTaoc5quj2yFfWgkoLMPDW7b
   +1zVrEKHd02Dhp6Wdhp6Pz/vs5R/4K8JlUthzgKsHGJ4RtoYf50DwV3PG
   p+n9Wm6TPIatz/B5iM0trxkpU8MCwzM77nNxDHbKoX0peih0BLaXOD21/
   w==;
X-IronPort-AV: E=Sophos;i="5.97,267,1669100400"; 
   d="asc'?scan'208";a="199047268"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2023 02:09:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 02:09:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 2 Feb 2023 02:09:02 -0700
Date:   Thu, 2 Feb 2023 09:08:38 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH v6 09/13] riscv/kprobe: Search free registers from unused
 caller-saved ones
Message-ID: <Y9t9ljSEJtnr835Y@wendy>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-10-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aHQm0zwpXHrO71dn"
Content-Disposition: inline
In-Reply-To: <20230127130541.1250865-10-chenguokai17@mails.ucas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--aHQm0zwpXHrO71dn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Chen,

Was looking at the insn manipulation code in 4/13 and noticed a minor
nit in this patch in the process.

On Fri, Jan 27, 2023 at 09:05:37PM +0800, Chen Guokai wrote:
> +/*
> + * Register	ABI Name	Saver
> + * x0		zero		--
> + * x1		ra		Caller
> + * x2		sp		Callee
> + * x3		gp		--
> + * x4		tp		--
> + * x5-7 	t0-2		Caller

I know it's just a comment, but this line here has a space before the
first tab that makes nvim unhappy.

Thanks,
Conor.


--aHQm0zwpXHrO71dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9t9igAKCRB4tDGHoIJi
0iRMAP9UcWucUeNFvkwtiH1LHVHVWEqdLTuGy49K60zsCtS9uQEAtBfuqg0Ovlw3
ybWuIvRwhcGgmKIQ6dTMACFSeuUXYAY=
=qR8Q
-----END PGP SIGNATURE-----

--aHQm0zwpXHrO71dn--
