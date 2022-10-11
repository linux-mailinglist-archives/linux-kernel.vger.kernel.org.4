Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C845FB2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJKNER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJKNEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:04:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D3692582
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665493453; x=1697029453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8RoWLFSAgy5Tr7o7PC0j+CfMRD/Jv0warDBFvuCp6tM=;
  b=T+SJB7WVb2iGLMfTJ5GqoNKXJ0wQxYdzEgyUxMEwGJiv1bXkX6UzEVHu
   Z4sPg0y4QMWbnphwqlot+Wjxvs6BuPDxVVG1s/J76Rqbyi16E68Wj7k6b
   5k/RCQkw7ueEwxSGrjE47TsZWVViYhoHe91WwnWDzhmb3ToxfctB2A5Fc
   4JR9oyN1rClNIGQjdyiCDY5S+JHhD7Je5LO71UgYitU7I+jdKPIqr5iI8
   W4EwUM/qMiI6AIOzDQCYZR56az+ecU0XrkN5NgBiBkyUCwxMq1RoCr2Uo
   Io85gibeiRKwAQB98KPxYl3pLEUkv9Hk3p0xsgzuLt+OF6O422aKQ5VaD
   g==;
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="184194289"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2022 06:04:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 11 Oct 2022 06:04:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 11 Oct 2022 06:04:05 -0700
Date:   Tue, 11 Oct 2022 14:03:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC:     Wenting Zhang <zephray@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: always honor the CONFIG_CMDLINE_FORCE when
 parsing dtb
Message-ID: <Y0VprlqUrSnDPQ77@wendy>
References: <PSBPR04MB399135DFC54928AB958D0638B1829@PSBPR04MB3991.apcprd04.prod.outlook.com>
 <87bkqjk93q.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bkqjk93q.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:10:33PM +0200, Björn Töpel wrote:
> Wenting Zhang <zephray@outlook.com> writes:
> 
> > When CONFIG_CMDLINE_FORCE is enabled, cmdline provided by
> > CONFIG_CMDLINE are always used. This allows CONFIG_CMDLINE to be
> > used regardless of the result of device tree scanning.
> >
> > This especially fixes the case where a device tree without the
> > chosen node is supplied to the kernel. In such cases,
> > early_init_dt_scan would return true. But inside
> > early_init_dt_scan_chosen, the cmdline won't be updated as there
> > is no chosen node in the device tree. As a result, CONFIG_CMDLINE
> > is not copied into boot_command_line even if CONFIG_CMDLINE_FORCE
> > is enabled. This commit allows properly update boot_command_line
> > in this situation.
> >
> > Fixes: 8fd6e05c7463 ("arch: riscv: support kernel command line forcing when no DTB passed")
> > Signed-off-by: Wenting Zhang <zephray@outlook.com>
> 
> Reviewed-by: Björn Töpel <bjorn@kernel.org>

I noticed that the version of this patch that I had left un-archived in
patchwork was not the correct one. I then realised I gave a "LGTM" type
thing in reponse to the v1, about the v2 but nothing on v2 itself.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

