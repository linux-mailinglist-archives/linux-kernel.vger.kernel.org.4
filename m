Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B186C601844
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJQT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJQT6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:58:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7136C125
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0C8DB81637
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B81C433D7;
        Mon, 17 Oct 2022 19:58:05 +0000 (UTC)
Date:   Mon, 17 Oct 2022 15:58:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Subject: Re: [PATCH v15 1/4] trace: Add trace any kernel object
Message-ID: <20221017155829.7e8d4812@gandalf.local.home>
In-Reply-To: <20220819032706.695212-2-xiehuan09@gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
        <20220819032706.695212-2-xiehuan09@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 11:27:03 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:


> index 27febd4ee33e..2c2477dea0f2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5621,6 +5621,9 @@ static const char readme_msg[] =
>  	"\t            enable_hist:<system>:<event>\n"
>  	"\t            disable_hist:<system>:<event>\n"
>  #endif
> +#ifdef CONFIG_TRACE_OBJECT
> +	"\t            objtrace:add:obj[:count][if <filter>]\n"
> +#endif
>  #ifdef CONFIG_STACKTRACE
>  	"\t\t    stacktrace\n"
>  #endif
> @@ -9261,6 +9264,9 @@ static struct trace_array *trace_array_create(const char *name)
>  	if (ftrace_allocate_ftrace_ops(tr) < 0)
>  		goto out_free_tr;
>  
> +	if (allocate_objtrace_data(tr) < 0)
> +		goto out_free_tr;

When I was rewriting this, I found there's no reason to associate a objdata
with a tr. It should all be self contained (per event file). The objdata
can have a tr, but the tr doesn't care about the objdata.

> +
>  	ftrace_init_trace_array(tr);
>  
>  	init_trace_flags_index(tr);
> @@ -9280,6 +9286,7 @@ static struct trace_array *trace_array_create(const char *name)
>  
>   out_free_tr:
>  	ftrace_free_ftrace_ops(tr);
> +	free_objtrace_data(tr);
>  	free_trace_buffers(tr);
>  	free_cpumask_var(tr->tracing_cpumask);
>  	kfree(tr->name);
> @@ -9373,6 +9380,7 @@ static int __remove_instance(struct trace_array *tr)
>  	event_trace_del_tracer(tr);
>  	ftrace_clear_pids(tr);
>  	ftrace_destroy_function_files(tr);
> +	free_objtrace_data(tr);
>  	tracefs_remove(tr->dir);
>  	free_percpu(tr->last_func_repeats);
>  	free_trace_buffers(tr);
> @@ -10110,6 +10118,9 @@ __init static int tracer_alloc_buffers(void)
>  		goto out_free_savedcmd;
>  	}
>  
> +	if (allocate_objtrace_data(&global_trace))
> +		goto out_free_savedcmd;
> +
>  	if (global_trace.buffer_disabled)
>  		tracing_off();
>  
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 900e75d96c84..8da1ef78a09a 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -54,6 +54,7 @@ enum trace_type {
>  	TRACE_TIMERLAT,
>  	TRACE_RAW_DATA,
>  	TRACE_FUNC_REPEATS,
> +	TRACE_OBJECT,
>  
>  	__TRACE_LAST_TYPE,
>  };
> @@ -363,6 +364,9 @@ struct trace_array {
>  	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
>  	int			ref;
>  	int			trace_ref;
> +#ifdef CONFIG_TRACE_OBJECT
> +	struct objtrace_data	*obj_data;
> +#endif

That means the above is not needed.

>  #ifdef CONFIG_FUNCTION_TRACER
>  	struct ftrace_ops	*ops;
>  	struct trace_pid_list	__rcu *function_pids;
> @@ -471,6 +475,7 @@ extern void __ftrace_bad_type(void);
>  			  TRACE_GRAPH_RET);		\
>  		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
>  			  TRACE_FUNC_REPEATS);				\
> +		IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
>  		__ftrace_bad_type();					\
>  	} while (0)
>  
> @@ -1536,6 +1541,16 @@ static inline int register_trigger_hist_cmd(void) { return 0; }
>  static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_TRACE_OBJECT
> +extern int register_trigger_object_cmd(void);
> +extern int allocate_objtrace_data(struct trace_array *tr);
> +extern void free_objtrace_data(struct trace_array *tr);
> +#else
> +static inline int register_trigger_object_cmd(void) { return 0; }
> +static inline int allocate_objtrace_data(struct trace_array *tr) { return 0; }
> +static inline void free_objtrace_data(struct trace_array *tr) { };
> +#endif
> +
>  extern int register_trigger_cmds(void);
>  extern void clear_event_triggers(struct trace_array *tr);
>  
> @@ -1611,6 +1626,12 @@ extern bool event_trigger_check_remove(const char *glob);
>  extern bool event_trigger_empty_param(const char *param);
>  extern int event_trigger_separate_filter(char *param_and_filter, char **param,
>  					 char **filter, bool param_required);
> +extern int register_trigger(char *glob,
> +			struct event_trigger_data *data,
> +			struct trace_event_file *file);
> +extern void unregister_trigger(char *glob,
> +			struct event_trigger_data *test,
> +			struct trace_event_file *file);
>  extern struct event_trigger_data *
>  event_trigger_alloc(struct event_command *cmd_ops,
>  		    char *cmd,
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index cd41e863b51c..bb120d9498a9 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
>  		 __entry->context,
>  		 __entry->timer_latency)
>  );
> +
> +/*
> + * trace object entry:
> + */
> +FTRACE_ENTRY(object, trace_object_entry,
> +
> +	TRACE_OBJECT,
> +
> +	F_STRUCT(
> +		__field(	unsigned long,		ip		)
> +		__field(	unsigned long,		parent_ip	)
> +		__field(	unsigned long,		object		)
> +	),
> +
> +	F_printk(" %ps <-- %ps object:%lx\n",
> +		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> +);
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index cb866c3141af..8bad4eb3b997 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -560,7 +560,7 @@ void update_cond_flag(struct trace_event_file *file)
>   *
>   * Return: 0 on success, errno otherwise
>   */
> -static int register_trigger(char *glob,
> +int register_trigger(char *glob,
>  			    struct event_trigger_data *data,
>  			    struct trace_event_file *file)
>  {
> @@ -605,7 +605,7 @@ static int register_trigger(char *glob,
>   * Usually used directly as the @unreg method in event command
>   * implementations.
>   */
> -static void unregister_trigger(char *glob,
> +void unregister_trigger(char *glob,
>  			       struct event_trigger_data *test,
>  			       struct trace_event_file *file)
>  {
> @@ -1976,6 +1976,7 @@ __init int register_trigger_cmds(void)
>  	register_trigger_enable_disable_cmds();
>  	register_trigger_hist_enable_disable_cmds();
>  	register_trigger_hist_cmd();
> +	register_trigger_object_cmd();
>  
>  	return 0;
>  }
> diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> new file mode 100644
> index 000000000000..19ec4b1c0186
> --- /dev/null
> +++ b/kernel/trace/trace_object.c
> @@ -0,0 +1,450 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * trace the kernel object in the kernel function parameter
> + * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) "trace_object: " fmt
> +
> +#include "trace_output.h"
> +
> +#define MAX_TRACED_OBJECT 5
> +#define OBJTRACE_CMD_LEN  16
> +#define OBJTRACE_CMD_ADD "add"
> +static LIST_HEAD(obj_data_head);
> +static const int max_args_num = 6;
> +static void exit_trace_object(struct trace_array *tr);
> +static int init_trace_object(struct trace_array *tr);
> +
> +struct object_instance {
> +	void *obj;
> +	struct trace_array *tr;

The instance will need to hold the object, and last value.

> +};
> +
> +/* objtrace private data */
> +struct objtrace_trigger_data {
> +	struct ftrace_event_field *field;
> +	char objtrace_cmd[OBJTRACE_CMD_LEN];
> +	struct trace_array *tr;
> +};
> +
> +/* objtrace data with fops and objtrace_instances */
> +struct objtrace_data {
> +	struct list_head head;
> +	struct trace_array *tr;
> +	struct ftrace_ops fops;
> +	int num_traced_obj;
> +	struct object_instance traced_obj[MAX_TRACED_OBJECT];
> +	raw_spinlock_t obj_data_lock;
> +};

The objtrace_data and the objtrace_trigger_data could be merged into a
single instance that get's allocated when the trigger is written. The
object_instance array size can be the "count" passed in.

It will require initializing the entire instance at the time the trigger is
written into the trigger file.

> +
> +static struct objtrace_data *get_obj_data(struct trace_array *tr)
> +{
> +	struct objtrace_data *obj_data = NULL;
> +
> +	list_for_each_entry(obj_data, &obj_data_head, head) {
> +		if (obj_data->tr == tr)
> +			break;
> +	}
> +	return obj_data;
> +}

I deleted the above function.

> +
> +static bool object_exist(void *obj, struct trace_array *tr)
> +{
> +	int i, max;
> +	struct objtrace_data *obj_data;
> +
> +	obj_data = get_obj_data(tr);
> +	if (!obj_data)
> +		return false;
> +
> +	max = READ_ONCE(obj_data->num_traced_obj);
> +	smp_rmb();
> +	for (i = 0; i < max; i++) {
> +		if (obj_data->traced_obj[i].obj == obj)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool object_empty(struct trace_array *tr)
> +{
> +	struct objtrace_data *obj_data;
> +
> +	obj_data = get_obj_data(tr);
> +	if (!obj_data)
> +		return false;
> +
> +	return !READ_ONCE(obj_data->num_traced_obj);
> +}
> +
> +static void set_trace_object(void *obj, struct trace_array *tr)
> +{
> +	unsigned long flags;
> +	struct object_instance *obj_ins;
> +	struct objtrace_data *obj_data;

BTW, please use "upside-down x-mas tree" formatting for variables. That is:

	struct object_instance *obj_ins;
	struct objtrace_data *obj_data;
	unsigned long flags;

And I have more to comment on about variable declarations.

> +
> +	if (in_nmi())
> +		return;
> +
> +	if (!obj && object_exist(obj, tr))

If we are checking values, we do not test for object_exist here. Just !obj.

> +		return;
> +
> +	obj_data = get_obj_data(tr);
> +	if (!obj_data)
> +		return;
> +
> +	/* only this place has write operations */
> +	raw_spin_lock_irqsave(&obj_data->obj_data_lock, flags);
> +	if (READ_ONCE(obj_data->num_traced_obj) == MAX_TRACED_OBJECT) {

No need for the READ_ONCE() in the spin locked area.

> +		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
> +				"object_pool is full, can't trace object:0x%px\n", obj);

Also, I'm not sure if we have a counter, that we are going to want to print
anything when it is full. Maybe for debugging?
> +		goto out;
> +	}
> +	obj_ins = &obj_data->traced_obj[READ_ONCE(obj_data->num_traced_obj)];
> +	obj_ins->obj = obj;
> +	obj_ins->tr = tr;
> +	/* make sure the num_traced_obj update always appears after traced_obj update */
> +	smp_wmb();
> +	obj_data->num_traced_obj++;
> +out:
> +	raw_spin_unlock_irqrestore(&obj_data->obj_data_lock, flags);
> +}
> +
> +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> +				 unsigned long object, struct trace_array *tr)
> +{
> +
> +	struct trace_buffer *buffer = tr->array_buffer.buffer;
> +	struct ring_buffer_event *event;
> +	struct trace_object_entry *entry;
> +	unsigned int trace_ctx = 0;
> +
> +	trace_ctx = tracing_gen_ctx();
> +	event = trace_buffer_lock_reserve(buffer, TRACE_OBJECT,
> +			sizeof(*entry), trace_ctx);
> +	if (!event)
> +		return;
> +	entry   = ring_buffer_event_data(event);
> +	entry->ip                       = ip;
> +	entry->parent_ip                = parent_ip;
> +	entry->object			= object;
> +
> +	trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
> +}
> +
> +static void
> +trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> +		struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> +	struct trace_array *tr = op->private;

We do not need the op->private for the tr. instead:

	struct obj_data *obj_data;

> +	struct trace_array_cpu *data;
> +	unsigned long obj;
> +	long disabled;
> +	int cpu, n;

	obj_data = container_of(op, struct obj_data, fops);

	tr = obj_data->tr;

> +
> +	preempt_disable_notrace();
> +
> +	cpu = raw_smp_processor_id();
> +	data = per_cpu_ptr(tr->array_buffer.data, cpu);
> +	disabled = atomic_inc_return(&data->disabled);
> +	if (likely(disabled == 1)) {
> +		if (object_empty(tr))
> +			goto out;
> +		for (n = 0; n < max_args_num; n++) {
> +			obj = regs_get_kernel_argument(pt_regs, 

As I mentioned, the above is best effort at best. Instead, we should get
the value and check if it changed. If it did, then we print, otherwise skip
it. Will need to be under the lock to do this check.


> +			if (object_exist((void *)obj, tr))
> +				submit_trace_object(ip, parent_ip, obj, tr);
> +		/* The parameters of a function may match multiple objects */
> +		}
> +	}
> +out:
> +	atomic_dec(&data->disabled);
> +	preempt_enable_notrace();
> +}
> +
> +static void
> +trace_object_trigger(struct event_trigger_data *data,
> +		   struct trace_buffer *buffer,  void *rec,
> +		   struct ring_buffer_event *event)
> +{
> +	struct objtrace_trigger_data *obj_data = data->private_data;
> +	struct trace_array *tr = obj_data->tr;
> +	struct ftrace_event_field *field;
> +	void *obj = NULL;
> +
> +	field = obj_data->field;
> +	memcpy(&obj, rec + field->offset, sizeof(obj));
> +	set_trace_object(obj, tr);
> +}
> +
> +static void
> +trace_object_trigger_free(struct event_trigger_data *data)
> +{
> +	struct objtrace_trigger_data *obj_data = data->private_data;
> +
> +	if (WARN_ON_ONCE(data->ref <= 0))
> +		return;
> +
> +	data->ref--;
> +	if (!data->ref) {
> +		exit_trace_object(obj_data->tr);
> +		kfree(data->private_data);
> +		trigger_data_free(data);
> +	}
> +}
> +
> +static void
> +trace_object_count_trigger(struct event_trigger_data *data,
> +			 struct trace_buffer *buffer, void *rec,
> +			 struct ring_buffer_event *event)
> +{
> +	if (!data->count)
> +		return;
> +
> +	if (data->count != -1)
> +		(data->count)--;
> +
> +	trace_object_trigger(data, buffer, rec, event);
> +}
> +
> +static int
> +event_trigger_print(const char *name, struct seq_file *m,
> +		void *data, char *filter_str, void *objtrace_data)
> +{
> +	long count = (long)data;
> +	struct objtrace_trigger_data *obj_data = objtrace_data;
> +
> +	seq_puts(m, name);
> +
> +	seq_printf(m, ":%s", obj_data->objtrace_cmd);
> +	seq_printf(m, ":%s", obj_data->field->name);
> +
> +	if (count == -1)
> +		seq_puts(m, ":unlimited");
> +	else
> +		seq_printf(m, ":count=%ld", count);

We are not going to have an "unlimited" here. I think the count should be
the number of objects we can trace.

> +
> +	if (filter_str)
> +		seq_printf(m, " if %s\n", filter_str);
> +	else
> +		seq_putc(m, '\n');
> +
> +	return 0;
> +}
> +
> +static int event_object_trigger_init(struct event_trigger_data *data)
> +{
> +	struct objtrace_trigger_data *obj_data = data->private_data;
> +	int ret;
> +
> +	if (!data->ref) {
> +		ret = init_trace_object(obj_data->tr);
> +		if (ret)
> +			return ret;
> +	}
> +	data->ref++;
> +	return 0;
> +}
> +
> +static int
> +trace_object_trigger_print(struct seq_file *m, struct event_trigger_data *data)
> +{
> +	return event_trigger_print("objtrace", m, (void *)data->count,
> +				   data->filter_str, data->private_data);
> +}
> +
> +static struct event_trigger_ops objecttrace_trigger_ops = {
> +	.trigger		= trace_object_trigger,
> +	.print			= trace_object_trigger_print,
> +	.init			= event_object_trigger_init,
> +	.free			= trace_object_trigger_free,
> +};
> +
> +static struct event_trigger_ops objecttrace_count_trigger_ops = {
> +	.trigger		= trace_object_count_trigger,
> +	.print			= trace_object_trigger_print,
> +	.init			= event_object_trigger_init,
> +	.free			= trace_object_trigger_free,
> +};
> +
> +static struct event_trigger_ops *
> +objecttrace_get_trigger_ops(char *cmd, char *param)
> +{
> +	return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
> +}
> +
> +static bool field_exist(struct trace_event_file *file,
> +			struct event_command *cmd_ops,
> +			const char *field_name)
> +{
> +	struct event_trigger_data *data;
> +	struct objtrace_trigger_data *obj_data;
> +
> +	lockdep_assert_held(&event_mutex);
> +
> +	list_for_each_entry(data, &file->triggers, list) {
> +		if (data->cmd_ops->trigger_type == cmd_ops->trigger_type) {
> +			obj_data = data->private_data;
> +			if (!strcmp(obj_data->field->name, field_name))
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int
> +event_object_trigger_parse(struct event_command *cmd_ops,
> +		       struct trace_event_file *file,
> +		       char *glob, char *cmd, char *param_and_filter)
> +{
> +	struct event_trigger_data *trigger_data;
> +	struct objtrace_trigger_data *obj_data;
> +	struct ftrace_event_field *field;
> +	char *objtrace_cmd, *arg;
> +	char *param, *filter;
> +	int ret;
> +	bool remove;

BTW, do not declare more than one variable on the same line. It makes it
hard to know what is declared, makes diffs harder to know what changed, and
makes it annoying when the compiler says a variable is unused to delete it.

The above should be:

	struct event_trigger_data *trigger_data;
	struct objtrace_trigger_data *obj_data;
	struct ftrace_event_field *field;
	char *objtrace_cmd;
	char *filter;
	char *param;
	char *arg;
	bool remove;
	int ret;

Although, when I changed this to use the fetch instruction, most of it was
removed anyway (which is why I found the above to be annoying due to all the
"unused variable" warnings I had).

-- Steve

> +
> +	remove = event_trigger_check_remove(glob);
> +
> +	/*
> +	 * separate the param and the filter:
> +	 * objtrace:add:OBJ[:COUNT] [if filter]
> +	 */
> +	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
> +	if (ret)
> +		return ret;
> +
> +	objtrace_cmd = strsep(&param, ":");
> +	if (!objtrace_cmd || strcmp(objtrace_cmd, OBJTRACE_CMD_ADD)) {
> +		pr_err("error objtrace command\n");
> +		return -EINVAL;
> +	}
> +
> +	arg = strsep(&param, ":");
> +	if (!arg)
> +		return -EINVAL;
> +
> +	field = trace_find_event_field(file->event_call, arg);
> +	if (!field)
> +		return -EINVAL;
> +
> +	if (field->size != sizeof(void *)) {
> +		pr_err("the size of the %s should be:%zu\n", field->name, sizeof(void *));
> +		return -EINVAL;
> +	}
> +
> +	if (remove && !field_exist(file, cmd_ops, field->name))
> +		return -ENOENT;
> +
> +	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> +	if (!obj_data)
> +		return -ENOMEM;
> +
> +	obj_data->field = field;
> +	obj_data->tr = file->tr;
> +	snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
> +
> +	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
> +	if (!trigger_data) {
> +		kfree(obj_data);
> +		return -ENOMEM;
> +	}
> +	if (remove) {
> +		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> +		kfree(obj_data);
> +		kfree(trigger_data);
> +		return 0;
> +	}
> +
> +	ret = event_trigger_parse_num(param, trigger_data);
> +	if (ret)
> +		goto out_free;
> +
> +	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
> +	if (ret < 0)
> +		goto out_free;
> +
> +	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
> +	if (ret)
> +		goto out_free;
> +
> +	return ret;
> +
>
