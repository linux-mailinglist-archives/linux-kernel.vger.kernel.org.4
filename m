Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7370E3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjEWRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbjEWRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:30:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1F97
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:30:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae851f2a7dso34611385ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684863012; x=1687455012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHRHm9cqQ7Q0n1UjBQwnZXDQwg6SsSkREtAQzpA0zS8=;
        b=SP811KKYOneg7dl/rmLOhy9/xH6sqzY2GnOzj4smgfmDjcrNa1t+TeWH+MftwdTdYc
         E4BW4v0YCWJszzUnIyk6s5yZ8eHJPHGmGtHHpiX8qXFCDB3eF6JRsj5bjXrESVN39YKd
         /i1og6RnHIp8XIO4y1LBmPTKuDNMNqYW0a7Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863012; x=1687455012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHRHm9cqQ7Q0n1UjBQwnZXDQwg6SsSkREtAQzpA0zS8=;
        b=KeoQOXHZn1i2vuPtof2ZbblUpTrqAsjKH4OhrLPuhWOaf0TAGPfSHO6v3NwrYnJkjy
         F9RNLXR5LwDkzyp67GDUmTsL+zvigRFduDO/cbc79GMElYNHxn6/xOaZXsPMRjyuvlqC
         c/XBjqhS46Y4PyxTKkAsUrRF7p60EDwCxIY+lJaGGjorkTUjqP/YnVHkOiKnHe0WuxPn
         aZYcpcIS9sPe2P2/Fhwz/KW9kKaj2O+KurIcDWsAz5CX4ntYBxMznQULxED070JuLJLz
         c7YDc5/l/c/h2URm9mu7CaD35U4yF7fMCYEjybAibR53Kaj1MvzBMpTH/VZYe787Ecsi
         965Q==
X-Gm-Message-State: AC+VfDxTCfhvaLsa9HeNkEkFcEbdmZFKN5oAwitBCSuMVNLQwL/jkA/1
        ATAcVTNGyZJ71UWa6eXr41OCaA==
X-Google-Smtp-Source: ACHHUZ7YEdTfg2D6FXrXBlWvhCCMQ2QiK02a1DwN2Y+FEqHr4FZs/WDdEAE9LsGJyuvLGJwEHXnMcg==
X-Received: by 2002:a17:903:228d:b0:1a9:6a10:70e9 with SMTP id b13-20020a170903228d00b001a96a1070e9mr14552996plh.33.1684863012392;
        Tue, 23 May 2023 10:30:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001a1c721f7f8sm7073073plr.267.2023.05.23.10.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:30:12 -0700 (PDT)
Date:   Tue, 23 May 2023 10:30:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] vfio/ccw: Use struct_size() helper
Message-ID: <202305231030.5DE9FCD31@keescook>
References: <cover.1684805398.git.gustavoars@kernel.org>
 <f657276073630e806e69726a40ad1cc85101448a.1684805398.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f657276073630e806e69726a40ad1cc85101448a.1684805398.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:35:59PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
