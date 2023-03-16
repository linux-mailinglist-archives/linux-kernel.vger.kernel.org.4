Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C56BD7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCPR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCPR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:58:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A7211EB;
        Thu, 16 Mar 2023 10:57:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y15so3406711lfa.7;
        Thu, 16 Mar 2023 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678989478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/utl8ZaT/2tlxp2lFNNxmbt5CfG0+r5dqlUPd9a7z8=;
        b=L0EV36tEsdgdwk+P2FvfGvZlV68YKLUlkauRBO86K7fPIW+UmYtndgzw2fxr5CTw7K
         Ua2wWzpdqR0Ee2RwmAox1aKRu5DA1u6tvpbP2s74ld7aMpKri8Wp42Riz9VNYNHGpmDp
         MxSAZtbWKr2yuYFmi8aza00gLBdghCvOIkRHLWjZrsd8hLEBIs86C+W2Ll2Hdvt0PurU
         xUrhIOMcUMOpzp3gbVRRbhD6/qCsfywd5PxQJ9NvHLU6VyDWiKeiBxD5LqFRBzhWjIWA
         XLSrwxk/CF/BRwFL72wp3K8TtInQWGwu7Cn2c/A+Qt/wAlaK092ESQEe3c8a2t/dJyUa
         T0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/utl8ZaT/2tlxp2lFNNxmbt5CfG0+r5dqlUPd9a7z8=;
        b=bKEu/0x9e1RVj+4ubgArbtO1D5IwEyAn6jrOcyAT62hEnYmPN1tb+DoTLcetYs6CCa
         LAK01+vB6sAilbWPwcyUFmO9XqHIf1w2sFAHnGVSTsDCdgoatYMLs7GQHpuPOpkv/XIU
         66rW3s6iN0ugdUp59toDM1nq/6bHtm6Dbq+OB668X1e+kY5lgyR4i+KR8z7ll4F0xZ5g
         SXnhYcV7jG1ZzCKpJ1ty4I6L+uvsJN33hvl3YkRihbe+lFyfp5Dp1a4Q4IxbTWKEK+i+
         opsAns8o4gsxKEiz0q6hJHPAY8lryMtIPID9eQ7tkBVKVFlopJG8CMJrm8o50vZ2pUfM
         rN1Q==
X-Gm-Message-State: AO0yUKXvYz3Ssp0nPO8zkBd6aK6L+Xx4bDEGUn06WG9cRbzQ5qdut2a/
        Sq/amczX2w9ZlX4dKzUEcBc=
X-Google-Smtp-Source: AK7set8Gv5QfqOqN5Sbd+WYgMKC6t2c+gMx5bUwHV7gT299WzwefTPoKLRuweyBVal4NpAxb+YjYig==
X-Received: by 2002:ac2:5fb0:0:b0:4ca:98ec:7d9a with SMTP id s16-20020ac25fb0000000b004ca98ec7d9amr2997230lfe.15.1678989477816;
        Thu, 16 Mar 2023 10:57:57 -0700 (PDT)
Received: from pc636 (host-90-233-209-246.mobileonline.telia.com. [90.233.209.246])
        by smtp.gmail.com with ESMTPSA id w20-20020a19c514000000b004b56bebdc4esm10175lfe.14.2023.03.16.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:57:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Mar 2023 18:57:54 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZBNYogVe9spBmTm2@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315183648.5164af0f@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:36:48PM -0400, Steven Rostedt wrote:
> On Thu, 9 Mar 2023 14:45:21 +0100
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > The kvfree_rcu()'s single argument name is deprecated therefore
> > > rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
> > > underline that it is for sleepable contexts.
> > > 
> > > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >  
> > Could you please add you reviwed-by or Acked-by tags so we can bring
> > our series with renaming for the next merge window?
> 
> I don't know. Perhaps we should just apply this patch and not worry about
> sleeping and whatnot.
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 04f0fdae19a1..5de945a8f61d 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -76,6 +76,7 @@ static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
>  struct osnoise_instance {
>  	struct list_head	list;
>  	struct trace_array	*tr;
> +	struct rcu_head		rcu;
>  };
>  
>  static struct list_head osnoise_instances;
> @@ -159,7 +160,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
>  	if (!found)
>  		return;
>  
> -	kvfree_rcu(inst);
> +	kvfree_rcu(inst, rcu);
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 20d0c4a97633..ef5fafb40c76 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1172,7 +1172,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
>  		return -ENOENT;
>  
>  	list_del_rcu(&link->list);
> -	kvfree_rcu(link);
> +	kvfree_rcu(link, rcu);
>  
>  	if (list_empty(&tp->event->files))
>  		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index ef8ed3b65d05..e6037752dcf0 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -256,6 +256,7 @@ struct trace_probe {
>  struct event_file_link {
>  	struct trace_event_file		*file;
>  	struct list_head		list;
> +	struct rcu_head			rcu;
>  };
>  
>  static inline bool trace_probe_test_flag(struct trace_probe *tp,
>
Anyway i do not see any problems with it

Acked-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
