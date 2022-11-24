Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73ED637827
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKXLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKXLz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:55:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6EBC5B62;
        Thu, 24 Nov 2022 03:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669290928; x=1700826928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=55nH4LmzDK+5WNB9MoXsKRknvVrM2IQDWXw3Al5UU80=;
  b=EDy6qYR8OiqLFY9zK45oL63khFfMVHFVedyC8cO4xaHg3udrXdxyeSU8
   xQSjz1mnID1Q+wNM3flz+a9zk88mUh5AbRPCKaiUbJ0on0Ly1Y7YHlEsn
   IyhBMbGj2MW0eaMmmL1f5HRQrWjvV0BZ1ATDNrHLDQf//H0TQu4blVmQy
   XGS8N3UGxbigQNr/UFk7C9F4DZiAdJLCdxknozEXVNb+2y8Sj6/T+XCpP
   5YnRIruMCKnwRccuUvbGkVFe9ypLrzBoXFO0YmUuS9g1XbgXrn8kLHs40
   wiUt1QWhRWIU4BR2Mz8S9yP94mmEGBWIyCeQWt6Y0hkau1sA0u4LsEp+R
   g==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="124940786"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 04:55:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 04:55:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 24 Nov 2022 04:55:20 -0700
Date:   Thu, 24 Nov 2022 11:55:01 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
CC:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, <linux-mm@kvack.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        <linux-man@vger.kernel.org>, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Y39blUaC/jHiOYCk@wendy>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0i22SdbHjB/MX@Sun>
 <Y385rS/5zDaDJ3Os@vermeer>
 <Y39AXYPFzSiBngwI@wendy>
 <Y39Lwp4rQc3Qkl0i@vermeer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y39Lwp4rQc3Qkl0i@vermeer>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 11:47:30AM +0100, Samuel Ortiz wrote:

> Patch #1 is definitely needed regardless of which interface we pick for
> exposing the ISA strings to userspace.

I took another look at #1, and I feel more confused about what
constitutes canonical order than I did before! If you know better than
I, and you probably do since you're interested in these 6 month old
patches, some insight would be appreciated!

Thanks,
Conor.

