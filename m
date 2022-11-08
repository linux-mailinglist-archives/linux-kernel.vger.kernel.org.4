Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6175620AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiKHH4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKHH4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:56:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B106B84C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667894180; x=1699430180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UZKMnJKFAv4vSHd9oWtskNWgnKnXMz5bt69bqiWFP88=;
  b=J0o4L0blqWds6IDas7g1y50JbPelIFznoP96gn4DWDfNiUoIIbhm3PCW
   Gjt0QKmT1EqJ8UTbgo+Jy9ZJyIGBO3ikWyziaFY6sKSWmceX7De0bRaFt
   9ZZS+6q63j5SbaYkmRiB7aw2bNWInT03QE6oVvymluRqqEGvdRtnvd+om
   lkLqRZqu6/v7T9D1nSnP9IebkTgfJCvzJ9JAgOiWLfYRIUZx1Wx99G4td
   M3E1hXTcfcRi3w4W/Hhvbv/JTeHuzH6i6ShmMkSIBRnKQAX6o5kXG4zRl
   A+otCPy1muAAW1Rqx4hDghKwtQMn633UXMfnP5aZ6bSPEvAIGSf754AoO
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="198857937"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2022 00:56:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 8 Nov 2022 00:56:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 8 Nov 2022 00:56:17 -0700
Date:   Tue, 8 Nov 2022 07:56:01 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Vineet Gupta <vineetg@rivosinc.com>
CC:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Chris Stillson <stillson@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
Message-ID: <Y2oLkQSdCBJPvZW/@wendy>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
 <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
 <f4887649-3933-0a65-7ed5-1bf6bd842a46@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4887649-3933-0a65-7ed5-1bf6bd842a46@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:04:28PM -0800, Vineet Gupta wrote:
> +CC Andy, Conor
> 
> On 11/7/22 09:21, Björn Töpel wrote:
> > > +config VECTOR
> > > +	bool "VECTOR support"
> > > +	depends on GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
> > > +	default n
> > > +	help
> > > +	  Say N here if you want to disable all vector related procedure
> > > +	  in the kernel.
> > > +
> > > +	  If you don't know what to do here, say Y.
> > > +
> > > +endmenu
> > "VECTOR" is not really consistent to how the other configs are named;
> > RISCV_ISA_V, RISCV_ISA_VECTOR, RISCV_VECTOR?
> 
> Good point, I've changed it to RISCV_ISA_V to keep it consistent with
> existing RISCV_ISA_C.

Hey Vineet, kinda randomly replying here but the wording makes it look
like you're going to take this patchset on?
If so, please check out v10 (think it was from April) as there are some
comments on that version that IIRC remain un-resolved.
Thanks,
Conor.

