Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FDF65E2A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjAEBtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjAEBtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:49:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67E3056C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:49:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o2so32832329pjh.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sl4NZ25YSkL6ZQKbML8DmcTVFW9Y9x/5TYNGiByW+gg=;
        b=YCfhkeRJ+T4ufGGNn5eQ0Ulghck4MzNbRoXe8djTLklyQNcIpOI1pgxQBWlkz9Dv1/
         MrwBgG0sWHYlkQd0CoOraa71YigemicovsOwfuXKeZ6DhKoHn2/xedADoY2MJHLIi565
         cTOfpVBj1VFCKV5V4ORQR2v8hJonLKhgEoRQmQidopwE/+7ufamQx6MTgv75lqAiM9yb
         bbNXvO66NYhIr613KAfOR1GNgMJEnFtm8rrPL6SxAfFelasFbs3zslQ56NIFsGyfIoEG
         gfl6YSbLLeLtrTZ4VrpZuOZWopScD9RcjxPAuDx3WaOCYyOUKbUZuLJc3t15YxfhNLlc
         J7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sl4NZ25YSkL6ZQKbML8DmcTVFW9Y9x/5TYNGiByW+gg=;
        b=fQbS/2EV64oA2WXEbiJSMPkKCMQLaM2d5weTDIMwjQQq0WEJZsrLbhH3AjUkgywiOv
         42yKhrdoHk3ci/E/B+5c26aoOMaqKGgdgtWsG1xzNAvvZvyvIptmWxZkWhYpB+Bl/gsp
         425cIHwG7Sf0i0l7jvTycv48CWfIGflFerj5zBOoC/yTBbRw2p+9ja1fJpgwU6AjfkFs
         Ii3x/1I2hii8orj6wN4XzuMEnbD/EEkMUK8RN/hmKWdwt7J649s3PxDHAw/SzWyh+v2s
         kY+KgcCTv0+sA+A4tvGctjR4PixPP3yx9AjOyMbicaPUV6Mx4m5GLjSD0WtJ+b+rYvZH
         h3LQ==
X-Gm-Message-State: AFqh2krIksxrnsKXEEx9YdJCkvxYWfhKoN85Mu/uACQxDZM7OlGoMMUt
        CJprm5/6TOLrYsTzSrKohhGSLiqbJuqmg4YC
X-Google-Smtp-Source: AMrXdXtLKjQwQsvoTb0MBo/2z5VbvmjnYaZ8a0jUdieJsoUc1pfXly+aIRtNUppsduXK5v+zF06Xwg==
X-Received: by 2002:a17:902:f7d1:b0:192:8a1e:9bc7 with SMTP id h17-20020a170902f7d100b001928a1e9bc7mr67538plw.0.1672883354580;
        Wed, 04 Jan 2023 17:49:14 -0800 (PST)
Received: from [2620:15c:29:203:fc97:724c:15bb:25c7] ([2620:15c:29:203:fc97:724c:15bb:25c7])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b00192849d1209sm5397969plk.96.2023.01.04.17.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:49:13 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:49:13 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>,
        Andy Nguyen <theflow@google.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, John Allen <john.allen@amd.com>
Subject: Re: [patch] crypto: ccp - Avoid page allocation failure warning for
 SEV_GET_ID2
In-Reply-To: <260364a5-f467-f83b-b180-583576ce70ee@amd.com>
Message-ID: <271fc4e5-c4cb-a086-fb7f-8b9389570af4@google.com>
References: <20221214202046.719598-1-pgonda@google.com> <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au> <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com> <Y6wDJd3hfztLoCp1@gondor.apana.org.au> <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
 <833b4dd0-7f85-b336-0786-965f3f573f74@google.com> <1000d0c8-bd8c-8958-d54f-7e1924fd433d@amd.com> <06de8454-2b29-f3b6-7cf2-c037c2735b6d@google.com> <260364a5-f467-f83b-b180-583576ce70ee@amd.com>
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

On Wed, 4 Jan 2023, Tom Lendacky wrote:

> > > > For SEV_GET_ID2, the user provided length does not have a specified
> > > > limitation because the length of the ID may change in the future.  The
> > > > kernel memory allocation, however, is implicitly limited to 4MB on x86
> > > > by
> > > > the page allocator, otherwise the kzalloc() will fail.
> > > > 
> > > > When this happens, it is best not to spam the kernel log with the
> > > > warning.
> > > > Simply fail the allocation and return ENOMEM to the user.
> > > > 
> > > > Fixes: d6112ea0cb34 ("crypto: ccp - introduce SEV_GET_ID2 command")
> > > > Reported-by: Andy Nguyen <theflow@google.com>
> > > > Reported-by: Peter Gonda <pgonda@google.com>
> > > > Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > > Signed-off-by: David Rientjes <rientjes@google.com>
> > > > ---
> > > >    drivers/crypto/ccp/sev-dev.c | 9 ++++++++-
> > > >    1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > > > --- a/drivers/crypto/ccp/sev-dev.c
> > > > +++ b/drivers/crypto/ccp/sev-dev.c
> > > > @@ -881,7 +881,14 @@ static int sev_ioctl_do_get_id2(struct
> > > > sev_issue_cmd
> > > > *argp)
> > > >    	input_address = (void __user *)input.address;
> > > >      	if (input.address && input.length) {
> > > > -		id_blob = kzalloc(input.length, GFP_KERNEL);
> > > > +		/*
> > > > +		 * The length of the ID shouldn't be assumed by software since
> > > > +		 * it may change in the future.  The allocation size is
> > > > limited
> > > > +		 * to 1 << (PAGE_SHIFT + MAX_ORDER - 1) by the page allocator.
> > > > +		 * If the allocation fails, simply return ENOMEM rather than
> > > > +		 * warning in the kernel log.
> > > > +		 */
> > > > +		id_blob = kzalloc(input.length, GFP_KERNEL | __GFP_NOWARN);
> > > 
> > > We could do this or we could have the driver invoke the API with a zero
> > > length
> > > to get the minimum buffer size needed for the call. The driver could then
> > > perform some validation checks comparing the supplied input.length to the
> > > returned length. If the driver can proceed, then if input.length is
> > > exactly 2x
> > > the minimum length, then kzalloc the 2 * minimum length, otherwise kzalloc
> > > the
> > > minimum length. This is a bit more complicated, though, compared to this
> > > fix.
> > > 
> > 
> > Thanks Tom.  IIUC, this could be useful to identify situations where
> > input.length != min_length and input.length != min_length*2 and, in those
> > cases, return EINVAL?  Or are there situations where this is actually a
> > valid input.length?
> > 
> > I was assuming that the user was always doing its own SEV_GET_ID2 first to
> > determine the length and then use it for input.length, but perhaps that's
> > not the case and they are passing a bogus value.
> 
> Except that if the user was always doing that, then we wouldn't be worried
> about this case then. But, I think my method is overkill and the simple
> approach of this patch is the way to go.
> 

Makes sense, thanks for the clarification.  Does that translate into an 
acked-by? :)
