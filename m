Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1206F1EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbjD1TyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbjD1TyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:54:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08442700;
        Fri, 28 Apr 2023 12:54:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a69f686345so2985595ad.2;
        Fri, 28 Apr 2023 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682711644; x=1685303644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHPsFDmDH4e6bcwmm2MedMDFCNz8rSawrQA+SpMotHU=;
        b=KDCL8CKfthS/VjPfI1tpGJn4Me28ELEGrnITyD5EkHPxaTi0oA4X/r9CxJ37uGsj5M
         wy2SUO73B+C4toDS0nLcU8X6wEI0PB5kFo5kL7swfwbPpp03DN9bFskal+kgO+jMGkT5
         MlkeZ29/XznfVNHqlsQ8AstS46fhn6Ir0IfmQ+R0ttsdgpdZb+feJq7ftZGHmPKNIiVD
         RJGs+EAg390jfgDUTjiB+UaGydF0lgH8PConBT0xdb7mLDXP6y8wvn/Q+YMl0rmXpGYb
         36TiYjCJUbW6m54pHxNzFeClSW8CCKSZ1vvpGYZYZOkY3APTzhUJa7TErD71IgqcWxjO
         j4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682711644; x=1685303644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHPsFDmDH4e6bcwmm2MedMDFCNz8rSawrQA+SpMotHU=;
        b=HtjXopTOX5wPTcERJQYaw1lTER7n+IrPXXz7iYN887ETGRTyxOEEFvuX06WxnKng+x
         6wTApauPhez0SgTjbZhTSsWSH1nWBhXv+HYRpHVVRcqej53pHy7BwZnM7MG+YKNolgzu
         WADVa5j2ayzDCH4Gq3WeLliNW1Ut/0QZ1TjUL18v2qB65k8NyydDuEdW4Vjuqr/gMYe9
         nBLflEjrkgO32A7T/I7QcIk1KVRJ0LT7RAjBoKJRrnwfv1NHfqyfybNkc7eyhTHsAbAJ
         SVQ+vP8Y3S7GA/6x00kU2QLgS4y/UIGVtmwDeWnSkNuosZXXcjBIdMBSigQ64Ku62hcf
         GhvQ==
X-Gm-Message-State: AC+VfDwSyMWYiIloUIwetNrhbBnDQz6Hp1sERt4zmAs0Tp37KUzLHIkW
        PMSJHT7qxsFzBdsmasodo5A=
X-Google-Smtp-Source: ACHHUZ6UZCGjDmtyqahVDRYPJ2dnvTD37oeJp/wXeDZCK02tf6cFsKWSEUKSbP6REcM39vJxi4hb3g==
X-Received: by 2002:a17:902:e5d2:b0:1a6:5487:3f97 with SMTP id u18-20020a170902e5d200b001a654873f97mr7349682plf.64.1682711644202;
        Fri, 28 Apr 2023 12:54:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f36d:d0d9:ea96:1c8f])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902b08c00b0019c919bccf8sm13684500plr.86.2023.04.28.12.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:54:03 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:54:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Siarhei Vishniakou <svv@google.com>
Cc:     Biswarup Pal <biswarupp@google.com>, kernel-team@android.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Call input_set_timestamp for events injected using uinput
Message-ID: <ZEwkWAtpwdUiqHb1@google.com>
References: <20230427000152.1407471-1-biswarupp@google.com>
 <CAKF84v2Rw8xQv=m+ciL+n_uXhyAZWFmhYpgA63Q=DnVh5sbOsw@mail.gmail.com>
 <ZEwkC7BiUpq7kbjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEwkC7BiUpq7kbjc@google.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 12:52:43PM -0700, Dmitry Torokhov wrote:
> Hi,
> 
> On Fri, Apr 28, 2023 at 11:38:36AM -0700, Siarhei Vishniakou wrote:
> > Thanks Biswarup!
> 
> Please avoid top posting.
> 
> > 
> > Just to add a bit of context: we were concerned with  breaking the
> > existing uinput usages where the caller might be setting an incorrect
> > value (since previously, that had no effect).
> > So the 10 second guard was added to fall back to the default behaviour
> > for those devices.
> 
> What is the benefit of sending this in uinput? It is not much close
> to the exact time the hardware generated the event than the timestamp
> generated in the input core, so I do not see why it is needed in uinput.

Ah, sorry, my apologies, I mis-parsed the code.

-- 
Dmitry
