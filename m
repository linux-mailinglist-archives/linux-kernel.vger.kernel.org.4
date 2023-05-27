Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B4C7134A0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjE0MTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjE0MTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:19:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D310A;
        Sat, 27 May 2023 05:19:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b025d26f4fso5136805ad.1;
        Sat, 27 May 2023 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685189957; x=1687781957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qviKV3i3STE3AXCvfu5JTAs+Njj6W5y8a0etiB8eeTM=;
        b=FHNuKZns2acgNCt2UqajVTGznoJuMCxYyEc9/3/gn28LTXlqpuRsZD0Xe0shZlcxrY
         7pL1T1ljFDYgAxXDjD5HL+yk0evJsXDsRiZ5b0Q2mixXej00TcFBF/ojfbPK8JyJBYK+
         ArLnu6oylmp4sYrJDqsuhHaQpIHn1svrNpTNn3qpFMIyeFINyGieQtoLIwanFGnxiz38
         c9YdVQ5mVMT1U3WGHDmHkqEiD4GMGRlxaBXcKDiT6xnUWmyB6CBGSGQMVBS1RMEfIdbq
         lmDJwJipTZuc55dph4qVejn+U+wj+VczRm8Y7ZKYiOb+kB8wYM70Db2kh0VhVRQwizqb
         Jmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685189957; x=1687781957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qviKV3i3STE3AXCvfu5JTAs+Njj6W5y8a0etiB8eeTM=;
        b=Ep8u6eGjE/+T552REv4azoogb9CSG57YP9CJPiiIHkqhicyzUkSEWNJ7B5xmnBtZE2
         jMRSrqIK2OoaD5+TJzI3Z+DxStc8hTYx909sfmMNrruchMarL0SdRzS7UneaAvxoUuhm
         4OT75HFPwzfa07y9xOSIrnXBapLrpaA2ycEvHz9f/Y4TUzr4vwuLeUp7a7TBHQ4ZbYrv
         7kQOReN/wa4/EgW2zqCdmU/0jOgvPuD86FzM9NImU8nAluwRr8PjuUirddFwxXDGsclH
         yq1RW7eka/sBSmvJpwFro7CZ2fGcaYkxczmq4PCL8ES4PAP5t/+q9ahmqxnlvH9rvn0M
         diPQ==
X-Gm-Message-State: AC+VfDw8TMBC0im2zAO4PNTYsdJrziukSNIy4vym3/oypX8LT1lvMjlF
        uotVslvDr4YjRY46I2xi9HZKHA9ptSU=
X-Google-Smtp-Source: ACHHUZ4/pJGfiQ7eVixpX97VETJ9hy3gJqn4yStODFzNC8TUbEehqxGImiTa2fKqrkWJhCdmlSYrjg==
X-Received: by 2002:a17:903:18b:b0:1af:b682:7a78 with SMTP id z11-20020a170903018b00b001afb6827a78mr6036138plg.52.1685189956867;
        Sat, 27 May 2023 05:19:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001a9a3b3f931sm4804222pls.99.2023.05.27.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 05:19:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 27 May 2023 05:19:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joaquin Aramendia <samsagax@gmail.com>
Cc:     "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Differentiate new BIOS for the Mini
Message-ID: <f10a1c61-bc8b-420f-988d-ba0ebfccf00f@roeck-us.net>
References: <20230526215621.16075-1-samsagax@gmail.com>
 <430e7be0-26a9-43b0-a61f-66cb8dfc805e@roeck-us.net>
 <CABgtM3jNVp63XB5A8Cf0KhB4So2==HLGa9_meuTn0vHYy=gBzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgtM3jNVp63XB5A8Cf0KhB4So2==HLGa9_meuTn0vHYy=gBzQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:42:51PM -0300, Joaquin Aramendia wrote:
> > On Fri, May 26, 2023 at 06:56:22PM -0300, Joaquín Ignacio Aramendía wrote:
> > > Newer BIOS got some other changes aside from string changes. Add a board
> > > enum to differentiate it from the old OneXplayer Mini AMD BIOS.
> > >
> >
> > I see no functional difference. What is the point of this change ?
> >
> > Thanks,
> > Guenter
> 
> It is nothing right now, honestly. But is necessary for a later change
> i have queued and a bit of OCD on my part. Should I add this to the
> other change?
> 

It can stay as separate patch, but please resubmit it together with
the patch(es) actually using it.

Guenter
