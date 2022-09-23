Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D25E753D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIWHxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIWHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649012BD96
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663919617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOGG5hgOKi/CJM4NK1rzcJoL+Wi8Clwwu1KXxusOWjU=;
        b=WtiLI8nVUqQOkJr3YODBPMgFLEjIVLKpdNGXGc65/fOR+X9zjqMZru0uwAQLjhBLQm4r/C
        K12aP2FDAEbkBA+72TqFyJrjHQbbpvhJMuce74DnpGxCeY264yTkA6wi9SpwJGJ2pqM1qs
        8ES1N9Ca8hfKOTHyz5QjOqIP+DpO4s0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-_i6V8lngNXajPEiNifPUOQ-1; Fri, 23 Sep 2022 03:53:34 -0400
X-MC-Unique: _i6V8lngNXajPEiNifPUOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78F333817A74;
        Fri, 23 Sep 2022 07:53:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 201D640C6E14;
        Fri, 23 Sep 2022 07:53:31 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     cambda@linux.alibaba.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: Syscall kill() can send signal to thread ID
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
        <87pmfn5tu1.fsf@email.froward.int.ebiederm.org>
        <87r102ejwo.fsf@oldenburg.str.redhat.com>
        <0CC7D0E7-71C5-4DAC-8A01-F9E13659F864@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 09:53:30 +0200
In-Reply-To: <0CC7D0E7-71C5-4DAC-8A01-F9E13659F864@linux.alibaba.com>
        (cambda@linux.alibaba.com's message of "Fri, 23 Sep 2022 14:25:05
        +0800")
Message-ID: <87illeedc5.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't quite understand what you mean, sorry. But if kill() returns
> -ESRCH for tid which is not equal to tgid, kill() can only send signal
> to thread group via main thread id, that is what BSD did and manual
> said. It seems not odd?

It's still odd because there's one TID per process that's valid for
kill by accident.  That's all.

Thanks,
Florian

