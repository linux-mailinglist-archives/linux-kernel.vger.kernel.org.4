Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704E171102D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbjEYP7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbjEYP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:59:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04493CC
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:59:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56183784dd3so9704507b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685030357; x=1687622357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cizxR2tf6Gm/Qra8hn0ivIOj8u2JEZrpDUd1iu4ARf0=;
        b=OARfcsadBSB+sOJB5M7ew5aVNzIpbI3uM6exggHIVJpdCDE2R+p0axB+qhSCJscQQ6
         /B6C6gHXlxoLXL36sTfwaBgV3AsuMZbQjVparj4zWAzc9jBX/Mn0yF9Goo95gIGr5XCg
         N+w72uNEEy1LAuEb3AkuZTh44I+Muotv94BKZomPnIIeRMxkRPazoFaXNm2soLhSc3Yt
         vpmid56IkrdLW2NbbKC7RcbM2pOorML2acgyB0XBvN6j2xD455WGDoxhnGKRbNdpoxAn
         ks+tA+Vb9w1OXH1tmrydTJWq1NrOUSKQnYOOmuSHljvJ95CuzkZwm8focYCCDN3oyX/O
         OTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030357; x=1687622357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cizxR2tf6Gm/Qra8hn0ivIOj8u2JEZrpDUd1iu4ARf0=;
        b=Mlm4ME81JAcjFOrJavd6yQx7IjNBeB0NIxG4FhExvR4RmPo9wuCqmFO+IFv/I+a31c
         3GxLn6uocBclZEaA8KqszRmR/KjtW0+O+NSD3jOWhmBf3dIKG/si3OluYRgOLOU3fO7z
         J9P2wRD0conT1QZwLdXOAKBZD/rgDWb/xGyJXFvk4vOtJzB0EOCwpnHy+RpLO6fLKecw
         tWXkoI0R+aqD9SSTqrkcCWSAi+vz3olVT0Gqj4/8X6vltExvWNTCxlg6dksawJbazk+z
         z7eU+sAERHWSPVDE+Iy3udxNMI60JKBINmbE0E8aiy3IgZotFOqAZlqYu0sUjWpspGC1
         9aJg==
X-Gm-Message-State: AC+VfDwBf1IX61hGC92tWwZz2Ck8PY5QMSjbUC0+lEdYhtr6bANEoPFf
        A/HFcBzDOVezi2jLc7RTKGXkU62bPow=
X-Google-Smtp-Source: ACHHUZ4pD9tgEvRuriXEoPy8QygMImdYVqp1+GKRGm/Iq1V0sMKHL286IlXGP1VJ1fwrfN96DYwV5vfrnBg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ac56:0:b0:559:f7b1:431 with SMTP id
 z22-20020a81ac56000000b00559f7b10431mr17319ywj.2.1685030357264; Thu, 25 May
 2023 08:59:17 -0700 (PDT)
Date:   Thu, 25 May 2023 08:59:15 -0700
In-Reply-To: <2692c723-239c-20ad-a735-8b83988f072a@linux.intel.com>
Mime-Version: 1.0
References: <20230510060611.12950-1-binbin.wu@linux.intel.com> <2692c723-239c-20ad-a735-8b83988f072a@linux.intel.com>
Message-ID: <ZG+F02XuoSbZvuvv@google.com>
Subject: Re: [PATCH v8 0/6] Linear Address Masking (LAM) KVM Enabling
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.gao@intel.com,
        kai.huang@intel.com, robert.hu@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023, Binbin Wu wrote:
> Gentle ping.
> Do you have any comments for this patch series?

Probably, I haven't looked at it yet.  This is on my todo list, but there are
multiple large series ahead of it.
