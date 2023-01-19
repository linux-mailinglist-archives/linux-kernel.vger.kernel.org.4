Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C9673145
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjASFkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjASFj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:39:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE4B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:39:55 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so4812732pjm.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGDn0N8Ms6feoyrcP9CT4zVtB2Eed1lBejF9LTMQpMU=;
        b=dZnwg0Ly1yeOJNsCb4QCQdYVOEJUCq6Si1pae/K3zD7A3EzzkXrUPQes3tfoy6diw7
         sztMsuos6SjPcczzcpcYab+62BXRSopALKqN+ZLYmRNbELW0nen7PR+qAp0pdNM2B5Ea
         O3U2An5c7kJs1U9P1Q02Ca+oAKSG61LhEqN5SFql1/R9IQ3ZhUBLKG2BQQVBuzqKpA/Z
         J3iHK4KnwD/ET1o7oLNcycRoo82cEwG1YpFOK6rqkwG35sldnfznkJtmgnGt3bRSszsV
         LU9jI8i8YMz+3bx+qu6b65F1KTzGAmhwY8qbZVQ+biivzwytyw86r2W1wojfqp4lrjvh
         YK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGDn0N8Ms6feoyrcP9CT4zVtB2Eed1lBejF9LTMQpMU=;
        b=hrBeyC8lRFRtWyOh91bfyjpZqZsrRyXiRJiVgNNqP/+REqduw5KTK0Rc0lSRKi4M/i
         T05FkQSGwosLTKPWTGQ3w0strroaMY1EXukpJGrDXEW5LQHQkr3Cj1qkyTmhpEIDfIMy
         rwtW5jrOAnWj1N7NraZfCObYxrTsTITnVTipG/4dO9Yk5EtCg6lfcrR8PnDkjLVanMlK
         k1ILzTD00f5qO6Bj2wKKadnQxYUl5M7tnDRrMPb+TAmjlJ6S/jPEEns1m04aHYUYP2aY
         Qes8slYlenGcs/I4dpapUf3QGjhY2Ha7JGl0tPy6hc+HzJjSbHv2gwGP8wYg3sm80/RR
         NoRg==
X-Gm-Message-State: AFqh2kr5f71ibJbJuG7TWQxM0/8XIN/Qvfl5vtSrkxZ1/6ZcDgB7b5vQ
        9bW5vP/oWUvbWN2lPiXguZ/VtA==
X-Google-Smtp-Source: AMrXdXtkQCK+4BLvooEaySdhdPo9CXsc3cxW/QcHx53H3kXI7eJt/RwNqVl6YIPbtIWKH75QPRZfIQ==
X-Received: by 2002:a17:90b:3d0c:b0:219:5fc5:7790 with SMTP id pt12-20020a17090b3d0c00b002195fc57790mr9993838pjb.16.1674106795185;
        Wed, 18 Jan 2023 21:39:55 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a558200b00229661c5650sm2180168pji.37.2023.01.18.21.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:39:54 -0800 (PST)
Date:   Thu, 19 Jan 2023 11:09:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Wang <bhuwz@163.com>,
        Vincent Wang <vincentwang3@lenovo.com>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Register with perf domain before
Message-ID: <20230119053952.qwh2yrmhddzocnju@vireshk-i7>
References: <20230118044733.29391-1-bhuwz@163.com>
 <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
 <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-23, 09:24, Lukasz Luba wrote:
> Viresh, If that's an issue for other governors, than maybe
> we should address that.

As you said in the other email, it isn't a mainline issue, I will
ignore it then :)

-- 
viresh
