Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC7686623
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBAMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjBAMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CE42E0D9;
        Wed,  1 Feb 2023 04:42:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010D261335;
        Wed,  1 Feb 2023 12:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FF2C4339B;
        Wed,  1 Feb 2023 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675255372;
        bh=0tVxqwP6J5RK2m0oIF5Emx6bU3NkR94XMmYH6CF4uN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C7F/d+ZJPppJsPzMmOITBjEUzwMUgB9cMJJO4lTW0ee/+7RJrpWHjrdOvx6RnFdV9
         uQE05KT6R48p52Hfp09r3RrRcz9WpLjwBnOShxkfs0HMbnPoUTLdt9/aAmf6mXVcKO
         lvXP8NtCOl+eKs8bP8s7dpAwHbZkTG60h8VaRysrzmICBDuOoOjXlfU13ke78lYTl/
         +cTIYqAetA8mXHPxY/KCKxGQSPMn2kcHyeRtkyFmFNQM9B8rVkNy3LUB81bxXRJwTl
         SHcPWDByb0ZY3vY1HquhPmHyc+H9Zq2pbKXdMuXxlubT07XhlPXj2F5V/lyyirtshA
         WvETGWyDf3dQw==
Date:   Wed, 1 Feb 2023 21:42:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 09/10] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230201214248.c88dbeb75018a57f03650e42@kernel.org>
In-Reply-To: <202302011530.7vm4O8Ro-lkp@intel.com>
References: <167518178446.336834.4654027409699647726.stgit@mhiramat.roam.corp.google.com>
        <202302011530.7vm4O8Ro-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 15:27:49 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> [also build test WARNING on bpf/master shuah-kselftest/next shuah-kselftest/fixes linus/master v6.2-rc6]
> [cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/fprobe-Pass-entry_data-to-handlers/20230201-001911
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/167518178446.336834.4654027409699647726.stgit%40mhiramat.roam.corp.google.com
> patch subject: [PATCH v2 09/10] tracing/probes: Add fprobe events for tracing function entry and exit.
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230201/202302011530.7vm4O8Ro-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/90de2b114484f12e2645d2beb964b7d230c9c705
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Masami-Hiramatsu-Google/fprobe-Pass-entry_data-to-handlers/20230201-001911
>         git checkout 90de2b114484f12e2645d2beb964b7d230c9c705
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/trace/trace_probe.c:394:32: warning: use of logical '||' with constant operand [-Wconstant-logical-operand]
>                    if (flags & (TPARG_FL_TPOINT || TPARG_FL_FPROBE)) {
>                                                 ^  ~~~~~~~~~~~~~~~
>    kernel/trace/trace_probe.c:394:32: note: use '|' for a bitwise operation
>                    if (flags & (TPARG_FL_TPOINT || TPARG_FL_FPROBE)) {
>                                                 ^~
>                                                 |

Oops, thanks! this is an actual bug.

Let me fix it and update.

Thanks!

>    1 warning generated.
> 
> 
> vim +394 kernel/trace/trace_probe.c
> 
>    374	
>    375	/* Recursive argument parser */
>    376	static int
>    377	parse_probe_arg(char *arg, const struct fetch_type *type,
>    378			struct fetch_insn **pcode, struct fetch_insn *end,
>    379			unsigned int flags, int offs)
>    380	{
>    381		struct fetch_insn *code = *pcode;
>    382		unsigned long param;
>    383		int deref = FETCH_OP_DEREF;
>    384		long offset = 0;
>    385		char *tmp;
>    386		int ret = 0;
>    387	
>    388		switch (arg[0]) {
>    389		case '$':
>    390			ret = parse_probe_vars(arg + 1, type, code, flags, offs);
>    391			break;
>    392	
>    393		case '%':	/* named register */
>  > 394			if (flags & (TPARG_FL_TPOINT || TPARG_FL_FPROBE)) {
>    395				/* eprobe and fprobe do not handle registers */
>    396				trace_probe_log_err(offs, BAD_VAR);
>    397				break;
>    398			}
>    399			ret = regs_query_register_offset(arg + 1);
>    400			if (ret >= 0) {
>    401				code->op = FETCH_OP_REG;
>    402				code->param = (unsigned int)ret;
>    403				ret = 0;
>    404			} else
>    405				trace_probe_log_err(offs, BAD_REG_NAME);
>    406			break;
>    407	
>    408		case '@':	/* memory, file-offset or symbol */
>    409			if (isdigit(arg[1])) {
>    410				ret = kstrtoul(arg + 1, 0, &param);
>    411				if (ret) {
>    412					trace_probe_log_err(offs, BAD_MEM_ADDR);
>    413					break;
>    414				}
>    415				/* load address */
>    416				code->op = FETCH_OP_IMM;
>    417				code->immediate = param;
>    418			} else if (arg[1] == '+') {
>    419				/* kprobes don't support file offsets */
>    420				if (flags & TPARG_FL_KERNEL) {
>    421					trace_probe_log_err(offs, FILE_ON_KPROBE);
>    422					return -EINVAL;
>    423				}
>    424				ret = kstrtol(arg + 2, 0, &offset);
>    425				if (ret) {
>    426					trace_probe_log_err(offs, BAD_FILE_OFFS);
>    427					break;
>    428				}
>    429	
>    430				code->op = FETCH_OP_FOFFS;
>    431				code->immediate = (unsigned long)offset;  // imm64?
>    432			} else {
>    433				/* uprobes don't support symbols */
>    434				if (!(flags & TPARG_FL_KERNEL)) {
>    435					trace_probe_log_err(offs, SYM_ON_UPROBE);
>    436					return -EINVAL;
>    437				}
>    438				/* Preserve symbol for updating */
>    439				code->op = FETCH_NOP_SYMBOL;
>    440				code->data = kstrdup(arg + 1, GFP_KERNEL);
>    441				if (!code->data)
>    442					return -ENOMEM;
>    443				if (++code == end) {
>    444					trace_probe_log_err(offs, TOO_MANY_OPS);
>    445					return -EINVAL;
>    446				}
>    447				code->op = FETCH_OP_IMM;
>    448				code->immediate = 0;
>    449			}
>    450			/* These are fetching from memory */
>    451			if (++code == end) {
>    452				trace_probe_log_err(offs, TOO_MANY_OPS);
>    453				return -EINVAL;
>    454			}
>    455			*pcode = code;
>    456			code->op = FETCH_OP_DEREF;
>    457			code->offset = offset;
>    458			break;
>    459	
>    460		case '+':	/* deref memory */
>    461		case '-':
>    462			if (arg[1] == 'u') {
>    463				deref = FETCH_OP_UDEREF;
>    464				arg[1] = arg[0];
>    465				arg++;
>    466			}
>    467			if (arg[0] == '+')
>    468				arg++;	/* Skip '+', because kstrtol() rejects it. */
>    469			tmp = strchr(arg, '(');
>    470			if (!tmp) {
>    471				trace_probe_log_err(offs, DEREF_NEED_BRACE);
>    472				return -EINVAL;
>    473			}
>    474			*tmp = '\0';
>    475			ret = kstrtol(arg, 0, &offset);
>    476			if (ret) {
>    477				trace_probe_log_err(offs, BAD_DEREF_OFFS);
>    478				break;
>    479			}
>    480			offs += (tmp + 1 - arg) + (arg[0] != '-' ? 1 : 0);
>    481			arg = tmp + 1;
>    482			tmp = strrchr(arg, ')');
>    483			if (!tmp) {
>    484				trace_probe_log_err(offs + strlen(arg),
>    485						    DEREF_OPEN_BRACE);
>    486				return -EINVAL;
>    487			} else {
>    488				const struct fetch_type *t2 = find_fetch_type(NULL, flags);
>    489	
>    490				*tmp = '\0';
>    491				ret = parse_probe_arg(arg, t2, &code, end, flags, offs);
>    492				if (ret)
>    493					break;
>    494				if (code->op == FETCH_OP_COMM ||
>    495				    code->op == FETCH_OP_DATA) {
>    496					trace_probe_log_err(offs, COMM_CANT_DEREF);
>    497					return -EINVAL;
>    498				}
>    499				if (++code == end) {
>    500					trace_probe_log_err(offs, TOO_MANY_OPS);
>    501					return -EINVAL;
>    502				}
>    503				*pcode = code;
>    504	
>    505				code->op = deref;
>    506				code->offset = offset;
>    507			}
>    508			break;
>    509		case '\\':	/* Immediate value */
>    510			if (arg[1] == '"') {	/* Immediate string */
>    511				ret = __parse_imm_string(arg + 2, &tmp, offs + 2);
>    512				if (ret)
>    513					break;
>    514				code->op = FETCH_OP_DATA;
>    515				code->data = tmp;
>    516			} else {
>    517				ret = str_to_immediate(arg + 1, &code->immediate);
>    518				if (ret)
>    519					trace_probe_log_err(offs + 1, BAD_IMM);
>    520				else
>    521					code->op = FETCH_OP_IMM;
>    522			}
>    523			break;
>    524		}
>    525		if (!ret && code->op == FETCH_OP_NOP) {
>    526			/* Parsed, but do not find fetch method */
>    527			trace_probe_log_err(offs, BAD_FETCH_ARG);
>    528			ret = -EINVAL;
>    529		}
>    530		return ret;
>    531	}
>    532	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
