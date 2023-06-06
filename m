Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004C72443D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbjFFNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjFFNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F3910D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686057679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7O+Uogxnv87YjJ34Ig51fjasBxTsbyDg+pu4Vsfmzzw=;
        b=VnNQm1GFpLZGCCUIheOUtZRScOyAW+AGu2kjADEbldlfq83AoEP64mFHaFVxC49GKpKT7O
        1W6dJnQM13a9ScL5APKeQIakwg8i03fgH0DMsvWhbEWwTMqB6tMPrOMgYlHdOEBKgZWNbH
        Ok266+yCN0+IcPQZEtNWgFmtlVkLDoM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-HyeFG2MzN-CBd_rZ_H4JhA-1; Tue, 06 Jun 2023 09:21:12 -0400
X-MC-Unique: HyeFG2MzN-CBd_rZ_H4JhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E45DA8032FA;
        Tue,  6 Jun 2023 13:21:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 872689E94;
        Tue,  6 Jun 2023 13:21:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Jun 2023 15:20:49 +0200 (CEST)
Date:   Tue, 6 Jun 2023 15:20:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2 v2] signal: Don't disable preemption in ptrace_stop()
 on PREEMPT_RT.
Message-ID: <20230606132047.GA16159@redhat.com>
References: <20230606085524.2049961-1-bigeasy@linutronix.de>
 <20230606085524.2049961-3-bigeasy@linutronix.de>
 <20230606110447.GA7542@redhat.com>
 <20230606111418.GA906324@hirez.programming.kicks-ass.net>
 <20230606113853.GC7542@redhat.com>
 <20230606131621.nbXfkFvG@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606131621.nbXfkFvG@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06, Sebastian Andrzej Siewior wrote:
>
> v1…v2:
>   - Extend the comment to note that preemption isn't disabled due to
>     the lock to make it obvious that the optimisation isn't just
>     harmful but also pointless.

Thanks,

Acked-by: Oleg Nesterov <oleg@redhat.com>


