Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3A67B8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjAYRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjAYRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:46:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C2B77C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:46:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso2823535pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iC0Aa+LvLOWRqrglROEsiHqHOdXIvV7Rd4tZi5KUCNU=;
        b=qhFtO2lfy/DT73Zzd7DPCYtB349BHjCL1rZyW0NgZl1Mx8c5nby2ZPfYAutZ3bNrY6
         qLesDKkzOctO3ooal5abLT0OxcEEOehOfGdijwqDuGS5y174rt6d8Y1tBYJKtSXYR8QP
         +l7Q3NkMtok/kF40x+I8OjLUBankxHP52chZXb/EWg1QAHdBM+8kLgnOco3Gq0hJ5uKY
         07iDfv5JjFBp8W7Qn6UZSDUGUWXL6K43BWSJoOA92alEHjnQ3N9PYsWXZWem0QhwAgZm
         SjWvOqE1SnqT09zoaNn+z1hAnTGynnR4CHqwUZiYPvxPVl/Ss+8V9Sl0N8Lhs1ZNcoL/
         oOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC0Aa+LvLOWRqrglROEsiHqHOdXIvV7Rd4tZi5KUCNU=;
        b=bcmOAO2BQhvSAVPRQ3hDsqTpMvO6+hJR2RncyeT1z1JKeACx9jPmgY0GoJJjwSON/0
         U86oEmtrt2brASp2lH3d6lw/h/lOgeR4ILLi2lF4MABgKd+uHhPM1mm7PSEzEsfSnUOb
         akSA6mcuY7p5sXfo359UDo9gA9d3opo93htGQccZ965TqlO437hzRk51yvbamfmLtrK0
         6qiY15SZYemhfiC6UQ0pBohUocPui339tkR/YvuKbZ2Yh+GfpPVKt0FjqGHekBJHWG4w
         xn3tfREzdqZ4Q5vv28pzjNl06StFkAeI0tpFl0bR4zSK2vtaflEf7HOUl3YcUQLKBPYW
         55pQ==
X-Gm-Message-State: AO0yUKVsOGF5wZKOQrGZIpSm9xK/WtbfhiGTiMIWnMENZ28NA6YzLQA3
        N8MGqOyBf1+lb61aZ04Exdlfcw==
X-Google-Smtp-Source: AK7set/JLkWTk+jgDk232Ym6nG0fZgUdI7ks138iYIQTAtbi0fUywoCMPBR1kxU8q6Rybdu0tz9kKw==
X-Received: by 2002:a17:902:e00c:b0:192:8a1e:9bc7 with SMTP id o12-20020a170902e00c00b001928a1e9bc7mr662574plo.0.1674668788223;
        Wed, 25 Jan 2023 09:46:28 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902988a00b00192b0a07891sm2081086plp.101.2023.01.25.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:46:26 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:46:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrei Vagin <avagin@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/6 v4] seccomp: add the synchronous mode for
 seccomp_unotify
Message-ID: <Y9Fq7hcWDfMKUvPZ@google.com>
References: <20230124234156.211569-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124234156.211569-1-avagin@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>

Is attributing your personal email intentional, or is user.email in your git config
misconfigured?  Quite a few folks use non-corp accounts, but I don't think I've
ever seen a case where someone intentionally posts from their corp email on behalf
of a personal account.

I don't mean to be the SoB police, this just stood out as being very odd.
