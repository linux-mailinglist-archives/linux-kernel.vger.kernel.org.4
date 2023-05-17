Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ECC706792
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjEQMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEQMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:07:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4B53586
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:05:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24e4f674356so739472a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684325102; x=1686917102;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RuKZVWH9E7N/bubLeMmfAj/B0LbPIeQTO+7UjwwqYA0=;
        b=kW96/xL3Oewn4JzD8YhL5YGujFjzqvhdyJTaWpQCxMeZc2hxieroK3+uuAEZD41bk9
         uz1qwGBzp/Sg1QJ62y5suMtqed8bGWJhSe+HHMoz2TKtHhjATtmXp5P01mGt2KBSjlMp
         tPm0r1PTbmEJvecSu4KW5F7zaiukRMfYfLk62PszVKGHLpLk51n67tE5NGwYNJhDF3Vy
         IPmhLfk/PYvxmMrzWGq9BB7s2wAesYSaKoHZr8FSAiDrZhBMOghlqtoZ1vKcKfwYclrO
         muWcoyqcYfoZHAV/cqn/3MCwrcY2IVb381d4hil47IuZmjdseNd1Rl0vR3ZhcVZik9OK
         I+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684325102; x=1686917102;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuKZVWH9E7N/bubLeMmfAj/B0LbPIeQTO+7UjwwqYA0=;
        b=j4IAO116S1/PLBfMePb32+kFD7l7MCB0l9qrfhYaPEUvR1qigfJoWSPZ6imSbEztl+
         u+01rcSzggGlVXfXu2YpEx+hhZD+/r4mU0cd7qOG/kIct6CKC5lTPfiXnRjnh5E1kIUj
         WIfjq+Ml8olH7jsRxBS7YEMsoDp2JBfa/wON96RCo78W+/mXv9dqy+MkpFrWF1gT7Bgu
         jlMvkvzs8OxxUvYOhn67napc2i3tcq9cGr+Pk9AtU+IgdHEPMDLYwvgRWsjEK58CZsam
         q1eqC7EfLRX/eiVhrX4mJnSyDOclZJLFinelrqW06OtdBiL5vbB7CjNgZ/ubPyxrZcWz
         h18Q==
X-Gm-Message-State: AC+VfDzJIVutvPmZv4P68H89CyUGP17QABdThcR9chPy5Krpj3W4g1IB
        7L3aDEiaMAWEkPp5eQ+n0XtqjQ==
X-Google-Smtp-Source: ACHHUZ6Abo1Ie9JeRcHIHLtMHVsxt+lqr1HCJV1Wcgikm3IKVHU0UqSCXlanfXqRhwy8QHmEKHckwg==
X-Received: by 2002:a05:6a20:734f:b0:107:35ed:28b5 with SMTP id v15-20020a056a20734f00b0010735ed28b5mr4963420pzc.2.1684325102467;
        Wed, 17 May 2023 05:05:02 -0700 (PDT)
Received: from n37-012-157.byted.org ([180.184.49.4])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7839a000000b0063b86aff031sm839311pfm.108.2023.05.17.05.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:05:02 -0700 (PDT)
From:   "dengqiao.joey" <dengqiao.joey@bytedance.com>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com
Subject: Re: [PATCH] KVM: SVM: Update destination when updating pi irte
Date:   Wed, 17 May 2023 20:04:58 +0800
Message-Id: <20230517120458.3761311-1-dengqiao.joey@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <ZGOnPMTEKqRq89jt@google.com>
References: <ZGOnPMTEKqRq89jt@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be a different issue. Joao's patch tries to fix the issue
that IRTE is not changed. The problem I encountered is that IRTE does
get changed, thus the destination field is also cleared by
amd_iommu_activate_guest_mode(). 
