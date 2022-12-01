Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9963F070
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiLAM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiLAM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136C2A95E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669897571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1cbd6hq1aBPo8PBxZgH12qMPl3yl8Mr+Uku+gvk4Mk=;
        b=O8ja7bfFUzDRYl7zW0r6E5opAIUmb3afnFi7sbU+5gAKNma1KkoBYLh3H+S+ITy9NCE4Cl
        md82Kz2EK390uxZFQHNWdKNKObZ5L8wwIbtETbW2Cj8tEqOK1ddhNJohX7idt9lXFJ8LFw
        zy32ker96KYVKbmwFxc2nxgtDJVh4II=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-6D2d9tSbMrOnq2QZAMB1iA-1; Thu, 01 Dec 2022 07:26:06 -0500
X-MC-Unique: 6D2d9tSbMrOnq2QZAMB1iA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42475800186;
        Thu,  1 Dec 2022 12:26:06 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1D90FD48;
        Thu,  1 Dec 2022 12:26:05 +0000 (UTC)
Date:   Thu, 1 Dec 2022 07:26:01 -0500
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5 0/2] cpuhp: fix some st->target issues
Message-ID: <Y4idWUktk/R/cHE/@lorien.usersys.redhat.com>
References: <20221117162329.3164999-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117162329.3164999-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:23:27AM -0500 Phil Auld wrote:
> Fix a few cpuhp related issues.
> 
> The first prevents target_store() from calling cpu_down() when
> target == state which prevents the cpu being incorrectly marked
> as dying.  The second just makes the boot cpu have a valid cpuhp
> target rather than 0 (CPU_OFFLINE) while being in state
> CPU_ONLINE.
> 
> v3: Added code to make sure st->target == target in the nop case.
> 
> v4: Use WARN_ON in the case where state == target but st->target does
> not.
> 
> v5: Fixed lowercase on first patch title and cleaned up cover letter.
> Rebased on v6.1-rc5.
> 
> Phil Auld (2):
>   cpuhp: Make target_store() a nop when target == state
>   cpuhp: Set cpuhp target for boot cpu
> 
>  cpu.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Thanks for picking these up, Thomas!


Cheers,
Phil


> -- 
> 2.31.1
> 

-- 

