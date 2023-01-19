Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A2674368
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjASUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjASUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:18:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E79B13D;
        Thu, 19 Jan 2023 12:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674159506; x=1705695506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dXacAnPMY8mVEZ8huMGREX1R1yBef6xPx1fIeRYytyA=;
  b=VZewhgDyAA0LeX/4DUI9/6nyRuBjm9a+OfYy8zSM8d6CKvRTmlZttMHo
   LvUbMnbMn56x2d8EeIfLEF4a36WBy8zpWnRbZXCOAWTdPlXq1gKYzucf2
   R8tWiNQXqEvPuhp+uMgxdizPbKfUWaIzXYZIu8b3kB8fo8dJA1F+bJ44B
   OL5pv9FyCRzzmh+ceY1Hl5IiDCyF3RJWOZW9263LDsCUv+LcLxdpIDXEb
   aK3cMcHhqqav4LuSrXgoxOltECmEH0tE2nbumS+QdzzHsqofut+e3ZJ6r
   sd7LhODD9qYmtkZXa0IeHGGKpvLadK3BuXfBPIIFY6fxH7a5UtsQv03eF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327503117"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="327503117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 12:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="723659302"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="723659302"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2023 12:18:20 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIbMZ-0001om-24;
        Thu, 19 Jan 2023 20:18:19 +0000
Date:   Fri, 20 Jan 2023 04:17:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Babis Chalios <bchalios@amazon.es>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, amit@kernel.org, graf@amazon.de,
        Jason@zx2c4.com, xmarcalx@amazon.co.uk
Subject: Re: [PATCH 1/2] virtio-rng: implement entropy leak feature
Message-ID: <202301200407.n4URhGEQ-lkp@intel.com>
References: <20230119184349.74072-2-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119184349.74072-2-bchalios@amazon.es>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babis,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.2-rc4 next-20230119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
patch link:    https://lore.kernel.org/r/20230119184349.74072-2-bchalios%40amazon.es
patch subject: [PATCH 1/2] virtio-rng: implement entropy leak feature
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230120/202301200407.n4URhGEQ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/686114cbba5005584d458ad44164b4a4b88135f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
        git checkout 686114cbba5005584d458ad44164b4a4b88135f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/char/hw_random/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/err.h:8,
                    from drivers/char/hw_random/virtio-rng.c:8:
>> arch/parisc/include/uapi/asm/errno.h:7: warning: "ENOMSG" redefined
       7 | #define ENOMSG          35      /* No message of desired type */
         | 
   In file included from drivers/char/hw_random/virtio-rng.c:7:
   include/uapi/asm-generic/errno.h:23: note: this is the location of the previous definition
      23 | #define ENOMSG          42      /* No message of desired type */
         | 
>> arch/parisc/include/uapi/asm/errno.h:8: warning: "EIDRM" redefined
       8 | #define EIDRM           36      /* Identifier removed */
         | 
   include/uapi/asm-generic/errno.h:24: note: this is the location of the previous definition
      24 | #define EIDRM           43      /* Identifier removed */
         | 
>> arch/parisc/include/uapi/asm/errno.h:9: warning: "ECHRNG" redefined
       9 | #define ECHRNG          37      /* Channel number out of range */
         | 
   include/uapi/asm-generic/errno.h:25: note: this is the location of the previous definition
      25 | #define ECHRNG          44      /* Channel number out of range */
         | 
>> arch/parisc/include/uapi/asm/errno.h:10: warning: "EL2NSYNC" redefined
      10 | #define EL2NSYNC        38      /* Level 2 not synchronized */
         | 
   include/uapi/asm-generic/errno.h:26: note: this is the location of the previous definition
      26 | #define EL2NSYNC        45      /* Level 2 not synchronized */
         | 
>> arch/parisc/include/uapi/asm/errno.h:11: warning: "EL3HLT" redefined
      11 | #define EL3HLT          39      /* Level 3 halted */
         | 
   include/uapi/asm-generic/errno.h:27: note: this is the location of the previous definition
      27 | #define EL3HLT          46      /* Level 3 halted */
         | 
>> arch/parisc/include/uapi/asm/errno.h:12: warning: "EL3RST" redefined
      12 | #define EL3RST          40      /* Level 3 reset */
         | 
   include/uapi/asm-generic/errno.h:28: note: this is the location of the previous definition
      28 | #define EL3RST          47      /* Level 3 reset */
         | 
>> arch/parisc/include/uapi/asm/errno.h:13: warning: "ELNRNG" redefined
      13 | #define ELNRNG          41      /* Link number out of range */
         | 
   include/uapi/asm-generic/errno.h:29: note: this is the location of the previous definition
      29 | #define ELNRNG          48      /* Link number out of range */
         | 
>> arch/parisc/include/uapi/asm/errno.h:14: warning: "EUNATCH" redefined
      14 | #define EUNATCH         42      /* Protocol driver not attached */
         | 
   include/uapi/asm-generic/errno.h:30: note: this is the location of the previous definition
      30 | #define EUNATCH         49      /* Protocol driver not attached */
         | 
>> arch/parisc/include/uapi/asm/errno.h:15: warning: "ENOCSI" redefined
      15 | #define ENOCSI          43      /* No CSI structure available */
         | 
   include/uapi/asm-generic/errno.h:31: note: this is the location of the previous definition
      31 | #define ENOCSI          50      /* No CSI structure available */
         | 
>> arch/parisc/include/uapi/asm/errno.h:16: warning: "EL2HLT" redefined
      16 | #define EL2HLT          44      /* Level 2 halted */
         | 
   include/uapi/asm-generic/errno.h:32: note: this is the location of the previous definition
      32 | #define EL2HLT          51      /* Level 2 halted */
         | 
>> arch/parisc/include/uapi/asm/errno.h:17: warning: "EDEADLK" redefined
      17 | #define EDEADLK         45      /* Resource deadlock would occur */
         | 
   include/uapi/asm-generic/errno.h:7: note: this is the location of the previous definition
       7 | #define EDEADLK         35      /* Resource deadlock would occur */
         | 
>> arch/parisc/include/uapi/asm/errno.h:19: warning: "ENOLCK" redefined
      19 | #define ENOLCK          46      /* No record locks available */
         | 
   include/uapi/asm-generic/errno.h:9: note: this is the location of the previous definition
       9 | #define ENOLCK          37      /* No record locks available */
         | 
>> arch/parisc/include/uapi/asm/errno.h:20: warning: "EILSEQ" redefined
      20 | #define EILSEQ          47      /* Illegal byte sequence */
         | 
   include/uapi/asm-generic/errno.h:67: note: this is the location of the previous definition
      67 | #define EILSEQ          84      /* Illegal byte sequence */
         | 
>> arch/parisc/include/uapi/asm/errno.h:22: warning: "ENONET" redefined
      22 | #define ENONET          50      /* Machine is not on the network */
         | 
   include/uapi/asm-generic/errno.h:47: note: this is the location of the previous definition
      47 | #define ENONET          64      /* Machine is not on the network */
         | 
>> arch/parisc/include/uapi/asm/errno.h:23: warning: "ENODATA" redefined
      23 | #define ENODATA         51      /* No data available */
         | 
   include/uapi/asm-generic/errno.h:44: note: this is the location of the previous definition
      44 | #define ENODATA         61      /* No data available */
         | 
>> arch/parisc/include/uapi/asm/errno.h:24: warning: "ETIME" redefined
      24 | #define ETIME           52      /* Timer expired */
         | 
   include/uapi/asm-generic/errno.h:45: note: this is the location of the previous definition
      45 | #define ETIME           62      /* Timer expired */
         | 
>> arch/parisc/include/uapi/asm/errno.h:25: warning: "ENOSR" redefined
      25 | #define ENOSR           53      /* Out of streams resources */
         | 
   include/uapi/asm-generic/errno.h:46: note: this is the location of the previous definition
      46 | #define ENOSR           63      /* Out of streams resources */
         | 
>> arch/parisc/include/uapi/asm/errno.h:26: warning: "ENOSTR" redefined
      26 | #define ENOSTR          54      /* Device not a stream */
         | 
   include/uapi/asm-generic/errno.h:43: note: this is the location of the previous definition
      43 | #define ENOSTR          60      /* Device not a stream */
         | 
>> arch/parisc/include/uapi/asm/errno.h:27: warning: "ENOPKG" redefined
      27 | #define ENOPKG          55      /* Package not installed */
         | 
   include/uapi/asm-generic/errno.h:48: note: this is the location of the previous definition
      48 | #define ENOPKG          65      /* Package not installed */
         | 
>> arch/parisc/include/uapi/asm/errno.h:29: warning: "ENOLINK" redefined
      29 | #define ENOLINK         57      /* Link has been severed */
         | 
   include/uapi/asm-generic/errno.h:50: note: this is the location of the previous definition
      50 | #define ENOLINK         67      /* Link has been severed */
         | 
   arch/parisc/include/uapi/asm/errno.h:30: warning: "EADV" redefined
      30 | #define EADV            58      /* Advertise error */
         | 
   include/uapi/asm-generic/errno.h:51: note: this is the location of the previous definition
      51 | #define EADV            68      /* Advertise error */
         | 
   arch/parisc/include/uapi/asm/errno.h:31: warning: "ESRMNT" redefined
      31 | #define ESRMNT          59      /* Srmount error */
         | 
   include/uapi/asm-generic/errno.h:52: note: this is the location of the previous definition
      52 | #define ESRMNT          69      /* Srmount error */
         | 
   arch/parisc/include/uapi/asm/errno.h:32: warning: "ECOMM" redefined
      32 | #define ECOMM           60      /* Communication error on send */
         | 
   include/uapi/asm-generic/errno.h:53: note: this is the location of the previous definition
      53 | #define ECOMM           70      /* Communication error on send */
         | 
   arch/parisc/include/uapi/asm/errno.h:33: warning: "EPROTO" redefined
      33 | #define EPROTO          61      /* Protocol error */
         | 
   include/uapi/asm-generic/errno.h:54: note: this is the location of the previous definition
      54 | #define EPROTO          71      /* Protocol error */
         | 
   arch/parisc/include/uapi/asm/errno.h:35: warning: "EMULTIHOP" redefined
      35 | #define EMULTIHOP       64      /* Multihop attempted */
         | 
   include/uapi/asm-generic/errno.h:55: note: this is the location of the previous definition
      55 | #define EMULTIHOP       72      /* Multihop attempted */
         | 
   arch/parisc/include/uapi/asm/errno.h:37: warning: "EDOTDOT" redefined
      37 | #define EDOTDOT         66      /* RFS specific error */
         | 
   include/uapi/asm-generic/errno.h:56: note: this is the location of the previous definition
      56 | #define EDOTDOT         73      /* RFS specific error */
         | 
   arch/parisc/include/uapi/asm/errno.h:38: warning: "EBADMSG" redefined
      38 | #define EBADMSG         67      /* Not a data message */
         | 
   include/uapi/asm-generic/errno.h:57: note: this is the location of the previous definition
      57 | #define EBADMSG         74      /* Not a data message */
         | 
   arch/parisc/include/uapi/asm/errno.h:39: warning: "EUSERS" redefined
      39 | #define EUSERS          68      /* Too many users */
         | 
   include/uapi/asm-generic/errno.h:70: note: this is the location of the previous definition
      70 | #define EUSERS          87      /* Too many users */
         | 
   arch/parisc/include/uapi/asm/errno.h:40: warning: "EDQUOT" redefined
      40 | #define EDQUOT          69      /* Quota exceeded */
         | 
   include/uapi/asm-generic/errno.h:105: note: this is the location of the previous definition
     105 | #define EDQUOT          122     /* Quota exceeded */
         | 
   arch/parisc/include/uapi/asm/errno.h:41: warning: "ESTALE" redefined
      41 | #define ESTALE          70      /* Stale file handle */
         | 
   include/uapi/asm-generic/errno.h:99: note: this is the location of the previous definition
      99 | #define ESTALE          116     /* Stale file handle */
         | 
   arch/parisc/include/uapi/asm/errno.h:42: warning: "EREMOTE" redefined
      42 | #define EREMOTE         71      /* Object is remote */
         | 
   include/uapi/asm-generic/errno.h:49: note: this is the location of the previous definition
      49 | #define EREMOTE         66      /* Object is remote */
         | 
   arch/parisc/include/uapi/asm/errno.h:43: warning: "EOVERFLOW" redefined
      43 | #define EOVERFLOW       72      /* Value too large for defined data type */
         | 
   include/uapi/asm-generic/errno.h:58: note: this is the location of the previous definition
      58 | #define EOVERFLOW       75      /* Value too large for defined data type */
         | 
   arch/parisc/include/uapi/asm/errno.h:47: warning: "EBADE" redefined
      47 | #define EBADE           160     /* Invalid exchange */
         | 
   include/uapi/asm-generic/errno.h:33: note: this is the location of the previous definition
      33 | #define EBADE           52      /* Invalid exchange */
         | 
   arch/parisc/include/uapi/asm/errno.h:48: warning: "EBADR" redefined
      48 | #define EBADR           161     /* Invalid request descriptor */
         | 
   include/uapi/asm-generic/errno.h:34: note: this is the location of the previous definition
      34 | #define EBADR           53      /* Invalid request descriptor */
         | 
   arch/parisc/include/uapi/asm/errno.h:49: warning: "EXFULL" redefined
      49 | #define EXFULL          162     /* Exchange full */
         | 
   include/uapi/asm-generic/errno.h:35: note: this is the location of the previous definition
      35 | #define EXFULL          54      /* Exchange full */
         | 
   arch/parisc/include/uapi/asm/errno.h:50: warning: "ENOANO" redefined
      50 | #define ENOANO          163     /* No anode */
         | 
   include/uapi/asm-generic/errno.h:36: note: this is the location of the previous definition
      36 | #define ENOANO          55      /* No anode */


vim +/ENOMSG +7 arch/parisc/include/uapi/asm/errno.h

^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16    6  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   @7  #define	ENOMSG		35	/* No message of desired type */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   @8  #define	EIDRM		36	/* Identifier removed */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   @9  #define	ECHRNG		37	/* Channel number out of range */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @10  #define	EL2NSYNC	38	/* Level 2 not synchronized */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @11  #define	EL3HLT		39	/* Level 3 halted */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @12  #define	EL3RST		40	/* Level 3 reset */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @13  #define	ELNRNG		41	/* Link number out of range */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @14  #define	EUNATCH		42	/* Protocol driver not attached */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @15  #define	ENOCSI		43	/* No CSI structure available */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @16  #define	EL2HLT		44	/* Level 2 halted */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @17  #define	EDEADLK		45	/* Resource deadlock would occur */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   18  #define	EDEADLOCK	EDEADLK
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @19  #define	ENOLCK		46	/* No record locks available */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @20  #define	EILSEQ		47	/* Illegal byte sequence */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   21  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @22  #define	ENONET		50	/* Machine is not on the network */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @23  #define	ENODATA		51	/* No data available */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @24  #define	ETIME		52	/* Timer expired */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @25  #define	ENOSR		53	/* Out of streams resources */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @26  #define	ENOSTR		54	/* Device not a stream */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @27  #define	ENOPKG		55	/* Package not installed */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   28  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @29  #define	ENOLINK		57	/* Link has been severed */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @30  #define	EADV		58	/* Advertise error */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @31  #define	ESRMNT		59	/* Srmount error */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @32  #define	ECOMM		60	/* Communication error on send */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @33  #define	EPROTO		61	/* Protocol error */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   34  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @35  #define	EMULTIHOP	64	/* Multihop attempted */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   36  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @37  #define	EDOTDOT		66	/* RFS specific error */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @38  #define	EBADMSG		67	/* Not a data message */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @39  #define	EUSERS		68	/* Too many users */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @40  #define	EDQUOT		69	/* Quota exceeded */
0ca43435188b9f arch/parisc/include/uapi/asm/errno.h Eric Sandeen        2013-11-12  @41  #define	ESTALE		70	/* Stale file handle */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @42  #define	EREMOTE		71	/* Object is remote */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @43  #define	EOVERFLOW	72	/* Value too large for defined data type */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   44  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   45  /* these errnos are defined by Linux but not HPUX. */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   46  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @47  #define	EBADE		160	/* Invalid exchange */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @48  #define	EBADR		161	/* Invalid request descriptor */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @49  #define	EXFULL		162	/* Exchange full */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @50  #define	ENOANO		163	/* No anode */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @51  #define	EBADRQC		164	/* Invalid request code */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @52  #define	EBADSLT		165	/* Invalid slot */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @53  #define	EBFONT		166	/* Bad font file format */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @54  #define	ENOTUNIQ	167	/* Name not unique on network */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @55  #define	EBADFD		168	/* File descriptor in bad state */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @56  #define	EREMCHG		169	/* Remote address changed */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @57  #define	ELIBACC		170	/* Can not access a needed shared library */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @58  #define	ELIBBAD		171	/* Accessing a corrupted shared library */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @59  #define	ELIBSCN		172	/* .lib section in a.out corrupted */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @60  #define	ELIBMAX		173	/* Attempting to link in too many shared libraries */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @61  #define	ELIBEXEC	174	/* Cannot exec a shared library directly */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @62  #define	ERESTART	175	/* Interrupted system call should be restarted */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @63  #define	ESTRPIPE	176	/* Streams pipe error */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @64  #define	EUCLEAN		177	/* Structure needs cleaning */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @65  #define	ENOTNAM		178	/* Not a XENIX named type file */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @66  #define	ENAVAIL		179	/* No XENIX semaphores available */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @67  #define	EISNAM		180	/* Is a named type file */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @68  #define	EREMOTEIO	181	/* Remote I/O error */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @69  #define	ENOMEDIUM	182	/* No medium found */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @70  #define	EMEDIUMTYPE	183	/* Wrong medium type */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @71  #define	ENOKEY		184	/* Required key not available */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @72  #define	EKEYEXPIRED	185	/* Key has expired */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @73  #define	EKEYREVOKED	186	/* Key has been revoked */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @74  #define	EKEYREJECTED	187	/* Key was rejected by service */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   75  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   76  /* We now return you to your regularly scheduled HPUX. */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   77  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16   78  #define ENOSYM		215	/* symbol does not exist in executable */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @79  #define	ENOTSOCK	216	/* Socket operation on non-socket */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @80  #define	EDESTADDRREQ	217	/* Destination address required */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @81  #define	EMSGSIZE	218	/* Message too long */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @82  #define	EPROTOTYPE	219	/* Protocol wrong type for socket */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @83  #define	ENOPROTOOPT	220	/* Protocol not available */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @84  #define	EPROTONOSUPPORT	221	/* Protocol not supported */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @85  #define	ESOCKTNOSUPPORT	222	/* Socket type not supported */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @86  #define	EOPNOTSUPP	223	/* Operation not supported on transport endpoint */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @87  #define	EPFNOSUPPORT	224	/* Protocol family not supported */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @88  #define	EAFNOSUPPORT	225	/* Address family not supported by protocol */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @89  #define	EADDRINUSE	226	/* Address already in use */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @90  #define	EADDRNOTAVAIL	227	/* Cannot assign requested address */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @91  #define	ENETDOWN	228	/* Network is down */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @92  #define	ENETUNREACH	229	/* Network is unreachable */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @93  #define	ENETRESET	230	/* Network dropped connection because of reset */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @94  #define	ECONNABORTED	231	/* Software caused connection abort */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @95  #define	ECONNRESET	232	/* Connection reset by peer */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @96  #define	ENOBUFS		233	/* No buffer space available */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @97  #define	EISCONN		234	/* Transport endpoint is already connected */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @98  #define	ENOTCONN	235	/* Transport endpoint is not connected */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  @99  #define	ESHUTDOWN	236	/* Cannot send after transport endpoint shutdown */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @100  #define	ETOOMANYREFS	237	/* Too many references: cannot splice */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @101  #define	ETIMEDOUT	238	/* Connection timed out */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @102  #define	ECONNREFUSED	239	/* Connection refused */
3eb53b20d7bd13 arch/parisc/include/uapi/asm/errno.h Helge Deller        2016-08-20  103  #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  104  #define	EREMOTERELEASE	240	/* Remote peer released connection */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @105  #define	EHOSTDOWN	241	/* Host is down */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @106  #define	EHOSTUNREACH	242	/* No route to host */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  107  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @108  #define	EALREADY	244	/* Operation already in progress */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @109  #define	EINPROGRESS	245	/* Operation now in progress */
f5a408d53edef3 arch/parisc/include/uapi/asm/errno.h Guy Martin          2014-01-16  110  #define	EWOULDBLOCK	EAGAIN	/* Operation would block (Not HPUX compliant) */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @111  #define	ENOTEMPTY	247	/* Directory not empty */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @112  #define	ENAMETOOLONG	248	/* File name too long */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @113  #define	ELOOP		249	/* Too many symbolic links encountered */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16 @114  #define	ENOSYS		251	/* Function not implemented */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  115  
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  116  #define ECANCELLED	253	/* aio request was canceled before complete (POSIX.4 / HPUX) */
05aa10de701409 include/asm-parisc/errno.h           Grant Grundler      2005-10-21 @117  #define ECANCELED	ECANCELLED	/* SuSv3 and Solaris wants one 'L' */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  118  
4750e2c0c59e0c include/asm-parisc/errno.h           Joe Korty           2005-05-01  119  /* for robust mutexes */
4750e2c0c59e0c include/asm-parisc/errno.h           Joe Korty           2005-05-01 @120  #define EOWNERDEAD	254	/* Owner died */
4750e2c0c59e0c include/asm-parisc/errno.h           Joe Korty           2005-05-01 @121  #define ENOTRECOVERABLE	255	/* State not recoverable */
4750e2c0c59e0c include/asm-parisc/errno.h           Joe Korty           2005-05-01  122  
7d217d7ffc3433 arch/parisc/include/asm/errno.h      Alexander Beregalov 2009-06-07 @123  #define	ERFKILL		256	/* Operation not possible due to RF-kill */
^1da177e4c3f41 include/asm-parisc/errno.h           Linus Torvalds      2005-04-16  124  
69ebb83e13e514 arch/parisc/include/asm/errno.h      Huang Ying          2011-01-30 @125  #define EHWPOISON	257	/* Memory page has hardware error */
69ebb83e13e514 arch/parisc/include/asm/errno.h      Huang Ying          2011-01-30  126  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
