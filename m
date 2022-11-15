Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829D5629FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiKORHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKORHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:07:43 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDCF3D77
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:07:42 -0800 (PST)
Received: from kbox (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 89F7020B717A;
        Tue, 15 Nov 2022 09:07:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89F7020B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668532062;
        bh=HrunAVDEDm+yyiX3Yrk2zJt4p2vGEeG8d0hq/GRhpwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKZTb0FqpRT9LHP5yW1FbduWK9uCd/imA3SR+R48ODOBYSadn6CmE5oeUbNW/44cM
         FNAw5lDUWmTivEToNzYo4sKlQ9ENtjn+ROr/Kn2xejJ+JYkt2TcSf3llaRKiHEMJB+
         yN1Lc9a+CxubHQXHVrwgYuRhfMdrt98LhZ2yUp3M=
Date:   Tue, 15 Nov 2022 09:07:35 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Fix memory leak in
 user_event_create()
Message-ID: <20221115170735.GA1794@kbox>
References: <20221115014445.158419-1-xiujianfeng@huawei.com>
 <20221116000717.4b62513eeaf0b2296b399bda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116000717.4b62513eeaf0b2296b399bda@kernel.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:07:17AM +0900, Masami Hiramatsu wrote:
> On Tue, 15 Nov 2022 09:44:45 +0800
> Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> 
> > Before current_user_event_group(), it has allocated memory and save it
> > in @name, this should freed before return error.
> > 

Nice catch!

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau

> > Fixes: e5d271812e7a ("tracing/user_events: Move pages/locks into groups to prepare for namespaces")
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks,
> 
> > ---
> >  kernel/trace/trace_events_user.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index ae78c2d53c8a..539b08ae7020 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -1100,8 +1100,10 @@ static int user_event_create(const char *raw_command)
> >  
> >  	group = current_user_event_group();
> >  
> > -	if (!group)
> > +	if (!group) {
> > +		kfree(name);
> >  		return -ENOENT;
> > +	}
> >  
> >  	mutex_lock(&group->reg_mutex);
> >  
> > -- 
> > 2.17.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
