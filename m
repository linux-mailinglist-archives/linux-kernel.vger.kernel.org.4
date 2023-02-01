Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5F685C22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBAAYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjBAAYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:24:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27696A79
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:24:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e6so8598398plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7WBhOEiVZdqc0BA30ccxv3c9iHMq2s9Xo01AT+J+yw=;
        b=ZzIsouW/BeX+45M2lzhmEbKDchuSsVslA2IB2gCABoupUePNhB9g4Lh5EGSgA0Ewh5
         Z6vzzQ3QeUJRisWl8y4cBDBgjxPda3WUMhFcZjz83p8U1vqEW1f17R9hqTDudZ2I8t4G
         09TBDSabUWSRX1EXaAG+8UIy7CnYuuouXOzytBVgcRXpJn3GpxwQKisizJNZ0sJtYnqT
         WmroCBYXbZL5/upaOvwSHkbw5DrhJUxK3PPJTEBSsLe8b9E8NtVIkuGzXgkl+/+6wr91
         NQdKsKbyM2B0ImQbXRNxQ20Rj59FQrLpiLJXaV95UK4J6Wy2yfMEP2avh//hQDi/neWh
         +AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7WBhOEiVZdqc0BA30ccxv3c9iHMq2s9Xo01AT+J+yw=;
        b=oqWNQFwl6bFrIi8XluWZ6ddwHGUjNZClSomo4VREpEm/856F9UcBdp5lGN66b6ci12
         aMUx18F2yEA31bZPeAYkufcX6wRXb1q2nIFZNBeLHObHLA93HZcFV6cJ6aNN+xAlvcj6
         t3qBMP7wzYGy3h81PUx6yy0mJF78qUDRzPOwp1i3Ifj2Mv7N1+hNhosAKV46weI4Ydci
         d9/dOM9yoOXb53aESm0LwVVuMgpvrQiGH0VmpZ4M0LkZ9jO8cPy70hFHP3IoRizcp8KC
         PXHqPtaTjFPKBNLk8ilLvHaLEht6AyRRzTvTWC7TeOnaTC/f3WoyOdFhUf6o2LfE7q9O
         p8Xw==
X-Gm-Message-State: AO0yUKWSGKCeTYE7Rcc8eWftsUrcx86tMIQGQPxyOV1mTMJWFx2u2nsi
        Xo27dF+SRQTEtNTuT2rL2sBWnw==
X-Google-Smtp-Source: AK7set9kB2sgTJIeYp/I1DZkiWdjxmonvUffplQjBHqSYAqg2fja3K0LYpsr/Yi6ujytu0TtmqwJrg==
X-Received: by 2002:a17:903:32c5:b0:198:af50:e4e7 with SMTP id i5-20020a17090332c500b00198af50e4e7mr203plr.13.1675211062256;
        Tue, 31 Jan 2023 16:24:22 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f190-20020a636ac7000000b004a737a6e62fsm8922939pgc.14.2023.01.31.16.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 16:24:21 -0800 (PST)
Date:   Wed, 1 Feb 2023 00:24:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 00/11] SVM: vNMI (with my fixes)
Message-ID: <Y9mxMvQG+52BC5z4@google.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
 <0f56e139-4c7f-5220-a4a2-99f87f45fd83@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f56e139-4c7f-5220-a4a2-99f87f45fd83@amd.com>
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

On Tue, Dec 06, 2022, Santosh Shukla wrote:
> Series tested on EPYC-v4.
> Tested-By: Santosh Shukla <Santosh.Shukla@amd.com>

In the future, please use Tested-by, not Tested-By.  For whatever reason, the
preferred kernel style for tags is to capitalize only the first word, e.g.
Co-developed-by, Tested-by, Reviewed-by, etc...
