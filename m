Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97E46B21E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCIKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCIKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:52:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB4E8AAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:52:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a25so5395529edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678359163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDH8OLZkH1zNeGUVE0PPzxXRqdEYd+lesm/7IX7WPhI=;
        b=yPwsLrbpELTrhmevcCA4PI51KtnJnIBb3ne276/2e8BjzHhjy/E+S8mI/gn7P+R3zW
         //lIpdqXC1SLLcpCuZ08CV6KIDbcFlJqhW70U6n0/b94mIA4lXE4malCs4DSeV5XlEuL
         AXJ15p6Sr+I+nbNxfyv2sOKC9M5uTNEYPxq+/+58LqbtH+t8sA4hCUSoqs0tsQSdxZfC
         oYfN5qzNHzx5JQ+4DM/IYw+vFCXHtiaggT7eTlQLDwqgyeM8xiJGOLcamZXK27T8gu3S
         VeA6x8USN/XgD2CY6EBGEA3rKggob8W+pmfbrNwzL1pYOoITtWlsgS+Z+uGEouLuFqRC
         /J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDH8OLZkH1zNeGUVE0PPzxXRqdEYd+lesm/7IX7WPhI=;
        b=ZViK8e7Ij38yox0H4ama7oHREwvwBV5+pt65CLlACQMlK1cgoWbuCGfa8EBf68xo/l
         Pb+JBF2Iob8TS682Dku/FWJ5F7YkEI4rYcDjWiA8AnwFdnZc5+Xvk+SOb+2/OyqnIyn4
         evP4R/4UjPncFptErLdiRF6G3voz50yQHxRbMvSbUgaWxpx8C5R0QyCa0OHa8aOWAg5V
         ulVDJGTMruxsjgbYAjjDobMHowCFp/Omfae9+RUg3QBrCML+01WZ2VilgSRamaX3KeC/
         ogJ/LpC7OuuNdnToVLK5fHxfML4homhhsWJWGzNI2xuFB2uMtJbMZrTCBGW6s7/+OlOI
         tMyA==
X-Gm-Message-State: AO0yUKUcngleMFMT89u1gl/Wn9DoTp2f9Bvw47v9WUg5ud+NYLGBly6o
        bC+ksEjGixZYs2g57jPCuTZ+Ag==
X-Google-Smtp-Source: AK7set+iTDjQGgE05HYqYyDd5tphuWtkw3KokPYqWDwo7oXDYpNFrmhxjp5ck/aH23b5Thpe8vg8gw==
X-Received: by 2002:a17:906:11c6:b0:8b1:3191:286f with SMTP id o6-20020a17090611c600b008b13191286fmr19533233eja.25.1678359163235;
        Thu, 09 Mar 2023 02:52:43 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id dt2-20020a170906b78200b008dcf89a72d7sm8823028ejb.147.2023.03.09.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:52:42 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:52:40 +0000
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
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v1 01/18] kdb: do not assume write() callback
 available
Message-ID: <20230309105240.GA83039@aspen.lan>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:02:01PM +0106, John Ogness wrote:
> It is allowed for consoles to provide no write() callback. For
> example ttynull does this.
>
> Check if a write() callback is available before using it.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Any thoughts on best way to land the series. All via one tree or can
we pick and mix?


Daniel.
