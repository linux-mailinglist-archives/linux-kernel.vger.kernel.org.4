Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5B5E7B45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiIWNCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIWNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA313A060
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663938161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8KZImyH1keDN6o1jnF6cQm8Dllod+zGLto6X0zKc1c=;
        b=gdANi0P/jGcGXY3ucD9Xh9ikqLQMNcltOSoGHrit9u8tlZCWNRHH/v5RpHQR4YJ5VrMpP3
        7Wjn3T2BfIYsyklpNqjyHM73Ud91v83uk6izbnJjqwO1ZsbZpa/vTqhl282cD2fwcSlH+w
        UGoYe0K4h45P7k6ugwrquO8jPgMexLg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-6ruVlsqJMtm46GIVpa9B_w-1; Fri, 23 Sep 2022 09:02:36 -0400
X-MC-Unique: 6ruVlsqJMtm46GIVpa9B_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9E041C05EB4;
        Fri, 23 Sep 2022 13:02:35 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.195.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A9EC16922;
        Fri, 23 Sep 2022 13:02:33 +0000 (UTC)
Date:   Fri, 23 Sep 2022 09:02:30 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        rafael@kernel.org
Subject: Re: aarch64 5.15.68 regression in topology/thread_siblings (huge
 file size and no content)
Message-ID: <Yy2uZvsbKStqBKnF@lorien.usersys.redhat.com>
References: <20220922113217.GA90426@meh.true.cz>
 <YyxVytqQDbGWPa+6@lorien.usersys.redhat.com>
 <YyxXoPmtTZHCr5pR@kroah.com>
 <Yyxgtx/Vr6Ar1xEe@lorien.usersys.redhat.com>
 <20220922140504.GA58265@meh.true.cz>
 <YyyY1LgHzQZpQkqM@lorien.usersys.redhat.com>
 <20220922200506.GC87797@meh.true.cz>
 <Yy15h2vXFBhCRMrL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yy15h2vXFBhCRMrL@kroah.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:16:55AM +0200 Greg Kroah-Hartman wrote:
> On Thu, Sep 22, 2022 at 10:05:06PM +0200, Petr Štetiar wrote:
> > Phil Auld <pauld@redhat.com> [2022-09-22 13:18:12]:
> > 
> > > Then I applied the fix and the problem went away:
> > 
> > I've just tried the same aarch64 and I can confirm, that the
> > patch fixes the issue.
> 
> Wow, that's odd that the file size matters here.
>

Yeah, I looked through the code some but nothing jumped out where
that unsigned -1 could cause a problem (like count + 1 wrapping
to 0 or something).

> Ok, I'll send this to Linus in a few hours, thanks.

Thanks!


Cheers,
Phil

> 
> greg k-h
> 

-- 

