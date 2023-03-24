Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE276C765D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCXDrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCXDrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:47:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFD14E83;
        Thu, 23 Mar 2023 20:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679629620; x=1711165620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8co0ZdFzyi4N9K0a/L1zFwdckqxK52/r+doDVNBcj8I=;
  b=ClVwa3t2GWqB1OFUUWPCPNXmLOC9Atvt5CvqnsOZKEfxx0Hfo0zCBtTN
   9Ws/bA7MpKD87ntMVrgTRTw66rHrzUI6ObmWJ02kDAHtUSDnTPMtOmUxb
   j9O2ubxjQo7ZW2Qeq+E034Ah3hDakSLiA+ATqsWYUBPiwY/2bnbSyC2L3
   WggX/n8oY6X/WokPDIGz39+nQ66uViHInrS9bI/wZgcDvNitv9bNwXP/2
   GjxAWEBTKorQGdAdytLp6UyN68wKGqb1007FiXC5OAo81LWUFNW01vN4m
   GYKVUzmCkWMtyZsHO77d8R0KpU/xN1fQBgR84vitmqiG1FYpX8tJ+CltP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="404603547"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="404603547"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 20:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632685457"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="632685457"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 20:46:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfYOG-000Ex2-1G;
        Fri, 24 Mar 2023 03:46:56 +0000
Date:   Fri, 24 Mar 2023 11:46:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: Re: [PATCH v2 3/3] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <202303241128.WBKc4LIy-lkp@intel.com>
References: <c0e914e2b2d5876265494df3ca102edcf259f02a.1679605919.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e914e2b2d5876265494df3ca102edcf259f02a.1679605919.git.william.gray@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

I love your patch! Yet something to improve:

[auto build test ERROR on 00f4bc5184c19cb33f468f1ea409d70d19f8f502]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Breathitt-Gray/counter-104-quad-8-Utilize-bitfield-access-macros/20230324-052655
base:   00f4bc5184c19cb33f468f1ea409d70d19f8f502
patch link:    https://lore.kernel.org/r/c0e914e2b2d5876265494df3ca102edcf259f02a.1679605919.git.william.gray%40linaro.org
patch subject: [PATCH v2 3/3] counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and PSC
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230324/202303241128.WBKc4LIy-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5da9052d37541a9470e1f9b6621d41b52c148b34
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review William-Breathitt-Gray/counter-104-quad-8-Utilize-bitfield-access-macros/20230324-052655
        git checkout 5da9052d37541a9470e1f9b6621d41b52c148b34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303241128.WBKc4LIy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/counter/104-quad-8.c:8:
   In function 'field_multiplier',
       inlined from 'field_mask' at include/linux/bitfield.h:170:17,
       inlined from 'u8_encode_bits' at include/linux/bitfield.h:198:1,
       inlined from 'u8p_replace_bits' at include/linux/bitfield.h:198:1,
       inlined from 'quad8_control_register_update' at drivers/counter/104-quad-8.c:206:2:
>> include/linux/bitfield.h:165:17: error: call to '__bad_mask' declared with attribute error: bad bitfield mask
     165 |                 __bad_mask();
         |                 ^~~~~~~~~~~~
   In function 'field_multiplier',
       inlined from 'u8_encode_bits' at include/linux/bitfield.h:198:1,
       inlined from 'u8p_replace_bits' at include/linux/bitfield.h:198:1,
       inlined from 'quad8_control_register_update' at drivers/counter/104-quad-8.c:206:2:
>> include/linux/bitfield.h:165:17: error: call to '__bad_mask' declared with attribute error: bad bitfield mask
     165 |                 __bad_mask();
         |                 ^~~~~~~~~~~~


vim +/__bad_mask +165 include/linux/bitfield.h

e2192de59e457a Johannes Berg   2023-01-18  119  
e2192de59e457a Johannes Berg   2023-01-18  120  /**
e2192de59e457a Johannes Berg   2023-01-18  121   * FIELD_PREP_CONST() - prepare a constant bitfield element
e2192de59e457a Johannes Berg   2023-01-18  122   * @_mask: shifted mask defining the field's length and position
e2192de59e457a Johannes Berg   2023-01-18  123   * @_val:  value to put in the field
e2192de59e457a Johannes Berg   2023-01-18  124   *
e2192de59e457a Johannes Berg   2023-01-18  125   * FIELD_PREP_CONST() masks and shifts up the value.  The result should
e2192de59e457a Johannes Berg   2023-01-18  126   * be combined with other fields of the bitfield using logical OR.
e2192de59e457a Johannes Berg   2023-01-18  127   *
e2192de59e457a Johannes Berg   2023-01-18  128   * Unlike FIELD_PREP() this is a constant expression and can therefore
e2192de59e457a Johannes Berg   2023-01-18  129   * be used in initializers. Error checking is less comfortable for this
e2192de59e457a Johannes Berg   2023-01-18  130   * version, and non-constant masks cannot be used.
e2192de59e457a Johannes Berg   2023-01-18  131   */
e2192de59e457a Johannes Berg   2023-01-18  132  #define FIELD_PREP_CONST(_mask, _val)					\
e2192de59e457a Johannes Berg   2023-01-18  133  	(								\
e2192de59e457a Johannes Berg   2023-01-18  134  		/* mask must be non-zero */				\
e2192de59e457a Johannes Berg   2023-01-18  135  		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
e2192de59e457a Johannes Berg   2023-01-18  136  		/* check if value fits */				\
e2192de59e457a Johannes Berg   2023-01-18  137  		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
e2192de59e457a Johannes Berg   2023-01-18  138  		/* check if mask is contiguous */			\
e2192de59e457a Johannes Berg   2023-01-18  139  		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
e2192de59e457a Johannes Berg   2023-01-18  140  		/* and create the value */				\
e2192de59e457a Johannes Berg   2023-01-18  141  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
e2192de59e457a Johannes Berg   2023-01-18  142  	)
e2192de59e457a Johannes Berg   2023-01-18  143  
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  144  /**
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  145   * FIELD_GET() - extract a bitfield element
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  146   * @_mask: shifted mask defining the field's length and position
7240767450d6d8 Masahiro Yamada 2017-10-03  147   * @_reg:  value of entire bitfield
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  148   *
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  149   * FIELD_GET() extracts the field specified by @_mask from the
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  150   * bitfield passed in as @_reg by masking and shifting it down.
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  151   */
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  152  #define FIELD_GET(_mask, _reg)						\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  153  	({								\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  154  		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  155  		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  156  	})
3e9b3112ec74f1 Jakub Kicinski  2016-08-31  157  
e7d4a95da86e0b Johannes Berg   2018-06-20  158  extern void __compiletime_error("value doesn't fit into mask")
00b0c9b82663ac Al Viro         2017-12-14  159  __field_overflow(void);
00b0c9b82663ac Al Viro         2017-12-14  160  extern void __compiletime_error("bad bitfield mask")
00b0c9b82663ac Al Viro         2017-12-14  161  __bad_mask(void);
00b0c9b82663ac Al Viro         2017-12-14  162  static __always_inline u64 field_multiplier(u64 field)
00b0c9b82663ac Al Viro         2017-12-14  163  {
00b0c9b82663ac Al Viro         2017-12-14  164  	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
00b0c9b82663ac Al Viro         2017-12-14 @165  		__bad_mask();
00b0c9b82663ac Al Viro         2017-12-14  166  	return field & -field;
00b0c9b82663ac Al Viro         2017-12-14  167  }
00b0c9b82663ac Al Viro         2017-12-14  168  static __always_inline u64 field_mask(u64 field)
00b0c9b82663ac Al Viro         2017-12-14  169  {
00b0c9b82663ac Al Viro         2017-12-14  170  	return field / field_multiplier(field);
00b0c9b82663ac Al Viro         2017-12-14  171  }
e31a50162feb35 Alex Elder      2020-03-12  172  #define field_max(field)	((typeof(field))field_mask(field))
00b0c9b82663ac Al Viro         2017-12-14  173  #define ____MAKE_OP(type,base,to,from)					\
00b0c9b82663ac Al Viro         2017-12-14  174  static __always_inline __##type type##_encode_bits(base v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  175  {									\
e7d4a95da86e0b Johannes Berg   2018-06-20  176  	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
00b0c9b82663ac Al Viro         2017-12-14  177  		__field_overflow();					\
00b0c9b82663ac Al Viro         2017-12-14  178  	return to((v & field_mask(field)) * field_multiplier(field));	\
00b0c9b82663ac Al Viro         2017-12-14  179  }									\
00b0c9b82663ac Al Viro         2017-12-14  180  static __always_inline __##type type##_replace_bits(__##type old,	\
00b0c9b82663ac Al Viro         2017-12-14  181  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  182  {									\
00b0c9b82663ac Al Viro         2017-12-14  183  	return (old & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  184  }									\
00b0c9b82663ac Al Viro         2017-12-14  185  static __always_inline void type##p_replace_bits(__##type *p,		\
00b0c9b82663ac Al Viro         2017-12-14  186  					base val, base field)		\
00b0c9b82663ac Al Viro         2017-12-14  187  {									\
00b0c9b82663ac Al Viro         2017-12-14  188  	*p = (*p & ~to(field)) | type##_encode_bits(val, field);	\
00b0c9b82663ac Al Viro         2017-12-14  189  }									\
00b0c9b82663ac Al Viro         2017-12-14  190  static __always_inline base type##_get_bits(__##type v, base field)	\
00b0c9b82663ac Al Viro         2017-12-14  191  {									\
00b0c9b82663ac Al Viro         2017-12-14  192  	return (from(v) & field)/field_multiplier(field);		\
00b0c9b82663ac Al Viro         2017-12-14  193  }
00b0c9b82663ac Al Viro         2017-12-14  194  #define __MAKE_OP(size)							\
00b0c9b82663ac Al Viro         2017-12-14  195  	____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  196  	____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu)	\
00b0c9b82663ac Al Viro         2017-12-14  197  	____MAKE_OP(u##size,u##size,,)
37a3862e123826 Johannes Berg   2018-06-20  198  ____MAKE_OP(u8,u8,,)
00b0c9b82663ac Al Viro         2017-12-14  199  __MAKE_OP(16)
00b0c9b82663ac Al Viro         2017-12-14  200  __MAKE_OP(32)
00b0c9b82663ac Al Viro         2017-12-14  201  __MAKE_OP(64)
00b0c9b82663ac Al Viro         2017-12-14  202  #undef __MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  203  #undef ____MAKE_OP
00b0c9b82663ac Al Viro         2017-12-14  204  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
