Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492506132E0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJaJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJaJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:38:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689AD63AE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667209091; x=1698745091;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3HEhlyRyhTi1FcIpdqcmYBvpi5mKFGVbhxYqGdD60I8=;
  b=NSjuXmHYHlBlIJ82Wjlq0D8BastfBKCEEoj4vAU0pfKWnTx54Th0T7Sp
   4zMYGXynWuYmHGY1veHRwY3dkoZiOriFeNFalsqbEPsCUF8uZtwGM1EQi
   jGAjsznBxjZRZ4HNlmLSUc4IQ664VRmq37GBZzOix4a7EFJlXMXeShTqJ
   GwsvVhWD6A2neIVrDCrEMCnv3QInZ1YuWE/GKbJgBcLE8mIF4Lo9ZBcad
   QDva/SFYUINgBro0BSS8/zb1uNtxa8a4b00nq+MAHSf0romj00E6DlmH4
   SEzy8f7CpfIFiE4cwN1QYHbzi+cTT+FtFhjqLJi0rijR77NQmt9hxnZOw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="395171945"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="395171945"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 02:38:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="722751836"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="722751836"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.214.212]) ([10.254.214.212])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 02:38:10 -0700
Subject: Re: include/linux/fortify-string.h:220:25: warning: call to
 '__write_overflow_field' declared with attribute warning: detected write
 beyond size of field (1st parameter); maybe use struct_group()?
To:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202210230440.8ZaljZvp-lkp@intel.com>
 <202210281501.29D9A905@keescook>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <659aee78-b911-1ff8-87ee-c15fdf735f8b@intel.com>
Date:   Mon, 31 Oct 2022 17:38:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202210281501.29D9A905@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2022 6:03 AM, Kees Cook wrote:
> On Sun, Oct 23, 2022 at 04:45:58AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   4da34b7d175dc99b8befebd69e96546c960d526c
>> commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
>> date:   8 months ago
>> config: arm-randconfig-r012-20221023
>> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/ocfs2/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from include/linux/string.h:253,
>>                      from include/linux/bitmap.h:11,
>>                      from include/linux/cpumask.h:12,
>>                      from include/linux/smp.h:13,
>>                      from include/linux/lockdep.h:14,
>>                      from include/linux/spinlock.h:62,
>>                      from include/linux/mmzone.h:8,
>>                      from include/linux/gfp.h:6,
>>                      from include/linux/slab.h:15,
>>                      from fs/ocfs2/dlmglue.c:11:
>>     In function 'fortify_memset_chk',
>>         inlined from 'ocfs2_lock_res_free' at fs/ocfs2/dlmglue.c:790:2:
>>>> include/linux/fortify-string.h:220:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>>       220 |                         __write_overflow_field(p_size_field, size);
>>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This appears to be a compiler bug. The line in question is:
> 
>          memset(&res->l_lksb, 0, sizeof(res->l_lksb));
> 
> Looking at binary output, something is failing in dead code elimination,
> as the copy of the code holding this is never called, and has a
> non-literal value for the __builtin_object_size() output, which isn't
> possible.
> 
> -Kees
> 


Hi Kees,

Thanks for your feedback, we'll add it to ignore list.

Best Regards,
Rong Chen
