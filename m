Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5099174FB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGKWj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGKWj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:39:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57EE5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689115166; x=1720651166;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H35hh2eCOlupriQYSROoxTxTb6q7rwmY7bz+sP4Na44=;
  b=T8VmZ9KDaavMzMkAiOYWBXBGikejsrDiFeO0tLXByPIrqRD0tCU82eVO
   SBK8bRSh0f/y1oUZKyg/gWqlgSVYM9SMH33vrJsw07AVajh8aBEq2yZ4R
   xf4xaKoR+IhGfwJsEXmmWspkM2rLMyhxfQHNcWiVzlQmHijFo2j1iL9aR
   jVAxSy+Q+q0Wx+6kM5tTJUYWVphFdWu+6buIFBisJFYhxcZkJq+oC4TYf
   I5gqhpO/eGCky5ZN34xt4dnsRP3MoKaJf6uGkzAMED6eM4VrR6CublaDK
   l3Yad0/KqZuivhfUgR4TTXmf8G9D7244kGsFagb7FtK6+dKeOiIzmVRpv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354653348"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="354653348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 15:39:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698623689"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="698623689"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2023 15:39:24 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJM0x-0005AD-2q;
        Tue, 11 Jul 2023 22:39:23 +0000
Date:   Wed, 12 Jul 2023 06:38:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/crypto/ccree/cc_aead.c:541:12: warning: stack frame size
 (1104) exceeds limit (1024) in 'cc_aead_setkey'
Message-ID: <202307120605.u4Quc7pF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
commit: 607e57c6c62c00965ae276902c166834ce73014a hardening: Remove Clang's enable flag for -ftrivial-auto-var-init=zero
date:   10 months ago
config: powerpc-randconfig-r024-20230712 (https://download.01.org/0day-ci/archive/20230712/202307120605.u4Quc7pF-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230712/202307120605.u4Quc7pF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307120605.u4Quc7pF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/ccree/cc_aead.c:541:12: warning: stack frame size (1104) exceeds limit (1024) in 'cc_aead_setkey' [-Wframe-larger-than]
   static int cc_aead_setkey(struct crypto_aead *tfm, const u8 *key,
              ^
   296/1104 (26.81%) spills, 808/1104 (73.19%) variables
   1 warning generated.


vim +/cc_aead_setkey +541 drivers/crypto/ccree/cc_aead.c

ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  540  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22 @541  static int cc_aead_setkey(struct crypto_aead *tfm, const u8 *key,
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  542  			  unsigned int keylen)
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  543  {
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  544  	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  545  	struct cc_crypto_req cc_req = {};
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  546  	struct cc_hw_desc desc[MAX_AEAD_SETKEY_SEQ];
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  547  	unsigned int seq_len = 0;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  548  	struct device *dev = drvdata_to_dev(ctx->drvdata);
dc95b5350a8f07 Eric Biggers     2018-12-16  549  	const u8 *enckey, *authkey;
dc95b5350a8f07 Eric Biggers     2018-12-16  550  	int rc;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  551  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  552  	dev_dbg(dev, "Setting key in context @%p for %s. key=%p keylen=%u\n",
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  553  		ctx, crypto_tfm_alg_name(crypto_aead_tfm(tfm)), key, keylen);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  554  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  555  	/* STAT_PHASE_0: Init and sanity checks */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  556  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  557  	if (ctx->auth_mode != DRV_HASH_NULL) { /* authenc() alg. */
dc95b5350a8f07 Eric Biggers     2018-12-16  558  		struct crypto_authenc_keys keys;
dc95b5350a8f07 Eric Biggers     2018-12-16  559  
dc95b5350a8f07 Eric Biggers     2018-12-16  560  		rc = crypto_authenc_extractkeys(&keys, key, keylen);
dc95b5350a8f07 Eric Biggers     2018-12-16  561  		if (rc)
674f368a952c48 Eric Biggers     2019-12-30  562  			return rc;
dc95b5350a8f07 Eric Biggers     2018-12-16  563  		enckey = keys.enckey;
dc95b5350a8f07 Eric Biggers     2018-12-16  564  		authkey = keys.authkey;
dc95b5350a8f07 Eric Biggers     2018-12-16  565  		ctx->enc_keylen = keys.enckeylen;
dc95b5350a8f07 Eric Biggers     2018-12-16  566  		ctx->auth_keylen = keys.authkeylen;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  567  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  568  		if (ctx->cipher_mode == DRV_CIPHER_CTR) {
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  569  			/* the nonce is stored in bytes at end of key */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  570  			if (ctx->enc_keylen <
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  571  			    (AES_MIN_KEY_SIZE + CTR_RFC3686_NONCE_SIZE))
674f368a952c48 Eric Biggers     2019-12-30  572  				return -EINVAL;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  573  			/* Copy nonce from last 4 bytes in CTR key to
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  574  			 *  first 4 bytes in CTR IV
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  575  			 */
dc95b5350a8f07 Eric Biggers     2018-12-16  576  			memcpy(ctx->ctr_nonce, enckey + ctx->enc_keylen -
dc95b5350a8f07 Eric Biggers     2018-12-16  577  			       CTR_RFC3686_NONCE_SIZE, CTR_RFC3686_NONCE_SIZE);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  578  			/* Set CTR key size */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  579  			ctx->enc_keylen -= CTR_RFC3686_NONCE_SIZE;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  580  		}
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  581  	} else { /* non-authenc - has just one key */
dc95b5350a8f07 Eric Biggers     2018-12-16  582  		enckey = key;
dc95b5350a8f07 Eric Biggers     2018-12-16  583  		authkey = NULL;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  584  		ctx->enc_keylen = keylen;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  585  		ctx->auth_keylen = 0;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  586  	}
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  587  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  588  	rc = validate_keys_sizes(ctx);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  589  	if (rc)
674f368a952c48 Eric Biggers     2019-12-30  590  		return rc;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  591  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  592  	/* STAT_PHASE_1: Copy key to ctx */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  593  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  594  	/* Get key material */
dc95b5350a8f07 Eric Biggers     2018-12-16  595  	memcpy(ctx->enckey, enckey, ctx->enc_keylen);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  596  	if (ctx->enc_keylen == 24)
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  597  		memset(ctx->enckey + 24, 0, CC_AES_KEY_SIZE_MAX - 24);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  598  	if (ctx->auth_mode == DRV_HASH_XCBC_MAC) {
dc95b5350a8f07 Eric Biggers     2018-12-16  599  		memcpy(ctx->auth_state.xcbc.xcbc_keys, authkey,
dc95b5350a8f07 Eric Biggers     2018-12-16  600  		       ctx->auth_keylen);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  601  	} else if (ctx->auth_mode != DRV_HASH_NULL) { /* HMAC */
dc95b5350a8f07 Eric Biggers     2018-12-16  602  		rc = cc_get_plain_hmac_key(tfm, authkey, ctx->auth_keylen);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  603  		if (rc)
674f368a952c48 Eric Biggers     2019-12-30  604  			return rc;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  605  	}
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  606  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  607  	/* STAT_PHASE_2: Create sequence */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  608  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  609  	switch (ctx->auth_mode) {
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  610  	case DRV_HASH_SHA1:
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  611  	case DRV_HASH_SHA256:
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  612  		seq_len = hmac_setkey(desc, ctx);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  613  		break;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  614  	case DRV_HASH_XCBC_MAC:
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  615  		seq_len = xcbc_setkey(desc, ctx);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  616  		break;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  617  	case DRV_HASH_NULL: /* non-authenc modes, e.g., CCM */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  618  		break; /* No auth. key setup */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  619  	default:
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  620  		dev_err(dev, "Unsupported authenc (%d)\n", ctx->auth_mode);
674f368a952c48 Eric Biggers     2019-12-30  621  		return -ENOTSUPP;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  622  	}
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  623  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  624  	/* STAT_PHASE_3: Submit sequence to HW */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  625  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  626  	if (seq_len > 0) { /* For CCM there is no sequence to setup the key */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  627  		rc = cc_send_sync_request(ctx->drvdata, &cc_req, desc, seq_len);
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  628  		if (rc) {
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  629  			dev_err(dev, "send_request() failed (rc=%d)\n", rc);
674f368a952c48 Eric Biggers     2019-12-30  630  			return rc;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  631  		}
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  632  	}
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  633  
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  634  	/* Update STAT_PHASE_3 */
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  635  	return rc;
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  636  }
ff27e85a85bbde Gilad Ben-Yossef 2018-01-22  637  

:::::: The code at line 541 was first introduced by commit
:::::: ff27e85a85bbde19589f775297db92ff925e5981 crypto: ccree - add AEAD support

:::::: TO: Gilad Ben-Yossef <gilad@benyossef.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
