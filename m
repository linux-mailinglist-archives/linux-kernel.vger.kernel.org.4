Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACC5F31C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJCOML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJCOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A74A11B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664806319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCeNUoYplnvPs/5O9iLGFT1l5iKQnivIGxllLMxqSeU=;
        b=g+33cOPfVf8PCNnH/zvbMdEi/kJV7ytxvkD+LQBkNHmsveWov1SiKmIKJHgZrYI0MXrJpH
        tpaIYIgvnh3cYAIWSrj4lGRId6iLWLYg/+sZuk0aSAB00uRUj8rDRjBUd/G5nS6Fxk0O5v
        2NOjj0FNF6KpXhJA5jPWkqHbRLzmP9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-F7ezoSG3ON6hKWatEfxUmA-1; Mon, 03 Oct 2022 10:11:58 -0400
X-MC-Unique: F7ezoSG3ON6hKWatEfxUmA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1170185A7A3;
        Mon,  3 Oct 2022 14:11:57 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.195.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68858492B04;
        Mon,  3 Oct 2022 14:11:55 +0000 (UTC)
Date:   Mon, 3 Oct 2022 10:11:51 -0400
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RESEND PATCH v4 0/2] cpuhp: fix some st->target issues
Message-ID: <Yzrtp9wDUED+72w8@lorien.usersys.redhat.com>
References: <20220915153751.2123654-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915153751.2123654-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 11:37:49AM -0400 Phil Auld wrote:
> Fix a couple of cpuhp inconsistencies.
> 
> The first prevents target_store() from calling cpu_down() when
> target == state which prevents the cpu being incorrectly marked
> as dying.  The second just makes the boot cpu have a valid cpuhp
> target rather than 0 (CPU_OFFLINE) while being in state
> CPU_ONLINE.
> 
> A further issue which these two patches don't address is that
> the cpuX/online file looks at the device->offline state and can
> thus get out of sync with the actual cpuhp state if the cpuhp
> target is used to change state.
> 
> v3: Added code to make sure st->target == target in the nop case.
> 
> v4: Use WARN_ON in the case where state == target but st->target does
> not.
> 
> Phil Auld (2):
>   cpuhp: make target_store() a nop when target == state
>   cpuhp: Set cpuhp target for boot cpu
> 
>  kernel/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> -- 
> 2.31.1
> 

Pingy McPing-face :)

Peter?  Anyone?   It's really not ideal to have a cpu marked dying when
it isn't actually going down. Please take a look. 

Thanks for your time.

Cheers,
Phil

-- 

