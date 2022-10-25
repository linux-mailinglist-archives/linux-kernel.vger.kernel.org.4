Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CCC60CA9E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJYLId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJYLI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281F12B378
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666696106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbFZfMwxDx0onwzCpoqUiakpnSjMLfSg7C2QrxxsGK4=;
        b=JDuLsFEtKae2mZgnUEZySjiEf9jeqrwoJ/6rqqePcqyz431lBi5w0/pV11GEEtgHb9NN62
        qlSdbw/3sOyO+4qbf0YTdrte5dIk+zknceHOQB7qO4KxGEYjbkdwsT3nHp6pSMsY+B8V9H
        74YDiWaRD2jAFkPUBUKk21J2K6rWr2M=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-rrPjH48mMOeVyj57HfAHWw-1; Tue, 25 Oct 2022 07:08:25 -0400
X-MC-Unique: rrPjH48mMOeVyj57HfAHWw-1
Received: by mail-vk1-f199.google.com with SMTP id f129-20020a1f9c87000000b003b6d7b00d48so943247vke.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbFZfMwxDx0onwzCpoqUiakpnSjMLfSg7C2QrxxsGK4=;
        b=uS6afOGgHLpMejGIEVTsEjieJrJKyyfXefIQxCPQgoRPhHKb7wZf+bXXTRUiaO7b9M
         sQUoJfqUXEEO7dukfetEQ0jQWYs+hZCmZZE3kbiRXOu0tr5lTwFBbumiRb3w/Ge+IVsV
         N5lEJ5AqDRtchvSlPtoeaeAiDgoRYDngqo8EaaaN50Xa4dAD+JTjY9U4pGjyRAQEiSqF
         B7pwMYlOFy3WrCSSYyIWaIwzxe+8g+1FmgrO8Qwog122gE2+ooM1e8IvAgevL/4OVCKZ
         sQQYuDBMo6TiU6UHNeeaNf2w41OGhkJouGYjxl3hSZGtKBCKkkf4GKh1IFyNf90EyFFa
         Hdlg==
X-Gm-Message-State: ACrzQf2XUD7DzWG7E2i/EmkptBkWXbpryu62XnljQ3Z3oPoKj72NiZ6N
        +jYwzsKbPF9NGEOozjTi3LsRD0kTE3hhAlPLVlMQHq+POJ9AqnTpeUj4mh3cJoMOyoPRZoE879W
        altNPoMYdF4ziF9JyQuVkg6ywyJqWCq5oD3nZ/aFZ
X-Received: by 2002:ac5:c1d9:0:b0:3b4:7394:7b7 with SMTP id g25-20020ac5c1d9000000b003b4739407b7mr9578614vkk.11.1666696104726;
        Tue, 25 Oct 2022 04:08:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7EUbGLB/rDds585tq55Wl4/tVVwITzQQEXtZm8AfW9Fma4NxTd9oCv9EU3wnDj+904F0d4RfiTnVasrXoigOQ=
X-Received: by 2002:ac5:c1d9:0:b0:3b4:7394:7b7 with SMTP id
 g25-20020ac5c1d9000000b003b4739407b7mr9578607vkk.11.1666696104483; Tue, 25
 Oct 2022 04:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221025101828.1626490-1-ecurtin@redhat.com> <20221025104833.io3spnxw7724vlhb@begin>
In-Reply-To: <20221025104833.io3spnxw7724vlhb@begin>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 25 Oct 2022 12:08:08 +0100
Message-ID: <CAOgh=FwFHrLc3kmjVD49cVoRcfhtPFAqKrO5U_RE6FYVV2zXTw@mail.gmail.com>
Subject: Re: [PATCH] speakup: include types.h so u_char is a known type
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Eric Curtin <ecurtin@redhat.com>, gregkh@linuxfoundation.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        "open list:SPEAKUP CONSOLE SPEECH DRIVER" <speakup@linux-speakup.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 11:54, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> Hello,
>
> Eric Curtin, le mar. 25 oct. 2022 11:18:24 +0100, a ecrit:
> > Fixes build of utils.h header file, occurred when building kernel on
> > postmarketOS on Lenovo Duet Chromebook.
> >
> >   drivers/accessibility/speakup/utils.h:57:9: error: unknown type name 'u_char'; did you mean 'char'?
> >      57 |         u_char *pn = (u_char *)name;
> >         |         ^~~~~~
> >         |         char
> >
>
> There is already a patch pending commit that just replaces it with
> unsigned char.

Sorry I missed that. that works for me :)

>
> (see
> Subject: [PATCH] speakup: replace utils' u_char with unsigned char
> )
>
> Samuel
>

