Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6106EE7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjDYSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjDYSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:48:39 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBEF19AB;
        Tue, 25 Apr 2023 11:48:38 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5fe25d190so5921923a34.2;
        Tue, 25 Apr 2023 11:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448518; x=1685040518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r58rpLX+XFStcPRLxVqXhROnTm1gbP6Vnd8k2yd5R9M=;
        b=ivozhBXSNGcfjzSP5BuW6OkzQ6kBESnb0mcFzVXCp7jOFaSe8uD0C4yJ1LSrtBKIos
         kX1jJ2W6qYkzShnJCPRh1gqDSptyubgNTnrGxlKfpFYcTQ/lWjS46a+0XPxYZindbLiN
         d6/OonMKqQAPCL0i7a/et4qJSOQNbXUyvuQtMsRmh7igVOXNZVvZn/nsZqLDMnQAiCbm
         /2plZNzslIoRnDIw/kL2GBruHrCwuUc58c5zWHylr6rlBpgWM1rIwVg63wckzIJ3u4t9
         bYvt+Q5Yr0OZN2NcCvXo4bIBRNG5DcwGxKynDv1AkR4C2KbYQyS3273hFogQebczvgXS
         vF+A==
X-Gm-Message-State: AAQBX9eqhnwcTh7i9j8ymEFvBpz2mA28xTJIZWFCC3zZNvxwRJbQMEN0
        QL85KHU1wMILrJSho+Ka01u4XWnWOw==
X-Google-Smtp-Source: AKy350YOPQT+GlTcYxB/IyUiMbJVoXHrhFf6gq7gDImfjUP/elswZc9kNiokJ+FE1IWc1aHd5RkbuA==
X-Received: by 2002:a05:6830:108:b0:6a5:ea63:b9e7 with SMTP id i8-20020a056830010800b006a5ea63b9e7mr10142025otp.16.1682448518003;
        Tue, 25 Apr 2023 11:48:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k26-20020a0568301bfa00b006a415c6f304sm6001143otb.68.2023.04.25.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:48:37 -0700 (PDT)
Received: (nullmailer pid 2072466 invoked by uid 1000);
        Tue, 25 Apr 2023 18:48:36 -0000
Date:   Tue, 25 Apr 2023 13:48:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     "logic.yu" <hymmsx.yu@gmail.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of:Use remote_parent instead of remote
Message-ID: <20230425184836.GA2070751-robh@kernel.org>
References: <20230422150343.43569-1-hymmsx.yu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422150343.43569-1-hymmsx.yu@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 08:03:43AM -0700, logic.yu wrote:
> Since the parent node of the remote node is obtained here,
> it is more reasonable to change it to the remote_parent

Would have been a better name, but not really worth changing as it then 
changes the authorship of the lines in 'git blame'.

Rob
