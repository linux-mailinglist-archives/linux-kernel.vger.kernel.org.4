Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2100D63AD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiK1QCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiK1QCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:02:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1D10570;
        Mon, 28 Nov 2022 08:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669651337; x=1701187337;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=szx3V/THdgBnLdEMF5U5QuumyUgo5RkTBLtv41gapAo=;
  b=B3nmhsMAUHFK0BZl2EKrNUhubWHu+MTFVETpsoeeMQrTLKJcOlggyZ/2
   /yLopi7eM0UQZpgdl3h06dAaUwz/DdBMsPxvQvQ6X+BjOZ7JhcOyLmQVg
   DxLOBl+p/lAK8JQfF8regmaccJP7+Ij1041sGOETRScAf5TtgyImSoae3
   SsDR8mk5Y0zxodvzKpJASEzW8Xv0bTjoHXVnXzUmXkI11zdRLx+DrvJNF
   fhcKf9A1sLXmgwFP2gUR/JkaEjK0lcSZK8HvbqcwU4umemR0rXRIuxDRN
   fSFYRUf6C5KWtCjkaqW3tHgqUyOpIARrMamcggbAxEFtXXFcQdmn+xanF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316702272"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316702272"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 08:01:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="732189888"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="732189888"
Received: from steinint-mobl1.ger.corp.intel.com ([10.249.34.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 08:01:33 -0800
Date:   Mon, 28 Nov 2022 18:01:28 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] serial: bflb_uart: add Bouffalolab UART Driver
In-Reply-To: <Y4TD48v84CJcMS+S@xhacker>
Message-ID: <e1f689d2-d337-5a42-e4c9-91c1d338b42b@linux.intel.com>
References: <20221127132448.4034-1-jszhang@kernel.org> <20221127132448.4034-3-jszhang@kernel.org> <c0406076-04e1-6b81-1bba-ac684516d898@kernel.org> <Y4TD48v84CJcMS+S@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022, Jisheng Zhang wrote:

> On Mon, Nov 28, 2022 at 07:10:41AM +0100, Jiri Slaby wrote:
> > On 27. 11. 22, 14:24, Jisheng Zhang wrote:
> > > +static void bflb_uart_tx_chars(struct uart_port *port)
> > 
> > Again:
> > 
> > Are you unable to use the TX helper? If so:
> 
> You know serial subsystem better than me, may I ask for more
> details? For example,
> Besides uart_xmit_advance(), do you expect other TX helpers? If yes,
> can you please list them?

Please take on look on commit 8275b48b278096edc1e3ea5aa9cf946a10022f79.
The changes following that commit convert some drivers to use the tx 
helper so you can look into them to see examples.

> > * why?
> > * use uart_advance_xmit() at least.
> 
> Do you mean uart_xmit_advance()? in the do while loop below?

Yes, Jiri had the name wrong. But your code looked like it could use 
the tx helper instead.

-- 
 i.
