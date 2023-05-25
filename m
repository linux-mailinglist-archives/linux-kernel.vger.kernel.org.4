Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F5D711193
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjEYRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjEYRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:02:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7859E19D;
        Thu, 25 May 2023 10:02:16 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id D850820FBE8A;
        Thu, 25 May 2023 10:02:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D850820FBE8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685034136;
        bh=EgVF48GGGbH4AEk2pm5ZOYU7xMFzxBxcy4M6c/oV564=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnsOnRpar130IqJi2QdrNZKNDxz/h/NPnp3Xbcll123FLUnFFbzDxXHcuZ0U8yyRN
         ydVMNpi5xm/vROxyBpF9rTm/zPHyfrspVxaH6mv8jmB43YB2yy6lTd+R2sbV9nLTwP
         LUfLvAOxF8bPa4aJJtmhvgOQ46U7icELlBKIol2k=
Date:   Thu, 25 May 2023 10:02:12 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com
Subject: Re: [PATCH] tracing/user_events: Prevent same name but different
 args event
Message-ID: <20230525170212.GB82@W11-BEAU-MD.localdomain>
References: <20230525012105.7936-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525012105.7936-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 09:21:05AM +0800, sunliming wrote:
> User processes register name_args for events. If the same name but different
> args event are registered. The trace outputs of second event are printed
> as the first event. This is incorrect.
> 

Good catch, we do this in dynamic_events, but not in the raw ABI case.

> Return EADDRINUSE back to the user process if the same name but different args
> event has being registered.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c              | 74 ++++++++++++++++---
>  .../selftests/user_events/ftrace_test.c       |  6 ++
>  2 files changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index b1ecd7677642..aacd22c1e9f8 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1741,6 +1741,46 @@ static int user_event_trace_register(struct user_event *user)
>  	return ret;
>  }
>  
> +static int compare_ftrace_field(struct ftrace_event_field *field1,
> +					struct ftrace_event_field *field2)
> +{
> +	if (field1->offset == field2->offset &&
> +	    field1->size == field2->size &&
> +	    field1->is_signed == field2->is_signed &&
> +	    field1->filter_type == field2->filter_type &&
> +	    !strcmp(field1->name, field2->name))
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +static int user_event_compare_fields(struct user_event *user1,
> +						struct user_event *user2)
> +{
> +	struct ftrace_event_field *field1, *field2;
> +
> +	field1 = list_first_entry(&user1->fields,
> +			struct ftrace_event_field, link);
> +	field2 = list_first_entry(&user2->fields,
> +			struct ftrace_event_field, link);
> +
> +	while (&field1->link != &user1->fields &&
> +			&field2->link != &user2->fields) {
> +
> +		if (compare_ftrace_field(field1, field2))
> +			break;
> +
> +		field1 = list_next_entry(field1, link);
> +		field2 = list_next_entry(field2, link);
> +	}
> +
> +	if (&field1->link == &user1->fields &&
> +			&field2->link == &user2->fields)
> +		return 0;
> +	else
> +		return -EADDRINUSE;
> +}
> +

We already have a way to compare the fields match via the dynamic_events
interface. Please change to use user_fields_match() instead. This makes
it so we only have one way to do this check, etc.

>  /*
>   * Parses the event name, arguments and flags then registers if successful.
>   * The name buffer lifetime is owned by this method for success cases only.
> @@ -1752,23 +1792,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  {
>  	int ret;
>  	u32 key;
> -	struct user_event *user;
> +	struct user_event *user, *tmp_user;
>  
>  	/* Prevent dyn_event from racing */
>  	mutex_lock(&event_mutex);
> -	user = find_user_event(group, name, &key);
> +	tmp_user = find_user_event(group, name, &key);
>  	mutex_unlock(&event_mutex);
>  

Here we should be able to just do something like:
argv = argv_split(GFP_KERNEL, args, &argc);
match = user_fields_match(user, argc, argv);
argv_free(argv);

NOTE: The above is just pseudocode and does not check the return of
argv_split, etc. but gives you the idea.

> -	if (user) {
> -		*newuser = user;
> -		/*
> -		 * Name is allocated by caller, free it since it already exists.
> -		 * Caller only worries about failure cases for freeing.
> -		 */
> -		kfree(name);
> -		return 0;
> -	}
> -
>  	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
>  
>  	if (!user)
> @@ -1786,6 +1816,26 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  	if (ret)
>  		goto put_user;
>  
> +	if (tmp_user) {
> +		/*
> +		 * Prevent users form using the same name for different fields. This
> +		 * can cause unexpected output for the second event.
> +		 */
> +		ret = user_event_compare_fields(user, tmp_user);
> +
> +		if (!ret) {
> +			*newuser = tmp_user;
> +			/*
> +			 * Name is allocated by caller, free it since it already exists.
> +			 * Caller only worries about failure cases for freeing.
> +			 */
> +			kfree(name);
> +		} else
> +			refcount_dec(&tmp_user->refcnt);
> +
> +		goto put_user;
> +	}
> +
>  	ret = user_event_create_print_fmt(user);
>  
>  	if (ret)
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index 7c99cef94a65..d738efd51daf 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -228,6 +228,12 @@ TEST_F(user, register_events) {
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
>  	ASSERT_EQ(0, reg.write_index);
>  
> +	/* Multipule regitsters to same name but different args should fail */

Typos, should be Multiple registers to same name but different args
should fail.

> +	reg.enable_bit = 29;
> +	reg.name_args = (__u64)"__test_event u32 field1;";
> +	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
> +	ASSERT_EQ(EADDRINUSE, errno);
> +
>  	/* Ensure disabled */
>  	self->enable_fd = open(enable_file, O_RDWR);
>  	ASSERT_NE(-1, self->enable_fd);
> -- 
> 2.25.1

Thanks,
-Beau
