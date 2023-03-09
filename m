Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B96B2205
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCIK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjCIK53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:57:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43833EBD88
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:55:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so5425023edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678359343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3WJfEb92xt22bfFrUgoL1/wj4gfJmjIX6QMBtki11E=;
        b=TwTMzP6pzXfLRsTYKHz1AfNCtBnZG1xs35LMAeJpVLdRxg66JtnQoc8BgMlZl4AJ5u
         5Fqv95xgP4iXrp2U3rLknE0hmRVWN8dxqsl+zAut0Af08QfMzLcikpS6rh6JtUN2ojIP
         hXuIMCF5dwD3EjuRWEnr98FfedfF77XY7MMO046T4sEZr1+4Rw+TAYyFV4Cybr9Vm6QH
         3rXD4MiDZMQfE1n339YIwvXzyBMy51+QIgXa+h0FYP3DM3WE47HlK3dWtktft7URXMAj
         OIywN8sSp+3c1bWjpyyYHCva762GKeQcUTxZUi8+WgkW5cyoxMR4LwQinoLFIQ/iLcL3
         P0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3WJfEb92xt22bfFrUgoL1/wj4gfJmjIX6QMBtki11E=;
        b=kPHMsgQf0jxaHFAhPEmFZ2hpEfkb7oAoefmrE9X9dgem6xLoz/lD7PyUxTbGdqtQ7B
         9JxuK9hlEUewHceEE1kkroPNXU6zntG1Toc6BpDEoUQRzTES7ftwqkPTGlf3n3lB6SyA
         imtrtwssFh+dLl+HDUV86qEOwsA9aPfkD26UEU/C8+YUpauHY6tbcESsVrUNX5tkEZZ+
         7OMAmPKFDbFbvQFaiVwioRzoOwH/YTlLGqWz+0xm5BTB3+X/Jl2LRuqsl1SOjVtpJNFn
         Rf4aGIvkRwCEBni1uhBznOcxOnkaMxXn17OfyPs2+JBgWgYI5NTS94OTdGphw3SoOe3D
         2klw==
X-Gm-Message-State: AO0yUKXIVDRMlIXTYKiW+ypMq7VqKYOgg1xxdH1vSjhnC2LiCViwTS9Z
        aqUDZt3G76wrJj16nx1QIJ8VQA==
X-Google-Smtp-Source: AK7set/eMw/OTCfWM+qcnpe0fvIZLj5VwP+nBvPdyhEHct4AV3vuQ1Gw+aPhqva031kCDvgYXDboyg==
X-Received: by 2002:a17:906:9c86:b0:914:4277:f3e1 with SMTP id fj6-20020a1709069c8600b009144277f3e1mr11340126ejc.53.1678359342896;
        Thu, 09 Mar 2023 02:55:42 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id hb15-20020a170906b88f00b008d09b900614sm8614241ejb.80.2023.03.09.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:55:42 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:55:39 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        David Gow <davidgow@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        tangmeng <tangmeng@uniontech.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v1 00/18] threaded/atomic console support
Message-ID: <20230309105539.GA83145@aspen.lan>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:02:00PM +0106, John Ogness wrote:
> Hi,
>
> This is v1 of a series to bring in a new threaded/atomic console
> infrastructure. The history, motivation, and various explanations and
> examples are available in the cover letter of tglx's RFC series
> [0]. From that series, patches 1-18 have been mainlined as of the 6.3
> merge window. What remains, patches 19-29, is what this series
> represents.

So I grabbed the whole series and pointed it at the kgdb test suite.

Don't get too excited about that (the test suite only exercises 8250
and PL011... and IIUC little in the set should impact UART polling
anyway) but FWIW:
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
