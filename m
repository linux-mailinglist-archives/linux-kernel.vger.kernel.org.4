Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9547C6247B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKJQ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiKJQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:56:55 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B841988
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:56:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d20so1859331plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MObtVKIB7l4b8WfJfpmkCk3gsljGAahPc93DAQJ6frg=;
        b=W/0Fkr/byKXpfxP6+/jTpnDsIjqIxtuvfL0qjcv4YJK39Z2TVqxxhwqsaNDUOUbx1c
         2KijmlCyXt1eIEfCI7vM+r4LVEDXUIbT3iGDtqC5dVjQgqWg2Z2TPnd2gakmNTZPCd+5
         Ggcho7pqKNfRLqnV0GXCOcZHHVyeg+PPxDxWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MObtVKIB7l4b8WfJfpmkCk3gsljGAahPc93DAQJ6frg=;
        b=EFy0zz3Me52YEUm+3SecOdqZvqTc1OP8aesGH4Z5OlIVT4iHBHTB8ZjUTFSX5o9h0v
         ov88C5R1/ZXzE2MJUwNYhqkMoDmFvQIuuycxVonrKg4LEsREsZtcZuL5ToIT3lKyfQYF
         B6u5yYA4GMbEsuMuJy8LaoQlXji4A/xRLmwKRJJrdaopg86wstZNefQukWYnrHkptV/h
         h2pgczj4Iws6HfRYzQc8FFdmrwsP7tsVGLXdmygPa4MxjLx742mQI+5DqKMwgaXdgL8j
         kqWkmjj6COYSRMnRfelU1y8gGxuAMv2vXDPhbT4jFiEGxw3l1iQqX5ljrBfssrzs9MAy
         K3jQ==
X-Gm-Message-State: ACrzQf0UUjYZ9pNsVspEhSXcWtNlqtY9CHRSIEuj5wijKRr1R0SXnI/J
        cHdQwyp0q5UVKr6gjDwto20XwA==
X-Google-Smtp-Source: AMsMyM6aYNGQRU9jd0TsshThz+/JIVzG11NvElrb65k/L5ym/ko6eFmmta8lbovKLs0qzsYhiQnHTA==
X-Received: by 2002:a17:90a:8503:b0:212:9b3f:dee5 with SMTP id l3-20020a17090a850300b002129b3fdee5mr1464006pjn.62.1668099411538;
        Thu, 10 Nov 2022 08:56:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79f8a000000b00560bb4a57f7sm10748151pfr.179.2022.11.10.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:56:51 -0800 (PST)
Date:   Thu, 10 Nov 2022 08:56:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: imx290_ctrl_init(): Error handling issues
Message-ID: <202211100856.9CE03EC@keescook>
References: <202211100830.1F097DC@keescook>
 <CAPY8ntCkjG0BafMy+iLna2BDvr0n10E8hzUqL01WpUgFCjwV4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntCkjG0BafMy+iLna2BDvr0n10E8hzUqL01WpUgFCjwV4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:41:28PM +0000, Dave Stevenson wrote:
> On Thu, 10 Nov 2022 at 16:31, coverity-bot <keescook@chromium.org> wrote:
> >
> > Hello!
> >
> > This is an experimental semi-automated report about issues detected by
> > Coverity from a scan of next-20221110 as part of the linux-next scan project:
> > https://scan.coverity.com/projects/linux-next-weekly-scan
> >
> > You're getting this email because you were associated with the identified
> > lines of code (noted below) that were touched by commits:
> >
> >   Thu Oct 27 14:38:02 2022 +0300
> >     4c9c93cf8657 ("media: i2c: imx290: Create controls for fwnode properties")
> >
> > Coverity reported the following:
> >
> > *** CID 1527251:  Error handling issues  (CHECKED_RETURN)
> > drivers/media/i2c/imx290.c:1056 in imx290_ctrl_init()
> > 1050            imx290->vblank = v4l2_ctrl_new_std(&imx290->ctrls, &imx290_ctrl_ops,
> > 1051                                               V4L2_CID_VBLANK, blank, blank, 1,
> > 1052                                               blank);
> > 1053            if (imx290->vblank)
> > 1054                    imx290->vblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > 1055
> > vvv     CID 1527251:  Error handling issues  (CHECKED_RETURN)
> > vvv     Calling "v4l2_ctrl_new_fwnode_properties" without checking return value (as is done elsewhere 9 out of 10 times).
> > 1056            v4l2_ctrl_new_fwnode_properties(&imx290->ctrls, &imx290_ctrl_ops,
> > 1057                                            &props);
> > 1058
> > 1059            imx290->sd.ctrl_handler = &imx290->ctrls;
> > 1060
> > 1061            if (imx290->ctrls.error) {
> >
> > If this is a false positive, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make
> > sure fixes get into linux-next. :) For patches fixing this, please
> > include these lines (but double-check the "Fixes" first):
> 
> I looked at this one when the patches were sent to the list.
> 
> On failure, v4l2_ctrl_new_fwnode_properties will have set the error
> flag in struct v4l2_ctrl_handler. This is also what it returns.
> 
> In most of the existing drivers the error flag has already been
> checked before calling v4l2_ctrl_new_fwnode_properties, therefore the
> return value has to be checked explicitly. In this case it is checked
> at line 1061 which is after v4l2_ctrl_new_fwnode_properties has been
> called, and therefore there is no need to check the return value of
> the call.
> 
> IMHO Neither is particularly right or wrong, just slightly different
> approaches. In some regards this new code pattern is nicer as it
> removes a number of error handling paths.

Great! Thanks for double-checking it. :)

-- 
Kees Cook
