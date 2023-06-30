Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95F74403B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjF3Q55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjF3Q5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:57:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F4C420C;
        Fri, 30 Jun 2023 09:57:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25eabe8b5fcso263622a91.1;
        Fri, 30 Jun 2023 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688144261; x=1690736261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WbvTFCty7AXhGWc17dVqnpVXlZ2ZnUtOfdshsodAAU=;
        b=HNvUV70PBbb6z2cRbQ9PoHPkeNtGLZbLkn8RlNRkV2qGIW1OGPS8uSTjsMPDgBZTZJ
         82tRgf2GZPYwDfu4eYcqqBPQXqHnL1/TzI5bWHpX02Ojl7TC084orn/dwcY2BgbRBCQI
         poTzfuUMLZj2mfWruU5GDX68doWjrlbR/vjl9etkIbHe9BkD8aSrJSXwLmNaoEcsNzW9
         O2Hh0XCrgZCCj68PKLIdiQ4d3EzbRku1lQK5GIQzew54NJG020XykPX6mkF/6ZJUr8bg
         LNG23L4Hd46PTiNrZ3QGHKImnys6NSAuLtUFOhKuatiVgA6L442SwAOdzHyp1pz4bSAC
         f9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144261; x=1690736261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WbvTFCty7AXhGWc17dVqnpVXlZ2ZnUtOfdshsodAAU=;
        b=Lw4ccedhpZSUmS6ei97c5K/8ii9H8TjcQWP4sJGMAHLKbV2qBmAEaLWbeNgdlpxFJ1
         8vZ0I7yOmXrHq7kpB7rez5Y2DryJgLA+mwtsZFWIunJdePsN3ZXrTQPcuAbbUGxpdm1E
         X3KFgT46lEt1m3y5N5sVg8Fd5YmxXI0wASZ8T82VOQy2DaFvZWm7jhPnFKzMdZ9YK0B3
         GuZ9WVFbe/uGyZcjt603iNE3aw5cE0Yo77JgNSya2TAhYvnEG/CU3DqkKidW8NCECwrd
         hrMHEvjuok/u+d7gR+Nf5avcqPgytCbZ286U1YuBTW/J3R0uH2isBVdNf5TgFC4uVsQ2
         tmJQ==
X-Gm-Message-State: ABy/qLbJl/hSuSO44QX+OoHr5bJ3BnZ45QgOUEjPK6noXU5XFeJkLoLw
        /n1EGjeXleJvG2+06KvvKbk=
X-Google-Smtp-Source: APBJJlHGMy7JxCMfwvYk/+o/WTY+8mCPj7NC3s62ZuXEV9zpMn2iZz931YBUfxyRilftypsqm8WEdw==
X-Received: by 2002:a17:90a:be16:b0:262:c2a1:c029 with SMTP id a22-20020a17090abe1600b00262c2a1c029mr3096424pjs.2.1688144261502;
        Fri, 30 Jun 2023 09:57:41 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b00262ffa796d7sm8417569pje.42.2023.06.30.09.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:57:40 -0700 (PDT)
Date:   Fri, 30 Jun 2023 09:57:38 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] igb: Use TAI clock to reset PHC value
Message-ID: <ZJ8Jgt60QQmCQlFi@hoboy.vegasvil.org>
References: <20230630154138.4041809-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630154138.4041809-1-yoann.congal@smile.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 05:41:38PM +0200, Yoann Congal wrote:
> The PHC is usually synchronised in TAI (from PTP). By resetting it with
> the kernel TAI clock we avoid having to correct the PHC from REALTIME
> (usually UTC) to TAI (37s as of today).

Nothing guarantees that the kernel's time is correct.

When initializing a PHC, it is better to reset it to zero.  That way,
the fact that the clock is unsynchronized is obvious.  Otherwise,
people may believe the PHC is synchronized when in fact it is not.
 
> RFC: While this patch looks trivial and it does make linuxptp/ptp4l
> complain about a driver bug:
>   timed out while polling for tx timestamp
>   increasing tx_timestamp_timeout may correct this issue, but it is likely caused by a driver bug
>   port 1: send peer delay response failed
> 
> Increasing tx_timestamp_timeout to 1s does nothing different so I guess
> the driver does indeed freeze with this change but I can't figure out
> why... 
> 
> Do you have any idea/pointers? Thanks!

No idea, but you should figure that out before posting a "fix".

Thanks,
Richard
