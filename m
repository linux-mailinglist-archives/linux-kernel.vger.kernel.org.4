Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C04705919
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEPUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:48:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FEBE45
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:48:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64359d9c531so10901781b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684270122; x=1686862122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKaehGbAc8k6lY0qnWn8D9TG/mOHGPGNlxmLWsJ8N2Y=;
        b=m6g7gvRdMU7jCzC8ARN7/pLJ8/l0HGcYN/ecQrFL8r6qefKpx+LlryT1s0VBLOvMZ/
         8NGvHStpsS98vJ+5X8QuR+LLHskGF4taS+69JCYVhI4JGkbJjHZiVnom/4YDXAnLj1P4
         OLWTwUgV6aPnyWwNie4y3u1jK4ODcfvyk3iII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270122; x=1686862122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKaehGbAc8k6lY0qnWn8D9TG/mOHGPGNlxmLWsJ8N2Y=;
        b=D6pTci4ukuGUk4daLkL5Z+K2uUoUwoKapo3dJT+Wg3fQ4i2nNJIHYNMBYgQ9h1s0ro
         RDATM90VV4QRHS/sUCMAS4iEew6cBSJEydaqUWW/agf4ymkleVG0nVIrlO/cD55rqDL2
         MImEcJAT7Rs6y/BK4HXFx9EJrnHccp/+qWL5ODhyi3h7SNqtPcqcwo04OHgrzRf6zvR9
         4ObDpmrQLGuO7Yidwzfgt3Pz7pXvvZiSNVoeXH32VNWtaDGOQPSRtiNuYk3sLgrqw+e1
         qyeiL+LsHJ6y+QO83no4zX+vEx6QHJTRWGz4uEAnHUNyF33jj3RtJ7chvSxcXVhRZjl9
         gs9A==
X-Gm-Message-State: AC+VfDyXBqEMvJeNGiHNWe8eZ2ufdEH8tK/EqvoDqDiYlHH3OoJJ+0fE
        h3nHY9hd/hb4tLk2TTWgYv1FRw==
X-Google-Smtp-Source: ACHHUZ5ctGEO5DTWH2umfiLzjQSQOYpVnHxq7Fzxd0iVp6cTAQyPJzA4ndkUWCok1pjUTqLN+PoZKQ==
X-Received: by 2002:a05:6a00:189a:b0:646:7234:cbfc with SMTP id x26-20020a056a00189a00b006467234cbfcmr43536436pfh.27.1684270121976;
        Tue, 16 May 2023 13:48:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p24-20020a62ab18000000b0063b5776b073sm13857047pff.117.2023.05.16.13.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:48:40 -0700 (PDT)
Date:   Tue, 16 May 2023 13:48:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        tony.luck@intel.com, gpiccoli@igalia.com, catalin.marinas@arm.com,
        will@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 09/18] soc: qcom: Add qcom's pstore minidump driver
 support
Message-ID: <202305161347.80204C1A0E@keescook>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-10-git-send-email-quic_mojha@quicinc.com>
 <e25723bf-be85-b458-a84c-1a45392683bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25723bf-be85-b458-a84c-1a45392683bb@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 06:06:26PM +0200, Luca Stefani wrote:
> 
> On 03/05/23 19:02, Mukesh Ojha wrote:
> > This driver was inspired from the fact pstore ram region should be
> > fixed and boot firmware need to have awarness about this region,
> > so that it will be persistent across boot. But, there are many
> > QCOM SoC which does not support warm boot from hardware but they
> > have minidump support from the software, and for them, there is
> > no need of this pstore ram region to be fixed, but at the same
> > time have interest in the pstore frontends. So, this driver
> > get the dynamic reserved region from the ram and register the
> > ramoops platform device.
> > 
> >   +---------+     +---------+   +--------+     +---------+
> >   | console |     | pmsg    |   | ftrace |     | dmesg   |
> >   +---------+     +---------+   +--------+     +---------+
> >         |             |             |              |
> >         |             |             |              |
> >         +------------------------------------------+
> >                            |
> >                           \ /
> >                    +----------------+
> >              (1)   |pstore frontends|
> >                    +----------------+
> >                            |
> >                           \ /
> >                   +------------------- +
> >              (2)  | pstore backend(ram)|
> >                   +--------------------+
> >                            |
> >                           \ /
> >                   +--------------------+
> >              (3)  |qcom_pstore_minidump|
> >                   +--------------------+
> >                            |
> >                           \ /
> >                     +---------------+
> >              (4)    | qcom_minidump |
> >                     +---------------+
> > 
> > This driver will route all the pstore front data to the stored
> > in qcom pstore reserved region and the reason of showing an
> > arrow from (3) to (4) as qcom_pstore_minidump driver will register
> > all the available frontends region with qcom minidump driver
> > in upcoming patch.
> > 
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> [...]
> > +static struct qcom_ramoops_config default_ramoops_config = {
> > +	.mem_type = 2,
> > +	.record_size = 0x0,
> > +	.console_size = 0x200000,
> > +	.ftrace_size = 0x0,
> > +	.pmsg_size = 0x0,
> > +};
> 
> This is effectively hard-cording the configuration of ramoops.
> 
> Since the memory range is dynamic and by itself doesn't impose any
> limitation this should be configurable in the device-tree, like a standard
> ramoops entry backed by a memory range.
> 
> I think this should provide the same interface/knobs as pstore-ram does,
> unless there's some known limitations to minidump, in which case those
> should be expressed.

Yeah, I had the same thought reading this myself. Beyond that, it looks
fine as a way to let pstore know about a new RAM backend.

-Kees

-- 
Kees Cook
