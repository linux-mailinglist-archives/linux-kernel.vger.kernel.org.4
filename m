Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3E6F4B46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEBUV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEBUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:21:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332F10FF;
        Tue,  2 May 2023 13:21:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaec6f189cso22995915ad.3;
        Tue, 02 May 2023 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683058884; x=1685650884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfnq1F7sa+Omz1PxdZ4GtiidNe15h03FO7bcBu19cNg=;
        b=GpjrevYqgaVUEmCBXMZgIcajkOQzpx9SkAu6OEoYrXyjmXjfZIG3fayiqAMbCkwaVF
         JDUr386Rqcg/bOujsqELeczM0TeevY3rguDfH0p0f0mzpxWbeLI9w7LqRfNfmyge7pIO
         QjhMbOoCXJIZiUtZLfscfCeDEo5eCZATckPz1IsHFGYGdobGX77CNnz186vJ6FnFGpBb
         zlqJFqSFkeKvfuseYAgMv6k+oxG1bPCopWtPO8ufPnx1S5l76Pke+c/JiW0ro4OBS48K
         SIgyqYwg6A6IRxrYc99CHcsDTABgmgGVvtF7+0uyDWtmCrcsKKvhlVv6WYr7RL9uE4DE
         OwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058884; x=1685650884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vfnq1F7sa+Omz1PxdZ4GtiidNe15h03FO7bcBu19cNg=;
        b=Az/A0nB3apiZHBJgcmgxeuUqBeMBCau48Mw7/E6ALxIo9OkIfk/SCfLcw7+QHEzmDE
         oC3qNLvx7yjy2eDnrCdhDhO7kLpdnBgp3i88KKqmO6X7vKw17mpts8DUBDjwAiguQxWt
         5zqaOEK4DNOo+S0ngvZ2YxKHjYKk5wGL4PiXvJrEgGTqiNJNSJ24QnAAFnWE4RxSMcOt
         /AKE6fHN2Q+UKNYHVAkeFSCNcQxzoLeej/PGimtVrBtqPxWJ6nR0I7O8Sodx697Z4zJb
         aUdqlpbO038LcHgG+CsioKy2ARBxGDssYIFFJK6YsPvnoFyT4NZV0mzvZbaEJaWSSqE8
         oCoA==
X-Gm-Message-State: AC+VfDxpjQ4HUSigghQ7AKGtwZ60xVax/G60855MvN2qsPIYBgKWqrDV
        vTUqXB7edWNRrrPrFsTiWPZ6cPhL3c4=
X-Google-Smtp-Source: ACHHUZ7bRzoSm5XzbDxjiUGtHAbbE4iWI/5VVlkRYSrdN97tmh3Jlzq5jR/Hf69NOM+8RkMvtblZkQ==
X-Received: by 2002:a17:902:9347:b0:1a6:e564:6046 with SMTP id g7-20020a170902934700b001a6e5646046mr19044825plp.46.1683058884107;
        Tue, 02 May 2023 13:21:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6edf:1ae0:55be:72db])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b001aaf6353736sm4160034pll.80.2023.05.02.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:21:23 -0700 (PDT)
Date:   Tue, 2 May 2023 13:21:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org,
        Teng Qi <starmiku1207184332@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: avoid calling input_set_abs_val() in the event
 handling core
Message-ID: <ZFFwwF+VqzNUmUx/@google.com>
References: <ZFBg379uuHjf+YEM@google.com>
 <20230502060531.GA857155@quokka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502060531.GA857155@quokka>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 04:05:31PM +1000, Peter Hutterer wrote:
> On Mon, May 01, 2023 at 06:01:19PM -0700, Dmitry Torokhov wrote:
> > input_abs_set_val() can nominally call input_alloc_absinfo() which may
> > allocate memory with GFP_KERNEL flag. This does not happen when
> > input_abs_set_val() is called by the input core to set current MT slot when
> > handling a new input event, but it trips certain static analyzers.
> > 
> > Rearrange the code to access the relevant structures directly.
> > 
> > Reported-by: Teng Qi <starmiku1207184332@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Thanks for the review.

> 
> If git grep is to be believed, this is the only use of
> input_abs_set_val. Maybe removing that function is an option?

We generate input_abs_[get|set]_<item>() accessors and setters, and
there is a couple of users of input_abs_get_val() in the code, so
dropping just input_abs_set_val() is kind of hard. It might be useful
elsewhere although I have no idea if anyone is actually using it
anywhere...

Thanks.

-- 
Dmitry
