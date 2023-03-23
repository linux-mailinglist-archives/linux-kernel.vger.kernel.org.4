Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032E86C6C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCWPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCWPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:30:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B83034325
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:30:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54463468d06so222879687b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679585439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+qI/oNwFeW5AU4lNqRSemjHEDPcMdJv7efareLc9JI=;
        b=pYBYHAzRnUHg1ZIG+T4kZzo8qWT+DElhuGUnwneUR/mF5Lij/6Q6KJsTaJvn8Q6dGv
         ygB8qrtA4OrfpSW3n13l9JKnhrcQXgsKLN2ApThD7mxb48Jcevk+F+9nfD9JbPjkMv3K
         sDc3TVFk3byG0190WDuvvjiz8kw/6rfdul6u8y3/Rzg8dbkM/ZGcBD1+Bsi1eMr2jGkj
         BWTCNIFTDmdX+pIOaL8Dgx7Zt2a99k544J2gjdxEpclc01RC2PRMc5zqZm5eeWvQH4Ho
         2t8yuWJeV4zPLLcsUKbqtlAvou56czy262wZnkUKTw4BkF3FH9zF+NzpspH/0035ae3S
         IBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679585439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+qI/oNwFeW5AU4lNqRSemjHEDPcMdJv7efareLc9JI=;
        b=CeYKDt2xMAfi1KFWlv0LvxelMUkbum4SHs6W1UJUcMtK/efjL6kXjH+8+0abSmeu7x
         L83kL3QB6N97Z1q+PrfCnudo4PbA8YnhtrbBAQLWYrjgonb/CO1VwWyhqNs9PfxqTxVg
         kpyh0rGtN0DkDOIOTm0QFt+WGKU+vgwEOzbbJjCDB+ZExQsWZWTXjAnsgSwzTdEKbX0B
         9t6xZRxxi82Ls+Ilw4VIFGtvSSvVu0EuQ3ldU/9DkCooaP2DINZaZjbFmoP7WmGQuRxM
         pVEb7CGGRlsrvfhGJXzDE0zyZYTo1WpBwtRAjsQbpVsWsYkf3O0X55SwdsoZp3PixS23
         MZGg==
X-Gm-Message-State: AAQBX9c3Snf/FeM1cvbFafzWZAqXoJewoY9wPZoTxj51lnCopQ9mPpfk
        EFU65+gQI+/6pU/1wIcy8Kk9cRak/Ag=
X-Google-Smtp-Source: AKy350a00+PVtD4gMfoaD4iNCL0ZDQAzD5N6bhQaxe1CtCJstjnO3aAc6TWBd49huAyNeBuSvhfpCPVxx9M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100d:b0:b6d:fc53:c5c0 with SMTP id
 w13-20020a056902100d00b00b6dfc53c5c0mr2444777ybt.1.1679585439650; Thu, 23 Mar
 2023 08:30:39 -0700 (PDT)
Date:   Thu, 23 Mar 2023 08:30:38 -0700
In-Reply-To: <20230207123713.3905-3-wei.w.wang@intel.com>
Mime-Version: 1.0
References: <20230207123713.3905-1-wei.w.wang@intel.com> <20230207123713.3905-3-wei.w.wang@intel.com>
Message-ID: <ZBxwnq3dG3kzLcHg@google.com>
Subject: Re: [PATCH v2 2/2] kvm/eventfd: use list_for_each_entry when deassign ioeventfd
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, mhal@rbox.co, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023, Wei Wang wrote:
> Simpify kvm_deassign_ioeventfd_idx to use list_for_each_entry as the
> loop just ends at the entry that's founded and deleted.
> 

Suggested-by: Michal Luczaj <mhal@rbox.co>

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
