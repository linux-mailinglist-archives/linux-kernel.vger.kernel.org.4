Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAB5E8B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiIXJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiIXJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:47:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D412889D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:47:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id y11so2141474pjv.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3+pOaDQW9YjxLklfVNTeyrUxpQCI7rQ2FY27kMcvVNA=;
        b=HB9MKYQSVCpN/uOYAgHtfTu8vX+gh120MEMg6y8EIcdyz09xYzp2JSduLy24Dvszy4
         1P6BsSMu2mOvfjkp7zHTUtONSi2wbDo6M1uy9AKuN43KZoUA4/EqJvSPJHoKE8piFuiq
         TFDPTQqsUqfRalbN7HFLyt9F8n9Jwf+Qj+abU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3+pOaDQW9YjxLklfVNTeyrUxpQCI7rQ2FY27kMcvVNA=;
        b=gi8egNPpKyOHcUmcWN81GAhyOdp+7XFHe6TmP3xEHL1gTodnaZC/JMSvMdN4Z1xlPE
         /qT2fcSPsTuD44XdejTj27hq66yOKz/UpvTwDqmV7Z/2Zq3zbCDxGwrWql364ODAWRKy
         18pI9nmGpOnARc9lCX7+ph1ZUwOkogs8zw59gZw5dGA8K6Z0QskXOXElh8ZjZ3zfkmuI
         tP693DvleLHM3HBomMFGUZmQ6GZgKg2DlysndJr+FP06dCOuG4GHWmDxehhnmwMC+wYX
         PkhgvOTzaILp60sEYmMpP3Mu87ce4BNMCsOcfL99ONwwhEst6ZXSvwLPzSbO1T2sgtPP
         bQ2A==
X-Gm-Message-State: ACrzQf1Bl6l/VDE7/56Brqn3qWnfppXZUm3PCltKTSFxekS8cLdnL8PJ
        neRxSF8OYcBhxbm0bwn69X2OmA==
X-Google-Smtp-Source: AMsMyM50G4MkB+jPSoG0HzIFo+yOu3RUvfrllcNX4ltgLcfVL+PMcHqel4EXpC55kA3rQFQuMU8DdQ==
X-Received: by 2002:a17:90a:fe0a:b0:203:467b:9e64 with SMTP id ck10-20020a17090afe0a00b00203467b9e64mr14759009pjb.146.1664012866953;
        Sat, 24 Sep 2022 02:47:46 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78f37000000b0053e61633057sm7899715pfr.132.2022.09.24.02.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:47:46 -0700 (PDT)
Date:   Sat, 24 Sep 2022 18:47:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sven Schnelle <svens@stackframe.org>,
        John David Anglin <dave.anglin@bell.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-parisc@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH printk 00/18] preparation for threaded/atomic printing
Message-ID: <Yy7SOp9wKWdDnbLM@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> 
>    Patches  6 - 12:  Locking and list conversion
> 

A quick question: I wonder why xenfb_make_preferred_console() isn't
converted to list lock and for_each_registered_console()?
