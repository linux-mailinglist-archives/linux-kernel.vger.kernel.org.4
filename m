Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A16DFF50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDLUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:00:34 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F4359E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:00:33 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id t9-20020a17090a3e4900b00246669ab458so4591338pjm.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681329632; x=1683921632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jcl3gk9M3bVX56GXSurnA4vZncbccQIQ9VxkxYgM9Q=;
        b=aYTaBGWsNj/eD5+dBuK5/K4fkvMZxMAfXONBZxomMlrYfP1RL3ITgO0fmP3GosT/CK
         uoLSxD7O+CvXxrQ6eK0W6Z+EA7tMbRkhaIl/RgM2CpJP5PfiIe9F08jtdu/BRhydsO5G
         EMgggw2ctVGMVMy0OGbep32I+0lp4shm14tuzP55T79mAeC4rN9tejlSw7wsws0e8AVK
         zG3ZlK0my54GrboRYTUMZMYb5Px6zWhMlSK62B1AUmjp19sAAQrQ8DZaXSEwVaRC0gqg
         Pwr/FxPp5dwoWuYWl06ZX9elR6kWmN6/XAB0ehZn+4StXZmdXxgi/IIzaLQnC/1K+Rkc
         3dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329632; x=1683921632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jcl3gk9M3bVX56GXSurnA4vZncbccQIQ9VxkxYgM9Q=;
        b=JKg2XNAQsZPGRRxKHb3LiULarYW9sPbay6/nIZUglyiP9lKlvjeml7UwI7MM8TrJBM
         i04qAeBCiHbG3b45YMVzx9+lX0CBcncY2hHxQ8v7YjjBaY1iBJrAtFmHuS0DFYnCMh96
         IbQ/BsnCwN7y/Q7U1sxLrT/DEPXq+9ynoK/Ty8+217Q4LCR83qos4NxhS+iSr84LxZVQ
         p2BKjULggFjoXBtQnEJlzAtyfxaNDFT+DYXsOAJTlg0QkHJQGiyUVRk63m/ntTtpfs2G
         qSEd+XWE0BUnucXxwkJhJvyRoFMpFm6HXnqnjySv56J0IWCsq6ZXSYvZoQFQi0wj8l7i
         yGlQ==
X-Gm-Message-State: AAQBX9cZO28oZr9o7TO7khDz+sxRWjF/kdoxKnm/I/Ru5FEeRa+TXSeo
        YMLcCsciYRxNidj+U4auSCmn6YhgBYM=
X-Google-Smtp-Source: AKy350ZGVQ/mTN9gkBB6k/G/BtgTqq5qVlxj5ol2tx70CKiHj0o/v9nbxasL0zmBUP3/LG6bFL8ZoRTgfVI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2111:0:b0:503:a26e:b4cf with SMTP id
 h17-20020a632111000000b00503a26eb4cfmr5037260pgh.8.1681329632566; Wed, 12 Apr
 2023 13:00:32 -0700 (PDT)
Date:   Wed, 12 Apr 2023 13:00:30 -0700
In-Reply-To: <20230412194942.1556575-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20230322011440.2195485-1-seanjc@google.com> <20230412194942.1556575-1-pbonzini@redhat.com>
Message-ID: <ZDcN3hLF+5Vn2qKr@google.com>
Subject: Re: [PATCH 0/6] KVM: x86: Unhost the *_CMD MSR mess
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023, Paolo Bonzini wrote:
> Queued, thanks.

Roger that, I'll drop kvm-x86/cmd_msrs.
