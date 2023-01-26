Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD30C67CF71
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjAZPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjAZPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FB59E6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674745847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QG6Sd9tYt9i9oyjRZB/m7JGOx0vpbuKAr/nqEOLMCI=;
        b=Svy8oPBa6R/lOtMNGNcXMySQozg5ub5rnBWuJ1H9hrjSvtsADvK12mWDUzv3coTGU3qZMu
        4rl1dzwHIYzGvVL0bKu4stfTtyQOWVhm4pFaYLnoW/deG3wu4fDFiccO7oEn6CCQyrAxPk
        dtAN9e18QsKvwYJxbPZ3CIkXJN4kMOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-Pq3b_L0CMSSNTmEXsBRC9w-1; Thu, 26 Jan 2023 10:10:43 -0500
X-MC-Unique: Pq3b_L0CMSSNTmEXsBRC9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8381181E3F4;
        Thu, 26 Jan 2023 15:10:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-60.brq.redhat.com [10.40.194.60])
        by smtp.corp.redhat.com (Postfix) with SMTP id 763A9140EBF5;
        Thu, 26 Jan 2023 15:10:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Jan 2023 16:10:39 +0100 (CET)
Date:   Thu, 26 Jan 2023 16:10:36 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <20230126151035.GC4069@redhat.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
 <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
 <Y9IPCpYzfGb6k0sF@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9IPCpYzfGb6k0sF@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26, Gregory Price wrote:
>
> So basic questions are:
> 1) Andrei do you think any injection occurs during quiesce that can't be
>    worked around?
>
> 2) Oleg is the auto-clearing nature of the flag sufficient justification
>    for keeping SUSPEND?

I understand that SUSPEND is more convenient for CRIU and more "safe".

But. This kernel is already overbloated ;) IMO, if SUSPEND is not strictly
necessary, it should be dropped.

Oleg.

