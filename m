Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4C74EA61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGKJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGKJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:25:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA212E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:21:51 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D6793F36E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689067310;
        bh=OJ/UfvjsgxXJVj9cI8O8ORaFeewJGYP94m+QX22LbOU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=BbEE/AZBh6K1akTHp9yqgV5tCvgyzQJZknWoOu2u+FuGPIXk5BYixNjpiqfeSURO9
         iRXuPinIWZBcC21EGGpdYEnUV9K2ZfvHSUjlThK2qM0we9zh6CtAeWKWjkMsirTB5b
         hFikvpZJAISs9uj8/hSdfHYnm5Tbqv192K5MrGZzsC4DJ2ppdkN2h3qDjxCNvPTevM
         E1q5HUtOAZtCKkfw+Dr1CrXpaIoT9UrJ2XIZ94EXIC+SmMwEs6Epq0j++NVP2W0xsI
         o9L3pwQzvwt+fi9WAjgMQiHx8mBBVgDmSgtC3qZLm65cvb+OzQOyuYbM2BBc5P+y0T
         O3+P3PjzPVh7A==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993c2d9e496so289762466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067309; x=1691659309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ/UfvjsgxXJVj9cI8O8ORaFeewJGYP94m+QX22LbOU=;
        b=MHs+EniuRSSc1z7RFZ4cKOwL1u8HGsuN65a3qDaEjH903uEkURn3sY1grUMy8NmsRw
         aXkG+vatFGyCN01X+hms6+tbGh4yu2Y52nfnP8aUWUWK0Z85wzo+GUYWX/ve5MJuSQ4m
         6utwtUnW9yYEDodae4de6yZugyaT7fE0ky40Q3lbFGONaud1i3ZTMhID2BAhxb62nvJa
         IzHScHaNOkqvWW9qeMztg24f5pzNa1pVgCOvj1mS9ltPXYzTBGY82eXqBDppni0eNfQB
         DeKfKMMrWmHz35fKeQ3VCw0jz5/1zAppPLKFj/Z5zmM2OAeM/oGhyw/IQuhXfXXi9ba2
         vb7A==
X-Gm-Message-State: ABy/qLYxSGrxaaGIkbEPahGawMUGVfeF5t1YEcX0n9VYBbUJJDd0HXXX
        9YAU2Zn3tY9mYocPE6ui8mYo70X6xxlFYGFMmlN8SMIAY9jvr2qyCqIZ85cvkfstYh3ROy/BBU7
        dfoLBjWaOXzrYCmfNEGeGW8f/13ntMqfzD20L/phOlA==
X-Received: by 2002:a17:906:914c:b0:992:13c7:563 with SMTP id y12-20020a170906914c00b0099213c70563mr16737337ejw.75.1689067309611;
        Tue, 11 Jul 2023 02:21:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpMr0HuT9jbNM4jFYWwm/n67RIaIchwui/AhY3jPzD6rrXDz3TR9tPvLS84M605b1mpWVltA==
X-Received: by 2002:a17:906:914c:b0:992:13c7:563 with SMTP id y12-20020a170906914c00b0099213c70563mr16737307ejw.75.1689067309194;
        Tue, 11 Jul 2023 02:21:49 -0700 (PDT)
Received: from localhost (host-95-234-206-203.retail.telecomitalia.it. [95.234.206.203])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906298800b0098df7d0e096sm907161eje.54.2023.07.11.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:21:48 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:21:48 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 12/34] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZK0fLAnJrdJm5TUJ@righiandr-XPS-13-7390>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-13-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711011412.100319-13-tj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:13:30PM -1000, Tejun Heo wrote:
...
> +static void free_dsq_irq_workfn(struct irq_work *irq_work)
> +{
> +	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
> +	struct scx_dispatch_q *dsq, *tmp_dsq;
> +
> +	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
> +		kfree_rcu(dsq);

Maybe kfree_rcu(dsq, rcu)?

With 7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
we don't allow single argument kfree_rcu() anymore and I don't think we
want to use kfree_rcu_mightsleep() here...

-Andrea
