Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB520718E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjEaWQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEaWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:16:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7111E44
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:15:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae64580e9fso24335ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685571343; x=1688163343;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C69/HgDQcYHZzBDl4mqXS6yFcUMrvhBV+XsyYfCeFy4=;
        b=avojlsc996gGnZc9DZwhWPrvUhBeM5Ph8gNSA8jcDuKN2emMUuWsHnU64lv54HzvW1
         gk6Wiy/Gzo6kgMr7K5QQNsEvMkacDXf2sAq/hr/kXiDcBe5L+W24usb8vJEl3eouOszC
         dwWJzkYg9zPXF2m/+jsTwydw/xtxLXhHqz9MAGF8SyKIJnM5LaBgqpOdsGhxqG1SGl0V
         oU66ytUYcUTWLe2l3lfrG7+oADifxqKM2mo/sZgsogoDIgyX34io8uFbt8rOh9stuV8a
         pupW/pRMsonx5qViaZUfcJwVB0ydPW8XE0BHrd4SS80BzTaNWrKGuPKW46p2Y8suyrNZ
         ilMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571343; x=1688163343;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C69/HgDQcYHZzBDl4mqXS6yFcUMrvhBV+XsyYfCeFy4=;
        b=TV9NSo/lhxl55BUYDaFXY+/AcKusY9AiI2ViyxuWgEo0tn8kt7xXKVVuz+bn0Pc7Q1
         iKpa31u908Lg16qLAQLYOhNQJQc9NVRKaHPjCIplxmByK6/Imo+Omiabocd7ufJcGOMA
         cujgiGzDn42OrJ+JvwO6gQ+09mKw2WFCvFDRa3bYlCPXx5Xfv8SZCrISF8QPXhzYJgOr
         UXiY4nSJx0CmX8VEqJgSyFNivHdW9xnIhXGedHLpj0O5z6UC1V39UPseKRW2VNGbVilT
         e3HTYjgI600qNhYtoRS6OneUvi7nEz4GeEFd/CZkmfCNg0W/4l2xWl2Pvsnx5YnC7lEB
         09oA==
X-Gm-Message-State: AC+VfDzzEwoTnyabae6YvZA4+eF6HxkiB4XrWV5qEePNbXibpLpsM/Vq
        FzMtrdaW0Uerjr+tYzoTqSNy+Q==
X-Google-Smtp-Source: ACHHUZ7zAWHVLeCjO/NeIx9R8Cm5pi2tcHFmuvYnV9NvWdpLer08hYIMnMnuREKWaC6bxLVBoTsmCw==
X-Received: by 2002:a17:902:f38c:b0:1a6:6a2d:18f0 with SMTP id f12-20020a170902f38c00b001a66a2d18f0mr19120ple.9.1685571342975;
        Wed, 31 May 2023 15:15:42 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b0019aaab3f9d7sm1910004plg.113.2023.05.31.15.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:15:42 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] epoll: ep_autoremove_wake_function should use
 list_del_init_careful
References: <xm26pm6hvfer.fsf@google.com>
        <20230531015748.GB1648@quark.localdomain>
        <20230531-zupacken-laute-22564cd952f7@brauner>
Date:   Wed, 31 May 2023 15:15:41 -0700
In-Reply-To: <20230531-zupacken-laute-22564cd952f7@brauner> (Christian
        Brauner's message of "Wed, 31 May 2023 09:53:01 +0200")
Message-ID: <xm26ilc8uoz6.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Tue, May 30, 2023 at 06:57:48PM -0700, Eric Biggers wrote:
>> On Tue, May 30, 2023 at 11:32:28AM -0700, Benjamin Segall wrote:
>> > autoremove_wake_function uses list_del_init_careful, so should epoll's
>> > more aggressive variant. It only doesn't because it was copied from an
>> > older wait.c rather than the most recent.
>> > 
>> > Fixes: a16ceb139610 ("epoll: autoremove wakers even more aggressively")
>> > Signed-off-by: Ben Segall <bsegall@google.com>
>> > Cc: stable@vger.kernel.org
>> > ---
>> >  fs/eventpoll.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> > index 52954d4637b5..081df056398a 100644
>> > --- a/fs/eventpoll.c
>> > +++ b/fs/eventpoll.c
>> > @@ -1756,11 +1756,11 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
>> >  static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
>> >  				       unsigned int mode, int sync, void *key)
>> >  {
>> >  	int ret = default_wake_function(wq_entry, mode, sync, key);
>> >  
>> > -	list_del_init(&wq_entry->entry);
>> > +	list_del_init_careful(&wq_entry->entry);
>> >  	return ret;
>> >  }
>> 
>> Can you please provide a more detailed explanation about why
>> list_del_init_careful() is needed here?
>
> Yeah, this needs more explanation... Next time someone looks at this
> code and there's a *_careful() added they'll want to know why.

So the general reason is the same as with autoremove_wake_function, it
pairs with the list_entry_careful in ep_poll (which is epoll's modified
copy of finish_wait).

I think the original actual _problem_ was a -stable issue that was fixed
instead by doing additional backports, so this may just avoid potential
extra loops and avoid potential compiler shenanigans from the data race.
