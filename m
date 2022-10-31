Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437ED613893
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiJaOA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJaOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:00:24 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A4510066;
        Mon, 31 Oct 2022 07:00:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso6820840otn.0;
        Mon, 31 Oct 2022 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nX78Pz0Vg/0l+qunKn+yXk41tg6RQwkAu3sKfKR7H3I=;
        b=Px/n8IM4J7RfRRY+T6Q2LZF+5RX0xO/sh+r8BErlhfmEjt4sWNJUnzNF5Xe5+WEQZU
         40W+UJcUTCNxoQArdD2MIxew01TpJXYcAGg8ujss9v5hQ9Lx7wJTLWuIhG81lm0MJSUe
         A4VgVpsOZXp5c9xcRpfpZU3pHJIAAh3QSO09xsWJbRc6sRuGlxS60Q8JKELsA7QPxe7L
         NBSs7++yGU50MPLH2XNaSpgK4WzI59krzaJlT0KZc3on3EbXbyvn8lG19Jxjumc6TPok
         CFNwdfwdklzLdFP6TBDfXxi81VErpdVzR67Y4bWU8Me888jMrjpZ3QzoI4QbWjD2e2XS
         Pftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX78Pz0Vg/0l+qunKn+yXk41tg6RQwkAu3sKfKR7H3I=;
        b=06q9zHdgN+mypad5XByrFqTPwEYijde39X1fImek8qdpRGEiMo22zJ/XxhcdIiGTyP
         ddMEICQe6n3s+q6vwFTt3X9sPNo2CvwLIntDVdbLdPPQvrv83nZaP6l0WFYyvbJOu8nt
         NESRR5xciYDiKh9uSR41/ZxEmvU+tT2OulekCLGieE0ARlreX+heoZ9d+6V6PA7nq+D+
         kxRo7uruwEJlqos100Vb2TqPuSxRCfD7Bkmhg7nUHi+jk7/rg5tIqwsoELAtmca6Wtz4
         ShN+QT4pWIQy/E8jegxviuWKDFSjSZVwi392C7pTvF3HdvU3UfLZUyJ4/tMNsIUSqzkC
         astA==
X-Gm-Message-State: ACrzQf3fY5SsqVfn8DvQRMIgWeExhnFlMS/4Sed4zXVZjfo/xIHRg0rI
        NyvfeSdPZcuFD9vhVllWVtE=
X-Google-Smtp-Source: AMsMyM4frFeWE7yf6Fw6JkN8R+WGS7eT3XTx2n6blM1uU0uVpazW7WLBei+uCAl2xCgPNb2Nuj4H5Q==
X-Received: by 2002:a9d:5911:0:b0:657:a6bd:372c with SMTP id t17-20020a9d5911000000b00657a6bd372cmr6835267oth.6.1667224823324;
        Mon, 31 Oct 2022 07:00:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb37-20020a056820162500b0049bd96ec131sm434116oob.8.2022.10.31.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:00:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Oct 2022 07:00:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 7/8] hwmon: (scmi) Register explicitly with Thermal
 Framework
Message-ID: <20221031140021.GB948107@roeck-us.net>
References: <7acc7a49-debb-abdb-f01c-f8adef4c1f0e@roeck-us.net>
 <20221031114018.59048-1-cristian.marussi@arm.com>
 <20221031132523.mfp7d5esk5hohldk@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031132523.mfp7d5esk5hohldk@bogus>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:25:23PM +0000, Sudeep Holla wrote:
> On Mon, Oct 31, 2022 at 11:40:18AM +0000, Cristian Marussi wrote:
> > Available sensors are enumerated and reported by the SCMI platform server
> > using a 16bit identification number; not all such sensors are of a type
> > supported by hwmon subsystem and, among the supported ones, only a subset
> > could be temperature sensors that have to be registered with the Thermal
> > Framework.
> > Potential clashes between hwmon channels indexes and the underlying real
> > sensors IDs do not play well with the hwmon<-->thermal bridge automatic
> > registration routines and could need a sensible number of fake dummy
> > sensors to be made up in order to keep indexes and IDs in sync.
> > 
> > Avoid to use the hwmon<-->thermal bridge dropping the HWMON_C_REGISTER_TZ
> > attribute and instead explicit register temperature sensors directly with
> > the Thermal Framework.
> >
> 
> Hi Guenter,
> 
> FWIW from scmi perspective,
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> I was about to ask for your ack to pickup myself but I see there is no
> strict dependency for that. Not sure if you want to take this as fix for
> v6.1 as the thermal changes broke the existing support in SCMI hwmon
> or do you still prefer v6.2 ?
> 

It is a regression and should be applied to 6.1. I'll pick it up and send
a pull request to Linus later this week.

Thanks,
Guenter
