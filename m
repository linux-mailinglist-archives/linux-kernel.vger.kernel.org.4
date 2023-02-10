Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6DB692AFB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBJXIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBJXID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:08:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA5D7A7D3;
        Fri, 10 Feb 2023 15:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676070482; x=1707606482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7sQU3qLBarJwbOltvPK0DlyIvdrrHZ36gjP2djkEoxE=;
  b=TKDM7YZ6TxPmwtMNXYj/aLO3SOtmw5Qw43Q23v32KornjUacdzIDFwF/
   5+lkkzCAej9g5w/981+mGUOC7Kc049JD2uzg+y0iya16k1JRLChC/uqPG
   nZkHHOZkM4Sp92sfk68vhsWuamtpvl+3IyqM5kVIwG25jEzfbVoXCwc6k
   toC3WKgIapV/9hyvwIxvoFVQ8Qx9bBQF1EuDfYCGx4lo0y8KkjJngKiqy
   VkKPuUG2jnf+xJsrJwsOeSxWmKgsK3kVrVKnFkN5O3GGCjoKxhL3iUq4R
   PYoTK66DetcDHHDqQ54fRA9OnGbpP0GCP3RHqWBBEPl9p9t252Sg3PFDq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329181039"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329181039"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="618045959"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="618045959"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2023 15:07:50 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQcUf-00066n-1G;
        Fri, 10 Feb 2023 23:07:49 +0000
Date:   Sat, 11 Feb 2023 07:07:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Zanussi <zanussi@kernel.org>, rostedt@goodmis.org
Cc:     oe-kbuild-all@lists.linux.dev, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        akpm@linux-foundation.org, zwisler@google.com,
        chinglinyu@google.com
Subject: Re: [PATCH 3/4] tracing/histogram: Fix stacktrace key
Message-ID: <202302110636.O2hlhbxt-lkp@intel.com>
References: <11aa614c82976adbfa4ea763dbe885b5fb01d59c.1676063532.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11aa614c82976adbfa4ea763dbe885b5fb01d59c.1676063532.git.zanussi@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20230210]
[cannot apply to linus/master rostedt-trace/for-next rostedt-trace/for-next-urgent v6.2-rc7 v6.2-rc6 v6.2-rc5 v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Zanussi/tracing-histogram-Don-t-use-strlen-to-find-length-of-stacktrace-variables/20230211-053647
patch link:    https://lore.kernel.org/r/11aa614c82976adbfa4ea763dbe885b5fb01d59c.1676063532.git.zanussi%40kernel.org
patch subject: [PATCH 3/4] tracing/histogram: Fix stacktrace key
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230211/202302110636.O2hlhbxt-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/797160b4aa615acf656dc6c8ef6fe41b3c2b84a2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tom-Zanussi/tracing-histogram-Don-t-use-strlen-to-find-length-of-stacktrace-variables/20230211-053647
        git checkout 797160b4aa615acf656dc6c8ef6fe41b3c2b84a2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110636.O2hlhbxt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events_hist.c: In function 'event_hist_trigger':
>> kernel/trace/trace_events_hist.c:5261:41: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    5261 |                                 stack = (unsigned long *)field_contents;
         |                                         ^


vim +5261 kernel/trace/trace_events_hist.c

  5231	
  5232	static void event_hist_trigger(struct event_trigger_data *data,
  5233				       struct trace_buffer *buffer, void *rec,
  5234				       struct ring_buffer_event *rbe)
  5235	{
  5236		struct hist_trigger_data *hist_data = data->private_data;
  5237		bool use_compound_key = (hist_data->n_keys > 1);
  5238		unsigned long entries[HIST_STACKTRACE_DEPTH];
  5239		u64 var_ref_vals[TRACING_MAP_VARS_MAX];
  5240		char compound_key[HIST_KEY_SIZE_MAX];
  5241		struct tracing_map_elt *elt = NULL;
  5242		struct hist_field *key_field;
  5243		u64 field_contents;
  5244		void *key = NULL;
  5245		unsigned int i;
  5246	
  5247		if (unlikely(!rbe))
  5248			return;
  5249	
  5250		memset(compound_key, 0, hist_data->key_size);
  5251	
  5252		for_each_hist_key_field(i, hist_data) {
  5253			key_field = hist_data->fields[i];
  5254	
  5255			if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
  5256				memset(entries, 0, HIST_STACKTRACE_SIZE);
  5257				if (key_field->field) {
  5258					unsigned long *stack, n_entries;
  5259	
  5260					field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
> 5261					stack = (unsigned long *)field_contents;
  5262					n_entries = *stack;
  5263					memcpy(entries, ++stack, n_entries * sizeof(unsigned long));
  5264				} else {
  5265					stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
  5266							 HIST_STACKTRACE_SKIP);
  5267				}
  5268				key = entries;
  5269			} else {
  5270				field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
  5271				if (key_field->flags & HIST_FIELD_FL_STRING) {
  5272					key = (void *)(unsigned long)field_contents;
  5273					use_compound_key = true;
  5274				} else
  5275					key = (void *)&field_contents;
  5276			}
  5277	
  5278			if (use_compound_key)
  5279				add_to_key(compound_key, key, key_field, rec);
  5280		}
  5281	
  5282		if (use_compound_key)
  5283			key = compound_key;
  5284	
  5285		if (hist_data->n_var_refs &&
  5286		    !resolve_var_refs(hist_data, key, var_ref_vals, false))
  5287			return;
  5288	
  5289		elt = tracing_map_insert(hist_data->map, key);
  5290		if (!elt)
  5291			return;
  5292	
  5293		hist_trigger_elt_update(hist_data, elt, buffer, rec, rbe, var_ref_vals);
  5294	
  5295		if (resolve_var_refs(hist_data, key, var_ref_vals, true))
  5296			hist_trigger_actions(hist_data, elt, buffer, rec, rbe, key, var_ref_vals);
  5297	}
  5298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
