Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7E5E911F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 07:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIYF11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 01:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIYF1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 01:27:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD439124
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 22:27:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so3906807pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 22:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=h1OpJr+C3W9GVBsYpGwX8MPdm9CUF+UUNYOn/m5PxGI=;
        b=nXNUuH1RLLju8z1NF/NSrzFeMwEh/RaXPeqYUVQoZVcp95GNKEdFxPfrnOJPD22NRS
         YdY2pxjsPbKfJrft2KGWK9CCZ5iTcASVDs0P9PR2B5amdVIrozaG7IHokT5eJrLPrw0x
         cZE2SpNtatKDK3wjWeAlj+gl4QfBou4fuAF2qU2ql9zeyd1MqthP50NBm4Nn4RsHMHIC
         ecEmM6xfNuQYTCuNnj5np5OdFdru5KayYfycezATjk3mgF3JkXUr/cakH/6PdKEnjW/G
         9boSVdHgm6hTcrQH5SvM5MnBvbyob/iG19cUpbD2HwE1Ckk049JnjiIZONY2s4D2+0Ay
         YLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=h1OpJr+C3W9GVBsYpGwX8MPdm9CUF+UUNYOn/m5PxGI=;
        b=0KOGE2LMYDj8i418eG/eTM9gZgkyF2x85yeXklSdqmbpRjdopHKmK12ayWqBT3idYc
         YNlOJqGOEU3UiYpNupMkt2THsOlIup9+SBGsZwhC1B5p0R/YYs8nxHz9VXZUOn7eVegI
         xBzErHwziZGKXTjRJjTUClCEB4+KFHkHBBZVCQo8D2AHkrPlPIPR90EhrzLvjz5NHCpu
         /H70qxyoYHKJZtPavl0hrnfbwGiMfe2v7LYafre74LUfhCCoLwUNCGdbpsas8DodS7t0
         94lLdHnh9t6oRAz4LE4eT9SpIvZVvPWXyS5HCka27xHbMSwvwl3aye7PF+bL9UYqC9Iz
         Of8Q==
X-Gm-Message-State: ACrzQf1nUtUR7cH0mI3IhFBEskYpujeOS6FLg1/MVEG/9hSk64qFTH0b
        N9qrMIooDa8sCoN3QvcCNSYOEzz/eiebmfsHZddA1V8MJis=
X-Google-Smtp-Source: AMsMyM4KVYIZpG46ovDizEUnXMqkOv9iwkNgAzjznH7/llb807wl01cQEMvquIvzDiKoRXnOEKwcL+Uq3PCBrng9Ywc=
X-Received: by 2002:a17:903:2443:b0:178:221d:c599 with SMTP id
 l3-20020a170903244300b00178221dc599mr16521584pls.100.1664083642669; Sat, 24
 Sep 2022 22:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20220819032706.695212-3-xiehuan09@gmail.com>
 <20220924160136.5029e942@rorschach.local.home>
In-Reply-To: <20220924160136.5029e942@rorschach.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sun, 25 Sep 2022 13:27:10 +0800
Message-ID: <CAEr6+ECbocOnr_fSp_rwnu7ugg_q0wrYWShYsW3XOJffqwSOYA@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] trace/objtrace: Get the value of the object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Sun, Sep 25, 2022 at 4:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 19 Aug 2022 11:27:04 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi Jeff,
>
> I finally (sorry about the long wait) got a chance to take a look at
> this code and I really like it a lot! and I want to get this into the
> next merge window.
>

It's so exciting for me to hear this ;-) , and I really appreciate you
looking at this series patch.

> I have one issue with it though, and that's with the syntax.
>
> > Using objtrace trigger to get the value of the object which from the kernel
> > function parameter.
> >
> > Syntax:
> >       objtrace:add:obj[,offset][:type][:count][if <filter>]
>
> I'm thinking instead of using the above syntax that is new, instead use
> the syntax that is used by kprobes, eprobes and uprobes. That is:
>
>   objtrace:+offset(obj):type
>
> That is, instead of:
>
>   objtrace:add:arg1,0x28:u32:1
>
> have:
>
>   objtrace:+0x28(arg1):u32
>
> Perhaps we can add for count for greater than 1:
>
>   obtrace:+0x28(arg1):u32[2]
>
> for two items.
>
> Then we could do even more complex analysis where we can dereference a
> pointer within a structure to another pointer:
>
>   obtrace:+0x16(+0x28(arg1)):u32[2]
>
> Which will look at arg1, add 0x28 to it. dereference that location,
> then add 0x16 to the value, and then dereference that location as well.

Agree with your idea, It does seem like it's more powerful to
dereference pointers.

It also looks like the "add" command field has been removed,
Masami previously suggested I to add a reserved command field for the
future (see [1] and [2]):

[1]:
https://lore.kernel.org/lkml/20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org/

[2]:
https://lore.kernel.org/lkml/20211105004704.3f4aa456c2c537a56f64e65a@kernel.org/


> This code is available in the kprobe code that eprobes also uses:
>
> See process_fetch_insn() in kernel/trace/trace_eprobe.c
>
> and the parsing of the string is in kernel/trace/trace_probe.c:
>
>   parse_probe_arg()
>

Thanks for your guidance, but the next merge window is coming soon,
and since I'm not doing full-time kernel development,
I can't guarantee that the development and testing of this change will
be completed before the next window merge.

 Anyone familiar with this code providing a patch is welcome ;-)

>
> I think doing this will make it much more extensive, not to mention it
> will match the syntax of other code in the tracing infrastructure.

I super agree.

> What do you think?
>
> -- Steve
>
> >
> > Usage:
> >       # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> >       # gdb vmlinux
> >       (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> >       $1 = (unsigned int *) 0x28
> >       # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> >                p_bio_add_page_0/trigger
> >       # cat /test.txt
> >
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace.c         |   2 +-
> >  kernel/trace/trace_entries.h |   5 +-
> >  kernel/trace/trace_object.c  | 187 ++++++++++++++++++++++++++++++++---
> >  kernel/trace/trace_output.c  |   6 +-
> >  4 files changed, 181 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 2c2477dea0f2..c2ffc2235b7b 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5622,7 +5622,7 @@ static const char readme_msg[] =
> >       "\t            disable_hist:<system>:<event>\n"
> >  #endif
> >  #ifdef CONFIG_TRACE_OBJECT
> > -     "\t            objtrace:add:obj[:count][if <filter>]\n"
> > +     "\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"
> >  #endif
> >  #ifdef CONFIG_STACKTRACE
> >       "\t\t    stacktrace\n"
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > index bb120d9498a9..2407c45a568c 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -413,8 +413,9 @@ FTRACE_ENTRY(object, trace_object_entry,
> >               __field(        unsigned long,          ip              )
> >               __field(        unsigned long,          parent_ip       )
> >               __field(        unsigned long,          object          )
> > +             __field(        unsigned long,          value           )
> >       ),
> >
> > -     F_printk(" %ps <-- %ps object:%lx\n",
> > -              (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> > +     F_printk(" %ps <-- %ps object:%lx value:%lx\n", (void *)__entry->ip,
> > +            (void *)__entry->parent_ip, __entry->object, __entry->value)
> >  );
> > diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> > index 19ec4b1c0186..611341abeb7c 100644
> > --- a/kernel/trace/trace_object.c
> > +++ b/kernel/trace/trace_object.c
> > @@ -16,8 +16,14 @@ static const int max_args_num = 6;
> >  static void exit_trace_object(struct trace_array *tr);
> >  static int init_trace_object(struct trace_array *tr);
> >
> > +/*
> > + * get the offset from the special object and
> > + * the type size of the value
> > + */
> >  struct object_instance {
> >       void *obj;
> > +     int obj_offset;
> > +     int obj_value_type_size;
> >       struct trace_array *tr;
> >  };
> >
> > @@ -25,9 +31,23 @@ struct object_instance {
> >  struct objtrace_trigger_data {
> >       struct ftrace_event_field *field;
> >       char objtrace_cmd[OBJTRACE_CMD_LEN];
> > +     int obj_offset;
> > +     int obj_value_type_size;
> >       struct trace_array *tr;
> >  };
> >
> > +/* get the type size for the special object */
> > +struct objtrace_fetch_type {
> > +     char *name;
> > +     int type_size;
> > +};
> > +
> > +enum objattr {
> > +     OBJ_OFFSET,
> > +     OBJ_VAL_TYPE_SIZE,
> > +     MAX_OBJ_ATTR
> > +};
> > +
> >  /* objtrace data with fops and objtrace_instances */
> >  struct objtrace_data {
> >       struct list_head head;
> > @@ -67,6 +87,35 @@ static bool object_exist(void *obj, struct trace_array *tr)
> >       return false;
> >  }
> >
> > +static int get_object_attr(void *obj, int objattr,
> > +             struct trace_array *tr, int *result)
> > +{
> > +     int i, max;
> > +     struct objtrace_data *obj_data;
> > +
> > +     obj_data = get_obj_data(tr);
> > +     if (!obj_data)
> > +             return -EINVAL;
> > +
> > +     max = READ_ONCE(obj_data->num_traced_obj);
> > +     smp_rmb();
> > +     for (i = 0; i < max; i++) {
> > +             if (obj_data->traced_obj[i].obj == obj) {
> > +                     switch (objattr) {
> > +                     case OBJ_OFFSET:
> > +                             *result = obj_data->traced_obj[i].obj_offset;
> > +                             return 0;
> > +                     case OBJ_VAL_TYPE_SIZE:
> > +                             *result = obj_data->traced_obj[i].obj_value_type_size;
> > +                             return 0;
> > +                     default:
> > +                             return -EINVAL;
> > +                     }
> > +             }
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> >  static bool object_empty(struct trace_array *tr)
> >  {
> >       struct objtrace_data *obj_data;
> > @@ -78,7 +127,8 @@ static bool object_empty(struct trace_array *tr)
> >       return !READ_ONCE(obj_data->num_traced_obj);
> >  }
> >
> > -static void set_trace_object(void *obj, struct trace_array *tr)
> > +static void set_trace_object(void *obj, int obj_offset,
> > +                     int obj_value_type_size, struct trace_array *tr)
> >  {
> >       unsigned long flags;
> >       struct object_instance *obj_ins;
> > @@ -103,6 +153,8 @@ static void set_trace_object(void *obj, struct trace_array *tr)
> >       }
> >       obj_ins = &obj_data->traced_obj[READ_ONCE(obj_data->num_traced_obj)];
> >       obj_ins->obj = obj;
> > +     obj_ins->obj_value_type_size = obj_value_type_size;
> > +     obj_ins->obj_offset = obj_offset;
> >       obj_ins->tr = tr;
> >       /* make sure the num_traced_obj update always appears after traced_obj update */
> >       smp_wmb();
> > @@ -112,7 +164,7 @@ static void set_trace_object(void *obj, struct trace_array *tr)
> >  }
> >
> >  static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > -                              unsigned long object, struct trace_array *tr)
> > +             unsigned long object, unsigned long value, struct trace_array *tr)
> >  {
> >
> >       struct trace_buffer *buffer = tr->array_buffer.buffer;
> > @@ -129,10 +181,43 @@ static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> >       entry->ip                       = ip;
> >       entry->parent_ip                = parent_ip;
> >       entry->object                   = object;
> > +     entry->value                    = value;
> >
> >       trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
> >  }
> >
> > +static inline long get_object_value(unsigned long *val, void *obj, int type_size)
> > +{
> > +     char tmp[sizeof(u64)];
> > +     long ret = 0;
> > +
> > +     ret = copy_from_kernel_nofault(tmp, obj, sizeof(tmp));
> > +     if (ret)
> > +             return ret;
> > +     switch (type_size) {
> > +     case 1: {
> > +             *val = (unsigned long)*(u8 *)tmp;
> > +             break;
> > +     }
> > +     case 2: {
> > +             *val = (unsigned long)*(u16 *)tmp;
> > +             break;
> > +     }
> > +     case 4: {
> > +             *val = (unsigned long)*(u32 *)tmp;
> > +             break;
> > +     }
> > +     case 8: {
> > +             *val = (unsigned long)*(u64 *)tmp;
> > +             break;
> > +     }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static void
> >  trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> >               struct ftrace_ops *op, struct ftrace_regs *fregs)
> > @@ -140,7 +225,8 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> >       struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> >       struct trace_array *tr = op->private;
> >       struct trace_array_cpu *data;
> > -     unsigned long obj;
> > +     int ret, val_type_size, obj_offset;
> > +     unsigned long obj, val;
> >       long disabled;
> >       int cpu, n;
> >
> > @@ -154,8 +240,21 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> >                       goto out;
> >               for (n = 0; n < max_args_num; n++) {
> >                       obj = regs_get_kernel_argument(pt_regs, n);
> > -                     if (object_exist((void *)obj, tr))
> > -                             submit_trace_object(ip, parent_ip, obj, tr);
> > +                     if (object_exist((void *)obj, tr)) {
> > +                             ret = get_object_attr((void *)obj, OBJ_OFFSET,
> > +                                             tr, &obj_offset);
> > +                             if (unlikely(ret) < 0)
> > +                                     goto out;
> > +                             ret = get_object_attr((void *)obj, OBJ_VAL_TYPE_SIZE,
> > +                                             tr, &val_type_size);
> > +                             if (unlikely(ret) < 0)
> > +                                     goto out;
> > +                             if (get_object_value(&val, (void *)(obj + obj_offset),
> > +                                                     val_type_size))
> > +                                     continue;
> > +
> > +                             submit_trace_object(ip, parent_ip, obj, val, tr);
> > +                     }
> >               /* The parameters of a function may match multiple objects */
> >               }
> >       }
> > @@ -176,9 +275,23 @@ trace_object_trigger(struct event_trigger_data *data,
> >
> >       field = obj_data->field;
> >       memcpy(&obj, rec + field->offset, sizeof(obj));
> > -     set_trace_object(obj, tr);
> > +     /* set the offset from the special object and the type size of the value*/
> > +     set_trace_object(obj, obj_data->obj_offset,
> > +                     obj_data->obj_value_type_size, tr);
> >  }
> >
> > +static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> > +     {"u8", 1},
> > +     {"x8", 1},
> > +     {"u16", 2},
> > +     {"x16", 2},
> > +     {"u32", 4},
> > +     {"x32", 4},
> > +     {"u64", 8},
> > +     {"x64", 8},
> > +     {NULL, 0},
> > +};
> > +
> >  static void
> >  trace_object_trigger_free(struct event_trigger_data *data)
> >  {
> > @@ -213,14 +326,25 @@ static int
> >  event_trigger_print(const char *name, struct seq_file *m,
> >               void *data, char *filter_str, void *objtrace_data)
> >  {
> > +     int i;
> >       long count = (long)data;
> >       struct objtrace_trigger_data *obj_data = objtrace_data;
> > +     const char *value_type_name;
> >
> >       seq_puts(m, name);
> >
> >       seq_printf(m, ":%s", obj_data->objtrace_cmd);
> >       seq_printf(m, ":%s", obj_data->field->name);
> > +     if (obj_data->obj_offset)
> > +             seq_printf(m, ",0x%x", obj_data->obj_offset);
> >
> > +     for (i = 0; objtrace_fetch_types[i].name; i++) {
> > +             if (objtrace_fetch_types[i].type_size == obj_data->obj_value_type_size) {
> > +                     value_type_name = objtrace_fetch_types[i].name;
> > +                     break;
> > +             }
> > +     }
> > +     seq_printf(m, ":%s", value_type_name);
> >       if (count == -1)
> >               seq_puts(m, ":unlimited");
> >       else
> > @@ -303,16 +427,18 @@ event_object_trigger_parse(struct event_command *cmd_ops,
> >       struct event_trigger_data *trigger_data;
> >       struct objtrace_trigger_data *obj_data;
> >       struct ftrace_event_field *field;
> > -     char *objtrace_cmd, *arg;
> > -     char *param, *filter;
> > -     int ret;
> > +     char *objtrace_cmd, *obj;
> > +     char *param, *filter, *str, *type;
> > +     int ret, i, def_type_size, obj_value_type_size = 0;
> > +     char *tmp_saved_param;
> > +     long offset = 0;
> >       bool remove;
> >
> >       remove = event_trigger_check_remove(glob);
> >
> >       /*
> >        * separate the param and the filter:
> > -      * objtrace:add:OBJ[:COUNT] [if filter]
> > +      * objtrace:add:OBJ[,OFFS][:TYPE][:COUNT] [if filter]
> >        */
> >       ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
> >       if (ret)
> > @@ -324,11 +450,44 @@ event_object_trigger_parse(struct event_command *cmd_ops,
> >               return -EINVAL;
> >       }
> >
> > -     arg = strsep(&param, ":");
> > -     if (!arg)
> > +     obj = strsep(&param, ":");
> > +     if (!obj)
> >               return -EINVAL;
> >
> > -     field = trace_find_event_field(file->event_call, arg);
> > +     str = strchr(obj, ',');
> > +     if (!str)
> > +             offset = 0;
> > +     else {
> > +             *str++ = '\0';
> > +             ret = kstrtol(str, 0, &offset);
> > +             if (ret)
> > +                     return -EINVAL;
> > +     }
> > +     def_type_size = sizeof(void *);
> > +     if (!param) {
> > +             obj_value_type_size = def_type_size;
> > +             goto skip_get_type;
> > +     }
> > +     tmp_saved_param = param;
> > +     type = strsep(&param, ":");
> > +     if (!type)
> > +             obj_value_type_size = def_type_size;
> > +     /* if this is the trigger count */
> > +     else if (isdigit(type[0])) {
> > +             obj_value_type_size = def_type_size;
> > +             param = tmp_saved_param;
> > +     } else {
> > +             for (i = 0; objtrace_fetch_types[i].name; i++) {
> > +                     if (strcmp(objtrace_fetch_types[i].name, type) == 0) {
> > +                             obj_value_type_size = objtrace_fetch_types[i].type_size;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +     if (!obj_value_type_size)
> > +             return -EINVAL;
> > +skip_get_type:
> > +     field = trace_find_event_field(file->event_call, obj);
> >       if (!field)
> >               return -EINVAL;
> >
> > @@ -345,6 +504,8 @@ event_object_trigger_parse(struct event_command *cmd_ops,
> >               return -ENOMEM;
> >
> >       obj_data->field = field;
> > +     obj_data->obj_offset = offset;
> > +     obj_data->obj_value_type_size = obj_value_type_size;
> >       obj_data->tr = file->tr;
> >       snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
> >
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index 34ff7b4dc521..a45871b52dcc 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -1561,6 +1561,7 @@ static enum print_line_t trace_object_print(struct trace_iterator *iter, int fla
> >       trace_assign_type(field, iter->ent);
> >       print_fn_trace(s, field->ip, field->parent_ip, flags);
> >       trace_seq_printf(s, " object:0x%lx", field->object);
> > +     trace_seq_printf(s, " value:0x%lx", field->value);
> >       trace_seq_putc(s, '\n');
> >
> >       return trace_handle_return(s);
> > @@ -1573,9 +1574,8 @@ static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags
> >
> >       trace_assign_type(field, iter->ent);
> >
> > -     trace_seq_printf(&iter->seq, "%lx %lx\n",
> > -                      field->ip,
> > -                      field->parent_ip);
> > +     trace_seq_printf(&iter->seq, "%lx %lx %lx %lx\n", field->ip,
> > +                     field->parent_ip, field->object, field->value);
> >
> >       return trace_handle_return(&iter->seq);
> >  }
>

-- 
Thanks,
JeffXie
