Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C647323FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjFPAAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjFPAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:00:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3712271C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 17:00:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc6a920e69aso109240276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686873651; x=1689465651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTMEKODPb3FRJH2K0p0YFyg3i5TgEpiZ3kirtZdTv2w=;
        b=tbF2tohEtNLhni/iXAr2HyqNmMRvOaf26O4dDG69+zW+inRRkk0Bw3jL93JHrgbLNY
         1TV+5AqWnXfAiXAtYLHtq79rKjfJ++Qai5D/nVCLLJegnYTfQt0j8O1urGlq1uF7nNEE
         qzaWUmQJUeIuD1hDg/PXU8k25x2Vc+HlQKxpk9WEpUNcsVNth60XvynygkTdRoi/4QwR
         iDfNDfrUouGx/fKx55ou+AQRxnjZWo0ll2TYl/1at+sTtbAUW4ARjjM13d13Lmlhiu02
         tJgnNTKTXxPIyZabyzOHnMdlkN2xFjNZ0UBwULzMvf2HZkWjnMyvvmDMoQOMQToV5R3O
         4ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686873651; x=1689465651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTMEKODPb3FRJH2K0p0YFyg3i5TgEpiZ3kirtZdTv2w=;
        b=GOnjuEw3pp0Kf7cNdrhZERjA3npRbK6IzkOexbaJPg0WK9xo/mLPKxfzRr0Hblsbpd
         k7WSsf3nlyrVBJJZQDEjxxnUVWr6V+c+ULj2PgnAauP9KKRTGFD33fF0T9i5OV9uWXYb
         AIdJMbge/no0xgqQGwA0N7rXX9r77orn8buWZPlMjW5UrN2mGbkQXrmqK2pIMSP1c6x8
         2GDsMVYS6RE0QuMT3WDE7hgi6+r/nLIjEukYKlBDkGiumYczdGxPd5paZinb6N5P0Vo2
         YErKprszAyV9trIzTaANOytKqG6t33VNP5DgcpdAi1ycL/A8XeJ0rQSTVXclclWQvcuT
         Yueg==
X-Gm-Message-State: AC+VfDzErUk+8u8hue4f85QdiGEoauLeGh0qMrTcXRfzaVLGSAvel/Ua
        OetqosST5f2FXr91icYhTF36UFpxdwU=
X-Google-Smtp-Source: ACHHUZ6YLELUNWNquVJwqHsbJ/VtDfHCXjATrg+bNtW8UobZV18L1xo3A3SD3wfDA14g+Ahi5/wRw46EJVs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:420c:0:b0:bd0:4e03:a247 with SMTP id
 p12-20020a25420c000000b00bd04e03a247mr70704yba.5.1686873651284; Thu, 15 Jun
 2023 17:00:51 -0700 (PDT)
Date:   Thu, 15 Jun 2023 17:00:49 -0700
In-Reply-To: <ZIufL7p/ZvxjXwK5@google.com>
Mime-Version: 1.0
References: <20230511040857.6094-1-weijiang.yang@intel.com> <ZIufL7p/ZvxjXwK5@google.com>
Message-ID: <ZIumMeRxDzzcKpUh@google.com>
Subject: Re: [PATCH v3 00/21] Enable CET Virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rppt@kernel.org, binbin.wu@linux.intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
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

On Thu, Jun 15, 2023, Sean Christopherson wrote:
> Your cover letter from v2 back in April said the same thing.  Why hasn't the patch
> been posted?  And what exactly is the issue?  IIUC, setting CR4.CET with
> MSR_IA32_S_CET=0 and MSR_IA32_U_CET=0 should be a nop, which suggests that there's
> a KVM bug.  And if that's the case, the next obvious questions is, why are you
> posting known buggy code?

Ah, is the problem that the test doesn't set CR0.WP as required by CR4.CET=1?
