Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7515728780
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjFHSvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjFHSvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:51:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1C2136
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686250303; x=1717786303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Do546SqSlw1K7uHgwulKmaY0ZDHBN3zEv/4nGSGHnZ8=;
  b=PtityK7gwHE7wIh1Ma9FkMMJbzHhUvvLAJ7LVk3Esj5y4CtZLqN2Afpm
   Mh3wlk/Jxz3lkYyGi1DgoQQLi0nCON5K7tm2aQOvqEkhy0KWKVAL57dAq
   /Jk83GDokfspvZ9CeE7QoHeG9DQgApc7kpbdoA15TfLFhr9WXIjvfBkFB
   rQKxR1bKe5oesNCc7v6Q1j8KAfmiRnzSJaUrPi+e7F995asdyUhC6GH+p
   KkkhYpjIWPLg7vILNYiPzWKTgf1bsSyWw2UvqKFjn3MJI8NXQbX518r9C
   E5/n/0P8stxJJTf9R7BQzMts6B+Y7cKuxGxVGKP7veaIEnrDKWz2ors19
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342075811"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="342075811"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 11:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="1040206616"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="1040206616"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2023 11:51:41 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7KjU-0008Ay-2K;
        Thu, 08 Jun 2023 18:51:40 +0000
Date:   Fri, 9 Jun 2023 02:50:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/verifier.c:8221:12: warning: stack frame size (2144)
 exceeds limit (2048) in 'check_kfunc_args'
Message-ID: <202306090228.JIljoJa6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumar,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a
commit: ac9f06050a3580cf4076a57a470cd71f12a81171 bpf: Introduce bpf_obj_drop
date:   7 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230609/202306090228.JIljoJa6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac9f06050a3580cf4076a57a470cd71f12a81171
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ac9f06050a3580cf4076a57a470cd71f12a81171
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/f2fs/ kernel/bpf/ lib/zstd/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090228.JIljoJa6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c:14822:12: warning: stack frame size (3024) exceeds limit (2048) in 'do_misc_fixups' [-Wframe-larger-than]
   static int do_misc_fixups(struct bpf_verifier_env *env)
              ^
   kernel/bpf/verifier.c:13035:12: warning: stack frame size (3280) exceeds limit (2048) in 'do_check' [-Wframe-larger-than]
   static int do_check(struct bpf_verifier_env *env)
              ^
>> kernel/bpf/verifier.c:8221:12: warning: stack frame size (2144) exceeds limit (2048) in 'check_kfunc_args' [-Wframe-larger-than]
   static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
              ^
   3 warnings generated.


vim +/check_kfunc_args +8221 kernel/bpf/verifier.c

00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8220  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18 @8221  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8222  {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8223  	const char *func_name = meta->func_name, *ref_tname;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8224  	const struct btf *btf = meta->btf;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8225  	const struct btf_param *args;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8226  	u32 i, nargs;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8227  	int ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8228  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8229  	args = (const struct btf_param *)(meta->func_proto + 1);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8230  	nargs = btf_type_vlen(meta->func_proto);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8231  	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8232  		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8233  			MAX_BPF_FUNC_REG_ARGS);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8234  		return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8235  	}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8236  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8237  	/* Check that BTF function arguments match actual types that the
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8238  	 * verifier sees.
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8239  	 */
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8240  	for (i = 0; i < nargs; i++) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8241  		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8242  		const struct btf_type *t, *ref_t, *resolve_ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8243  		enum bpf_arg_type arg_type = ARG_DONTCARE;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8244  		u32 regno = i + 1, ref_id, type_size;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8245  		bool is_ret_buf_sz = false;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8246  		int kf_arg_type;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8247  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8248  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
958cf2e273f0929 Kumar Kartikeya Dwivedi 2022-11-18  8249  
958cf2e273f0929 Kumar Kartikeya Dwivedi 2022-11-18  8250  		if (is_kfunc_arg_ignore(btf, &args[i]))
958cf2e273f0929 Kumar Kartikeya Dwivedi 2022-11-18  8251  			continue;
958cf2e273f0929 Kumar Kartikeya Dwivedi 2022-11-18  8252  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8253  		if (btf_type_is_scalar(t)) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8254  			if (reg->type != SCALAR_VALUE) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8255  				verbose(env, "R%d is not a scalar\n", regno);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8256  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8257  			}
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8258  
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8259  			if (is_kfunc_arg_constant(meta->btf, &args[i])) {
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8260  				if (meta->arg_constant.found) {
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8261  					verbose(env, "verifier internal error: only one constant argument permitted\n");
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8262  					return -EFAULT;
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8263  				}
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8264  				if (!tnum_is_const(reg->var_off)) {
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8265  					verbose(env, "R%d must be a known constant\n", regno);
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8266  					return -EINVAL;
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8267  				}
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8268  				ret = mark_chain_precision(env, regno);
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8269  				if (ret < 0)
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8270  					return ret;
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8271  				meta->arg_constant.found = true;
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8272  				meta->arg_constant.value = reg->var_off.value;
a50388dbb328a42 Kumar Kartikeya Dwivedi 2022-11-18  8273  			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8274  				meta->r0_rdonly = true;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8275  				is_ret_buf_sz = true;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8276  			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8277  				is_ret_buf_sz = true;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8278  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8279  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8280  			if (is_ret_buf_sz) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8281  				if (meta->r0_size) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8282  					verbose(env, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8283  					return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8284  				}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8285  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8286  				if (!tnum_is_const(reg->var_off)) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8287  					verbose(env, "R%d is not a const\n", regno);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8288  					return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8289  				}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8290  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8291  				meta->r0_size = reg->var_off.value;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8292  				ret = mark_chain_precision(env, regno);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8293  				if (ret)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8294  					return ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8295  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8296  			continue;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8297  		}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8298  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8299  		if (!btf_type_is_ptr(t)) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8300  			verbose(env, "Unrecognized arg#%d type %s\n", i, btf_type_str(t));
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8301  			return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8302  		}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8303  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8304  		if (reg->ref_obj_id) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8305  			if (is_kfunc_release(meta) && meta->ref_obj_id) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8306  				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8307  					regno, reg->ref_obj_id,
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8308  					meta->ref_obj_id);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8309  				return -EFAULT;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8310  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8311  			meta->ref_obj_id = reg->ref_obj_id;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8312  			if (is_kfunc_release(meta))
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8313  				meta->release_regno = regno;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8314  		}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8315  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8316  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8317  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8318  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8319  		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname, args, i, nargs);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8320  		if (kf_arg_type < 0)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8321  			return kf_arg_type;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8322  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8323  		switch (kf_arg_type) {
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8324  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8325  		case KF_ARG_PTR_TO_BTF_ID:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8326  			if (!is_kfunc_trusted_args(meta))
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8327  				break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8328  			if (!reg->ref_obj_id) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8329  				verbose(env, "R%d must be referenced\n", regno);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8330  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8331  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8332  			fallthrough;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8333  		case KF_ARG_PTR_TO_CTX:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8334  			/* Trusted arguments have the same offset checks as release arguments */
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8335  			arg_type |= OBJ_RELEASE;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8336  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8337  		case KF_ARG_PTR_TO_KPTR:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8338  		case KF_ARG_PTR_TO_DYNPTR:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8339  		case KF_ARG_PTR_TO_MEM:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8340  		case KF_ARG_PTR_TO_MEM_SIZE:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8341  			/* Trusted by default */
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8342  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8343  		default:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8344  			WARN_ON_ONCE(1);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8345  			return -EFAULT;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8346  		}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8347  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8348  		if (is_kfunc_release(meta) && reg->ref_obj_id)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8349  			arg_type |= OBJ_RELEASE;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8350  		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8351  		if (ret < 0)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8352  			return ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8353  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8354  		switch (kf_arg_type) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8355  		case KF_ARG_PTR_TO_CTX:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8356  			if (reg->type != PTR_TO_CTX) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8357  				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8358  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8359  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8360  			break;
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8361  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8362  			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8363  				verbose(env, "arg#%d expected pointer to allocated object\n", i);
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8364  				return -EINVAL;
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8365  			}
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8366  			if (!reg->ref_obj_id) {
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8367  				verbose(env, "allocated object must be referenced\n");
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8368  				return -EINVAL;
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8369  			}
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8370  			if (meta->btf == btf_vmlinux &&
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8371  			    meta->func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8372  				meta->arg_obj_drop.btf = reg->btf;
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8373  				meta->arg_obj_drop.btf_id = reg->btf_id;
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8374  			}
ac9f06050a3580c Kumar Kartikeya Dwivedi 2022-11-18  8375  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8376  		case KF_ARG_PTR_TO_KPTR:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8377  			if (reg->type != PTR_TO_MAP_VALUE) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8378  				verbose(env, "arg#0 expected pointer to map value\n");
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8379  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8380  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8381  			ret = process_kf_arg_ptr_to_kptr(env, reg, ref_t, ref_tname, meta, i);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8382  			if (ret < 0)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8383  				return ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8384  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8385  		case KF_ARG_PTR_TO_DYNPTR:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8386  			if (reg->type != PTR_TO_STACK) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8387  				verbose(env, "arg#%d expected pointer to stack\n", i);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8388  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8389  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8390  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8391  			if (!is_dynptr_reg_valid_init(env, reg)) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8392  				verbose(env, "arg#%d pointer type %s %s must be valid and initialized\n",
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8393  					i, btf_type_str(ref_t), ref_tname);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8394  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8395  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8396  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8397  			if (!is_dynptr_type_expected(env, reg, ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8398  				verbose(env, "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8399  					i, btf_type_str(ref_t), ref_tname);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8400  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8401  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8402  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8403  		case KF_ARG_PTR_TO_BTF_ID:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8404  			/* Only base_type is checked, further checks are done here */
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8405  			if (reg->type != PTR_TO_BTF_ID &&
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8406  			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8407  				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8408  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8409  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8410  			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8411  			if (ret < 0)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8412  				return ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8413  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8414  		case KF_ARG_PTR_TO_MEM:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8415  			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8416  			if (IS_ERR(resolve_ret)) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8417  				verbose(env, "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8418  					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8419  				return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8420  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8421  			ret = check_mem_reg(env, reg, regno, type_size);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8422  			if (ret < 0)
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8423  				return ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8424  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8425  		case KF_ARG_PTR_TO_MEM_SIZE:
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8426  			ret = check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8427  			if (ret < 0) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8428  				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8429  				return ret;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8430  			}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8431  			/* Skip next '__sz' argument */
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8432  			i++;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8433  			break;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8434  		}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8435  	}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8436  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8437  	if (is_kfunc_release(meta) && !meta->release_regno) {
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8438  		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8439  			func_name);
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8440  		return -EINVAL;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8441  	}
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8442  
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8443  	return 0;
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8444  }
00b85860feb8098 Kumar Kartikeya Dwivedi 2022-11-18  8445  

:::::: The code at line 8221 was first introduced by commit
:::::: 00b85860feb809852af9a88cb4ca8766d7dff6a3 bpf: Rewrite kfunc argument handling

:::::: TO: Kumar Kartikeya Dwivedi <memxor@gmail.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
