Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5492C6F4BDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjEBVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjEBVDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:03:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418B2D69;
        Tue,  2 May 2023 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683061422; x=1714597422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kUyYt07vWYySJndOqYqER3ME1xU26/le/U4sSLqcBNs=;
  b=bzIyRHwLZpqA9kb+J+GDyiXkZYqy2Mjhgrl5dYD7vFnW9sjXbWtw94M1
   6LmEphknANX/xGxtwuxytoqxwa9Un7ktQJ4QggpAKGd2pMAO0hUtyjVlB
   MNHv1RV/zwkGf7WaUlbwjqz0BjPtyyQMyx87QyJNV8jplBKK8q9tkQY+W
   rpnzzKmphUMjxmhkVuwT4G1NVZUAk+a95k61ZsJAh0geHha/XpSRcMHr7
   RcWUzbia+foyEpVaFThnCjasDcHEtL/OTm92f6xTYkeW8Md2fZzXrQXIf
   vfyz6clAxp360JCNpWTZAy+P7crGWapP8NGnFrAkmY5jxvNJFfoBC4kTO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="413956685"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="413956685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 14:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="840438674"
X-IronPort-AV: E=Sophos;i="5.99,245,1677571200"; 
   d="scan'208";a="840438674"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2023 14:03:39 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptx9u-0001Hs-0b;
        Tue, 02 May 2023 21:03:38 +0000
Date:   Wed, 3 May 2023 05:03:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mortonm@chromium.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LSM: SafeSetID: fix UID printed instead of GID
Message-ID: <202305030431.SqnvfRsU-lkp@intel.com>
References: <20230502141832.217234-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502141832.217234-1-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on pcmoore-selinux/next linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Mikhalitsyn/LSM-SafeSetID-fix-UID-printed-instead-of-GID/20230502-222024
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
patch link:    https://lore.kernel.org/r/20230502141832.217234-1-aleksandr.mikhalitsyn%40canonical.com
patch subject: [PATCH] LSM: SafeSetID: fix UID printed instead of GID
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230503/202305030431.SqnvfRsU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9feeb800b8aaabd299e4b9f2a81f04de983046c0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Mikhalitsyn/LSM-SafeSetID-fix-UID-printed-instead-of-GID/20230502-222024
        git checkout 9feeb800b8aaabd299e4b9f2a81f04de983046c0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305030431.SqnvfRsU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from arch/mips/include/asm/cmpxchg.h:11,
                    from arch/mips/include/asm/atomic.h:23,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rbtree.h:24,
                    from include/linux/key.h:15,
                    from include/linux/security.h:27,
                    from include/linux/lsm_hooks.h:28,
                    from security/safesetid/lsm.c:17:
   security/safesetid/lsm.c: In function 'safesetid_security_capable':
>> security/safesetid/lsm.c:134:40: error: incompatible type for argument 1 of '__kuid_val'
     134 |                         __kuid_val(cred->gid));
         |                                    ~~~~^~~~~
         |                                        |
         |                                        kgid_t
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:508:9: note: in expansion of macro 'printk'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   security/safesetid/lsm.c:133:17: note: in expansion of macro 'pr_warn'
     133 |                 pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
         |                 ^~~~~~~
   In file included from include/linux/sysctl.h:29,
                    from include/linux/key.h:17:
   include/linux/uidgid.h:34:39: note: expected 'kuid_t' but argument is of type 'kgid_t'
      34 | static inline uid_t __kuid_val(kuid_t uid)
         |                                ~~~~~~~^~~


vim +/__kuid_val +134 security/safesetid/lsm.c

    16	
  > 17	#include <linux/lsm_hooks.h>
    18	#include <linux/module.h>
    19	#include <linux/ptrace.h>
    20	#include <linux/sched/task_stack.h>
    21	#include <linux/security.h>
    22	#include "lsm.h"
    23	
    24	/* Flag indicating whether initialization completed */
    25	int safesetid_initialized __initdata;
    26	
    27	struct setid_ruleset __rcu *safesetid_setuid_rules;
    28	struct setid_ruleset __rcu *safesetid_setgid_rules;
    29	
    30	
    31	/* Compute a decision for a transition from @src to @dst under @policy. */
    32	enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
    33			kid_t src, kid_t dst)
    34	{
    35		struct setid_rule *rule;
    36		enum sid_policy_type result = SIDPOL_DEFAULT;
    37	
    38		if (policy->type == UID) {
    39			hash_for_each_possible(policy->rules, rule, next, __kuid_val(src.uid)) {
    40				if (!uid_eq(rule->src_id.uid, src.uid))
    41					continue;
    42				if (uid_eq(rule->dst_id.uid, dst.uid))
    43					return SIDPOL_ALLOWED;
    44				result = SIDPOL_CONSTRAINED;
    45			}
    46		} else if (policy->type == GID) {
    47			hash_for_each_possible(policy->rules, rule, next, __kgid_val(src.gid)) {
    48				if (!gid_eq(rule->src_id.gid, src.gid))
    49					continue;
    50				if (gid_eq(rule->dst_id.gid, dst.gid)){
    51					return SIDPOL_ALLOWED;
    52				}
    53				result = SIDPOL_CONSTRAINED;
    54			}
    55		} else {
    56			/* Should not reach here, report the ID as contrainsted */
    57			result = SIDPOL_CONSTRAINED;
    58		}
    59		return result;
    60	}
    61	
    62	/*
    63	 * Compute a decision for a transition from @src to @dst under the active
    64	 * policy.
    65	 */
    66	static enum sid_policy_type setid_policy_lookup(kid_t src, kid_t dst, enum setid_type new_type)
    67	{
    68		enum sid_policy_type result = SIDPOL_DEFAULT;
    69		struct setid_ruleset *pol;
    70	
    71		rcu_read_lock();
    72		if (new_type == UID)
    73			pol = rcu_dereference(safesetid_setuid_rules);
    74		else if (new_type == GID)
    75			pol = rcu_dereference(safesetid_setgid_rules);
    76		else { /* Should not reach here */
    77			result = SIDPOL_CONSTRAINED;
    78			rcu_read_unlock();
    79			return result;
    80		}
    81	
    82		if (pol) {
    83			pol->type = new_type;
    84			result = _setid_policy_lookup(pol, src, dst);
    85		}
    86		rcu_read_unlock();
    87		return result;
    88	}
    89	
    90	static int safesetid_security_capable(const struct cred *cred,
    91					      struct user_namespace *ns,
    92					      int cap,
    93					      unsigned int opts)
    94	{
    95		/* We're only interested in CAP_SETUID and CAP_SETGID. */
    96		if (cap != CAP_SETUID && cap != CAP_SETGID)
    97			return 0;
    98	
    99		/*
   100		 * If CAP_SET{U/G}ID is currently used for a setid or setgroups syscall, we
   101		 * want to let it go through here; the real security check happens later, in
   102		 * the task_fix_set{u/g}id or task_fix_setgroups hooks.
   103		 */
   104		if ((opts & CAP_OPT_INSETID) != 0)
   105			return 0;
   106	
   107		switch (cap) {
   108		case CAP_SETUID:
   109			/*
   110			* If no policy applies to this task, allow the use of CAP_SETUID for
   111			* other purposes.
   112			*/
   113			if (setid_policy_lookup((kid_t){.uid = cred->uid}, INVALID_ID, UID) == SIDPOL_DEFAULT)
   114				return 0;
   115			/*
   116			 * Reject use of CAP_SETUID for functionality other than calling
   117			 * set*uid() (e.g. setting up userns uid mappings).
   118			 */
   119			pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
   120				__kuid_val(cred->uid));
   121			return -EPERM;
   122		case CAP_SETGID:
   123			/*
   124			* If no policy applies to this task, allow the use of CAP_SETGID for
   125			* other purposes.
   126			*/
   127			if (setid_policy_lookup((kid_t){.gid = cred->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
   128				return 0;
   129			/*
   130			 * Reject use of CAP_SETUID for functionality other than calling
   131			 * set*gid() (e.g. setting up userns gid mappings).
   132			 */
   133			pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
 > 134				__kuid_val(cred->gid));
   135			return -EPERM;
   136		default:
   137			/* Error, the only capabilities were checking for is CAP_SETUID/GID */
   138			return 0;
   139		}
   140		return 0;
   141	}
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
