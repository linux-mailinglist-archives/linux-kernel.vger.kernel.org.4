Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9455E6A0F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjBWSjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBWSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:38:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B726CF2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677177491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLzkYWlqDfHO1zvCfSXGiM4cVbbzITU5Ng0iiPPY5/U=;
        b=aQgZbFSuZFjmRKPcUzpi/E2V3fLQkao6IlIP+4+uOrlCf1kAb+Hjv2FFZ6n/dh6Tm3scKw
        /x8+n5KEiiWRknCYPSStj9vOCaCAsJG6xjckJpCftXaxYCZBy1O85AeMKKD6yZT1QnjbcS
        rQrt47wWI89udWaHlRUJbUw95ecYUYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-CUN6l3LlNvmpVV9oob4o8Q-1; Thu, 23 Feb 2023 13:38:08 -0500
X-MC-Unique: CUN6l3LlNvmpVV9oob4o8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E1D719711D0;
        Thu, 23 Feb 2023 18:38:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.239])
        by smtp.corp.redhat.com (Postfix) with SMTP id F2C2A404BEC6;
        Thu, 23 Feb 2023 18:38:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 23 Feb 2023 19:38:00 +0100 (CET)
Date:   Thu, 23 Feb 2023 19:37:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230223183756.GB26182@redhat.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
 <20230221201740.2236-3-gregory.price@memverge.com>
 <20230222124834.GA15591@redhat.com>
 <Y/YzloHpiyOSvZfK@memverge.com>
 <20230223123020.GA26182@redhat.com>
 <Y/eG4oHc2jz6uSfi@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/eG4oHc2jz6uSfi@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23, Gregory Price wrote:
>
> On Thu, Feb 23, 2023 at 01:30:20PM +0100, Oleg Nesterov wrote:
> >
> > Well, if this is the only reason then this check and the "size" argument
> > ahould be removed, imo.
> >
> > But perhaps it can be useful for future extensions, I dunno.
> >
> > Oleg.
> >
>
> I suppose yes it could also be used to detect differences in versioning
> if the struct changes in the future, and that would not require an API
> change in the future to support it.

Yes this is what I tried to say. So I won't argue.

Oleg.

