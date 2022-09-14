Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC05B8B31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiINPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiINPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:03:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B427434A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:03:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so19278840pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dNdHgvByoy2R+oMT244sGz8QvNkoVUAwpFu6lpD/Iak=;
        b=I4ELJcTTd06NrEbZrhH5WVbadbXewHKCGVFua9Afi1o8daU92UseHKzKTC9EnyEhWb
         evntJuwVSCQUX2gddlTDQ7dDZFJdkm8jrVewoHk8PF2tPoH9RTCqPSHBe8Qal6iGRwbA
         RtkY5uZcuINL3hF33GVNvzgYq4JNEH9fcyhS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dNdHgvByoy2R+oMT244sGz8QvNkoVUAwpFu6lpD/Iak=;
        b=t7ix37fEZVHJpVONpExcVawtAcHraf1ROzi31iM7kZ0O/iyoyGhHg4PvsMMlxb2zaj
         owHkPdY31WphQTnbHq5+a7CJzykI3b+z2GnrkbFNOfCFolakUuAQ1gcCGBc3dcSn3C94
         T8zp2BMSETWCLaYTotNm2sw2/86Lzo7m91ha1GVzFef9T8VbCOEk4XE2NOXKVDWiO/hg
         FW9zbmCHRf0n8lhjmIVLuc+CGweX6pCne7DoXSMjzYXL4RgXiMm/mt/zcSGGit3xz7l2
         NQ+BLQRPTlLHfYC0roSD4hDDFwHjLGNNDtOBC+JlN9cp9m5k4Dkc+gfyacEe/J4gqrtw
         fHgA==
X-Gm-Message-State: ACrzQf3IP+LILqU39AalnaNtTpt8uRZBLQ1bdnCPAqDLgh7Pp1GZeDCz
        dlCNTeBQrCwC2oYf6ILBbdG/Cw==
X-Google-Smtp-Source: AMsMyM6IF/s8xo3aUXE9gSf/r1rJJNBpfj5sWbYbDbPWFllDdwAomASWBvJUHXcijGoqL292U+8HxA==
X-Received: by 2002:a17:90b:19ce:b0:203:182d:2c77 with SMTP id nm14-20020a17090b19ce00b00203182d2c77mr3993582pjb.45.1663167793507;
        Wed, 14 Sep 2022 08:03:13 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8201:ef09:d097:37b8])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b0017837d30a8csm6596592plm.254.2022.09.14.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:03:12 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:03:07 +0900
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
Subject: Re: [patch RFC 10/29] kgbd: Pretend that console list walk is safe
Message-ID: <YyHtKwzMH4yblJrD@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.966724916@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.966724916@linutronix.de>
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
> Provide a special list iterator macro for KGDB to allow unprotected list
> walks and add a few comments to explain the hope based approach.
> 
> Preperatory change for changing the console list to hlist and adding
> lockdep asserts to regular list walks.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]
> -	for_each_console(c) {
> +	/*
> +	 * This is a completely unprotected list walk designed by the
> +	 * wishful thinking departement. See the oops_inprogress comment

s/oops_inprogress/oops_in_progress/
