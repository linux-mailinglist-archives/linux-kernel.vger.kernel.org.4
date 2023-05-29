Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE98714F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjE2R4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjE2Rz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE92FEC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685382907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5T9MHRTHIQNCUkVW4I4H09mYouCxsI7tWivq2a2Wpc=;
        b=SavIwdyKdX8bsQ/mWwhuI6B0JnS7R5LDjjyuaWTO8RYh15yyFt0BD/bU6CRBadl8k87OWj
        yqFXBBxiOCjXHpGGp+qh3pevh643eAZm2FhhSP/5VIX4RNOwxsqp9L8tUFsxLzc5bIs6+Q
        DozfLTYDbRYwzTbDjlSei9hP9uARO6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-Rlbg88dHOUyRqa9wMvsnNQ-1; Mon, 29 May 2023 13:55:03 -0400
X-MC-Unique: Rlbg88dHOUyRqa9wMvsnNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D41C101A531;
        Mon, 29 May 2023 17:55:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1946620296C6;
        Mon, 29 May 2023 17:54:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 May 2023 19:54:44 +0200 (CEST)
Date:   Mon, 29 May 2023 19:54:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     michael.christie@oracle.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230529175440.GC15193@redhat.com>
References: <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
 <20230529174646.GB15193@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529174646.GB15193@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29, Oleg Nesterov wrote:
>
> Mike, sorry, I don't understand your email.
>
> Just in case, let me remind I know nothing about drivers/vhost/

And... this is slightly off-topic but you didn't answer my previous
question and I am just curious. Do you agree that, even if we forget
about CLONE_THREAD/signals, vhost_worker() needs fixes anyway because
it can race with vhost_work_queue() ?

Oleg.

