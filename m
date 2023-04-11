Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB36DE667
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDKVXB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:22:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3919DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:22:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-198-g5syxxZ0PvepsyDefepPNQ-1; Tue, 11 Apr 2023 22:22:54 +0100
X-MC-Unique: g5syxxZ0PvepsyDefepPNQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 11 Apr
 2023 22:22:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 11 Apr 2023 22:22:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lu Baolu' <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Topic: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Index: AQHZbEHu9QGkmONo40W+xGFseOdGmq8mnrSg
Date:   Tue, 11 Apr 2023 21:22:52 +0000
Message-ID: <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
In-Reply-To: <20230411064815.31456-12-baolu.lu@linux.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu
> Sent: 11 April 2023 07:48
> 
> From: Tina Zhang <tina.zhang@intel.com>
> 
> The patch fixes the klocwork issues that operands in a bitwise operation
> have different size at line 1692 of dmar.c, line 1898 and line 1907 of
> iommu.c.

Why is this any kind of thing that needs fixing?

	David

> Reported-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> Link: https://lore.kernel.org/r/20230406065944.2773296-2-tina.zhang@intel.com
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c  | 2 +-
>  drivers/iommu/intel/iommu.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23828d189c2a..f0f51c957ccb 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1690,7 +1690,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
>  	 * is present.
>  	 */
>  	if (ecap_smts(iommu->ecap))
> -		val |= (1 << 11) | 1;
> +		val |= BIT_ULL(11) | BIT_ULL(0);
> 
>  	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f4e536fd5a28..acbf82fa90e7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1870,7 +1870,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
>   */
>  static inline void context_set_sm_dte(struct context_entry *context)
>  {
> -	context->lo |= (1 << 2);
> +	context->lo |= BIT_ULL(2);
>  }
> 
>  /*
> @@ -1879,7 +1879,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
>   */
>  static inline void context_set_sm_pre(struct context_entry *context)
>  {
> -	context->lo |= (1 << 4);
> +	context->lo |= BIT_ULL(4);
>  }
> 
>  /* Convert value to context PASID directory size field coding. */
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

