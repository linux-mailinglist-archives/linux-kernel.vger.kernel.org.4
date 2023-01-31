Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A38682337
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 05:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjAaE0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 23:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAaE0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 23:26:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ECD39B97
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 20:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675139195; x=1706675195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P4fz89K79fqbWFa1/hpbn1TcgTw8ED1hotLhYJ06UZ8=;
  b=bf+7jMKiS0AvS9DMeSsuPW51K3D6T6dZrqOgukyZaez1JFlsLXg0Do6P
   KJ6afuoRFWbRhrPLUeEPkVtHtDxmM+zGjl0Qh74aVkz8X4z56ty881HOo
   aU38TKJ8D3p4DwAusITgcizIrbe0l11da3NsQ1jGg3xu269CcCgjB+zMi
   Px3Kc/YOLSYlv0ahUrRPaoYnvlw9wpvRemF3FvmWPAEeWZnCdhjZ+qn7B
   Wd6/Y+u/nupxobiLIZWvRnuG8WNYOQmHT53vHRSs/fK1I18JaNDEUKKVj
   0NA+h7NyYxhs/tMtNDQgL7LAP2836xuj6NF4kn8u5Xg3B0bWCnufJiEOo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326409835"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="326409835"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 20:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772809032"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="772809032"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2023 20:26:34 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMiE5-00049S-1R;
        Tue, 31 Jan 2023 04:26:33 +0000
Date:   Tue, 31 Jan 2023 12:25:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [tip:x86/tdx 3/7] arch/x86/coco/tdx/tdcall.o: warning: objtool:
 __tdx_hypercall+0x7b: return with modified stack frame
Message-ID: <202301311257.jasMtEiE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
head:   8de62af018cc9262649d7688f7eb1409b2d8f594
commit: c30c4b2555ba93b845559a036293fcaf7ffd2b82 [3/7] x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments
config: x86_64-randconfig-a012-20221107 (https://download.01.org/0day-ci/archive/20230131/202301311257.jasMtEiE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c30c4b2555ba93b845559a036293fcaf7ffd2b82
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/tdx
        git checkout c30c4b2555ba93b845559a036293fcaf7ffd2b82
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdcall.o: warning: objtool: __tdx_hypercall+0x7b: return with modified stack frame


objdump-func vmlinux.o __tdx_hypercall:
0000 0000000000004c40 <__tdx_hypercall>:
0000     4c40:	55                   	push   %rbp
0001     4c41:	48 89 e5             	mov    %rsp,%rbp
0004     4c44:	41 57                	push   %r15
0006     4c46:	41 56                	push   %r14
0008     4c48:	41 55                	push   %r13
000a     4c4a:	41 54                	push   %r12
000c     4c4c:	55                   	push   %rbp
000d     4c4d:	48 89 f8             	mov    %rdi,%rax
0010     4c50:	48 89 f5             	mov    %rsi,%rbp
0013     4c53:	4c 8b 50 10          	mov    0x10(%rax),%r10
0017     4c57:	4c 8b 58 18          	mov    0x18(%rax),%r11
001b     4c5b:	4c 8b 60 20          	mov    0x20(%rax),%r12
001f     4c5f:	4c 8b 68 28          	mov    0x28(%rax),%r13
0023     4c63:	4c 8b 70 30          	mov    0x30(%rax),%r14
0027     4c67:	4c 8b 78 38          	mov    0x38(%rax),%r15
002b     4c6b:	50                   	push   %rax
002c     4c6c:	31 c0                	xor    %eax,%eax
002e     4c6e:	b9 00 fc 00 00       	mov    $0xfc00,%ecx
0033     4c73:	48 f7 c5 02 00 00 00 	test   $0x2,%rbp
003a     4c7a:	74 01                	je     4c7d <__tdx_hypercall+0x3d>
003c     4c7c:	fb                   	sti
003d     4c7d:	66 0f 01 cc          	tdcall
0041     4c81:	48 85 c0             	test   %rax,%rax
0044     4c84:	75 36                	jne    4cbc <__tdx_hypercall+0x7c>
0046     4c86:	58                   	pop    %rax
0047     4c87:	48 f7 c5 01 00 00 00 	test   $0x1,%rbp
004e     4c8e:	74 18                	je     4ca8 <__tdx_hypercall+0x68>
0050     4c90:	4c 89 50 10          	mov    %r10,0x10(%rax)
0054     4c94:	4c 89 58 18          	mov    %r11,0x18(%rax)
0058     4c98:	4c 89 60 20          	mov    %r12,0x20(%rax)
005c     4c9c:	4c 89 68 28          	mov    %r13,0x28(%rax)
0060     4ca0:	4c 89 70 30          	mov    %r14,0x30(%rax)
0064     4ca4:	4c 89 78 38          	mov    %r15,0x38(%rax)
0068     4ca8:	4c 89 d0             	mov    %r10,%rax
006b     4cab:	45 31 d2             	xor    %r10d,%r10d
006e     4cae:	45 31 db             	xor    %r11d,%r11d
0071     4cb1:	5d                   	pop    %rbp
0072     4cb2:	41 5c                	pop    %r12
0074     4cb4:	41 5d                	pop    %r13
0076     4cb6:	41 5e                	pop    %r14
0078     4cb8:	41 5f                	pop    %r15
007a     4cba:	5d                   	pop    %rbp
007b     4cbb:	c3                   	ret
007c     4cbc:	e8 00 00 00 00       	call   4cc1 <__tdx_hypercall+0x81>	4cbd: R_X86_64_PLT32	__tdx_hypercall_failed-0x4
0081     4cc1:	eb f9                	jmp    4cbc <__tdx_hypercall+0x7c>
0083     4cc3:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
008d     4ccd:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
0097     4cd7:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
00a1     4ce1:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
00ab     4ceb:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
00b5     4cf5:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
00bf     4cff:	90                   	nop

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
