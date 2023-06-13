Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83F672D76D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjFMCsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjFMCsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:48:06 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F091720
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:48:05 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a5229df1f2so3221850fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686624484; x=1689216484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAqkcjT6LIQQdFeaFHSjrw8XkbwpmOnSGyOspM01Gew=;
        b=cun9njffuoamEe1XUOhorGMsTm4Qnlmyz2PArP+hsesHWx0DMxCkJKB4bfjtggF8Ax
         YW0WQpAHOk6DWsefa4dWoDonxjOkaInHuYyUGipvDIctkJpuchP/HG7D2Jt2sw9U7pcQ
         +0eCvwHXUc0WtW6w8Qn6gdqVHrNelu23sA2bhVlGQpYD/b8yQb9Q4Pv+0xVZEfBzQMEf
         d5+iQGeucsnB7SDy1yENfgf4uPjpEfIjMTJ6pPZ6Gx9EtIURIBs2SwLu7oNLfj81bNnD
         RZmczY1w0q/9hqEbcaS1WLwDVFtAMkXn2aDjVote9vabTAaH1LzCD+gLDsII/Tv9q4vr
         QlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686624484; x=1689216484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAqkcjT6LIQQdFeaFHSjrw8XkbwpmOnSGyOspM01Gew=;
        b=eqqGeMTkvtKh9uibFdFA7x9ScuiFuIWyBbvBgHHacXVtnbYIkErNqlebgqLhXjJqRA
         RKBwg1Dhd1CDylV7KpLbsjmWte8nuWo+jwDExOY0kNEGVxNwOaCXQwSJIs45P5HI4mCP
         ciQk19k4dOqLyOF0cT5bEKPz/IWaZva3pyA0Htxs2oc04lneLmcQ6sfuTsCouxSkNa0H
         UktTlhuUVoznPLDtpk39PZJcPKkC4DiVVG9NJPTsNzIuZACPqj7zhZ5Eu9gD+E5XSiLo
         eAX2JxaoR7RPdU4byDr1UAaGw/cwrVF9uCBRiMo79tVfGPLpTaD1SozZLZ4qcSLbOgI7
         o7UA==
X-Gm-Message-State: AC+VfDwR+ECGxPGPZEC85XDHPqFrKHfedWlqXc72ARmaTs2oiX5eeBvO
        ZGa8IFPaCGczFmmz2dw1WS0=
X-Google-Smtp-Source: ACHHUZ7X+vrRc18BVSk9Dn9FnHqL/RQSWNvlmr91M3GQ0DvWn8TfyWol48lSBmCp8opleMSWv9nIAA==
X-Received: by 2002:a05:6358:515a:b0:12b:e2d8:d80f with SMTP id 26-20020a056358515a00b0012be2d8d80fmr2218994rwj.5.1686624484006;
        Mon, 12 Jun 2023 19:48:04 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7924d000000b0064d74808738sm7485165pfp.214.2023.06.12.19.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 19:48:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 16:48:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, treapking@chromium.org
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZIfY5zhhHU9IgOqx@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <ZIewlkGJJJUXPFL0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIewlkGJJJUXPFL0@google.com>
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

Hello,

On Mon, Jun 12, 2023 at 04:56:06PM -0700, Brian Norris wrote:
> Thanks for the CC; my colleague tried out your patches (ported to 5.15
> with some minor difficulty), and aside from some crashes (already noted
> by others, although we didn't pull the proposed v2 fixes), he didn't

Yeah, there were a few subtle bugs that v2 fixes.

> notice a significant change in performance on our particular test system
> and WiFi-throughput workload. I don't think we expected a lot though,
> per the discussion at:
> 
> https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/

That's disappointing. I was actually expecting that the default behavior
would restrain migrations across L3 boundaries strong enough to make a
meaningful difference. Can you enable WQ_SYSFS and test the following
configs?

 1. affinity_scope = cache, affinity_strict = 1

 2. affinity_scope = cpu, affinity_strict = 0

 3. affinity_scope = cpu, affinity_strict = 1

#3 basically turns it into a percpu workqueue, so it should perform more or
less the same as a percpu workqueue without affecting everyone else.

Any chance you can post the toplogy details on the affected setup? How are
the caches and cores laid out?

Thanks.

-- 
tejun
