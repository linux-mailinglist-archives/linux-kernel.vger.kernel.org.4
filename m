Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D156A64A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCABTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCABTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:19:40 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15F659C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677633571; x=1709169571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V6miA8MHSGYGrEI6DdpNRW7sdj0ZbxKqOIltGcg9nuk=;
  b=GGw225+kX+pk4VSKgIWCQ032Bmzxa22cBIjCzwhCI34cdqeHueBlxKNe
   uPqkVm/i8SKaIgLfJOocNK+kyTc+nGNWLkZkHJvdCTiMaiV9DWWFCghoi
   JzcTf+SJD6JfJwZVh9ZJciTB/mZQeqBkfAznGZCg6q9XHuOGM8MH3Tykv
   w85w/skA2hY1g5P0/rla2aszUhKytuAawHUXQEFnjcaMXcMZfqksp+TwH
   JBl46OezcR74x7FizoRXNVtTo2qEylN0izZy7Sde5sh1EbSmeYBrwqmpv
   PdB2Rx1JsPAwLXyceuviRpTau6pLoaxwKJqvI13Uvi35p3kLgD3KYBL5k
   w==;
X-IronPort-AV: E=Sophos;i="5.98,223,1673884800"; 
   d="scan'208";a="224259541"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 09:19:31 +0800
IronPort-SDR: Vn79YQBeQJUhUMytZaVmHBrjmJROfL88ohbMkfcOuPhHcS6A8+N0r6zjGCE43CRHvAcAgHJhEY
 4N13bINcAqCvaSHXOeikgGOwM4jsz1RPPi+ua+5/kfGy1q4i5yIj4/zyk+SArsUDxQ/m3pa0wL
 aLNucYZlaAyqqzQG2ldbYqWO/cxZFcmMBMKOgaATde6NEX0ggEFFkfuXSqOB/d9non4i0IcFKJ
 FaYVUQ+3+6NyBvBJHhx8FZjkIhgJxPJCuo31VAkf0xsbY4pkK7dN3lHmeQxTwq5QBDevscfhGa
 3Pk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 16:30:37 -0800
IronPort-SDR: HbixYcKXTVOrw07SXfhfBTPYQpfEz59AdReHIrlfCzl+BLApnbxn6ZBXj/DuKiCwFp1ZnyDO0y
 zKA3sVUTXPZcN99W27kf7EAZ6A0srWRVOi/YLeXryjonTz5AIXCE5pNIa0jMSgOVwqIkU/llEp
 YbxkLapUFDCE8vqqVP5SG0yaj0bMbu+2DrTZUH/joXemEQQszYlGSzn/+hTOSKLvpyf2TebL/c
 HelC6IKC4C8jeNABdFaVdLnlUNenZScE1vSTtlZC754ljxKkY71qWolaD7IDSZFbY1EhPibCxa
 OsE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 17:19:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PRGc26WCfz1RvTp
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:19:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677633570; x=1680225571; bh=V6miA8MHSGYGrEI6DdpNRW7sdj0ZbxKqOIl
        tGcg9nuk=; b=VN0P4sqB/z5su4BfULi1dB/UhJIijWBF0zYcZ7gYhjJpCBz66Oy
        K8tYHQxWl5vxxESY6HehsGMSdJP7twl1dMLiXO2D3BBwLrGYW6jgPMWoakFiXh9f
        GWWUbIiry3GQqYbBnqpEYmHu7pmpvjrFBENqDmVm1jdelhzokjALHFSakDK80DOd
        LlpGJj689B9OzC80nFDwiXCcZp2O0sS/ZV+Sz5zIq8XUpKO0hvS4UJhlLJnqxZXM
        TC1OGiPk0WGMJVyQoryANk5VgECIxkZqF6Gsq0mMoW8c7yj/u59MxJGzyBtoWU6q
        AyUfWQWafGS9OK+eRXFbibeTJj7iJa2nkUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w-qXLwQXITsH for <linux-kernel@vger.kernel.org>;
        Tue, 28 Feb 2023 17:19:30 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PRGc023zmz1RvLy;
        Tue, 28 Feb 2023 17:19:28 -0800 (PST)
Message-ID: <5a727aa8-4620-7019-4f45-e78ab6c52b04@opensource.wdc.com>
Date:   Wed, 1 Mar 2023 10:19:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] clk: k210: remove an implicit 64-bit division
Content-Language: en-US
To:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
 <20230301002657.352637-2-Mr.Bossman075@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230301002657.352637-2-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 09:26, Jesse Taube wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The K210 clock driver depends on SOC_CANAAN, which is only selectable
> when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
> have been sent for its enabling. The kernel test robot reported this
> implicit 64-bit division there.
> 
> Replace the implicit division with an explicit one.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

