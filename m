Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D786972CD18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjFLRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjFLRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:43:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5707918B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:43:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-543b599054dso2569200a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686591806; x=1689183806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgKe+22S/Equ9vneq3cQY7jgDts9lbX3Yflbz2hEohc=;
        b=AnBTqX5ksLm0QJawfnoJq9W+zeMYJtgTAzLuh7CRohG91xwR832TgXN9q6eG1pLwQU
         IVBQFqoqiUggss/aZBXTnszll1q9ZIO9QkrK5Ef1nd+YsRi9am+YJMDjUdWLE9QzxZym
         vPLDItXQah9ot3Kf8o2vjkWfSBnrHuopMQrUZllBy/2zWYS4xfd3g6scpVjkLiFGEZJp
         3eHaCSfWaNkTNIhYgiSsovGKBXaREweLu/uzndoCKwcu9K9nwqyovwshmf/1KD83gri+
         grA8rqOoyEzq5yWoIZm+owujdM2Iv65ESFEBEJTAvL4AOIro4RrjUgONp0OvhYQuA1f3
         1vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591806; x=1689183806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgKe+22S/Equ9vneq3cQY7jgDts9lbX3Yflbz2hEohc=;
        b=bbi36Yf89JWmpLSwPYBPH49jv5PBduvnjph8tymqqS913NtyldOEa+VQnom1PFnOzw
         Upk3yHiYQCdXnDJaVeSj/+9s7Xjgiixd+I1gncnm84ekGwL609gR8ygqrUvT8TV31YQh
         EHbfDNt1lOG1qUgd2fiZgRLuWXBGNJguXXGQ4AXw2IG5GV5V9Q0bNGmwKUMp6E4g/bJg
         wYrdvsU/AlTymyOk5jNWQrFkrjqkMhI3Aq9JXlb33mfycCfADGKhUnLlwBq6aS1K233i
         DLdXm1PREC3/9U0LFmIt5Ja8UBd/ePLtikzQ9gvGyanW5YEJZInIEzOIToz0y2DaO7aG
         yMqQ==
X-Gm-Message-State: AC+VfDwd+Ol7nh2ArieTTpbSKwC3DiJWsE2c6LlBS9C9FqnG+niCNc4C
        ZxnKl2kZb3I2UhPebn8p7Xs=
X-Google-Smtp-Source: ACHHUZ560mH/7D8Ew6zwdbAzqjPF7h17AG0h5f4KvkBV8xlHoA5blPVMCTTU5p+Y4vXpA0VBM11EoA==
X-Received: by 2002:a17:90b:1e08:b0:259:bff8:17a2 with SMTP id pg8-20020a17090b1e0800b00259bff817a2mr15815946pjb.0.1686591805601;
        Mon, 12 Jun 2023 10:43:25 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a031c00b0025c02ef91f6sm718992pje.22.2023.06.12.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:43:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 07:43:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [tj-wq:affinity-scopes-dbg-invalid-cpu] [workqueue] e3485721f9:
 WARNING:at_kernel/workqueue.c:#workqueue_online_cpu
Message-ID: <ZIdZQBJbOkuaAYvx@slm.duckdns.org>
References: <202306120920.a932842-oliver.sang@intel.com>
 <ZIdY8-aOIR3lQI3M@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIdY8-aOIR3lQI3M@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:42:11AM -1000, Tejun Heo wrote:
> On Mon, Jun 12, 2023 at 10:04:02AM +0800, kernel test robot wrote:
> > [    3.388228][   T21] ------------[ cut here ]------------
> > [ 3.394990][ T21] WARNING: CPU: 1 PID: 21 at kernel/workqueue.c:5393 workqueue_online_cpu (kernel/workqueue.c:5393 kernel/workqueue.c:5481) 
> ...
> > [ 3.584746][ T21] ? workqueue_prepare_cpu (kernel/workqueue.c:5470) 
> > [ 3.591752][ T21] ? local_clock (kernel/sched/clock.c:270 kernel/sched/clock.c:307) 
> > [ 3.596749][ T21] cpuhp_invoke_callback (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/cpuhp.h:65 kernel/cpu.c:193) 
> > [ 3.603751][ T21] ? try_to_wake_up (include/linux/sched.h:2254 kernel/sched/core.c:4312) 
> > [ 3.610751][ T21] cpuhp_thread_fun (kernel/cpu.c:815) 
> 
> This is set_cpus_allowed_ptr() failing on kworkers when workqueue tries to
> put back the per-cpu kworkers on the onlining CPU, which is rather
> unexpected. Let me include the error code in the warning message so that we
> can understand why it fails the next time.

Ah, never mind. This ->__pod_cpumaks not being initialized correctly by the
patch and is already fixed in the newer version of the code.

Thanks.

-- 
tejun
