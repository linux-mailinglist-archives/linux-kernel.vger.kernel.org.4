Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAE72A1AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjFIRxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFIRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:53:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B35D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686333221; x=1717869221;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+kEs9rnNYTvwWDog3jiInkK2c0MD8o8Kmalan9Evf50=;
  b=IpQtAQoYbZXHw4uBGTlP5oA4wRz9c6MdMYekccXlguu7H680h4HFZbFy
   DF9FAX23jCyGEMPopKfet93BFaIp4KUw+8zEdSIIVCOaxx9X2wjQHGprn
   ykT0uyo3wWxOwJtLey6Cko+ZzEicGoCxwG7KsLphbKi04bSn6tLAfZ0eG
   yTdsxS2ft1MRsdd1drrakSYIj59FxM5FjqR3VGETBB/QEpB4E0N4pwpbn
   i9fULw2A4CJZAGm09V0KfxhXXlAESxfdxWOz/PHWtxK1nQKfX+Z03CCDN
   t69OqKfFAmOuFpf2v5vNK8nIw1qIm9a9xMKkmaf0T4CACff/5WIyZNmYY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337291556"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="337291556"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="743572586"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="743572586"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2023 10:53:39 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7gIs-0009H6-0v;
        Fri, 09 Jun 2023 17:53:38 +0000
Date:   Sat, 10 Jun 2023 01:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: lib/xz/xz_dec_stream.c:549:20: warning: stack frame size (2976)
 exceeds limit (2048) in 'dec_main'
Message-ID: <202306100124.8IFscRUR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f506c7f7d3d8d68a1a020c3d914390b3ffc30d0
commit: 8341dcfbd8dda98a3b2836a421016f7d88e35b1c riscv: Enable Undefined Behavior Sanitizer UBSAN
date:   1 year, 10 months ago
config: riscv-randconfig-r001-20230609 (https://download.01.org/0day-ci/archive/20230610/202306100124.8IFscRUR-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8341dcfbd8dda98a3b2836a421016f7d88e35b1c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8341dcfbd8dda98a3b2836a421016f7d88e35b1c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/bus/mhi/ drivers/char/ipmi/ drivers/mmc/host/ lib/xz/ lib/zlib_deflate/ lib/zlib_inflate/ lib/zstd/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306100124.8IFscRUR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/xz/xz_dec_stream.c:549:20: warning: stack frame size (2976) exceeds limit (2048) in 'dec_main' [-Wframe-larger-than]
   static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
                      ^
   1 warning generated.
--
>> lib/xz/xz_dec_lzma2.c:931:23: warning: stack frame size (4704) exceeds limit (2048) in 'xz_dec_lzma2_run' [-Wframe-larger-than]
   XZ_EXTERN enum xz_ret xz_dec_lzma2_run(struct xz_dec_lzma2 *s,
                         ^
>> lib/xz/xz_dec_lzma2.c:722:13: warning: stack frame size (2400) exceeds limit (2048) in 'lzma_main' [-Wframe-larger-than]
   static bool lzma_main(struct xz_dec_lzma2 *s)
               ^
   2 warnings generated.
--
>> lib/zlib_inflate/inflate.c:331:5: warning: stack frame size (3984) exceeds limit (2048) in 'zlib_inflate' [-Wframe-larger-than]
   int zlib_inflate(z_streamp strm, int flush)
       ^
   1 warning generated.
--
>> lib/zlib_deflate/deftree.c:618:13: warning: stack frame size (2864) exceeds limit (2048) in 'send_tree' [-Wframe-larger-than]
   static void send_tree(
               ^
   1 warning generated.
--
   lib/zstd/compress.c:434:8: warning: no previous prototype for function 'ZSTD_noCompressBlock' [-Wmissing-prototypes]
   size_t ZSTD_noCompressBlock(void *dst, size_t dstCapacity, const void *src, size_t srcSize)
          ^
   lib/zstd/compress.c:434:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   size_t ZSTD_noCompressBlock(void *dst, size_t dstCapacity, const void *src, size_t srcSize)
   ^
   static 
   lib/zstd/compress.c:2252:6: warning: no previous prototype for function 'ZSTD_compressBlock_greedy_extDict' [-Wmissing-prototypes]
   void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize) { ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0); }
        ^
   lib/zstd/compress.c:2252:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize) { ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0); }
   ^
   static 
   lib/zstd/compress.c:2982:15: warning: no previous prototype for function 'ZSTD_createCStream_advanced' [-Wmissing-prototypes]
   ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
                 ^
   lib/zstd/compress.c:2982:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
   ^
   static 
>> lib/zstd/compress.c:2272:13: warning: stack frame size (2912) exceeds limit (2048) in 'ZSTD_compressBlock_btopt' [-Wframe-larger-than]
   static void ZSTD_compressBlock_btopt(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
               ^
>> lib/zstd/compress.c:2284:13: warning: stack frame size (2896) exceeds limit (2048) in 'ZSTD_compressBlock_btopt2' [-Wframe-larger-than]
   static void ZSTD_compressBlock_btopt2(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
               ^
>> lib/zstd/compress.c:2296:13: warning: stack frame size (2976) exceeds limit (2048) in 'ZSTD_compressBlock_btopt_extDict' [-Wframe-larger-than]
   static void ZSTD_compressBlock_btopt_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
               ^
>> lib/zstd/compress.c:2308:13: warning: stack frame size (2992) exceeds limit (2048) in 'ZSTD_compressBlock_btopt2_extDict' [-Wframe-larger-than]
   static void ZSTD_compressBlock_btopt2_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
               ^
   7 warnings generated.
--
>> drivers/char/ipmi/ipmi_si_intf.c:748:26: warning: stack frame size (2240) exceeds limit (2048) in 'smi_event_handler' [-Wframe-larger-than]
   static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
                            ^
   1 warning generated.
--
>> drivers/mmc/host/sdhci.c:3411:20: warning: stack frame size (2992) exceeds limit (2048) in 'sdhci_irq' [-Wframe-larger-than]
   static irqreturn_t sdhci_irq(int irq, void *dev_id)
                      ^
   1 warning generated.


vim +/dec_main +549 lib/xz/xz_dec_stream.c

24fa0402a9b6a5 Lasse Collin     2011-01-12  548  
24fa0402a9b6a5 Lasse Collin     2011-01-12 @549  static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
24fa0402a9b6a5 Lasse Collin     2011-01-12  550  {
24fa0402a9b6a5 Lasse Collin     2011-01-12  551  	enum xz_ret ret;
24fa0402a9b6a5 Lasse Collin     2011-01-12  552  
24fa0402a9b6a5 Lasse Collin     2011-01-12  553  	/*
24fa0402a9b6a5 Lasse Collin     2011-01-12  554  	 * Store the start position for the case when we are in the middle
24fa0402a9b6a5 Lasse Collin     2011-01-12  555  	 * of the Index field.
24fa0402a9b6a5 Lasse Collin     2011-01-12  556  	 */
24fa0402a9b6a5 Lasse Collin     2011-01-12  557  	s->in_start = b->in_pos;
24fa0402a9b6a5 Lasse Collin     2011-01-12  558  
24fa0402a9b6a5 Lasse Collin     2011-01-12  559  	while (true) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  560  		switch (s->sequence) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  561  		case SEQ_STREAM_HEADER:
24fa0402a9b6a5 Lasse Collin     2011-01-12  562  			/*
24fa0402a9b6a5 Lasse Collin     2011-01-12  563  			 * Stream Header is copied to s->temp, and then
24fa0402a9b6a5 Lasse Collin     2011-01-12  564  			 * decoded from there. This way if the caller
24fa0402a9b6a5 Lasse Collin     2011-01-12  565  			 * gives us only little input at a time, we can
24fa0402a9b6a5 Lasse Collin     2011-01-12  566  			 * still keep the Stream Header decoding code
24fa0402a9b6a5 Lasse Collin     2011-01-12  567  			 * simple. Similar approach is used in many places
24fa0402a9b6a5 Lasse Collin     2011-01-12  568  			 * in this file.
24fa0402a9b6a5 Lasse Collin     2011-01-12  569  			 */
24fa0402a9b6a5 Lasse Collin     2011-01-12  570  			if (!fill_temp(s, b))
24fa0402a9b6a5 Lasse Collin     2011-01-12  571  				return XZ_OK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  572  
24fa0402a9b6a5 Lasse Collin     2011-01-12  573  			/*
24fa0402a9b6a5 Lasse Collin     2011-01-12  574  			 * If dec_stream_header() returns
24fa0402a9b6a5 Lasse Collin     2011-01-12  575  			 * XZ_UNSUPPORTED_CHECK, it is still possible
24fa0402a9b6a5 Lasse Collin     2011-01-12  576  			 * to continue decoding if working in multi-call
24fa0402a9b6a5 Lasse Collin     2011-01-12  577  			 * mode. Thus, update s->sequence before calling
24fa0402a9b6a5 Lasse Collin     2011-01-12  578  			 * dec_stream_header().
24fa0402a9b6a5 Lasse Collin     2011-01-12  579  			 */
24fa0402a9b6a5 Lasse Collin     2011-01-12  580  			s->sequence = SEQ_BLOCK_START;
24fa0402a9b6a5 Lasse Collin     2011-01-12  581  
24fa0402a9b6a5 Lasse Collin     2011-01-12  582  			ret = dec_stream_header(s);
24fa0402a9b6a5 Lasse Collin     2011-01-12  583  			if (ret != XZ_OK)
24fa0402a9b6a5 Lasse Collin     2011-01-12  584  				return ret;
24fa0402a9b6a5 Lasse Collin     2011-01-12  585  
4c1ca831adb101 Nick Desaulniers 2020-11-15  586  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  587  
24fa0402a9b6a5 Lasse Collin     2011-01-12  588  		case SEQ_BLOCK_START:
24fa0402a9b6a5 Lasse Collin     2011-01-12  589  			/* We need one byte of input to continue. */
24fa0402a9b6a5 Lasse Collin     2011-01-12  590  			if (b->in_pos == b->in_size)
24fa0402a9b6a5 Lasse Collin     2011-01-12  591  				return XZ_OK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  592  
24fa0402a9b6a5 Lasse Collin     2011-01-12  593  			/* See if this is the beginning of the Index field. */
24fa0402a9b6a5 Lasse Collin     2011-01-12  594  			if (b->in[b->in_pos] == 0) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  595  				s->in_start = b->in_pos++;
24fa0402a9b6a5 Lasse Collin     2011-01-12  596  				s->sequence = SEQ_INDEX;
24fa0402a9b6a5 Lasse Collin     2011-01-12  597  				break;
24fa0402a9b6a5 Lasse Collin     2011-01-12  598  			}
24fa0402a9b6a5 Lasse Collin     2011-01-12  599  
24fa0402a9b6a5 Lasse Collin     2011-01-12  600  			/*
24fa0402a9b6a5 Lasse Collin     2011-01-12  601  			 * Calculate the size of the Block Header and
24fa0402a9b6a5 Lasse Collin     2011-01-12  602  			 * prepare to decode it.
24fa0402a9b6a5 Lasse Collin     2011-01-12  603  			 */
24fa0402a9b6a5 Lasse Collin     2011-01-12  604  			s->block_header.size
24fa0402a9b6a5 Lasse Collin     2011-01-12  605  				= ((uint32_t)b->in[b->in_pos] + 1) * 4;
24fa0402a9b6a5 Lasse Collin     2011-01-12  606  
24fa0402a9b6a5 Lasse Collin     2011-01-12  607  			s->temp.size = s->block_header.size;
24fa0402a9b6a5 Lasse Collin     2011-01-12  608  			s->temp.pos = 0;
24fa0402a9b6a5 Lasse Collin     2011-01-12  609  			s->sequence = SEQ_BLOCK_HEADER;
24fa0402a9b6a5 Lasse Collin     2011-01-12  610  
4c1ca831adb101 Nick Desaulniers 2020-11-15  611  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  612  
24fa0402a9b6a5 Lasse Collin     2011-01-12  613  		case SEQ_BLOCK_HEADER:
24fa0402a9b6a5 Lasse Collin     2011-01-12  614  			if (!fill_temp(s, b))
24fa0402a9b6a5 Lasse Collin     2011-01-12  615  				return XZ_OK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  616  
24fa0402a9b6a5 Lasse Collin     2011-01-12  617  			ret = dec_block_header(s);
24fa0402a9b6a5 Lasse Collin     2011-01-12  618  			if (ret != XZ_OK)
24fa0402a9b6a5 Lasse Collin     2011-01-12  619  				return ret;
24fa0402a9b6a5 Lasse Collin     2011-01-12  620  
24fa0402a9b6a5 Lasse Collin     2011-01-12  621  			s->sequence = SEQ_BLOCK_UNCOMPRESS;
24fa0402a9b6a5 Lasse Collin     2011-01-12  622  
4c1ca831adb101 Nick Desaulniers 2020-11-15  623  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  624  
24fa0402a9b6a5 Lasse Collin     2011-01-12  625  		case SEQ_BLOCK_UNCOMPRESS:
24fa0402a9b6a5 Lasse Collin     2011-01-12  626  			ret = dec_block(s, b);
24fa0402a9b6a5 Lasse Collin     2011-01-12  627  			if (ret != XZ_STREAM_END)
24fa0402a9b6a5 Lasse Collin     2011-01-12  628  				return ret;
24fa0402a9b6a5 Lasse Collin     2011-01-12  629  
24fa0402a9b6a5 Lasse Collin     2011-01-12  630  			s->sequence = SEQ_BLOCK_PADDING;
24fa0402a9b6a5 Lasse Collin     2011-01-12  631  
4c1ca831adb101 Nick Desaulniers 2020-11-15  632  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  633  
24fa0402a9b6a5 Lasse Collin     2011-01-12  634  		case SEQ_BLOCK_PADDING:
24fa0402a9b6a5 Lasse Collin     2011-01-12  635  			/*
24fa0402a9b6a5 Lasse Collin     2011-01-12  636  			 * Size of Compressed Data + Block Padding
24fa0402a9b6a5 Lasse Collin     2011-01-12  637  			 * must be a multiple of four. We don't need
24fa0402a9b6a5 Lasse Collin     2011-01-12  638  			 * s->block.compressed for anything else
24fa0402a9b6a5 Lasse Collin     2011-01-12  639  			 * anymore, so we use it here to test the size
24fa0402a9b6a5 Lasse Collin     2011-01-12  640  			 * of the Block Padding field.
24fa0402a9b6a5 Lasse Collin     2011-01-12  641  			 */
24fa0402a9b6a5 Lasse Collin     2011-01-12  642  			while (s->block.compressed & 3) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  643  				if (b->in_pos == b->in_size)
24fa0402a9b6a5 Lasse Collin     2011-01-12  644  					return XZ_OK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  645  
24fa0402a9b6a5 Lasse Collin     2011-01-12  646  				if (b->in[b->in_pos++] != 0)
24fa0402a9b6a5 Lasse Collin     2011-01-12  647  					return XZ_DATA_ERROR;
24fa0402a9b6a5 Lasse Collin     2011-01-12  648  
24fa0402a9b6a5 Lasse Collin     2011-01-12  649  				++s->block.compressed;
24fa0402a9b6a5 Lasse Collin     2011-01-12  650  			}
24fa0402a9b6a5 Lasse Collin     2011-01-12  651  
24fa0402a9b6a5 Lasse Collin     2011-01-12  652  			s->sequence = SEQ_BLOCK_CHECK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  653  
4c1ca831adb101 Nick Desaulniers 2020-11-15  654  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  655  
24fa0402a9b6a5 Lasse Collin     2011-01-12  656  		case SEQ_BLOCK_CHECK:
24fa0402a9b6a5 Lasse Collin     2011-01-12  657  			if (s->check_type == XZ_CHECK_CRC32) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  658  				ret = crc32_validate(s, b);
24fa0402a9b6a5 Lasse Collin     2011-01-12  659  				if (ret != XZ_STREAM_END)
24fa0402a9b6a5 Lasse Collin     2011-01-12  660  					return ret;
24fa0402a9b6a5 Lasse Collin     2011-01-12  661  			}
24fa0402a9b6a5 Lasse Collin     2011-01-12  662  #ifdef XZ_DEC_ANY_CHECK
24fa0402a9b6a5 Lasse Collin     2011-01-12  663  			else if (!check_skip(s, b)) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  664  				return XZ_OK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  665  			}
24fa0402a9b6a5 Lasse Collin     2011-01-12  666  #endif
24fa0402a9b6a5 Lasse Collin     2011-01-12  667  
24fa0402a9b6a5 Lasse Collin     2011-01-12  668  			s->sequence = SEQ_BLOCK_START;
24fa0402a9b6a5 Lasse Collin     2011-01-12  669  			break;
24fa0402a9b6a5 Lasse Collin     2011-01-12  670  
24fa0402a9b6a5 Lasse Collin     2011-01-12  671  		case SEQ_INDEX:
24fa0402a9b6a5 Lasse Collin     2011-01-12  672  			ret = dec_index(s, b);
24fa0402a9b6a5 Lasse Collin     2011-01-12  673  			if (ret != XZ_STREAM_END)
24fa0402a9b6a5 Lasse Collin     2011-01-12  674  				return ret;
24fa0402a9b6a5 Lasse Collin     2011-01-12  675  
24fa0402a9b6a5 Lasse Collin     2011-01-12  676  			s->sequence = SEQ_INDEX_PADDING;
24fa0402a9b6a5 Lasse Collin     2011-01-12  677  
4c1ca831adb101 Nick Desaulniers 2020-11-15  678  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  679  
24fa0402a9b6a5 Lasse Collin     2011-01-12  680  		case SEQ_INDEX_PADDING:
24fa0402a9b6a5 Lasse Collin     2011-01-12  681  			while ((s->index.size + (b->in_pos - s->in_start))
24fa0402a9b6a5 Lasse Collin     2011-01-12  682  					& 3) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  683  				if (b->in_pos == b->in_size) {
24fa0402a9b6a5 Lasse Collin     2011-01-12  684  					index_update(s, b);
24fa0402a9b6a5 Lasse Collin     2011-01-12  685  					return XZ_OK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  686  				}
24fa0402a9b6a5 Lasse Collin     2011-01-12  687  
24fa0402a9b6a5 Lasse Collin     2011-01-12  688  				if (b->in[b->in_pos++] != 0)
24fa0402a9b6a5 Lasse Collin     2011-01-12  689  					return XZ_DATA_ERROR;
24fa0402a9b6a5 Lasse Collin     2011-01-12  690  			}
24fa0402a9b6a5 Lasse Collin     2011-01-12  691  
24fa0402a9b6a5 Lasse Collin     2011-01-12  692  			/* Finish the CRC32 value and Index size. */
24fa0402a9b6a5 Lasse Collin     2011-01-12  693  			index_update(s, b);
24fa0402a9b6a5 Lasse Collin     2011-01-12  694  
24fa0402a9b6a5 Lasse Collin     2011-01-12  695  			/* Compare the hashes to validate the Index field. */
24fa0402a9b6a5 Lasse Collin     2011-01-12  696  			if (!memeq(&s->block.hash, &s->index.hash,
24fa0402a9b6a5 Lasse Collin     2011-01-12  697  					sizeof(s->block.hash)))
24fa0402a9b6a5 Lasse Collin     2011-01-12  698  				return XZ_DATA_ERROR;
24fa0402a9b6a5 Lasse Collin     2011-01-12  699  
24fa0402a9b6a5 Lasse Collin     2011-01-12  700  			s->sequence = SEQ_INDEX_CRC32;
24fa0402a9b6a5 Lasse Collin     2011-01-12  701  
4c1ca831adb101 Nick Desaulniers 2020-11-15  702  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  703  
24fa0402a9b6a5 Lasse Collin     2011-01-12  704  		case SEQ_INDEX_CRC32:
24fa0402a9b6a5 Lasse Collin     2011-01-12  705  			ret = crc32_validate(s, b);
24fa0402a9b6a5 Lasse Collin     2011-01-12  706  			if (ret != XZ_STREAM_END)
24fa0402a9b6a5 Lasse Collin     2011-01-12  707  				return ret;
24fa0402a9b6a5 Lasse Collin     2011-01-12  708  
24fa0402a9b6a5 Lasse Collin     2011-01-12  709  			s->temp.size = STREAM_HEADER_SIZE;
24fa0402a9b6a5 Lasse Collin     2011-01-12  710  			s->sequence = SEQ_STREAM_FOOTER;
24fa0402a9b6a5 Lasse Collin     2011-01-12  711  
4c1ca831adb101 Nick Desaulniers 2020-11-15  712  			fallthrough;
5a244f48ecbbd0 Lasse Collin     2017-05-03  713  
24fa0402a9b6a5 Lasse Collin     2011-01-12  714  		case SEQ_STREAM_FOOTER:
24fa0402a9b6a5 Lasse Collin     2011-01-12  715  			if (!fill_temp(s, b))
24fa0402a9b6a5 Lasse Collin     2011-01-12  716  				return XZ_OK;
24fa0402a9b6a5 Lasse Collin     2011-01-12  717  
24fa0402a9b6a5 Lasse Collin     2011-01-12  718  			return dec_stream_footer(s);
24fa0402a9b6a5 Lasse Collin     2011-01-12  719  		}
24fa0402a9b6a5 Lasse Collin     2011-01-12  720  	}
24fa0402a9b6a5 Lasse Collin     2011-01-12  721  
24fa0402a9b6a5 Lasse Collin     2011-01-12  722  	/* Never reached */
24fa0402a9b6a5 Lasse Collin     2011-01-12  723  }
24fa0402a9b6a5 Lasse Collin     2011-01-12  724  

:::::: The code at line 549 was first introduced by commit
:::::: 24fa0402a9b6a537e87e38341e78b7da86486846 decompressors: add XZ decompressor module

:::::: TO: Lasse Collin <lasse.collin@tukaani.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
