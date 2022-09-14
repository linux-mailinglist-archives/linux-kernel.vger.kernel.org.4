Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB75B8B26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiINO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:59:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A003BCBA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:59:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso19319957pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YcOCvFv8Ww1CQ6MsvWRPqisqK9mPiN69h3UTY4oFQYk=;
        b=fy8C5RC3erd4fSSCv04W7zDyJNWQuBtcaCMo47NACF4nQ6sqLj5lCvFviELvC/e0l4
         DvhRdYP/l/tfs3xacVGNSIjLg1i/ZqZSN8yy/gTsWtlFoI/LCJnmdMA43qEGDO5Iml4I
         qpnvPwhk+Tg3uMu9oO2NAHV/ElAVRPLfXeRxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YcOCvFv8Ww1CQ6MsvWRPqisqK9mPiN69h3UTY4oFQYk=;
        b=hYVceoY4TS4t+NRcxBTH/9zfA9ozosaX/SMIne0eRkG65xqWvuoLTNnwDudfgGRjgq
         sKlKrgoNyPrZBsDHXzAt+0zJxI0jjsS6qEdD4kBGsQ5SEdNei+dDg6FyLbHlKA9WdFOW
         aiAIDivDZjYFUuCwuncAsVtKZ4vFfNWmyTUTWF/wmkZsaP9+kVsikELfO1I54m1m4FQu
         WueuvJ7T+kFePndzE0F97672olsVbwp/bbYbEtBMypATkJV6Timr1UZ20vqxO4486/SU
         D+QhVx75peufpTeQFuoTXfQu+ZnGctqXoXz7u7UcX/YwteSowvArrxOCRP/W/mpm6EkA
         rtJg==
X-Gm-Message-State: ACgBeo3NI1NGe3dX1z5tjuv3D+7a8xiXkC3dY55TuTUMMuc3v2yxd6aV
        7B4bymnB/HvU/soPTyXPxleErUYsaPpZYw==
X-Google-Smtp-Source: AA6agR6nhDnf/eashzX/3gd+99g8YdobSXF5wix0WL47aF0M3CfNFWExj1BhQO3Oc2dP80yTnfJ42Q==
X-Received: by 2002:a17:903:22cd:b0:176:ca53:3e82 with SMTP id y13-20020a17090322cd00b00176ca533e82mr37533818plg.59.1663167583839;
        Wed, 14 Sep 2022 07:59:43 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8201:ef09:d097:37b8])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b00176dd41320dsm10743768plb.119.2022.09.14.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:59:42 -0700 (PDT)
Date:   Wed, 14 Sep 2022 23:59:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 09/29] serial: kgdboc: Lock consoles in probe function
Message-ID: <YyHsWTkvZ7PRwNZp@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.906633712@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.906633712@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/11 00:27), Thomas Gleixner wrote:
> 
> Unprotected list walks are not necessarily safe.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

For what it's worth
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
