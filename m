Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8765CA45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjACXSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjACXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:18:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E115FCF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:18:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f3so21151300pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SKNwK2NyJVXaeShNit/vbIhlTVvPRm29ctCwVFguc8=;
        b=dKwcY+gyo70o9MnjanigW/qbwMZCHd1jZ/HZNSbTYA7uNNvtO5+1d3klhV3LBMg+Wz
         C2f5ATp6q34nZdwFYSHxnjLN6cdjcQaZYK8In156L+mHFNKh+ncF5id1Xdogt5wKfYUP
         Jfq+tUgmYLuZ+tsFX7/u5Ev8KhBwft2jYUV4FcrCcN7XOYrKU8lEy9cr4xdbEFAeeqOM
         +mNiWE5zo51VEhO5XWTZPXdcAW+wBtXNeIn+UGKmYkP6QHi06nkmYHqNyDHWviMrOrpU
         DOsV/Fm4EsBo2CqwNVgdmKbLjtd3H+h0QfLHQ/3g4IxCEdekFIWpWIAFgfLrqB5VWLuZ
         UoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SKNwK2NyJVXaeShNit/vbIhlTVvPRm29ctCwVFguc8=;
        b=BHiTAyJY/6fc/Yey8vnmJ2hWBzA8jBumrVXtQnDdkU2Rtnc1+APWZPFPpBjdya3yhA
         AzLaOIyWOOqnn3buAdeXCIOPa0m7HaO/BuMsabVniHEuGu7wuA7zZ9LCQhZW0CjE7wT2
         PpIGhjBOMEPn5Oz1E/5YAs7RUfSSexpE6eS0xnTJT9GSH91dCpwV4OY9RZ2gR22Lohpc
         CR0Ftp9GCL6YhXDcMO/cKtgiuP4BRYhgZTtX1hQbeJ6WU9NYGGBH7fR0urkTlUZLcGq9
         phnmyudvYUCNPd2vLARxRcg18izZNFj9ftfep+AAYP5jvFnPbdcT4la4cnSTHeWgffRB
         WbEQ==
X-Gm-Message-State: AFqh2kq0Au9wphxwFwBJxEA1VrB59/q8Lc1TwlD/ifWkFlCH51xhzjR4
        TIvs1gSXViRCducbKfZjD+hJ3hzu+j6wn/iW
X-Google-Smtp-Source: AMrXdXsj9J+1dDyzj3rH6i+WIAk9RX4wTCh/a0OvdiDq7jKdG5ipnl0KUACxUzdUC3b8vzSnoPI8sQ==
X-Received: by 2002:aa7:8084:0:b0:574:8995:c0d0 with SMTP id v4-20020aa78084000000b005748995c0d0mr3598502pff.1.1672787912621;
        Tue, 03 Jan 2023 15:18:32 -0800 (PST)
Received: from [2620:15c:29:203:3ac1:84a4:2f59:c43f] ([2620:15c:29:203:3ac1:84a4:2f59:c43f])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm12920964pfj.112.2023.01.03.15.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:18:31 -0800 (PST)
Date:   Tue, 3 Jan 2023 15:18:31 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>,
        Andy Nguyen <theflow@google.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, John Allen <john.allen@amd.com>
Subject: Re: [patch] crypto: ccp - Avoid page allocation failure warning for
 SEV_GET_ID2
In-Reply-To: <1000d0c8-bd8c-8958-d54f-7e1924fd433d@amd.com>
Message-ID: <06de8454-2b29-f3b6-7cf2-c037c2735b6d@google.com>
References: <20221214202046.719598-1-pgonda@google.com> <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au> <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com> <Y6wDJd3hfztLoCp1@gondor.apana.org.au> <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
 <833b4dd0-7f85-b336-0786-965f3f573f74@google.com> <1000d0c8-bd8c-8958-d54f-7e1924fd433d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023, Tom Lendacky wrote:

> On 12/30/22 16:18, David Rientjes wrote:
> > For SEV_GET_ID2, the user provided length does not have a specified
> > limitation because the length of the ID may change in the future.  The
> > kernel memory allocation, however, is implicitly limited to 4MB on x86 by
> > the page allocator, otherwise the kzalloc() will fail.
> > 
> > When this happens, it is best not to spam the kernel log with the warning.
> > Simply fail the allocation and return ENOMEM to the user.
> > 
> > Fixes: d6112ea0cb34 ("crypto: ccp - introduce SEV_GET_ID2 command")
> > Reported-by: Andy Nguyen <theflow@google.com>
> > Reported-by: Peter Gonda <pgonda@google.com>
> > Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >   drivers/crypto/ccp/sev-dev.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -881,7 +881,14 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd
> > *argp)
> >   	input_address = (void __user *)input.address;
> >     	if (input.address && input.length) {
> > -		id_blob = kzalloc(input.length, GFP_KERNEL);
> > +		/*
> > +		 * The length of the ID shouldn't be assumed by software since
> > +		 * it may change in the future.  The allocation size is
> > limited
> > +		 * to 1 << (PAGE_SHIFT + MAX_ORDER - 1) by the page allocator.
> > +		 * If the allocation fails, simply return ENOMEM rather than
> > +		 * warning in the kernel log.
> > +		 */
> > +		id_blob = kzalloc(input.length, GFP_KERNEL | __GFP_NOWARN);
> 
> We could do this or we could have the driver invoke the API with a zero length
> to get the minimum buffer size needed for the call. The driver could then
> perform some validation checks comparing the supplied input.length to the
> returned length. If the driver can proceed, then if input.length is exactly 2x
> the minimum length, then kzalloc the 2 * minimum length, otherwise kzalloc the
> minimum length. This is a bit more complicated, though, compared to this fix.
> 

Thanks Tom.  IIUC, this could be useful to identify situations where 
input.length != min_length and input.length != min_length*2 and, in those 
cases, return EINVAL?  Or are there situations where this is actually a 
valid input.length?

I was assuming that the user was always doing its own SEV_GET_ID2 first to 
determine the length and then use it for input.length, but perhaps that's 
not the case and they are passing a bogus value.
