Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6E62253B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKIIWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:22:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C691D0DE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:22:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h9so24629269wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crbYz3VLn9bPhdr6yskAHwJw97H6nt9Pu2v8KXje5/s=;
        b=HcdTtvU2QhsyDAU7f7sCdpTShc07xDkmy+hTRUfeTKqlKtgb89lOV1/0QBctWKnWrM
         O9DXM8V8wUUch9Lc+IdfXiw9iXx0I/44EuJ0fgcoKlrqnUdPDzBmzeFLLcV+l1ffxr0I
         my7X+tklF2MElCF2lKksB31BDYVDbhxmoKZrqT2hmLdZTnZMbk9wdMx3vAVvHC0KThRX
         jGKP7tLMBMHELFOYE4el7Tr7ZEzGCk6hk4WKEYV/QCxW+FvpbyxMzJ0bpxzy25Oi334e
         kA/tWo2LKJQvYmsclDlxHzb9gZVggEA9l95s2Q7tA+Ulm2xY1BvTy9z9hxgfazSs3AmY
         yePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crbYz3VLn9bPhdr6yskAHwJw97H6nt9Pu2v8KXje5/s=;
        b=8D4/tIEldrlbyjEpEhd3oSCg3j6Xi6IS9jTIKAddt9ILMM77sgdXzNtWclF/sQSoMV
         OIXjO4CZs+xM3XAYdPdHweqJ50b9wgNc54RLpdL+cO44xwrHJWU9x/r7789jaVVDAV/i
         ah4MiSDXxbfxUpRrHvdbq1mKZTQyXWGRpvsd9VbLHmMiG+oaKsLXzFTVoKmjTyX062OZ
         4Wg9Pc/VCEzZZT05q9BKm2lc7AIwbIYcsnm+5oc9t3QzOonRN+DDjvqOWMRESIGiA+aE
         m455tICkgDnSX8zrCTv8mQLq5c2X0RblTjxlJdw9beg1xfetHVPOzgO9D3dCAAByCOZ9
         2xyg==
X-Gm-Message-State: ACrzQf30bDVjTZ2CITsu9wvfhd2/TuNVLbxBkcRmiQ61vP85L31YQUp+
        mYCBEPwS3+v2V3LEyyFnvk3/vg==
X-Google-Smtp-Source: AMsMyM6MjADOLlTlAhLz7aZOc1cO/kOSTXn41LWTwMR6auezYg1wSpunTmH84+ozvyK0CPY1elgcXQ==
X-Received: by 2002:a05:6000:180b:b0:236:5985:9c4e with SMTP id m11-20020a056000180b00b0023659859c4emr38084419wrh.584.1667982168896;
        Wed, 09 Nov 2022 00:22:48 -0800 (PST)
Received: from ash.lan ([167.98.0.196])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d6409000000b00228d67db06esm12472140wru.21.2022.11.09.00.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:22:48 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:22:46 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v3 10/40] kdb: kdb_io: use console_is_enabled()
Message-ID: <20221109082246.vvolneae5lqmebdt@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:08PM +0106, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
