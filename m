Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A32708D29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 03:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjESBFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjESBFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 21:05:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC81E72;
        Thu, 18 May 2023 18:05:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso2898735b3a.1;
        Thu, 18 May 2023 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684458353; x=1687050353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSYVMPQ3qj8a/oGdCfP3ChzUdlIw5oHn6OsEYCKEbhE=;
        b=Rth35TClksUPImcNts0Hu3FlSVSE3DyrAny65QP0/qp22dd+jsjhO90EsgDrwiesgD
         FmCMizTGgTRLzipMPmH5vaVxREr9rbehnvQqrO1vFJPzozJcTSC/AosoPU2SaBIypSVP
         iFYTOSeE1LzAYZUVvg2MviUDaCX6mypvAWOzN6+WTJvW2UjBn1wX1JesMrEuv1V+6G/K
         snzG7RnVvCC5xvJqDy+gKX1j/2fKele+VuOlxyFfaMAK5OtDnc0QMFIzQfnEswQspucn
         h1lNDEZuXBLgsEdIIXLx3GVDjw7N1vlgOfKsM0KsefmXyXwYZaeVSUrAIiaR17twwjX0
         TOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684458353; x=1687050353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSYVMPQ3qj8a/oGdCfP3ChzUdlIw5oHn6OsEYCKEbhE=;
        b=UnEr7RFLwHellrarzPHnojtDSPQRei/NEx4nUICO81FpwGAwN0S2ktME5hnSip8unB
         ubjo6eQea0v2Oabb6E3AdDmCinlsHfL3d8HllI45PDnSDV1OmY6HT13U4ydK0B7QisNJ
         NvI6oNfYfTrU8APuTI2bppoD5096/gGUScI6BujI4NxeLysX5kVByN4oaUwGKIzDpjY4
         JrCrMwd1uqKK7pq787c/50/QeurRlZcN4zDgqOyWlQpj03LoiFnHyRktg5NAbevq55Fb
         5PQaFToI3qRCNS7mUxEdjMUTA789dfWefpA9o9gYKND2W4emc4RDToVARExP5l70Uziv
         QvJw==
X-Gm-Message-State: AC+VfDy6lmZchcTbsu0tN+Z2vBjCOKNZ6+OrVa0+PJxi0/zd4+Qv41zT
        r4WMNKcPjzyJM2RpncAwuNU=
X-Google-Smtp-Source: ACHHUZ6Fl3iXdAwbPHQEfCikSntdgoIoCgedUlJPp7xmBcIxxFF6oDDMbiB3KmzcevopG44y7tL8XA==
X-Received: by 2002:a05:6a20:1586:b0:101:73a9:1683 with SMTP id h6-20020a056a20158600b0010173a91683mr339836pzj.33.1684458352611;
        Thu, 18 May 2023 18:05:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:36bb:8bd6:552:c349])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b0064d2d0ff8d5sm445306pfo.163.2023.05.18.18.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:05:51 -0700 (PDT)
Date:   Thu, 18 May 2023 18:05:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
Message-ID: <ZGbLbOHYxq+bPzb7@google.com>
References: <20230130131003.668888-1-arnd@kernel.org>
 <ZGUbDFssUwXKTiDt@valkosipuli.retiisi.eu>
 <ZGUnBfqBLWkD7ZgD@google.com>
 <ZGUqWZoxXRGGJ9Kv@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGUqWZoxXRGGJ9Kv@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:26:17PM +0300, Sakari Ailus wrote:
> Hi Dmitry,
> 
> On Wed, May 17, 2023 at 12:12:05PM -0700, Dmitry Torokhov wrote:
> > On Wed, May 17, 2023 at 09:21:00PM +0300, Sakari Ailus wrote:
> > > Hi Arnd,
> > > 
> > > On Mon, Jan 30, 2023 at 02:09:47PM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > The gpio usage in the function is fairly straightforward,
> > > > but the normal gpiod_get() interface cannot be used here
> > > > since the gpio is referenced by a child node of the device.
> > > > 
> > > > Using devm_fwnode_gpiod_get_index() is the best alternative
> > > > here.
> > > > 
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > I've picked
> > > <URL:https://patchwork.linuxtv.org/project/linux-media/patch/20230130131003.668888-1-arnd@kernel.org/>
> > > instead. I hope that's fine. Also cc Dmitry.
> > 
> > What do you mean "instead"? This is the exact patch that started this
> > thread, and it is broken (uses wrong name of the GPIO and wrong polarity).
> > 
> > I'd much rather you picked up
> > https://lore.kernel.org/all/Y92VLGLQJZ%2FUDRx1@google.com/
> > 
> > Thanks.
> 
> Ah, the URL in my e-mail was wrong. I have
> <URL:https://patchwork.linuxtv.org/project/linux-media/patch/Y92VLGLQJZ/UDRx1@google.com/>,
> i.e. the same patch.

Ah, I see, thank you.

-- 
Dmitry
