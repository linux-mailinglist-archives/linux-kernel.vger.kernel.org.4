Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C732F5F7C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJGR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJGR2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:28:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2E410327C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:28:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p14so1148173pfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6VKEJBSnD7n5od0XaTiGO38JX8JUsRQmKYwfdVSQmM=;
        b=crnj2Qjz8aFWT8URx9wUX4DnOa2++syxRDBP8I8V+Dz8POl5R+3VKiFSLMC/vr0Cor
         e63JrunKsmPXZNmDl/iylAeUWaw0EBTUy16hmgJ5gp8HaZxoL6wAA+UG07f5usXykt7A
         ieviITOlp+KFdB5LiLxEqzSdy8MDpoiFFQATnEv46dX53mHKFb082d1nZTex+fq18mOD
         s8YwgRLLvJVV0B6/hkXQfLAik3lAKy32hna1pL5p4ck3Ta/lj4sLtyqvNSv361Q8IfOW
         DYzA8SgfesbtmFOYrwbzYaQOtYuXh/7CBZUSYR2OZ4xkLgS1ErJBOlo228yhZUwv3mvd
         ChBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6VKEJBSnD7n5od0XaTiGO38JX8JUsRQmKYwfdVSQmM=;
        b=Hd0pIf4jRtaxNnjqYToqOWWg21H+JgEPIPfdVRdlv5msspxcCHuJ1ulcgJbjekuYjR
         sE460qDUKbdzCTq71Y2f/EB53F7voV+zERkN+vP/7BavUV/i2wkCw0RqkFeZmmM4ofXu
         raDMkk0/tSipsJyayNfuqlOwxtu++cddv+aytxDLMzbCbQSQNPMDKf7AyqAeZ97raooo
         vg/PoxfUVtnYkWvMFcQyMnCpZmrqX+MLeCTBPT7+x0Tn2V3K0NA4GJtPGDb83PqSXOYM
         2T7vIZqiiwNn8ngaANmhel8JUusypgAf3Na4B4r1vZlrJptiv8K4FKMypb9ZmMPaZNZD
         OAiQ==
X-Gm-Message-State: ACrzQf1rBujRWzmGGmX93dABxW+0mbzB1gevUTVhkqX1uYS8JmC7jLEj
        WO7T5J49SJcvDsrt6WyoMZQfbg==
X-Google-Smtp-Source: AMsMyM5bBudqx/dOvE76R9v9HV0MahFAW1GMZapY+7p6If1WHfIxHi/QBI4oOD4f/41Gza3voNIwmw==
X-Received: by 2002:a63:db42:0:b0:45c:9c73:d72e with SMTP id x2-20020a63db42000000b0045c9c73d72emr5345138pgi.181.1665163729203;
        Fri, 07 Oct 2022 10:28:49 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00177fb862a87sm1839955plg.20.2022.10.07.10.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 10:28:48 -0700 (PDT)
Date:   Fri, 7 Oct 2022 17:28:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: x86: Keep the lock order consistent
Message-ID: <Y0Bhy/z+1Z1seT2d@google.com>
References: <CAPm50a+gcug5XOsg_Z=7R+3j+VUxHMrzyGNbps7-okR625KB_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50a+gcug5XOsg_Z=7R+3j+VUxHMrzyGNbps7-okR625KB_w@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> srcu read side in critical section may sleep, so it should precede
> the read lock,

I agree with the patch, but not necessarily with this statement.  The above
implies that it's not safe to acquire SRCU while in a non-sleepable context,
which is incorrect.  E.g. at first I thought the above implied there is an
incorrect sleep buried in this code.

> while other paths such as kvm_xen_set_evtchn_fast

Please put parantheses after function names, e.g. kvm_xen_set_evtchn_fast()
and srcu_read_lock().

> execute srcu_read_lock before acquiring the read lock.

How about this for a changelog?

  Acquire SRCU before taking the gpc spinlock in wait_pending_event() so as
  to be consistent with all other functions that acquire both locks.  It's
  not illegal to acquire SRCU inside a spinlock, nor is there deadlock
  potential, but in general it's preferable to order locks from least
  restrictive to most restrictive, e.g. if wait_pending_event() needed to
  sleep for whatever reason, it could do so while holding SRCU, but would
  need to drop the spinlock.
