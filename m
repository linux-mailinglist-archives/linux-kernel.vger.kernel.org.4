Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A268B133
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBESVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBESVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:21:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F081199DC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:21:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr8so28334808ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i63w/pV88DLO03mXliw8xYbIqTY9OqCF6qi2JifxJgg=;
        b=UjBHK6w6zZRkUaf8Bv6/PD0Vnx7BBG2ON4xhzbvdzpD8iRGNOI50WVi4jEANcWQmqP
         xozQq3qXk0Hr46jh9fiG1+g+u4CkfsoyUmM2gHWVr5we9KptIByDd0yj2OIK1bT+juuo
         qpfGG4rOUwkJFVryU5cDCo+Jje/+EgBFo9sdG0uWt4sSbllrv330LM0/S4C8H7S7sdS6
         YMB46GJwMOYJ4eyNu08K7NlskuvwfyDzjEtLE3rBpGhXxU59MIHL9Om6CeJf1PfFetqC
         F29jf0KrNFh2h+lP5rr4QkvS/NQ2mbIAJEmwbWfEYUT12/se++/QJPJV7MQwowzRS6JV
         cH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i63w/pV88DLO03mXliw8xYbIqTY9OqCF6qi2JifxJgg=;
        b=MDzMZN9skEPJVt+vqIFaiJ3NiZYOMO9ka/On5OedfYaYFoMjsDDEV81TUQm3X1DGng
         kAakZYrh5JEk0KROSFeqcV6UL+t2uwrUEj9gP2/bg7Topd10zmna5/s6uhyhzoAvbZw/
         Xmn/T2fDUu0IRvOtLYSIX1ULLxW7Yf1KRg7LritbmxJXqNQF4rWeH/E+8wS3dx2ofej5
         hGQK+htrCZGfQTBRC8hnGzfjTRHET+U85SujY6C1Wpfj6+KECG0SBrZKvbin6JtegeBF
         9tBgCVJWcy/mvo6NZ9LPQeGkz4f0pWvhpiwbXd2ZvEzNIPz/tFwgcGvX22rRnqYq0m6k
         pVoA==
X-Gm-Message-State: AO0yUKXObvjWW8MQlJsR29o2bXfy1jMLiuOTf1WQdx/EEesS5IBBW0aW
        gnZCbFXokSetJ2KjZCR+3RORnG62/VA=
X-Google-Smtp-Source: AK7set+CALiS3x2OAR+iXb85KCT92QwReNI/aP9r1T5bggcmlXY8f6S4gscfACoO5PG1orCsM6MoZg==
X-Received: by 2002:a17:906:ae4f:b0:877:962f:be0a with SMTP id lf15-20020a170906ae4f00b00877962fbe0amr15272422ejb.37.1675621277114;
        Sun, 05 Feb 2023 10:21:17 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id bj11-20020a170906b04b00b0088e9bbae7ecsm4335843ejb.165.2023.02.05.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 10:21:16 -0800 (PST)
Date:   Sun, 5 Feb 2023 19:21:14 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Nam Cao <namcaov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y9/zml6iPvoBBVXx@combine-ThinkPad-S1-Yoga>
References: <Y9+qMqYD2zGWRurD@combine-ThinkPad-S1-Yoga>
 <Y9+sFw0rviTAJNMf@kroah.com>
 <Y9+vkwYfQzYTbIIo@combine-ThinkPad-S1-Yoga>
 <Y9/MhS3pJ/Es0sGa@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9/MhS3pJ/Es0sGa@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 04:34:29PM +0100, Nam Cao wrote:
> On Sun, Feb 05, 2023 at 02:30:59PM +0100, Guru Mehar Rachaputi wrote:
> > On Sun, Feb 05, 2023 at 02:16:07PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 05, 2023 at 02:08:02PM +0100, Guru Mehar Rachaputi wrote:
> > > > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > > > as '(iobase)' to avoid precedence issues"
> > > > 
> > > > ---
> > > > Changes in v3:
> > > > 	- Whitespace error from checkpatch fixed
> > > > 
> > > > Changes in v2:
> > > > 	- Macros with one statement that is to call 'iowrite8' function changed
> > > > 	to inline function as reviewed by gregkh@linuxfoundation.org.
> > > > 	In relation to this, names of the callers of macro are also modified
> > > > 	to call this function.
> > > > 
> > > > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > > 
> > > Try to take this patch and apply it to a tree, and see that everything
> > > below the --- line is thrown away, including your signed-off-by: line :(
> > > 
> > Sorry, should not a patch contain signed-off-by: line?
> > I did not understand.
> 
> Patches must include signed-off-by. However your patch has it below the
> --- line, and git will throw it away. You can try "git am <your patch>"
> and see for yourself.
> 
> Best regards,
> Nam
I made my current working branch track origin/staging-testing and
modified the commit message and sent the patch again. I hope there won't
be any issue.

-- 
Thanks & Regards,
Guru
