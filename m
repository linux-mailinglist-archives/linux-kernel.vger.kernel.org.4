Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21A70E83C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbjEWV6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjEWV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:58:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4FE9;
        Tue, 23 May 2023 14:58:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2981e3abso29903b3a.1;
        Tue, 23 May 2023 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684879117; x=1687471117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxzlsA2ox//OU4cHa1oP0gHZlv78mJtJSYZTmINNVTk=;
        b=WaS64H6DgvcpplJGtgaRrFZYUT1nLdJ0eusi7A7eptWSx4HjAU373CvuWrxf5lE94Q
         B/co0DwNjy9acXd89omxnN4kUEAvLayJR6JiFFKGjN9dn7PVJ8/kH43NV843dpW1+48y
         j4Op3Z66M4CB7SVFyWKu97hwmweldAGHs+hu2Png4zYJ4BWhwXYP2awM04n2vZkBZT4l
         NPD1dNgV6KcNkFBMVuHdKuWZIwa+6R/u0BAQC04FrEM6H+y5JysAo5LvUwqnNVzbeIKL
         I9QLNDByhrmOeTdeYlY6Lhh5AGTpm4MLbXG5OGXS9D4HM96FFwDxEQVI/+hhqD806a+B
         tl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684879117; x=1687471117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxzlsA2ox//OU4cHa1oP0gHZlv78mJtJSYZTmINNVTk=;
        b=ASqaGQ22qDHeLeF1s1Kn3nitgAzERokoQnhATXWnhuRSOuBH55DsEkOiFddk4p5/23
         p24w3wPqHZOIbBuxnzQLOqMKuH4FAXtJ+B2u7AwNANpwOnxsMMFtbUX5v8VHp/Hp1oAY
         pmGgRkEAZoovCflZhD8BzWWKXbWp5zpEcjCdNv9RqhRhrDGT0t5Fe8rFdbMSo6dJWPSg
         QtDfDLbEIj6Au2jm9hkwud5n/RvlGqFFABbalgtlwjxwmx5SzW5Oezcm2gZSe0fQpwHc
         /LrGmWj+XL73TLAG17yAYnwy+IWaN/dG+NEglNYJfoS/TOkaa7MjelQu2iGgcvdt43E4
         ILLQ==
X-Gm-Message-State: AC+VfDwGyeAI5qYt7sou07ebHMd4YPhBV1S/Jgl/AKf6TPWiktjP8kOD
        /ez1PDo5AE1A0fYE6TC5jbo=
X-Google-Smtp-Source: ACHHUZ7bdpQxnAzcoMajSi+oUUimM366y1QT29dZAnGRd1HA2uwoVphakHnjFILHcr2iKE8FKfJBhA==
X-Received: by 2002:a05:6a21:6d86:b0:10b:6e18:b6a6 with SMTP id wl6-20020a056a216d8600b0010b6e18b6a6mr9729213pzb.40.1684879117049;
        Tue, 23 May 2023 14:58:37 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a194e00b0023cfdbb6496sm62621pjh.1.2023.05.23.14.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:58:36 -0700 (PDT)
Date:   Tue, 23 May 2023 14:58:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [resend] Input: gpio-keys - Use input_report_key()
Message-ID: <ZG03CVo0FGXhKNvQ@google.com>
References: <185f3320e39000159d4bd843fd3119b94c30d607.1684854795.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185f3320e39000159d4bd843fd3119b94c30d607.1684854795.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:13:55PM +0200, Geert Uytterhoeven wrote:
> Use the input_report_key() helper instead of open-coding the same
> operation.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

-- 
Dmitry
