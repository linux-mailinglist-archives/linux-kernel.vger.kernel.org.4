Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052A073C760
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFXHd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFXHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:33:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556E2139
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687592037; x=1719128037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFVPAa5jxAa93f2E989DShr2WFyMI5PyK24YCe/VRLI=;
  b=dAb6p5Xfp+vKgEPCH4/irikDfAYn2s/w5iHiAYVmzmERF5jSotAqhSOB
   t7b6WHrvEVp1hSB97qfp4o8hPPTwqa6Oq3oiXJ5EdbW51EBiRrzp2KHGK
   A6OkeRaUoYH7pQ9NmQtNryZ258Rdg20aCIpJz/lsMmvpbTLFBCf38/FNn
   MQMz/iE+OCDrFjGRnuni4tEUIvxIYmVSUrNAkVXFyO+V1BVhWrxvesyZl
   YvNEnJE/DuPUmlb3ALi98f2Q4KeTKmv39vqK8NI1FQ7mYv9QC4fjFbMuq
   SjAI1Gv2n2K9YZ1fXDpkM+hTAPNz8N20j4+sqsmIPuCEySgpZK5Y5OBNu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="364370832"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="364370832"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 00:33:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="718764291"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="718764291"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2023 00:33:54 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCxmL-0008q5-2K;
        Sat, 24 Jun 2023 07:33:53 +0000
Date:   Sat, 24 Jun 2023 15:33:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Make 'sec-address' always on
Message-ID: <202306241520.4jIgEhK4-lkp@intel.com>
References: <e7e1de1d01194df3ff4053cb0815fc2ddba33213.1687360711.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e1de1d01194df3ff4053cb0815fc2ddba33213.1687360711.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4-rc7 next-20230623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/objtool-Make-sec-address-always-on/20230621-232305
base:   linus/master
patch link:    https://lore.kernel.org/r/e7e1de1d01194df3ff4053cb0815fc2ddba33213.1687360711.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH] objtool: Make 'sec-address' always on
config: x86_64-randconfig-c002-20230622 (https://download.01.org/0day-ci/archive/20230624/202306241520.4jIgEhK4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230624/202306241520.4jIgEhK4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306241520.4jIgEhK4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: ibt_selftest+0x14 (.text+0x92b54): sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: .altinstr_replacement+0x19a4: redundant UACCESS disable
   vmlinux.o: warning: objtool: iovec_from_user.part.0+0xb1 (.text+0x1c47761): call to copy_iovec_from_user.part.0() with UACCESS enabled
   vmlinux.o: warning: objtool: ibt_selftest+0x1e (.text+0x92b5e): return with modified stack frame


objdump-func vmlinux.o ibt_selftest:
0000 0000000000092b40 <ibt_selftest>:
0000    92b40:	f3 0f 1e fa          	endbr64
0004    92b44:	e8 00 00 00 00       	call   92b49 <ibt_selftest+0x9>	92b45: R_X86_64_PLT32	__fentry__-0x4
0009    92b49:	55                   	push   %rbp
000a    92b4a:	48 89 e5             	mov    %rsp,%rbp
000d    92b4d:	48 8d 05 02 00 00 00 	lea    0x2(%rip),%rax        # 92b56 <ibt_selftest_ip>
0014    92b54:	ff e0                	jmp    *%rax
0000 0000000000092b56 <ibt_selftest_ip>:
0000    92b56:	90                   	nop
0001    92b57:	48 85 c0             	test   %rax,%rax
0004    92b5a:	5d                   	pop    %rbp
0005    92b5b:	0f 94 c0             	sete   %al
0008    92b5e:	e9 00 00 00 00       	jmp    92b63 <ibt_selftest_ip+0xd>	92b5f: R_X86_64_PLT32	__x86_return_thunk-0x4
000d    92b63:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
0017    92b6d:	0f 1f 00             	nopl   (%rax)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
