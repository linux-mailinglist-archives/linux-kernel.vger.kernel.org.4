Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75AB69CF27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBTOQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBTOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:16:20 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2B851ADFB;
        Mon, 20 Feb 2023 06:16:17 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pU6xY-0006pY-00; Mon, 20 Feb 2023 15:16:04 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D25F0C28F0; Mon, 20 Feb 2023 15:12:36 +0100 (CET)
Date:   Mon, 20 Feb 2023 15:12:36 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <john@phrozen.org>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: vpe-mt: drop physical_memsize
Message-ID: <20230220141236.GA9547@alpha.franken.de>
References: <20230219231525.21542-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230219231525.21542-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 03:15:25PM -0800, Randy Dunlap wrote:
> When neither LANTIQ nor MIPS_MALTA is set, 'physical_memsize' is not
> declared. This causes the build to fail with:
> 
> mips-linux-ld: arch/mips/kernel/vpe-mt.o: in function `vpe_run':
> arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x280): undefined reference to `physical_memsize'
> 
> LANTIQ is not using 'physical_memsize' and MIPS_MALTA's use of it is
> self-contained in mti-malta/malta-dtshim.c.
> Use of physical_memsize in vpe-mt.c appears to be unused, so eliminate
> this loader mode completely and require VPE programs to be compiled with
> DFLT_STACK_SIZE and DFLT_HEAP_SIZE defined.
> 
> Fixes: 9050d50e2244 ("MIPS: lantiq: Set physical_memsize")
> Fixes: 1a2a6d7e8816 ("MIPS: APRP: Split VPE loader into separate files.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202302030625.2g3E98sY-lkp@intel.com/
> Cc: Dengcheng Zhu <dzhu@wavecomp.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: "Steven J. Hill" <Steven.Hill@imgtec.com>
> Cc: Qais Yousef <Qais.Yousef@imgtec.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@vger.kernel.org
> ---
> v2 changes: instead of providing a default physical_memsize of 0, which
>     is not correct for MIPS_MALTA, just eliminate its use in vpe-mt.c.
> 
>  arch/mips/include/asm/vpe.h |    1 -
>  arch/mips/kernel/vpe-mt.c   |    7 +++----
>  arch/mips/lantiq/prom.c     |    6 ------
>  3 files changed, 3 insertions(+), 11 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
