Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE860D7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiJYXae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiJYXa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:30:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD632060
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:30:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g16so8088443pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZDxRYzZuHWnfgFr4L29qmwLAhe1STmyZz5ZOtW4i9w=;
        b=ABtMXBWvDK6YQbYXfqk9WH0NLdvhh3yu6CWfQvC28mvvsNmjy8yYlsB/0RxGVpPDTy
         ZpRCDNhEByyAN0OeGVS6NfJ0LT4EE6R1Kksny2o3SWzZNjwepnhk0FlqRiaGi3CetFV9
         njLyxiI3LOAa3VlP/V9DMVT6RekZXP0sThfu9vzd2ZCvWdlBionCQHve6ZG+xJfsv4tx
         kxRKUyrZZ+lqicvu2D0WBnux2Tt3HRow8uxWU/KRxrL9I6eFvzQsACIsr/AN/7IEnq5T
         K5drkHv2iPccqKUjvxDaZ21mfcgiOnRKi5CewfJYOIGPH/dxPsLg0x9Qqf4+S1oc2i+D
         Yy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZDxRYzZuHWnfgFr4L29qmwLAhe1STmyZz5ZOtW4i9w=;
        b=xuIx5HyHjRprkSxqbI/UTWmi8vDg5i4u2gPM2zc3+k7BCfoEYL+X+uKRVCH8y6uYiQ
         n3TmxKA7VpjxMdkIf9WsW7K03fHM+nKJ3HFhhDbXcG1fBCyQ35aptqo8jvmfNs15NpuO
         eqY3kM2kcia8TC5x7ziA8YuR5sfn/ZB5wVq8SnNabyscfKpAs+kS1OUjdaOW4qUEmwOX
         6c/Yalqjg2qosXeUWIGJbkOZUFcIKJqc7S/DOySINSXcu7W6A2UR+bnQmKJfpbHl56FR
         in2KBOrXF6/Dkkf1hnWhcmD9yJSc80szEjP00GVLmyCdU2qRUd18vVoWfUCvu1WZ0wBo
         D+Gw==
X-Gm-Message-State: ACrzQf33N2ef29jYOQ2K2loU1Wn6Ws5wlZNDPqmU5nLBmhz+5NwHRCow
        kI6IiPHGMZBakPwijr2N3QP0HA==
X-Google-Smtp-Source: AMsMyM6e1j2vFKPYTZ+VlCuFHZlCLr8LptKzQzmcn9hqI93xaoA4ZcSi+mSYw3Vw0knAs4LVIreNWw==
X-Received: by 2002:a63:8bc8:0:b0:461:ff70:7546 with SMTP id j191-20020a638bc8000000b00461ff707546mr35353597pge.70.1666740626624;
        Tue, 25 Oct 2022 16:30:26 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b00174c235e1fdsm1689809plg.199.2022.10.25.16.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:30:26 -0700 (PDT)
Date:   Tue, 25 Oct 2022 23:30:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Exempt pending triple fault from event
 injection sanity check
Message-ID: <Y1hxjyqEjrH+/TpN@google.com>
References: <20220930230008.1636044-1-seanjc@google.com>
 <3d7389cf-8cea-624b-2fdd-f3fadfa65ba2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7389cf-8cea-624b-2fdd-f3fadfa65ba2@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo, I hope your bus factor is high, because I'm throwing you under one :-)

On Tue, Oct 25, 2022, Yujie Liu wrote:
> Hi Sean and Paolo,
> 
> Thanks for posting this fix patch to address the issue we reported.
> 
> We noticed that commit 7055fb113116 has been merged to mainline, but seems
> this patch is still under review, so the mmio_warning_test kvm selftests
> still fails on the current head of mainline. Could you please help to
> update the status that whether this patch will be applied? Thanks.

Last I heard, Paolo is planning on handling patches for this cycle (fixes for 6.1
and new features for 6.2), which is why I haven't been queuing anything.  Not sure
what Paolo's excuse is.  ;-)
