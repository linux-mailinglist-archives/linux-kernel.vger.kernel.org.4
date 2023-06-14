Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2B71F7BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjFBBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjFBBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:22:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F841A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:22:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ef5a707dso22880177b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668923; x=1688260923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVBRO/sr7nPUkpgW2sMt8Oln4tjdALcpHBCgSE+pX4I=;
        b=25Wln+iz7J8nMLS9Y4U0wAjj/yic7eW9lOL1jZH3uTstFegI7CsJpfu1lRrNcjnex7
         nxnud4PPmaOywgFA6Bs190uKUVcPDuZc8gleGyK9Go1n5/C1FuBXuO/SC+z40whpTgN6
         O6n5vG+EISW/duET7bvpamo6xSQGrcM8FSms6Z0sEKReGQwdc3SF/3RBsLHAbrUt8zX/
         nuWAhTf/VUHAG8Ebl/mXVHKDRguQCIh2H5EjTOr38oNup3s5UDvzjHmFjjCX1DXFlEb7
         nvda/IRkJ308E1pQDiGHpdpiRFGfjWHeqX0xK21vaHuXNffa+nGY0WduFjhQ4Eu+xD6N
         TrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668923; x=1688260923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVBRO/sr7nPUkpgW2sMt8Oln4tjdALcpHBCgSE+pX4I=;
        b=ESs1fqtSgvIDoWmHi702DRJZF4w6qb+EUrTdDS37S225Wc0xgZls7YgkTat/MGZJWO
         7URm4oenEMMo2cdVg86WTF4cdlU/IJpiFx2W5eJGpo8VMJdtLywbH5ZgMlDOT3JaONz9
         GmchyAH9X+X4weOjx+hX29nD05A/NnhcYM/3TMQMTGPNHcPMWFDPe3UlpiUT3OmqEyDB
         woZyjAwpRo8BdFVdvU+Q1lxlyx/9L7V2f2ADFPQgfN7o/lICnQ54FWTzRWw80OZnKrir
         2bsdkZGibQ4JaE8zyAAsOhNYaknCOyoqRRlu6K357ucXZimElgb4QN/4WKwlqkjwfbqA
         GZJg==
X-Gm-Message-State: AC+VfDxfl0KrZ3q8Ti17ZSfT5yFXo8x4+BEUCiGhQwhje7lEnEfq3kf7
        FKBpObYPjlnO92srrjPYcmsQEVYnYjA=
X-Google-Smtp-Source: ACHHUZ6arP/za1K/Ojosr8kzDmYWvA4Vfc35tM4z4txTPMGYoefnIRckF/7kQtWXZXh8ZfyCwITd6cOuJCI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:70d:b0:ba8:37f6:a586 with SMTP id
 k13-20020a056902070d00b00ba837f6a586mr1129876ybt.3.1685668923235; Thu, 01 Jun
 2023 18:22:03 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:21:47 -0700
In-Reply-To: <20230419021924.1342184-1-alexjlzheng@tencent.com>
Mime-Version: 1.0
References: <20230419021924.1342184-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168565225854.661985.17570727608473144728.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: x86: Fix poll command
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        alexjlzheng@gmail.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 10:19:25 +0800, alexjlzheng@gmail.com wrote:
> According to the hardware manual, when the Poll command is issued, the
> byte returned by the I/O read is 1 in Bit 7 when there is an interrupt,
> and the highest priority binary code in Bits 2:0. The current pic
> simulation code is not implemented strictly according to the above
> expression.
> 
> Fix the implementation of pic_poll_read(), set Bit 7 when there is an
> interrupt.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Fix poll command
      https://github.com/kvm-x86/linux/commit/0d42522bdee7

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
