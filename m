Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19572BAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjFLIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjFLIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:36:31 -0400
X-Greylist: delayed 2068 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 01:36:24 PDT
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com [115.236.118.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A83419A;
        Mon, 12 Jun 2023 01:36:23 -0700 (PDT)
Received: from [172.23.197.27] (unknown [121.32.254.147])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 92F0A40040C;
        Mon, 12 Jun 2023 15:29:20 +0800 (CST)
Message-ID: <cb07ac16-cc0f-7e8d-6271-cde2e02e739d@sangfor.com.cn>
Date:   Mon, 12 Jun 2023 15:29:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v13 09/12] tracing/probes: Add BTF retval type support
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-kernel@vger.kernel.org,
        Ding Hui <dinghui@sangfor.com.cn>, huangcun@sangfor.com.cn
References: <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
 <168507476195.913472.16290308831790216609.stgit@mhiramat.roam.corp.google.com>
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
In-Reply-To: <168507476195.913472.16290308831790216609.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0wYVkxKSx9DGUlDQkhCGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJSlVISVVJTk9VSk9MWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Tid: 0a88ae8264f62eb3kusn92f0a40040c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAg6Dxw5PT1IKho*MTQ#QglO
        LyhPCUJVSlVKTUNNTk5PQk1KTE9OVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSklKVUhJVUlOT1VKT0xZV1kIAVlBTEJCTzcG
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/26 12:19, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Check the target function has non-void retval type and set the correct
> fetch type if user doesn't specify it.
> If the function returns void, $retval is rejected as below;
> 
>   # echo 'f unregister_kprobes%return $retval' >> dynamic_events
> sh: write error: No such file or directory
>   # cat error_log
> [   37.488397] trace_fprobe: error: This function returns 'void' type
>    Command: f unregister_kprobes%return $retval
>                                         ^
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v8:
>   - Fix wrong indentation.
> Changes in v7:
>   - Introduce this as a new patch.
> ---
>   kernel/trace/trace_probe.c |   69 ++++++++++++++++++++++++++++++++++++++++----
>   kernel/trace/trace_probe.h |    1 +
>   2 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 7318642aceb3..dfe3e1823eec 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -371,15 +371,13 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
>   	return NULL;
>   }
>   
> -static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> -						   bool tracepoint)
> +static const struct btf_type *find_btf_func_proto(const char *funcname)
>   {
>   	struct btf *btf = traceprobe_get_btf();
> -	const struct btf_param *param;
>   	const struct btf_type *t;
>   	s32 id;
>   
> -	if (!btf || !funcname || !nr)
> +	if (!btf || !funcname)
>   		return ERR_PTR(-EINVAL);
>   
>   	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> @@ -396,6 +394,22 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
>   	if (!btf_type_is_func_proto(t))
>   		return ERR_PTR(-ENOENT);
>   
> +	return t;
> +}
> +
> +static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> +						   bool tracepoint)
> +{
> +	const struct btf_param *param;
> +	const struct btf_type *t;
> +
> +	if (!funcname || !nr)
> +		return ERR_PTR(-EINVAL);
> +
> +	t = find_btf_func_proto(funcname);
> +	if (IS_ERR(t))
> +		return (const struct btf_param *)t;
> +
>   	*nr = btf_type_vlen(t);
>   	param = (const struct btf_param *)(t + 1);
>   
> @@ -462,6 +476,32 @@ static const struct fetch_type *parse_btf_arg_type(int arg_idx,
>   	return find_fetch_type(typestr, ctx->flags);
>   }
>   
> +static const struct fetch_type *parse_btf_retval_type(
> +					struct traceprobe_parse_context *ctx)
> +{

Can we make this a common interface so that the funcgraph-retval can
  also use it to get the return type?

-- Donglin Peng

> +	struct btf *btf = traceprobe_get_btf();
> +	const char *typestr = NULL;
> +	const struct btf_type *t;
> +
> +	if (btf && ctx->funcname) {
> +		t = find_btf_func_proto(ctx->funcname);
> +		if (!IS_ERR(t))
> +			typestr = type_from_btf_id(btf, t->type);
> +	}
> +
> +	return find_fetch_type(typestr, ctx->flags);
> +}
> +
> +static bool is_btf_retval_void(const char *funcname)
> +{
> +	const struct btf_type *t;
> +
> +	t = find_btf_func_proto(funcname);
> +	if (IS_ERR(t))
> +		return false;
> +
> +	return t->type == 0;
> +}
>   #else
>   static struct btf *traceprobe_get_btf(void)
>   {
> @@ -480,8 +520,15 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
>   	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
>   	return -EOPNOTSUPP;
>   }
> +
>   #define parse_btf_arg_type(idx, ctx)		\
>   	find_fetch_type(NULL, ctx->flags)
> +
> +#define parse_btf_retval_type(ctx)		\
> +	find_fetch_type(NULL, ctx->flags)
> +
> +#define is_btf_retval_void(funcname)	(false)
> +
>   #endif
>   
>   #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
> @@ -512,6 +559,11 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
>   
>   	if (strcmp(arg, "retval") == 0) {
>   		if (ctx->flags & TPARG_FL_RETURN) {
> +			if ((ctx->flags & TPARG_FL_KERNEL) &&
> +			    is_btf_retval_void(ctx->funcname)) {
> +				err = TP_ERR_NO_RETVAL;
> +				goto inval;
> +			}
>   			code->op = FETCH_OP_RETVAL;
>   			return 0;
>   		}
> @@ -912,9 +964,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>   		goto fail;
>   
>   	/* Update storing type if BTF is available */
> -	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
> -	    !t && code->op == FETCH_OP_ARG)
> -		parg->type = parse_btf_arg_type(code->param, ctx);
> +	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
> +		if (code->op == FETCH_OP_ARG)
> +			parg->type = parse_btf_arg_type(code->param, ctx);
> +		else if (code->op == FETCH_OP_RETVAL)
> +			parg->type = parse_btf_retval_type(ctx);
> +	}
>   
>   	ret = -EINVAL;
>   	/* Store operation */
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index c864e6dea10f..eb43bea5c168 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -449,6 +449,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>   	C(BAD_EVENT_NAME,	"Event name must follow the same rules as C identifiers"), \
>   	C(EVENT_EXIST,		"Given group/event name is already used by another event"), \
>   	C(RETVAL_ON_PROBE,	"$retval is not available on probe"),	\
> +	C(NO_RETVAL,		"This function returns 'void' type"),	\
>   	C(BAD_STACK_NUM,	"Invalid stack number"),		\
>   	C(BAD_ARG_NUM,		"Invalid argument number"),		\
>   	C(BAD_VAR,		"Invalid $-valiable specified"),	\
> 
> 
> 

