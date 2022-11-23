Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054C635C43
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiKWL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiKWL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D8B4E420
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669204606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72X0u56tTcH3cffEqUa/4emv/ok6eCjQ+RB31fNcuLo=;
        b=UMP2QgrVxos48xcvuNPpD0BmQxZiOuYp0rs4mavb0rOCfWmZPoRyMxna7ZUuubosdEv5W/
        8kGUWF+qDXRy8AvavQ4gjUyU1+Yx+IDasmKyCFiC62xyZLvFoBC+KdAf4KWG2sOJmlpAwq
        9PijPJpoXOHPoVFTVQVC5ZQ0B/1BVFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-GqFqv4YROdmOEB2YANGDRA-1; Wed, 23 Nov 2022 06:56:41 -0500
X-MC-Unique: GqFqv4YROdmOEB2YANGDRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 408DB88B776;
        Wed, 23 Nov 2022 11:56:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-238.brq.redhat.com [10.40.194.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 63727C2C8C5;
        Wed, 23 Nov 2022 11:56:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Nov 2022 12:56:40 +0100 (CET)
Date:   Wed, 23 Nov 2022 12:56:38 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Petr Skocik <pskocik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix kill(-1,s) returning 0 on 0 kills
Message-ID: <20221123115637.GD32207@redhat.com>
References: <20221122161240.137570-1-pskocik@gmail.com>
 <20221122161240.137570-2-pskocik@gmail.com>
 <20221123103016.GA32207@redhat.com>
 <dcfcb10b-10c9-eb37-b345-07735453f5b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcfcb10b-10c9-eb37-b345-07735453f5b5@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23, Petr Skocik wrote:
>
> On 11/23/22 11:30, Oleg Nesterov wrote:
> >
> >But I fail to understand the /*either all 0 or all -EINVAL*/ comment above..
> >
> >Oleg.
> >
> 
> Thanks. The comment is explained in my reply to Kees Cook:
> https://lkml.org/lkml/2022/11/22/1327.
> I felt like making it because without it to me it suspiciously looks like
> the
> `if ( err != -EPERM) ret = err;` (or `if ( err != -EPERM) retval = err;` in
> the original) could be masking
> a non-EPERM failure with a later success, but it isn't because in this
> context, all the non-EPERM return vals should either ALL be 0 or ALL be
> -EINVAL.

Ah, now I see what did you mean, thanks.

Well, you are probably right, __send_signal_locked() won't fail even if
__sigqueue_alloc() fails, because si_code = SI_USER.

Not sure we should rely on this, but I won't argue.

Oleg.

